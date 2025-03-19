{
  "version": 4,
  "terraform_version": "1.11.1",
  "serial": 225,
  "lineage": "d02fc27c-fdd9-9fd4-b4ec-3fc0e0d1982e",
  "outputs": {
    "instance_info": {
      "value": {
        "ami_id": [
          "ami-04b4f1a9cf54c11d0"
        ],
        "isntance_id": [
          "i-0040554aaf8a7b8fb"
        ],
        "public_ip": [
          "98.80.149.110"
        ]
      },
      "type": [
        "object",
        {
          "ami_id": [
            "tuple",
            [
              "string"
            ]
          ],
          "isntance_id": [
            "tuple",
            [
              "string"
            ]
          ],
          "public_ip": [
            "tuple",
            [
              "string"
            ]
          ]
        }
      ]
    },
    "sg_id": {
      "value": "sg-0cd8cd8c6eee9044d",
      "type": "string"
    },
    "sg_name": {
      "value": "admin-ssh",
      "type": "string"
    }
  },
  "resources": [
    {
      "mode": "managed",
      "type": "aws_instance",
      "name": "terrafom",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "index_key": 0,
          "schema_version": 1,
          "attributes": {
            "ami": "ami-04b4f1a9cf54c11d0",
            "arn": "arn:aws:ec2:us-east-1:585768148089:instance/i-0040554aaf8a7b8fb",
            "associate_public_ip_address": true,
            "availability_zone": "us-east-1f",
            "capacity_reservation_specification": [
              {
                "capacity_reservation_preference": "open",
                "capacity_reservation_target": []
              }
            ],
            "cpu_core_count": 4,
            "cpu_options": [
              {
                "amd_sev_snp": "",
                "core_count": 4,
                "threads_per_core": 2
              }
            ],
            "cpu_threads_per_core": 2,
            "credit_specification": [
              {
                "cpu_credits": "unlimited"
              }
            ],
            "disable_api_stop": false,
            "disable_api_termination": false,
            "ebs_block_device": [],
            "ebs_optimized": false,
            "enable_primary_ipv6": null,
            "enclave_options": [
              {
                "enabled": false
              }
            ],
            "ephemeral_block_device": [],
            "get_password_data": false,
            "hibernation": false,
            "host_id": "",
            "host_resource_group_arn": null,
            "iam_instance_profile": "",
            "id": "i-0040554aaf8a7b8fb",
            "instance_initiated_shutdown_behavior": "stop",
            "instance_lifecycle": "",
            "instance_market_options": [],
            "instance_state": "running",
            "instance_type": "t3.2xlarge",
            "ipv6_address_count": 0,
            "ipv6_addresses": [],
            "key_name": "vockey",
            "launch_template": [],
            "maintenance_options": [
              {
                "auto_recovery": "default"
              }
            ],
            "metadata_options": [
              {
                "http_endpoint": "enabled",
                "http_protocol_ipv6": "disabled",
                "http_put_response_hop_limit": 2,
                "http_tokens": "required",
                "instance_metadata_tags": "disabled"
              }
            ],
            "monitoring": false,
            "network_interface": [],
            "outpost_arn": "",
            "password_data": "",
            "placement_group": "",
            "placement_partition_number": 0,
            "primary_network_interface_id": "eni-00eb470435cddbb73",
            "private_dns": "ip-172-31-78-75.ec2.internal",
            "private_dns_name_options": [
              {
                "enable_resource_name_dns_a_record": false,
                "enable_resource_name_dns_aaaa_record": false,
                "hostname_type": "ip-name"
              }
            ],
            "private_ip": "172.31.78.75",
            "public_dns": "ec2-98-80-149-110.compute-1.amazonaws.com",
            "public_ip": "98.80.149.110",
            "root_block_device": [
              {
                "delete_on_termination": true,
                "device_name": "/dev/sda1",
                "encrypted": false,
                "iops": 3000,
                "kms_key_id": "",
                "tags": {},
                "tags_all": {},
                "throughput": 125,
                "volume_id": "vol-007c8970d60c23d2d",
                "volume_size": 8,
                "volume_type": "gp3"
              }
            ],
            "secondary_private_ips": [],
            "security_groups": [
              "admin-ssh"
            ],
            "source_dest_check": true,
            "spot_instance_request_id": "",
            "subnet_id": "subnet-07ef8d731542349d5",
            "tags": {
              "Name": "terrafom-0"
            },
            "tags_all": {
              "Name": "terrafom-0"
            },
            "tenancy": "default",
            "timeouts": null,
            "user_data": null,
            "user_data_base64": null,
            "user_data_replace_on_change": false,
            "volume_tags": null,
            "vpc_security_group_ids": [
              "sg-0cd8cd8c6eee9044d"
            ]
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6MTIwMDAwMDAwMDAwMCwicmVhZCI6OTAwMDAwMDAwMDAwLCJ1cGRhdGUiOjYwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiMSJ9",
          "dependencies": [
            "aws_key_pair.vockey",
            "aws_security_group.admin_ssh",
            "tls_private_key.vockey"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_key_pair",
      "name": "vockey",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 1,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:585768148089:key-pair/vockey",
            "fingerprint": "b5:8c:f6:a4:50:29:8c:07:79:e7:85:e6:77:9c:d9:28",
            "id": "vockey",
            "key_name": "vockey",
            "key_name_prefix": "",
            "key_pair_id": "key-03d464039e8293f20",
            "key_type": "rsa",
            "public_key": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDGJsQFS6Dh4ecHHEcLQrlHPxRgTuWxWv32igLyWaGApGGJbcst+R+M2tsKJDLxPIAdDLZ0ytp11key13OcE3HKnl48xEQUcjNL0TDcqSyI6VmBxlxNSUORbLoE+/+ReTgeUCDpr+bPj6r4DOtiuRP8eEjBP9BXTeAFPhygoHJZ4WlSEe/js2KC41LkwtsEv5+6wg55vVuElmWp0yqTqsWAireEQWFhri0biC39DQ+AqIQvW9YK99SzqLlI48UU0v3qUogLH92QJpFNeGZAvpeTQrYOYTxXdY1hA81plyjyRPBMHlA1vfbY1CcxHfVZSu3mR1wddSwegdqt4co2/k4F",
            "tags": null,
            "tags_all": {}
          },
          "sensitive_attributes": [],
          "private": "eyJzY2hlbWFfdmVyc2lvbiI6IjEifQ==",
          "dependencies": [
            "tls_private_key.vockey"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_security_group",
      "name": "admin_ssh",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 1,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:585768148089:security-group/sg-0cd8cd8c6eee9044d",
            "description": "Managed by Terraform",
            "egress": [],
            "id": "sg-0cd8cd8c6eee9044d",
            "ingress": [],
            "name": "admin-ssh",
            "name_prefix": "",
            "owner_id": "585768148089",
            "revoke_rules_on_delete": false,
            "tags": {
              "Name": "admin-ssh"
            },
            "tags_all": {
              "Name": "admin-ssh"
            },
            "timeouts": null,
            "vpc_id": "vpc-09c4b38653df63f28"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6OTAwMDAwMDAwMDAwfSwic2NoZW1hX3ZlcnNpb24iOiIxIn0="
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_vpc_security_group_egress_rule",
      "name": "allow_ssh_out",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:585768148089:security-group-rule/sgr-055744bc798346c4e",
            "cidr_ipv4": "0.0.0.0/0",
            "cidr_ipv6": null,
            "description": null,
            "from_port": null,
            "id": "sgr-055744bc798346c4e",
            "ip_protocol": "-1",
            "prefix_list_id": null,
            "referenced_security_group_id": null,
            "security_group_id": "sg-0cd8cd8c6eee9044d",
            "security_group_rule_id": "sgr-055744bc798346c4e",
            "tags": null,
            "tags_all": {},
            "to_port": null
          },
          "sensitive_attributes": [],
          "dependencies": [
            "aws_security_group.admin_ssh"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_vpc_security_group_ingress_rule",
      "name": "allow_http_in",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:585768148089:security-group-rule/sgr-0215cec24b24223b9",
            "cidr_ipv4": "0.0.0.0/0",
            "cidr_ipv6": null,
            "description": null,
            "from_port": 80,
            "id": "sgr-0215cec24b24223b9",
            "ip_protocol": "tcp",
            "prefix_list_id": null,
            "referenced_security_group_id": null,
            "security_group_id": "sg-0cd8cd8c6eee9044d",
            "security_group_rule_id": "sgr-0215cec24b24223b9",
            "tags": null,
            "tags_all": {},
            "to_port": 80
          },
          "sensitive_attributes": [],
          "dependencies": [
            "aws_security_group.admin_ssh"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_vpc_security_group_ingress_rule",
      "name": "allow_https_in",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:585768148089:security-group-rule/sgr-087287efc482a39ae",
            "cidr_ipv4": "0.0.0.0/0",
            "cidr_ipv6": null,
            "description": null,
            "from_port": 443,
            "id": "sgr-087287efc482a39ae",
            "ip_protocol": "tcp",
            "prefix_list_id": null,
            "referenced_security_group_id": null,
            "security_group_id": "sg-0cd8cd8c6eee9044d",
            "security_group_rule_id": "sgr-087287efc482a39ae",
            "tags": null,
            "tags_all": {},
            "to_port": 443
          },
          "sensitive_attributes": [],
          "dependencies": [
            "aws_security_group.admin_ssh"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_vpc_security_group_ingress_rule",
      "name": "allow_ssh_in",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "index_key": "192.168.1.0",
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:585768148089:security-group-rule/sgr-0f6c2174ae04445d6",
            "cidr_ipv4": "192.168.1.0/24",
            "cidr_ipv6": null,
            "description": null,
            "from_port": 22,
            "id": "sgr-0f6c2174ae04445d6",
            "ip_protocol": "tcp",
            "prefix_list_id": null,
            "referenced_security_group_id": null,
            "security_group_id": "sg-0cd8cd8c6eee9044d",
            "security_group_rule_id": "sgr-0f6c2174ae04445d6",
            "tags": null,
            "tags_all": {},
            "to_port": 22
          },
          "sensitive_attributes": [],
          "dependencies": [
            "aws_security_group.admin_ssh"
          ]
        },
        {
          "index_key": "77.207.199.0",
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:585768148089:security-group-rule/sgr-0bb1c13e4542ae8e3",
            "cidr_ipv4": "77.207.199.0/24",
            "cidr_ipv6": null,
            "description": null,
            "from_port": 22,
            "id": "sgr-0bb1c13e4542ae8e3",
            "ip_protocol": "tcp",
            "prefix_list_id": null,
            "referenced_security_group_id": null,
            "security_group_id": "sg-0cd8cd8c6eee9044d",
            "security_group_rule_id": "sgr-0bb1c13e4542ae8e3",
            "tags": null,
            "tags_all": {},
            "to_port": 22
          },
          "sensitive_attributes": [],
          "dependencies": [
            "aws_security_group.admin_ssh"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_vpc_security_group_ingress_rule",
      "name": "allow_ssh_in_myip",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:585768148089:security-group-rule/sgr-02829d391f9411e06",
            "cidr_ipv4": "176.172.132.0/24",
            "cidr_ipv6": null,
            "description": null,
            "from_port": 22,
            "id": "sgr-02829d391f9411e06",
            "ip_protocol": "tcp",
            "prefix_list_id": null,
            "referenced_security_group_id": null,
            "security_group_id": "sg-0cd8cd8c6eee9044d",
            "security_group_rule_id": "sgr-02829d391f9411e06",
            "tags": null,
            "tags_all": {},
            "to_port": 22
          },
          "sensitive_attributes": [],
          "dependencies": [
            "aws_security_group.admin_ssh"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "local_file",
      "name": "vockey_pem",
      "provider": "provider[\"registry.terraform.io/hashicorp/local\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "content": "-----BEGIN RSA PRIVATE KEY-----\nMIIEpAIBAAKCAQEAxibEBUug4eHnBxxHC0K5Rz8UYE7lsVr99ooC8lmhgKRhiW3L\nLfkfjNrbCiQy8TyAHQy2dMraddZHstdznBNxyp5ePMREFHIzS9Ew3KksiOlZgcZc\nTUlDkWy6BPv/kXk4HlAg6a/mz4+q+AzrYrkT/HhIwT/QV03gBT4coKByWeFpUhHv\n47NiguNS5MLbBL+fusIOeb1bhJZlqdMqk6rFgIq3hEFhYa4tG4gt/Q0PgKiEL1vW\nCvfUs6i5SOPFFNL96lKICx/dkCaRTXhmQL6Xk0K2DmE8V3WNYQPNaZco8kTwTB5Q\nNb322NQnMR31WUrt5kdcHXUsHoHareHKNv5OBQIDAQABAoIBAALcOGQjLVVVX3JY\n1CWzdt0yaebh/KrMt3HBmD1LUet7c/T54r7tI6ly10qULzAQQYEp19BjxTeCOlK4\njXCpTzEvjAiwhJMO+vKTOHNW9c+cHrCi3l43OoR031KHGK9O4qJ9YZw978T7O+qM\ntTEdns48JkCz3RwFgcBRnzQqXLwzYEGvvMayOhTnF4t6ClGbfCGnkE877J26sPgb\n6YRi9AxHNY2KRO3+cS5a33p0S2s17w6O/+vP0KBUxNKg6AFKRZPjrYHWyqHLNfGM\nDnKe14jR/0YAchs4SHmGJoNLhAKtp55es5Emg71fuMyZLHCaNhLwBY00hDshzjEr\nj0FOp1kCgYEA16hN2HPhvMbvwLXbOPDSdHZdAOo2qYBwsGKhXVibMIaUPxp3s/L6\nzO+TQSQquu4LkL3msl1Vgszp3ToWMYRycxBaSnOlU5EERLp1NTHGvpmoficMDR2G\n8VAr+cAiiTLHB49DsOxZyFBD9uwkwulMQDVWfMTSayrT/UdNz4EoChsCgYEA6zgc\nL6y0wH1kkPJmVdw7t615oRl5vxlxSnChZTwEGT5bubLmxsyAuUIh5F6g4FfLbItr\nzwcB/5huciP7807QV2QvEVeIe8Qu0YLGk2DisqOsmD4BQ+Il5bmJVsnr4bmhAist\ncmetjDIc3ErvLItr0rmTG6Gu0DOItADlDFYQil8CgYBLivRB503i39jqK4nwZ0OB\ncljf0it1sr1GvDYESd6K4AmcFTxrN6ktEpsFjZK+SlaYzDy8rD8hA4DEcu2FSP0C\nW28Vd28pV7okDSCzko0pBRBlqG3rRjWX4FqXMPuoDbZ0anXuyswkhCFapJu3/xsr\nvsNeD2AaFDWQGmMiVf7dkwKBgQDa/T9Ip3sU5uk1BWh/MW4roIdnlAdEAlT2YAvy\n60BJnEPbjJLMrOJ/F/Hj4rHWjAZpBRiXA0g6BVl2TMgqCstvQWeMtrjruYd5KU7l\nMUN922I5zyhwYeC0ktspgQ5p9d/P3BEQvTPXHWS/N8ia6Sa2Zm1uQUY2snPoWhjl\nNk9p8wKBgQDItT3/MWy6B0f1BCLsqk4kax1WF4AoqzcPqeb6WQTY998LUvM5+SEp\nyS9BnxXco0ZqXw8fP3NTOv8+NbkAkE7Ymiyn7FSuX/1q6S3DqepCLuyP7WNEWh+t\n5EOFqrN4JTVEuWfs+pyM8nToEyF8bp75rWAh+xc0I241Z9BBXqAAlQ==\n-----END RSA PRIVATE KEY-----\n",
            "content_base64": null,
            "content_base64sha256": "46TW7kvBqD/XYK8j+9ZtcAqOd7HCf3TuqTS/2sA8cLk=",
            "content_base64sha512": "ZLntjiCnFRfUBNABZNcBgpTFV8GteU5tZa5lrOVe2up+GuL/AJZDurJk50+FCzbtFO9qS1DtcDvLU8GHtyrsbA==",
            "content_md5": "db1efb1197fbbae3198f3045cf5781e8",
            "content_sha1": "77a147d0453540ccadef3a6811e5998e46ca2646",
            "content_sha256": "e3a4d6ee4bc1a83fd760af23fbd66d700a8e77b1c27f74eea934bfdac03c70b9",
            "content_sha512": "64b9ed8e20a71517d404d00164d7018294c557c1ad794e6d65ae65ace55edaea7e1ae2ff009643bab264e74f850b36ed14ef6a4b50ed703bcb53c187b72aec6c",
            "directory_permission": "0777",
            "file_permission": "0600",
            "filename": "./vockey.pem",
            "id": "77a147d0453540ccadef3a6811e5998e46ca2646",
            "sensitive_content": null,
            "source": null
          },
          "sensitive_attributes": [
            [
              {
                "type": "get_attr",
                "value": "content"
              }
            ],
            [
              {
                "type": "get_attr",
                "value": "sensitive_content"
              }
            ]
          ],
          "dependencies": [
            "tls_private_key.vockey"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "null_resource",
      "name": "generate_ansible_inventory",
      "provider": "provider[\"registry.terraform.io/hashicorp/null\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "id": "1171492642135133304",
            "triggers": null
          },
          "sensitive_attributes": [],
          "dependencies": [
            "aws_instance.terrafom",
            "aws_key_pair.vockey",
            "aws_security_group.admin_ssh",
            "tls_private_key.vockey"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "tls_private_key",
      "name": "vockey",
      "provider": "provider[\"registry.terraform.io/hashicorp/tls\"]",
      "instances": [
        {
          "schema_version": 1,
          "attributes": {
            "algorithm": "RSA",
            "ecdsa_curve": "P224",
            "id": "b21d1d58e77fce57da466bf3c47a7529eed36fc5",
            "private_key_openssh": "-----BEGIN OPENSSH PRIVATE KEY-----\nb3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAABFwAAAAdz\nc2gtcnNhAAAAAwEAAQAAAQEAxibEBUug4eHnBxxHC0K5Rz8UYE7lsVr99ooC8lmh\ngKRhiW3LLfkfjNrbCiQy8TyAHQy2dMraddZHstdznBNxyp5ePMREFHIzS9Ew3Kks\niOlZgcZcTUlDkWy6BPv/kXk4HlAg6a/mz4+q+AzrYrkT/HhIwT/QV03gBT4coKBy\nWeFpUhHv47NiguNS5MLbBL+fusIOeb1bhJZlqdMqk6rFgIq3hEFhYa4tG4gt/Q0P\ngKiEL1vWCvfUs6i5SOPFFNL96lKICx/dkCaRTXhmQL6Xk0K2DmE8V3WNYQPNaZco\n8kTwTB5QNb322NQnMR31WUrt5kdcHXUsHoHareHKNv5OBQAAA7iQwSdtkMEnbQAA\nAAdzc2gtcnNhAAABAQDGJsQFS6Dh4ecHHEcLQrlHPxRgTuWxWv32igLyWaGApGGJ\nbcst+R+M2tsKJDLxPIAdDLZ0ytp11key13OcE3HKnl48xEQUcjNL0TDcqSyI6VmB\nxlxNSUORbLoE+/+ReTgeUCDpr+bPj6r4DOtiuRP8eEjBP9BXTeAFPhygoHJZ4WlS\nEe/js2KC41LkwtsEv5+6wg55vVuElmWp0yqTqsWAireEQWFhri0biC39DQ+AqIQv\nW9YK99SzqLlI48UU0v3qUogLH92QJpFNeGZAvpeTQrYOYTxXdY1hA81plyjyRPBM\nHlA1vfbY1CcxHfVZSu3mR1wddSwegdqt4co2/k4FAAAAAwEAAQAAAQAC3DhkIy1V\nVV9yWNQls3bdMmnm4fyqzLdxwZg9S1Hre3P0+eK+7SOpctdKlC8wEEGBKdfQY8U3\ngjpSuI1wqU8xL4wIsISTDvrykzhzVvXPnB6wot5eNzqEdN9ShxivTuKifWGcPe/E\n+zvqjLUxHZ7OPCZAs90cBYHAUZ80Kly8M2BBr7zGsjoU5xeLegpRm3whp5BPO+yd\nurD4G+mEYvQMRzWNikTt/nEuWt96dEtrNe8Ojv/rz9CgVMTSoOgBSkWT462B1sqh\nyzXxjA5ynteI0f9GAHIbOEh5hiaDS4QCraeeXrORJoO9X7jMmSxwmjYS8AWNNIQ7\nIc4xK49BTqdZAAAAgQDItT3/MWy6B0f1BCLsqk4kax1WF4AoqzcPqeb6WQTY998L\nUvM5+SEpyS9BnxXco0ZqXw8fP3NTOv8+NbkAkE7Ymiyn7FSuX/1q6S3DqepCLuyP\n7WNEWh+t5EOFqrN4JTVEuWfs+pyM8nToEyF8bp75rWAh+xc0I241Z9BBXqAAlQAA\nAIEA16hN2HPhvMbvwLXbOPDSdHZdAOo2qYBwsGKhXVibMIaUPxp3s/L6zO+TQSQq\nuu4LkL3msl1Vgszp3ToWMYRycxBaSnOlU5EERLp1NTHGvpmoficMDR2G8VAr+cAi\niTLHB49DsOxZyFBD9uwkwulMQDVWfMTSayrT/UdNz4EoChsAAACBAOs4HC+stMB9\nZJDyZlXcO7eteaEZeb8ZcUpwoWU8BBk+W7my5sbMgLlCIeReoOBXy2yLa88HAf+Y\nbnIj+/NO0FdkLxFXiHvELtGCxpNg4rKjrJg+AUPiJeW5iVbJ6+G5oQIrLXJnrYwy\nHNxK7yyLa9K5kxuhrtAziLQA5QxWEIpfAAAAAAEC\n-----END OPENSSH PRIVATE KEY-----\n",
            "private_key_pem": "-----BEGIN RSA PRIVATE KEY-----\nMIIEpAIBAAKCAQEAxibEBUug4eHnBxxHC0K5Rz8UYE7lsVr99ooC8lmhgKRhiW3L\nLfkfjNrbCiQy8TyAHQy2dMraddZHstdznBNxyp5ePMREFHIzS9Ew3KksiOlZgcZc\nTUlDkWy6BPv/kXk4HlAg6a/mz4+q+AzrYrkT/HhIwT/QV03gBT4coKByWeFpUhHv\n47NiguNS5MLbBL+fusIOeb1bhJZlqdMqk6rFgIq3hEFhYa4tG4gt/Q0PgKiEL1vW\nCvfUs6i5SOPFFNL96lKICx/dkCaRTXhmQL6Xk0K2DmE8V3WNYQPNaZco8kTwTB5Q\nNb322NQnMR31WUrt5kdcHXUsHoHareHKNv5OBQIDAQABAoIBAALcOGQjLVVVX3JY\n1CWzdt0yaebh/KrMt3HBmD1LUet7c/T54r7tI6ly10qULzAQQYEp19BjxTeCOlK4\njXCpTzEvjAiwhJMO+vKTOHNW9c+cHrCi3l43OoR031KHGK9O4qJ9YZw978T7O+qM\ntTEdns48JkCz3RwFgcBRnzQqXLwzYEGvvMayOhTnF4t6ClGbfCGnkE877J26sPgb\n6YRi9AxHNY2KRO3+cS5a33p0S2s17w6O/+vP0KBUxNKg6AFKRZPjrYHWyqHLNfGM\nDnKe14jR/0YAchs4SHmGJoNLhAKtp55es5Emg71fuMyZLHCaNhLwBY00hDshzjEr\nj0FOp1kCgYEA16hN2HPhvMbvwLXbOPDSdHZdAOo2qYBwsGKhXVibMIaUPxp3s/L6\nzO+TQSQquu4LkL3msl1Vgszp3ToWMYRycxBaSnOlU5EERLp1NTHGvpmoficMDR2G\n8VAr+cAiiTLHB49DsOxZyFBD9uwkwulMQDVWfMTSayrT/UdNz4EoChsCgYEA6zgc\nL6y0wH1kkPJmVdw7t615oRl5vxlxSnChZTwEGT5bubLmxsyAuUIh5F6g4FfLbItr\nzwcB/5huciP7807QV2QvEVeIe8Qu0YLGk2DisqOsmD4BQ+Il5bmJVsnr4bmhAist\ncmetjDIc3ErvLItr0rmTG6Gu0DOItADlDFYQil8CgYBLivRB503i39jqK4nwZ0OB\ncljf0it1sr1GvDYESd6K4AmcFTxrN6ktEpsFjZK+SlaYzDy8rD8hA4DEcu2FSP0C\nW28Vd28pV7okDSCzko0pBRBlqG3rRjWX4FqXMPuoDbZ0anXuyswkhCFapJu3/xsr\nvsNeD2AaFDWQGmMiVf7dkwKBgQDa/T9Ip3sU5uk1BWh/MW4roIdnlAdEAlT2YAvy\n60BJnEPbjJLMrOJ/F/Hj4rHWjAZpBRiXA0g6BVl2TMgqCstvQWeMtrjruYd5KU7l\nMUN922I5zyhwYeC0ktspgQ5p9d/P3BEQvTPXHWS/N8ia6Sa2Zm1uQUY2snPoWhjl\nNk9p8wKBgQDItT3/MWy6B0f1BCLsqk4kax1WF4AoqzcPqeb6WQTY998LUvM5+SEp\nyS9BnxXco0ZqXw8fP3NTOv8+NbkAkE7Ymiyn7FSuX/1q6S3DqepCLuyP7WNEWh+t\n5EOFqrN4JTVEuWfs+pyM8nToEyF8bp75rWAh+xc0I241Z9BBXqAAlQ==\n-----END RSA PRIVATE KEY-----\n",
            "private_key_pem_pkcs8": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDGJsQFS6Dh4ecH\nHEcLQrlHPxRgTuWxWv32igLyWaGApGGJbcst+R+M2tsKJDLxPIAdDLZ0ytp11key\n13OcE3HKnl48xEQUcjNL0TDcqSyI6VmBxlxNSUORbLoE+/+ReTgeUCDpr+bPj6r4\nDOtiuRP8eEjBP9BXTeAFPhygoHJZ4WlSEe/js2KC41LkwtsEv5+6wg55vVuElmWp\n0yqTqsWAireEQWFhri0biC39DQ+AqIQvW9YK99SzqLlI48UU0v3qUogLH92QJpFN\neGZAvpeTQrYOYTxXdY1hA81plyjyRPBMHlA1vfbY1CcxHfVZSu3mR1wddSwegdqt\n4co2/k4FAgMBAAECggEAAtw4ZCMtVVVfcljUJbN23TJp5uH8qsy3ccGYPUtR63tz\n9Pnivu0jqXLXSpQvMBBBgSnX0GPFN4I6UriNcKlPMS+MCLCEkw768pM4c1b1z5we\nsKLeXjc6hHTfUocYr07ion1hnD3vxPs76oy1MR2ezjwmQLPdHAWBwFGfNCpcvDNg\nQa+8xrI6FOcXi3oKUZt8IaeQTzvsnbqw+BvphGL0DEc1jYpE7f5xLlrfenRLazXv\nDo7/68/QoFTE0qDoAUpFk+OtgdbKocs18YwOcp7XiNH/RgByGzhIeYYmg0uEAq2n\nnl6zkSaDvV+4zJkscJo2EvAFjTSEOyHOMSuPQU6nWQKBgQDXqE3Yc+G8xu/Atds4\n8NJ0dl0A6japgHCwYqFdWJswhpQ/Gnez8vrM75NBJCq67guQveayXVWCzOndOhYx\nhHJzEFpKc6VTkQREunU1Mca+mah+JwwNHYbxUCv5wCKJMscHj0Ow7FnIUEP27CTC\n6UxANVZ8xNJrKtP9R03PgSgKGwKBgQDrOBwvrLTAfWSQ8mZV3Du3rXmhGXm/GXFK\ncKFlPAQZPlu5subGzIC5QiHkXqDgV8tsi2vPBwH/mG5yI/vzTtBXZC8RV4h7xC7R\ngsaTYOKyo6yYPgFD4iXluYlWyevhuaECKy1yZ62MMhzcSu8si2vSuZMboa7QM4i0\nAOUMVhCKXwKBgEuK9EHnTeLf2OorifBnQ4FyWN/SK3WyvUa8NgRJ3orgCZwVPGs3\nqS0SmwWNkr5KVpjMPLysPyEDgMRy7YVI/QJbbxV3bylXuiQNILOSjSkFEGWobetG\nNZfgWpcw+6gNtnRqde7KzCSEIVqkm7f/Gyu+w14PYBoUNZAaYyJV/t2TAoGBANr9\nP0inexTm6TUFaH8xbiugh2eUB0QCVPZgC/LrQEmcQ9uMksys4n8X8ePisdaMBmkF\nGJcDSDoFWXZMyCoKy29BZ4y2uOu5h3kpTuUxQ33bYjnPKHBh4LSS2ymBDmn138/c\nERC9M9cdZL83yJrpJrZmbW5BRjayc+haGOU2T2nzAoGBAMi1Pf8xbLoHR/UEIuyq\nTiRrHVYXgCirNw+p5vpZBNj33wtS8zn5ISnJL0GfFdyjRmpfDx8/c1M6/z41uQCQ\nTtiaLKfsVK5f/WrpLcOp6kIu7I/tY0RaH63kQ4Wqs3glNUS5Z+z6nIzydOgTIXxu\nnvmtYCH7FzQjbjVn0EFeoACV\n-----END PRIVATE KEY-----\n",
            "public_key_fingerprint_md5": "4d:39:a7:35:4e:30:3e:6f:87:8f:dc:64:0a:fb:6a:b8",
            "public_key_fingerprint_sha256": "SHA256:UGgKeTfyU3y4UKmwdjujJl9zCzgrF1eQa4wlc+j3f6o",
            "public_key_openssh": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDGJsQFS6Dh4ecHHEcLQrlHPxRgTuWxWv32igLyWaGApGGJbcst+R+M2tsKJDLxPIAdDLZ0ytp11key13OcE3HKnl48xEQUcjNL0TDcqSyI6VmBxlxNSUORbLoE+/+ReTgeUCDpr+bPj6r4DOtiuRP8eEjBP9BXTeAFPhygoHJZ4WlSEe/js2KC41LkwtsEv5+6wg55vVuElmWp0yqTqsWAireEQWFhri0biC39DQ+AqIQvW9YK99SzqLlI48UU0v3qUogLH92QJpFNeGZAvpeTQrYOYTxXdY1hA81plyjyRPBMHlA1vfbY1CcxHfVZSu3mR1wddSwegdqt4co2/k4F\n",
            "public_key_pem": "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxibEBUug4eHnBxxHC0K5\nRz8UYE7lsVr99ooC8lmhgKRhiW3LLfkfjNrbCiQy8TyAHQy2dMraddZHstdznBNx\nyp5ePMREFHIzS9Ew3KksiOlZgcZcTUlDkWy6BPv/kXk4HlAg6a/mz4+q+AzrYrkT\n/HhIwT/QV03gBT4coKByWeFpUhHv47NiguNS5MLbBL+fusIOeb1bhJZlqdMqk6rF\ngIq3hEFhYa4tG4gt/Q0PgKiEL1vWCvfUs6i5SOPFFNL96lKICx/dkCaRTXhmQL6X\nk0K2DmE8V3WNYQPNaZco8kTwTB5QNb322NQnMR31WUrt5kdcHXUsHoHareHKNv5O\nBQIDAQAB\n-----END PUBLIC KEY-----\n",
            "rsa_bits": 2048
          },
          "sensitive_attributes": [
            [
              {
                "type": "get_attr",
                "value": "private_key_pem_pkcs8"
              }
            ],
            [
              {
                "type": "get_attr",
                "value": "private_key_pem"
              }
            ],
            [
              {
                "type": "get_attr",
                "value": "private_key_openssh"
              }
            ]
          ]
        }
      ]
    }
  ],
  "check_results": null
}
