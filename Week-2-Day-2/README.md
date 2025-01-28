
# NCAA Game Highlights

## Project Overview
This project uses RapidAPI to obtain NCAA game highlights using a Docker container and uses AWS Media Convert to convert the media file.

## Features
- ***Fetch Highlights***: Download videos from the API, upload them to S3, and optimise their quality using AWS MediaConvert (e.g., resolution adjustments).
- ***Process Videos***: Download videos from the API, upload them to S3, and optimise their quality using AWS MediaConvert (e.g., resolution adjustments, audio quality, etc.).
- ***AWS MediaConvert***: Convert video files from one format to another, supporting a wide variety of formats like MP4, MOV, MKV, and more.
- ***Storage***: Use Amazon S3 for storing large files, including video content.

## Project Files Overview

### ***config.py***
This code configures a project to fetch sports highlights, process videos using AWS MediaConvert, and store data in S3. It relies on environment variables for API settings, AWS resources, file paths, and retry/delay parameters, with default values provided for most configurations.

### ***fetch.py***
This script fetches basketball highlights from an external API and uploads them to an Amazon S3 bucket.
- Fetching highlights: The ***fetch_highlights function*** retrieves highlights using API credentials, date, league name, and a limit for the number of results. It handles errors if the API request fails.
- Saving to S3: The ***save_to_s3 function*** checks if the specified S3 bucket exists, creates it if needed, and uploads the highlights as a JSON file to the bucket.
- Workflow orchestration: The ***process_highlights function*** combines the fetching and saving steps, ensuring that highlights are retrieved and stored efficiently.

### ***process_one_video.py***
This script processes a single video from a JSON file stored in S3 and uploads it back to S3.
- Fetch input: The ***process_one_video function*** connects to S3, retrieves a JSON file using the INPUT_KEY, and extracts the first video URL.
- Download video: It makes an HTTP request to download the video content, using BytesIO to handle the video data in memory.
- Upload to S3: The video is uploaded to the specified S3 bucket using the OUTPUT_KEY.
- Error handling: The script catches and logs exceptions that occur during the process.


### ***mediaconvert_process.py***

This script creates an AWS MediaConvert job to process a video stored in an S3 bucket. It uses a defined set of configurations for input, output, video, and audio settings, then submits the job for processing.

### ***run_all.py***
Runs the scripts in a chronological order and provides buffer time for the tasks to be created.

### ***.env***
This file stores all over the environment variables, these are variables that we don't want to hardcode into our script.

### ***Dockerfile***
Provides the step by step approach to build the image.

## **Technologies**
- **Cloud Provider**: AWS
- **Services used**: 
  - AWS MediaConvert
  - Amazon Simple Storage Service
  - IAM
  

- **Programming Language**: Python 3.x
- **Containerization**: Docker
- **IAM Security**: Custom least privilege policies for ECS task execution and API Gateway

# Step by step

## **1** Create Rapidapi Account
Rapidapi.com account, will be needed to access highlight images and videos.

For this example we will be using NCAA (USA College Basketball) highlights since it's included for free in the basic plan.

[Sports Highlights API](https://rapidapi.com/highlightly-api-highlightly-api-default/api/sport-highlights-api/playground/apiendpoint_16dd5813-39c6-43f0-aebe-11f891fe5149) is the endpoint we will be using 

## **2** Verify prerequites are installed 

Ensure Docker, Python3, and the AWS CLI are installed on your iOS device to run the application locally. Additionally, confirm that your AWS credentials are configured on the device.

***Check Docker version***
```bash
docker --version
```

***Check AWS CLI version***
```bash
aws --version
```

***Check Python3 version***

```bash
python3 --version
```

## **Technical Diagram**
![Alt Text](/Week-2-Day-2/NCAAGameHighlights/src/Week-2-Day-2.drawio.png)

## **Project Structure**
```bash
src/
├── Dockerfile
├── config.py
├── fetch.py
├── mediaconvert_process.py
├── process_one_video.py
├── requirements.txt
├── run_all.py
├── .env
├── .gitignore
└── terraform/
    ├── main.tf
    ├── variables.tf
    ├── secrets.tf
    ├── iam.tf
    ├── ecr.tf
    ├── ecs.tf
    ├── s3.tf
    ├── container_definitions.tpl
    └── outputs.tf
```

# START HERE - Local
## **Step 1: Clone The Repo**
```bash
git clone https://github.com/alahl1/NCAAGameHighlights.git
cd src
```
## **Step 2: Add API Key to AWS Secrets Manager**
Run the code below on your terminal
```bash
aws secretsmanager create-secret \
    --name my-api-key \
    --description "API key for accessing the Sport Highlights API" \
    --secret-string '{"api_key":"YOUR_ACTUAL_API_KEY"}' \
    --region us-east-1
```

## **Step 3: Create an IAM role or user**

In the search bar type "IAM" 

Click Roles -> Create Role

For the Use Case enter "S3" and click next

Under Add Permission search for AmazonS3FullAccess, MediaConvertFullAccess and AmazonEC2ContainerRegistryFullAccess and click next

Under Role Details, enter "HighlightProcessorRole" as the name

Select Create Role

Find the role in the list and click on it
Under Trust relationships
Edit the trust policy to this:
Edit the Trust Policy and replace it with this:
```bash
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com",
          "ecs-tasks.amazonaws.com",
          "mediaconvert.amazonaws.com"
        ],
        "AWS": "arn:aws:iam::<"your-account-id">:user/<"your-iam-user">"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

## **Step 4: Update .env file**
1. RapidAPI_KEY: Ensure that you have successfully created the account and select "Subscribe To Test" in the top left of the Sports Highlights API
2. AWS_ACCESS_KEY_ID=your_aws_access_key_id_here
3. AWS_SECRET_ACCESS_KEY=your_aws_secret_access_key_here
4. S3_BUCKET_NAME=your_S3_bucket_name_here
5. MEDIACONVERT_ENDPOINT=https://your_mediaconvert_endpoint_here.amazonaws.com
```bash
aws mediaconvert describe-endpoints
```
7. MEDIACONVERT_ROLE_ARN=arn:aws:iam::your_account_id:role/HighlightProcessorRole

## **Step 5: Secure .env file**
```bash
chmod 600 .env
```
## **Step 6: Locally Buikd & Run The Docker Container**
Run:
```bash
docker build -t highlight-processor .
```

Run the Docker Container Locally:
```bash
docker run --env-file .env highlight-processor
```
           
This will run fetch.py, process_one_video.py and mediaconvert_process.py and the following files should be saved in your S3 bucket:

![Alt Text](/Week-2-Day-2/NCAAGameHighlights/src/Screenshot%202025-01-28%20at%2014.20.38.png)


### **What We Learned**
1. Working with Docker and AWS Services
2. Identity Access Management (IAM) and least privilege
3. How to enhance media quality 

### **Future Enhancements**
1. Using Terraform to enhance the Infrastructure as Code (IaC)
2. Increasing the amount of videos process and converted with AWS Media Convert
3. Change the date from static (specific point in time) to dyanmic (now, last 30 days from today's date,etc)

