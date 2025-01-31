resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/SportDataAPI-api-task"
  retention_in_days = 7 # Adjust this based on how long you want to retain logs
}
