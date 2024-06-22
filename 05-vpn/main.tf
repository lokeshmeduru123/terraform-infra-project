resource "aws_key_pair" "vpn" {
  key_name   = "vpn"
  # you can paste the public key directly like this
  #public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL6ONJth+DzeXbU3oGATxjVmoRjPepdl7sBuPzzQT2Nc sivak@BOOK-I6CR3LQ85Q"
  #public_key = file("~/.ssh/vpn.pub")
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDQG4WA4MtzbkY1M2zzmOPt960xGqiM0WCH+RDgDOM3cqFA2GmC7UzCAwwbPOqC0T8flOeF9ohOAvfyIAgW+IGEQWRE3xUzINxUPx0SENh9gzDCUU4KAqIJRc8FRGI7adH6U86I3yxuDnN3Vi5NlHVb0A1IfftyZuuQEp9uA07mCvlWgccNNW+XSwxlrvteyd0OcSXRdAmD41B2fv7ca8nEA5dpITgsPEh7TzVzFjjuStF+UOtfQDEqOeybK7Kt1Q7vHW8mj8anAUYQGojSrOn/C3zmaDNIjU7+KvlJ6qhyr+A+v19/IijgN1oSPd0tbhQ6gQ9sO5Aeat69yPtL3Wt2/kAuoJxEU3Y6NadOu4dd6RAxpuuyKsOXzEIwpzzhwaRNa43HnRSoqVL0OmQL48L3CS23eCCq52jvKHGw+oZgBgXEWFvL4DWywMDr3JlXdSkcc/RY1hS2mXf+a47BvJRANjniNDtG/o37AeLssUUalHIORirGNbBoSSgd8J/py78= lokesh@lokesh-HP-Pavilion-Notebook"
  # ~ means windows home directory
}


module "vpn" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  key_name = aws_key_pair.vpn.key_name
  name = "${var.project_name}-${var.environment}-vpn"

  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
  # convert StringList to list and get first element
  subnet_id = local.public_subnet_id
  ami = data.aws_ami.ami_info.id
  
  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-vpn"
    }
  )
}