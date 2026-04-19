terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

variable "hcloud_token" {
  type      = string
  sensitive = true
}

resource "hcloud_ssh_key" "default" {
  name       = "my-ssh-key"
  public_key = file("C:/Users/serta/.ssh/hetzner_key.pub")
}

resource "hcloud_network" "k8s_network" {
  name     = "k8s-network"
  ip_range = "10.0.0.0/16"
}

resource "hcloud_network_subnet" "k8s_subnet" {
  network_id   = hcloud_network.k8s_network.id
  type         = "cloud"
  network_zone = "eu-central"
  ip_range     = "10.0.1.0/24"
}
resource "hcloud_server" "master" {
  name        = "k8s-master"
  image       = "ubuntu-22.04"
  server_type = "cx23"
  location    = "nbg1"

  ssh_keys = [hcloud_ssh_key.default.id]

  network {
    network_id = hcloud_network.k8s_network.id
    ip         = "10.0.1.10"
  }
}

resource "hcloud_server" "worker" {
  name        = "k8s-worker"
  image       = "ubuntu-22.04"
  server_type = "cx23"
  location    = "nbg1"

  ssh_keys = [hcloud_ssh_key.default.id]

  network {
    network_id = hcloud_network.k8s_network.id
    ip         = "10.0.1.11"
  }
}

output "master_ip" {
  value = hcloud_server.master.ipv4_address
}

output "worker_ip" {
  value = hcloud_server.worker.ipv4_address
}

output "ansible_inventory" {
  value = <<EOT
[k8s_master]
master ansible_host=${hcloud_server.master.ipv4_address} ansible_user=root ansible_ssh_private_key_file=C:/Users/serta/.ssh/.ssh/hetzner_key

[k8s_worker]
worker ansible_host=${hcloud_server.worker.ipv4_address} ansible_user=root ansible_ssh_private_key_file=C:/Users/serta/.ssh/.ssh/hetzner_key

[k8s_cluster:children]
k8s_master
k8s_worker
EOT
}
