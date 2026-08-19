#!/bin/bash
# ==============================================================================
# Codespace Environment Setup Script
# Description: Automates the setup of core cloud infrastructure tools.
# Tools Installed: Terraform CLI, Azure CLI, and Kubectl CLI.
# ==============================================================================

# Exit immediately if any command fails
set -e

# ------------------------------------------------------------------------------
# 1. System Diagnosis & Prerequisites
# ------------------------------------------------------------------------------
echo "==> Checking OS architecture and distribution details..."
cat /etc/os-release

echo "==> Ensuring required system dependencies are present..."
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl wget

# ------------------------------------------------------------------------------
# 2. Install & Verify HashiCorp Terraform CLI
# ------------------------------------------------------------------------------
echo "==> Fetching HashiCorp official GPG keyring..."
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "==> Adding HashiCorp APT repository to package source lists..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

echo "==> Syncing package lists and installing the latest Terraform..."
sudo apt update && sudo apt install terraform

echo "==> [VERIFICATION] Checking Terraform version..."
terraform -version

# ------------------------------------------------------------------------------
# 3. Install & Verify Azure CLI (az)
# ------------------------------------------------------------------------------
echo "==> Pulling and executing the official Microsoft Azure CLI installation script..."
curl -fsSL 'https://azurecliprod.blob.core.windows.net/$root/deb_install.sh' | sudo bash

echo "==> [VERIFICATION] Checking Azure CLI version..."
az --version

# ------------------------------------------------------------------------------
# 4. Install & Verify Kubernetes CLI (kubectl)
# ------------------------------------------------------------------------------
echo "==> Setting up the Kubernetes official repository and installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

echo "==> [VERIFICATION] Checking Kubectl client version..."
kubectl version --client
