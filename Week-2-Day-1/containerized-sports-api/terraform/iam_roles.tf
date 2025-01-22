/* ============================== CodeBuild IAM Role ================================*/
# Assume the default service role created by CodeBuild
resource "aws_iam_role" "codebuild_default_role" {
  name               = "CodeBuildBasePolicy-SportDataAPI-us-east-1"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Policy: S3 Access
resource "aws_iam_policy" "codebuild_s3_access_policy" {
  name        = "CodeBuildS3AccessPolicySportsDataAPI"
  description = "Policy to allow CodeBuild to access S3 artifacts"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::SportDataAPI-codepipeline-bucket",
                "arn:aws:s3:::SportDataAPI-codepipeline-bucket/*"
            ]
        }
    ]
}
EOF
}

# Policy: Base Policy for CodeBuild
resource "aws_iam_policy" "codebuild_base_policy" {
  name        = "CodeBuildBasePolicy-SportDataAPI-CodeBuild"
  description = "Policy for SportDataAPI CodeBuild"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:us-east-1:${var.account_id}:log-group:/aws/codebuild/SportDataAPICodeBuild",
                "arn:aws:logs:us-east-1:${var.account_id}:log-group:/aws/codebuild/SportDataAPICodeBuild:*",
                "arn:aws:logs:us-east-1:${var.account_id}:log-group:CodeBuildSportsData:*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::SportDataAPI-codepipeline-bucket", 
                "arn:aws:s3:::SportDataAPI-codepipeline-bucket/*" 
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::codepipeline-us-east-1-*"
            ],
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:GetObjectVersion",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "codebuild:CreateReportGroup",
                "codebuild:CreateReport",
                "codebuild:UpdateReport",
                "codebuild:BatchPutTestCases",
                "codebuild:BatchPutCodeCoverages"
            ],
            "Resource": [
                "arn:aws:codebuild:us-east-1:${var.account_id}:report-group/SportDataAPICodeBuild-*"
            ]
        }
    ]
}
EOF
}

# Policy: CloudWatch Logs
resource "aws_iam_policy" "codebuild_cloudwatch_logs_policy" {
  name        = "CodeBuildCloudWatchLogsPolicy-SportDataAPICodeBuild"
  description = "Policy for CloudWatch Logs in CodeBuild"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:us-east-1:${var.account_id}:log-group:CodeBuildSportDataAPI:*",
                "arn:aws:logs:us-east-1:${var.account_id}:log-group:CodeBuildSportDataAPI:log-stream:*"
            ]
        }
    ]
}
EOF
}

# Policy: CodeStar Connections
resource "aws_iam_policy" "codebuild_connections_policy" {
  name        = "CodeBuildCodeConnectionsSourceCredentialsPolicy-SportDataAPICodeBuild"
  description = "Policy for CodeStar Connections in CodeBuild"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "codestar-connections:GetConnectionToken",
                "codestar-connections:GetConnection",
                "codeconnections:GetConnectionToken",
                "codeconnections:GetConnection",
                "codeconnections:UseConnection"
            ],
            "Resource": [
                "arn:aws:codestar-connections:us-east-1:${var.account_id}:connection/e45787a2-fc5d-453f-a71f-58608f57d13b",
                "arn:aws:codeconnections:us-east-1:${var.account_id}:connection/e45787a2-fc5d-453f-a71f-58608f57d13b"
            ]
        }
    ]
}
EOF
}

# Attach Policies to CodeBuild Role
resource "aws_iam_role_policy_attachment" "codebuild_s3_access_policy_attachment" {
  role       = aws_iam_role.codebuild_default_role.name
  policy_arn = aws_iam_policy.codebuild_s3_access_policy.arn
}

resource "aws_iam_role_policy_attachment" "codebuild_base_policy_attachment" {
  role       = aws_iam_role.codebuild_default_role.name
  policy_arn = aws_iam_policy.codebuild_base_policy.arn
}

resource "aws_iam_role_policy_attachment" "codebuild_cloudwatch_logs_policy_attachment" {
  role       = aws_iam_role.codebuild_default_role.name
  policy_arn = aws_iam_policy.codebuild_cloudwatch_logs_policy.arn
}

resource "aws_iam_role_policy_attachment" "codebuild_connections_policy_attachment" {
  role       = aws_iam_role.codebuild_default_role.name
  policy_arn = aws_iam_policy.codebuild_connections_policy.arn
}

resource "aws_iam_role_policy_attachment" "attach_ec2_instance_profile_policy" {
  role       = aws_iam_role.codebuild_default_role.name
  policy_arn = "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"
}