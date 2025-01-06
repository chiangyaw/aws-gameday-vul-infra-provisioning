resource "aws_iam_role" "gameday_role_a" {
  name = "gameday-role-c"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role" "gameday_role_b" {
  name = "gameday-role-b"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "gameday_policy_a" {
  name = "gameday-policy-a"
  role = aws_iam_role.gameday_role_a.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
            "s3:*"
        ]
        Effect   = "Allow"
        Resource = [
          aws_s3_bucket.gameday_s3_bucket.arn,
          "${aws_s3_bucket.gameday_s3_bucket.arn}/*"
        ]

      }
    ]
  })
}

resource "aws_iam_role_policy" "gameday_policy_b" {
  name = "gameday-policy-b"
  role = aws_iam_role.gameday_role_b.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
            "dynamodb:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}



resource "aws_iam_instance_profile" "gameday_profile_a" {
  name = "gameday-profile-a"
  role = "${aws_iam_role.gameday_role_a.name}"
}

resource "aws_iam_instance_profile" "gameday_profile_b" {
  name = "gameday-profile-b"
  role = "${aws_iam_role.gameday_role_b.name}"
}