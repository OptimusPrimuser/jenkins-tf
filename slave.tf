
# resource "aws_autoscaling_group" "jenkins_master" {
      
# }
resource "aws_launch_template" "jenkins_slave_image" {
    name = "jenkins_slave_image"
  image_id = "ami-084568db4383264d4" // Ubuntu Server 24.04 LTS
   tags = {
      Name = "jenkins_slave_image"
    }
    key_name = var.keypair_name
    block_device_mappings {
        device_name = "/dev/sda1"
        ebs {
            volume_size = var.slave_volume_size
            volume_type = var.slave_volume_type
        }
    }
    instance_type = "t2.micro"
    user_data = base64encode(templatefile("${path.module}/jenkins-slave-setup.tftpl", {
    jenkins_master_public_ip = data.aws_instance.master_instance.public_ip
    jenkins_admin_password   = var.jenkins_admin_password
  }))
}

resource "aws_autoscaling_group" "slave_asg" {
    name = "slave_jenkins_asg"
    availability_zones = [ "us-east-1a" ]
    min_size = 1
    max_size = 1
    vpc_zone_identifier = [
      var.private_subnet
    ]
    launch_template {
      id = aws_launch_template.jenkins_slave_image.id
    }
    depends_on = [ aws_launch_template.jenkins_slave_image ]

}