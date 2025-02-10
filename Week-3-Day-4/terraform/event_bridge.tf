# EventBridge Rule for Scheduling
resource "aws_cloudwatch_event_rule" "nba_schedule" {
  name                = "nba_game_alerts_schedule"
  schedule_expression = "rate(2 hours)" # Adjust as needed
}

# EventBridge Target
resource "aws_cloudwatch_event_target" "nba_target" {
  rule      = aws_cloudwatch_event_rule.nba_schedule.name
  target_id = "nba_lambda"
  arn       = aws_lambda_function.nba_lambda.arn
}

