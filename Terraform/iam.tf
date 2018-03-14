# note the role SSMReadOnlyAccess was created manually in IAM

# IAM Instance Profile called SSMReadOnlyAccess for Ansible Control Instance.
# Instance Profile = SSMReadOnlyAccess, Role = SSMReadOnlyAccess, Policy = AmazonSSMReadOnlyAccess
resource "aws_iam_instance_profile" "ansiblecontrol_instance_profile" {	    
    name = "Ansible_AmazonSSMReadOnlyAccess"
    role = "SSMReadOnlyAccess"  # the name of the role created in IAM
}