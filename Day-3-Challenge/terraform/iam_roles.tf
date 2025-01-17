// Define IAM Role
resource "aws_iam_role" "glue" {
 name = "GlueServiceRole"
 assume_role_policy = jsonencode({
 "Version": "2012–10–17",
 "Statement": [
 {
 "Action": "sts:AssumeRole",
 "Principal": {
 "Service": "glue.amazonaws.com"
 },
 "Effect": "Allow",
 },
 ]
 })
}

// Attach Policy
resource "aws_iam_role_policy_attachment" "glue" {
 role = aws_iam_role.glue.name
 policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}