resource "aws_security_group" "jenkins_master_sg" {
  name        = "jenkins-master-sg"
  description = "Security group for Jenkins Master"
  vpc_id = var.vpc_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH access"
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Jenkins web access"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  
  tags = {
    Name = "jenkins_master_sg"
  }
}

resource "aws_security_group" "jenkins_slave_sg" {
  name        = "jenkins-slave-sg"
  description = "Security group for Jenkins Slave"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH access (optional)"
  }

  ingress {
    from_port   = 50000 
    to_port     = 50000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Jenkins JNLP access from master"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "jenkins-slave-sg"
  }
}