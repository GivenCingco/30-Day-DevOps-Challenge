resource "aws_codebuild_project" "bitcube_codebuild" {
  name          = "game-highlights"
  description   = "CodeBuild project for Sports data application"
  build_timeout = 60

  source {
    type      = "GITHUB"
    location  = "https://github.com/GivenCingco/30-Day-DevOps-Challenge.git"
    buildspec = "Week-2-Day-4/src/buildspec.yml"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:5.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.region
    }

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = var.account_id
    }

    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = var.image_repo_name
    }

    environment_variable {
      name  = "IMAGE_TAG"
      value = var.image_tag
    }
  }

  service_role = aws_iam_role.codebuild_default_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "CodeBuildSportsData"
      stream_name = "buildlogs"
      status      = "ENABLED"
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}