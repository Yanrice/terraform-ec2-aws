# AWS EC2 Terraform Deployment with Jenkins Pipeline
This repository contains Terraform configuration to deploy an EC2 instance in AWS, along with a Jenkins pipeline to automate the deployment.

## Prerequisites

Terraform files from previous setup (`main.tf`, `variables.tf`)
GitHub repository with the code
Jenkins instance (e.g., at https://jenkins-yannickkalukuta.com) with Git and Terraform installed on the agents
AWS credentials configured in Jenkins
SSH key pair in AWS

## Setting Up Jenkins

1. Log in to your Jenkins at https://jenkins-yannickkalukuta.com (assuming this is your Jenkins URL).

2. Install necessary plugins if not already: Pipeline, Git, Credentials Binding.

3. Configure AWS Credentials:

* Go to Manage Jenkins > Credentials > System > Global credentials.
* Add two new credentials of type "Secret text":
  
* ID: `aws-access-key`, Secret: Your AWS Access Key ID
* ID: `aws-secret-key`, Secret: Your AWS Secret Access Key

4. Create a New Pipeline Job:

* New Item > Pipeline
* Name: e.g., "EC2-Deployment"
* In Pipeline section, select "Pipeline script from SCM"
* SCM: Git
* Repository URL: Your GitHub repo URL (e.g., https://github.com/yourusername/your-repo.git)
* Branch: main
* Script Path: **Jenkinsfile**


5. Save and Build the pipeline.


## Pipeline Stages

* Checkout: Pulls code from GitHub.
* Terraform Init: Initializes Terraform.
* Terraform Plan: Generates execution plan.
* Approval: Manual approval step before apply (on main branch).
* Terraform Apply: Applies the changes to deploy EC2.

## Variables
Ensure `terraform.tfvars` or variables are set appropriately. For security, avoid committing sensitive vars to Git; set them in Jenkins environment if needed.

## Notes

* Ensure Terraform is installed on the Jenkins agent (e.g., via system packages or Docker agent with Terraform image).
* For production, add more security, like locking Terraform state with S3 backend.
* If using a different branch, adjust the 'when' condition in Approval stage.
* After deployment, check the output in Jenkins console for the EC2 public IP.

## Cleanup

Run `terraform destroy` manually or add a destroy stage in the pipeline (with caution).

Add the `Jenkinsfile` to your repository root, commit, and push to GitHub.
