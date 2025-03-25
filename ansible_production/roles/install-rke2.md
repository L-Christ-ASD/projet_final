- name: Installer et configurer RKE2 haute disponibilité (HA)
  hosts: all
  become: true
  tasks:

    - name: Mettre à jour les paquets
      apt:
        update_cache: yes
        upgrade: yes

    - name: Désactiver swap (RKE2 exige que le swap soit désactivé)
      command: swapoff -a
      when: ansible_swaptotal_mb > 0

    - name: Supprimer swap du fstab pour éviter qu'il ne se réactive au reboot
      replace:
        path: /etc/fstab
        regexp: '^\s*[^#].*\bswap\b.*$'
        replace: ''

    - name: Installer les dépendances nécessaires
      apt:
        name:
          - curl
          - iptables
          - socat
          - unzip
          - iproute2
        state: present

    - name: Télécharger le script d'installation de RKE2
      get_url:
        url: https://get.rke2.io
        dest: /tmp/install-rke2.sh
        mode: '0755'

# ----------------- Installation sur les Masters -----------------
- name: Installer et configurer les Masters RKE2
  hosts: masters
  become: true
  tasks:

    - name: Installer RKE2 server
      command: sh /tmp/install-rke2.sh

    - name: Configurer RKE2 server
      copy:
        dest: /etc/rancher/rke2/config.yaml
        content: |
          token: "mysecuretoken"
          tls-san:
            - "{{ ansible_host }}"
          write-kubeconfig-mode: "0644"

    - name: Activer et démarrer le serveur RKE2
      systemd:
        name: rke2-server
        enabled: yes
        state: started

    - name: Attendre que RKE2 soit actif
      command: systemctl is-active rke2-server
      register: rke2_status
      until: rke2_status.stdout == "active"
      retries: 10
      delay: 5

    - name: Copier le kubeconfig sur le master principal (master1)
      fetch:
        src: /etc/rancher/rke2/rke2.yaml
        dest: ./kubeconfig.yaml
        flat: yes
      when: inventory_hostname == groups['masters'][0]  # Prend le premier master

# ----------------- Récupérer le token automatiquement-----------------
- name: Récupérer le token RKE2 sur master1
  hosts: masters[0]  # Récupérer depuis le premier master
  become: true
  tasks:

    - name: Lire le token RKE2
      command: cat /var/lib/rancher/rke2/server/node-token
      register: rke2_token

    - name: Partager le token avec les autres hôtes
      set_fact:
        rke2_token_value: "{{ rke2_token.stdout }}"

# ----------------- Installation sur le Worker -----------------
- name: Installer et configurer le Worker RKE2
  hosts: workers
  become: true
  tasks:

    - name: Installer RKE2 agent
      command: sh /tmp/install-rke2.sh

    - name: Configurer RKE2 agent
      copy:
        dest: /etc/rancher/rke2/config.yaml
        content: |
          token: "{{ hostvars[groups['masters'][0]]['rke2_token_value'] }}"
          server: "https://{{ hostvars[groups['masters'][0]]['ansible_host'] }}:9345"

    - name: Activer et démarrer RKE2 agent
      systemd:
        name: rke2-agent
        enabled: yes
        state: started
