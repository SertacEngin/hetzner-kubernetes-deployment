# GitOps Kubernetes Platform (CI/CD + IaC + Observability)

## Overview

This project demonstrates a complete cloud-native GitOps platform built on Kubernetes, including Infrastructure as Code, CI/CD automation, and the monitoring stack.

The system provisions infrastructure automatically, deploys applications via GitOps principles, and provides monitoring and autoscaling capabilities.

---

## Architecture

The platform is fully automated and follows a GitOps workflow:

GitHub → GitHub Actions → GHCR → Argo CD → Kubernetes Cluster → Ingress → Services → Pods → Prometheus + Grafana

---

## Infrastructure (IaC)

The infrastructure is provisioned using **Terraform on Hetzner Cloud** and fully automated as Infrastructure as Code.

It sets up a small Kubernetes environment consisting of master and worker nodes (Ubuntu 22.04), connected through a private network (10.0.0.0/16). Access is secured via SSH key-based authentication.

The setup is designed to be reproducible and allows consistent provisioning of the entire infrastructure from scratch.

Tools:

* Terraform
* Hetzner Cloud API
* Linux (Ubuntu)

---

## ☸️ Kubernetes Cluster

A lightweight Kubernetes cluster is deployed using **k3s**.

Key components:

* Multi-node cluster (master + worker)
* NGINX-based application deployment
* Kubernetes Services (ClusterIP)
* Ingress via Traefik
* Horizontal Pod Autoscaling (HPA)

---

## 🚀 CI/CD Pipeline (GitHub Actions)

A fully automated CI/CD pipeline is implemented:

### Pipeline flow:

1. Code is pushed to `main`
2. Docker image is built
3. Image is pushed to GitHub Container Registry (GHCR)
4. Kubernetes manifest is automatically updated
5. Git commit triggers Argo CD sync

### Features:

* Automatic image versioning
* Git-based deployment updates
* Zero manual deployment steps

---

## 🔄 GitOps (Argo CD)

Argo CD is used for continuous reconciliation:

* Monitors Git repository
* Automatically syncs Kubernetes state
* Ensures declarative infrastructure consistency
* Supports self-healing (prune + self-heal enabled)

---

## 📦 Application Layer

Simple NGINX-based application:

* Containerized via Docker
* Served via Kubernetes Deployment
* Exposed via Ingress

Features:

* Rolling updates
* Health checks (liveness/readiness probes)
* Resource limits (CPU management)

---

## 📊 Observability Stack

Monitoring is implemented using:

* Prometheus (metrics collection)
* Grafana (visualization dashboards)

Deployed via Helm chart:

* kube-prometheus-stack
* Argo CD managed deployment

---

## 🌐 Networking & Access

* Traefik Ingress Controller

* Custom host-based routing:

  * web.local
  * grafana.local
  * argocd.local

* DNS simulation via /etc/hosts mapping

* External access via NodePort (for debugging/demo purposes)

---

## 📈 Autoscaling

Horizontal Pod Autoscaler (HPA):

* CPU-based scaling
* Min: 1 replica
* Max: 5 replicas
* Target: 50% CPU utilization

---

## 🛠️ Tools & Technologies

* Kubernetes (k3s)
* Docker
* Terraform
* Ansible (inventory generation)
* GitHub Actions (CI/CD)
* Argo CD (GitOps)
* Helm
* Prometheus
* Grafana
* Traefik Ingress
* Linux (Ubuntu)

---

## 🔥 Key Engineering Concepts Demonstrated

* Infrastructure as Code (IaC)
* GitOps deployment model
* CI/CD automation
* Container orchestration
* Distributed systems management
* Monitoring & alerting
* Auto-scaling systems
* Declarative infrastructure
* Cloud networking

---

## 🚨 Troubleshooting / Lessons Learned

During implementation, several real-world issues were solved:

* Ingress/TLS routing issues with Argo CD behind reverse proxy
* Network configuration between cluster nodes
* Container image versioning synchronization
* DNS resolution for local development domains
* Debugging Kubernetes pods via logs and events

A temporary workaround was implemented for Argo CD access using NodePort to ensure full demo functionality.

---

## 📌 Deployment Summary

* Terraform provisions infrastructure
* k3s initializes Kubernetes cluster
* kubectl deploys workloads
* Argo CD manages GitOps synchronization
* GitHub Actions builds and updates images
* Prometheus + Grafana provide observability

---

## 🎯 Purpose of this Project

This project was built to gain hands-on experience with:

* Kubernetes cluster operations
* Infrastructure automation
* CI/CD pipelines
* GitOps workflows
* Observability systems
* Real-world system troubleshooting

---

## 🚀 Future Improvements

* Full TLS (cert-manager + Let’s Encrypt)
* Helm-based application packaging
* Multi-environment (dev/staging/prod)
* Centralized logging (ELK stack)
* Multi-cluster setup
