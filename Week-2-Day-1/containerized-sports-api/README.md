# Sports API Management System

## **Project Overview**
This project demonstrates building a containerized API management system for querying sports data. It leverages **Amazon ECS (Fargate)** for running containers, **Amazon API Gateway** for exposing REST endpoints, and an external **Sports API** for real-time sports data. The project showcases advanced cloud computing practices, including API management, container orchestration, and secure AWS integrations.

---

## **Features**
- Exposes a REST API for querying real-time sports data
- Runs a containerized backend using Amazon ECS with Fargate
- Scalable and serverless architecture
- API management and routing using Amazon API Gateway
- Secure storage of parameters in Parameter store
- Security groups protecting resources by restricting access to trusted IP ranges, specific ports.
- Enhance application performance by Load balancing user traffic and ensure high availability.
 - AWS CLoudWatch logs for monitoring
---

## **Technical Architecture**
![Alt Text](/Week-2-Day-1/containerized-sports-api/diagram-export-24-01-2025-23_58_44.png)
---

## **Technologies**
- **Cloud Provider**: AWS
- **Services used**: Amazon ECS (Fargate)
  - API Gateway 
  - CloudWatch
  - Application Elastic Load Balancer
  - Security Groups
  - IAM
  - CloudWatch Logs
  - Elastic Container service(Fargate)
  - CodeBuild
  - Parameter store
  - Elastic Container Registry

- **Programming Language**: Python 3.x
- **Containerization**: Docker
- **IAM Security**: Custom least privilege policies for ECS task execution and API Gateway

---

# **How the application works**

### **Build Process**

***GitHub:*** 
- The application source code and the Dockerfile are stored in a GitHub repository.

***CodeBuild:***
- Fetches the necessary build parameters from AWS Parameter Store.
- Pulls the application’s source code and Dockerfile from GitHub.
- Builds a Docker image using the Dockerfile.
- Pushes the built Docker image to Amazon Elastic Container Registry (ECR) for storage.

### **Deployment Process**
	
***Elastic Container Registry:***
- Acts as the image storage repository for Docker images.
- The ECS service retrieves the application Docker image from here during deployment.

***Elastic Container Service:***
- Deploys and runs the application as containerised tasks.
- Sends application logs to ECS Logs for monitoring.

***Security Group:***
- Configures inbound and outbound traffic rules to control access to the ECS service.

***Load Balancer:***
- Balances incoming user traffic across the ECS tasks in the target group.

### ***API Gateway***
- Acts as the entry point for users, handling their HTTP requests.
- Uses a DNS name to route requests to the Load Balancer, which in turn forwards traffic to the ECS service hosting the application.

### ***End Result***
- Users interact with the application through the API Gateway.
- The backend infrastructure handles builds, deployments, and scaling efficiently while storing logs for operational visibility.

### **Test the System**
- Use curl or a browser to test:
```bash
curl https://<api-gateway-id>.execute-api.us-east-1.amazonaws.com/prod/sports
```

### **Lessons Learned**
- Setting up a scalable, containerized application with ECS
- Creating public APIs using API Gateway.
- Provision AWS infrastructure using Terraform
- Build Docker image using CodeBuild
- Running   an image of an API on the ECS service.
- Ensure ECS resilience and monitoring using CloudWatch Logs

### **Future Enhancements**
- Add caching for frequent API requests using Amazon ElastiCache
- Add DynamoDB to store user-specific queries and preferences
- Secure the API Gateway using an API key or IAM-based authentication
Implement CI/CD for automating container deployments
- Fetch the API Key from secrets manager using the arn
- Have AWS CodePipeline for CodeBuild to be triggered automatically
- Have GitHub actions automate the whole process


