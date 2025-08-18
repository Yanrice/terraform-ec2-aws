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
* Check "This project is parameterized" and add a boolean parameter:
* Name: DESTROY, Default Value: unchecked, Description: "Check to destroy the infrastructure"
* In Pipeline section, select "Pipeline script from SCM"
* SCM: Git
* Repository URL: Your GitHub repo URL (e.g., https://github.com/yourusername/your-repo.git)
* Branch: main
* Script Path: **Jenkinsfile**


5. Save and Build the pipeline.


## Pipeline Stages

* Checkout: Pulls code from GitHub.
* Terraform Init: Initializes Terraform.
* Terraform Plan: Generates execution plan (skipped if DESTROY is checked).
* Approval: Manual approval step before apply (skipped if DESTROY is checked).
* Terraform Apply: Applies the changes to deploy EC2 (skipped if DESTROY is checked).
* Terraform Destroy: Destroys the infrastructure if DESTROY parameter is checked.

## Running the Pipeline

* To deploy: Run the pipeline with DESTROY unchecked (default).
* To destroy: Run the pipeline with DESTROY checked.
* Monitor the Jenkins console output for the EC2 public IP (on apply) or confirmation of destruction.

## Variables

Ensure `terraform.tfvars` or variables are set appropriately. For security, avoid committing sensitive vars to Git; set them in Jenkins environment if needed.

## Notes

* Ensure Terraform is installed on the Jenkins agent (e.g., via system packages or Docker agent with Terraform image: `hashicorp/terraform:1.5.7`).
* For production, add more security, like locking Terraform state with S3 backend.
* The destroy stage runs with `-auto-approve` for automation; use with caution.
* Update `AWS_DEFAULT_REGION` in `Jenkinsfile` to match your Terraform `aws_region`.

## Cleanup

To destroy the infrastructure:

* In Jenkins, click "Build with Parameters".
* Check the DESTROY box.
* lick Build.

Add the `Jenkinsfile` to your repository root, commit, and push to GitHub.
