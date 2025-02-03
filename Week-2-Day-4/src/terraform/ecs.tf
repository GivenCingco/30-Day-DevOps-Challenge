# ECS Cluster
resource "aws_ecs_cluster" "api_app_cluster" {
  name = "game-highlights-cluster"
}

# ECS Task Definition
resource "aws_ecs_task_definition" "api_app_task" {
  family                   = "game-highlights-task-family"
  container_definitions    = <<DEFINITION
  [
    {
      "name": "game-highlights-task",
      "image": "${aws_ecr_repository.sportsData_repository.repository_url}:latest",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 8080,
          "hostPort": 8080,
          "protocol": "tcp"
        }
      ],
      "memory": 512,
      "cpu": 256,
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/game-highlights-api-task",
          "awslogs-region": "us-east-1",
          "awslogs-stream-prefix": "ecs"
        }
      },
      "environment": [
        {
        "name": "S3_BUCKET_NAME",
        "value": "${var.aws_s3_bucket}"
      },
      {
        "name": "MEDIACONVERT_ENDPOINT",
        "value": "${var.mediaconvert_endpoint}"
      },
            {
        "name": "AWS_REGION",
        "value": "${var.region}"
      },
      {
        "name": "MEDIACONVERT_ROLE_ARN",
        "value": "${var.mediaconvert_role_arn}"
      }

      ],
          "secrets": [
      {
        "name": "RAPIDAPI_KEY",
        "valueFrom": "${aws_ssm_parameter.rapid_api_key.arn}"
      }
    ]
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
}

# ECS Service
resource "aws_ecs_service" "demo_app_service" {
  name            = "game-highlights-service"
  cluster         = aws_ecs_cluster.api_app_cluster.id
  task_definition = aws_ecs_task_definition.api_app_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  # Reference existing ALB target group
  load_balancer {
    target_group_arn = aws_lb_target_group.alb-target-group.arn
    container_name   = "game-highlights-task"
    container_port   = 8080
  }

  network_configuration {
    subnets          = [data.aws_subnet.az1.id, data.aws_subnet.az2.id]
    assign_public_ip = true
    security_groups  = [module.LoadBalancerSG.security_group_id]
  }

  # Wait for ALB listener to be created before ECS Service
  depends_on = [aws_lb_listener.alb-listerner]
}

# IAM Role for Task Execution
resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "game-highlights-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}