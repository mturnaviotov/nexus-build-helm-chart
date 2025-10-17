#!/bin/bash

# Configuration
NEXUS_URL="http://repos.local:2000"  # Assuming port-forward to 2000
REPO_NAME="helm-releases"
CHART_PATH="./charts/nexus"
NEXUS_USER="admin". # replace username if different
NEXUS_PASS="123123" # Replace with your admin password from env vars or secret manager

# Package the chart
echo "Packaging Helm chart..."
helm package $CHART_PATH

# Get the chart file name
CHART_FILE=$(ls nexus-*.tgz | tail -n 1)

# Upload to Nexus
echo "Uploading $CHART_FILE to Nexus..."
curl -v -u "$NEXUS_USER:$NEXUS_PASS" \
  --upload-file "$CHART_FILE" \
  "$NEXUS_URL/repository/$REPO_NAME/$CHART_FILE"

# Clean up
rm "$CHART_FILE"

# Add the repo to helm (if not already added)
helm repo add nexus-helm "$NEXUS_URL/repository/$REPO_NAME/"
helm repo update
echo "--------------------"
echo "Chart has been published and repo has been added to helm"
echo "You can now use: helm install nexus3 nexus-helm/nexus"