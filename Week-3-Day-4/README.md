# 30 Days DevOps Challenge Day 2 - Sports Alerts System


## Project Overview
This project is a real-time alert system that delivers NBA game day score notifications to subscribed users via SMS or email. It utilises Amazon SNS, AWS Lambda, Python, Amazon EventBridge, and NBA APIs to keep sports fans informed with the latest game updates. The project showcases cloud computing principles, including least privilege permissions, as well as event-driven architecture and automation for efficient notification delivery.

## Features
- Fetches live NBA game scores using an external API.
- Sends formatted score updates to subscribers via SMS/Email using Amazon SNS.
- Scheduled Cron job for regular updates using Amazon EventBridge.
- Designed with security in mind, following the principle of least privilege for IAM roles.


# Technical Architecture

![Alt Text](/Day-2-Challenge/diagram-export-11-01-2025-17_43_33.png)

# Technologies
- Language: Python 3.x
- Cloud Provider: AWS 
- External API: NBA Game API(SportsData.io)
- Permissions and Security:
    - Least priviledges using IAM Policies and Roles
- Monitoring : 
    - AWS CloudWatch
- Infrastructure as Code : Terraform


# Lessons learned
- Provision AWS Lambda using terraform
  - Benefits:
    - Eliminates manual errors and ensures repeatable deployments.
    - Uses variables for easy environment-specific configurations.
- Create SSM Parameter using AWS CLI
  - Benefits:
    - Creating an SSM Parameter using the AWS CLI helps with security by securely storing and managing sensitive data like API keys, database credentials, and configuration settings. 
    - Prevents accidental exposure of secrets in repositories.
    - SecureString parameters are encrypted using AWS KMS, ensuring protection at rest.
    - Applications retrieve secrets dynamically without storing them in config files.
- Retrieve AWS Account ID dynamically
  - Benefits:
    - Ensures the policy dynamically adjusts if the Terraform configuration is used in multiple AWS accounts.
    - Useful for managing multi-account setups in AWS Organizations to apply account-specific policies dynamically.
     Ensures only the current AWS account can assume the role, preventing unauthorised access.
# 