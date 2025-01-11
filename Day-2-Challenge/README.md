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
- Moniroting : 
    - AWS CloudWatch


# Lessons learned
- Designing event-driven architectures
- Securing AWS services with least privilege IAM policies.
- Automating workflows using EventBridge.
- Integrating external APIs into cloud-based workflows.
- Using AWS serverless services like AWS Lambda, EventBridge and SNS.

# Setup steps