Architecture du Cluster
3 Masters → master1, master2, master3
1 Worker → worker1
Méthode HA → etcd intégré
1️⃣ Création de l'Inventaire Ansible
On définit les 3 masters et le worker dans inventory.ini :

ini
Copier
Modifier
[masters]
master1 ansible_host=192.168.1.100 ansible_user=ubuntu
master2 ansible_host=192.168.1.101 ansible_user=ubuntu
master3 ansible_host=192.168.1.102 ansible_user=ubuntu

[workers]
worker1 ansible_host=192.168.1.103 ansible_user=ubuntu
2️⃣ Création du Playbook Ansible
Crée un fichier install-rke2.yml :

```yaml

---
- name: Installer et configurer RKE2 (HA)
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
            - "192.168.1.100"
            - "192.168.1.101"
            - "192.168.1.102"
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
      when: inventory_hostname == "master1"

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
          token: "mysecuretoken"
          server: "https://192.168.1.100:9345"

    - name: Activer et démarrer RKE2 agent
      systemd:
        name: rke2-agent
        enabled: yes
        state: started
```

3️⃣ Exécution du Playbook
Lance l'installation avec la commande :

bash
ansible-playbook -i inventory.ini install-rke2.yml

4️⃣ Vérification
Sur master1, exécute la commande suivante :

bash

export KUBECONFIG=/etc/rancher/rke2/rke2.yaml
kubectl get nodes

Tu devrais voir les 3 masters et le worker en Ready. 🎉

💡 Améliorations possibles
Ajouter firewalld pour ouvrir les ports nécessaires
Mettre en place un Load Balancer pour les masters
Automatiser la copie de kubeconfig
Dis-moi si tu veux des optimisations ! 🚀