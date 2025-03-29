
# resource "aws_autoscaling_group" "jenkins_master" {
      
# }

resource "aws_launch_template" "jenkins_master_image" {
  image_id = "ami-084568db4383264d4" // Ubuntu Server 24.04 LTS
   tags = {
      Name = "jenkins_master_image"
    }
    user_data = filebase64("${path.module}/jenkins-master-setup.sh")
}