resource "aws_iam_user" "jenkins" {
  name = "jenkins"
}

resource "aws_iam_access_key" "jenkins_access_key" {
  user = aws_iam_user.jenkins.name
}

resource "aws_iam_policy" "jenkins_policy" {
  name = "jenkins_policy"
  policy = file("${path.module}/iam_policy.json")
}

resource "aws_iam_user_policy_attachment" "jenkins_policy_attachment" {
  user       = aws_iam_user.jenkins.name
  policy_arn = aws_iam_policy.jenkins_policy.arn
}