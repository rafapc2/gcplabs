#!/bin/bash

# Setup
# Create vm and have fun.

#Setup
gcloud config list
gcloud auth list

export PROJECT_ID=$(gcloud config get-value project)

gcloud compute project-info describe --project $PROJECT_ID
# defaults propperties
# google-compute-default-region
# google-compute-default-zone

export REGION=us-east1
export ZONE=us-east1-b

gcloud config set compute/region "zone=$ZONE"
gcloud config set compute/region "region=$REGION"


# Create cluster micro machine type
gcloud container clusters create --machine-type=e2-micro --zone=$ZONE my-kube-cluster 

# Authenticate with the cluster
gcloud container clusters get-credentials my-kube-cluster --zone=$ZONE

# Deploy an application to the cluster
# Create Deployment
kubectl create deployment my-hello-server --image=gcr.io/google-samples/hello-app:2.0

#Create a Kubernetes Service
kubectl expose deployment my-hello-server --type=LoadBalancer --port 8081

# Inspect the service
kubectl get service

# Check conectivity 
http://[EXTERNAL-IP]:8080


#Delete the cluster
gcloud container clusters delete my-kube-cluster