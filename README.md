# GitOps Kubernetes Platform (CI/CD + IaC + Observability)

## Overview

This project demonstrates a complete cloud-native GitOps platform built on Kubernetes, including Infrastructure as Code, CI/CD automation, and the monitoring stack.

The system automatically provisions infrastructure, deploys containerized applications using a GitOps workflow, and provides observability and autoscaling capabilities. It is designed to simulate a production-like environment with fully automated deployment and operations processes.

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

## Kubernetes Cluster

A lightweight Kubernetes cluster is deployed using **k3s** to simulate a production-like, distributed environment.

The cluster is designed to run containerized workloads with basic production features such as scaling, routing, and service discovery.

Key components:

* Multi-node cluster (master + worker)
* Containerized NGINX application workloads
* Kubernetes Services (ClusterIP) for internal communication
* Ingress routing via Traefik for external access
* Horizontal Pod Autoscaling (HPA) based on CPU utilization

---

## CI/CD Pipeline (GitHub Actions)

A fully automated CI/CD pipeline is implemented using GitHub Actions and GitOps principles.

### Pipeline flow:

1. Code changes are pushed to `main` branch
2. A Docker image is built and versioned automatically
3. The image is pushed to GitHub Container Registry (GHCR)
4. Kubernetes manifests are updated with the new image tag
5. The Git commit triggers Argo CD to automatically sync and deploy the changes to the cluster

### Key Features:

* Automated image versioning based on pipeline runs
* Git-based deployment workflow (GitOps approach)
* Fully automated deployment process with no manual intervention
* Continuous synchronization between Git repository and Kubernetes cluster

---

## GitOps (Argo CD)

Argo CD is used to implement a GitOps-based deployment model with continuous synchronization between the Git repository and the Kubernetes cluster.

It continuously monitors the repository and ensures that the live cluster state always matches the desired state defined in Git.

### Key Responsibilies

* Continuous monitoring of the Git repository for changes
* Automatic synchronization of Kubernetes resources
* Enforcement of declarative infrastructure as the single source of truth
* Self-healing capabilities through automated drift detection and correction (prune & self-heal enabled)

---

## Application Layer

Simple NGINX-based application:

* Containerized via Docker
* Served via Kubernetes Deployment
* Exposed via Ingress

Features:

* Rolling updates
* Health checks (liveness/readiness probes)
* Resource limits (CPU management)

---

## Observability Stack

Monitoring is implemented using:

* Prometheus (metrics collection)
* Grafana (visualization dashboards)

Deployed via Helm chart:

* kube-prometheus-stack
* Argo CD managed deployment

---

## Networking & Access

* Traefik Ingress Controller

* Custom host-based routing:

  * web.local
  * grafana.local
  * argocd.local

* DNS simulation via /etc/hosts mapping

* External access via NodePort (for debugging/demo purposes)

---

## Autoscaling

Horizontal Pod Autoscaler (HPA):

* CPU-based scaling
* Min: 1 replica
* Max: 5 replicas
* Target: 50% CPU utilization

---

## 🛠️ Tools & Technologies

* Linux (Ubuntu)
* Kubernetes (k3s)
* Docker
* Terraform
* GitHub Actions (CI/CD)
* Argo CD (GitOps)
* Helm
* Prometheus
* Grafana
* Traefik Ingress

---

## Key Engineering Concepts Demonstrated

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

## Troubleshooting / Lessons Learned

During implementation, several real-world issues were solved:

* Ingress/TLS routing issues with Argo CD behind reverse proxy
* Network configuration between cluster nodes
* Container image versioning synchronization
* DNS resolution for local development domains
* Debugging Kubernetes pods via logs and events

A temporary workaround was implemented for Argo CD access using NodePort to ensure full demo functionality.

---

## Deployment Summary

* Terraform provisions infrastructure
* k3s initializes Kubernetes cluster
* kubectl deploys workloads
* Argo CD manages GitOps synchronization
* GitHub Actions builds and updates images
* Prometheus + Grafana provide observability

---

## Purpose of this Project

This project was built to gain hands-on experience with:

* Kubernetes cluster operations
* Infrastructure automation
* CI/CD pipelines
* GitOps workflows
* Observability systems
* Real-world system troubleshooting

---

## Future Improvements

* Full TLS (cert-manager + Let’s Encrypt)
* Helm-based application packaging
* Multi-environment (dev/staging/prod)
* Centralized logging (ELK stack)
* Multi-cluster setup
