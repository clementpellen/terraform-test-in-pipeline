variables {
  instance_name = "my-ec2-instance"
  ami_id = "ami-055744c75048d8296"
}

run "valid_instance_name" {
  command = plan

  assert {
    condition = anytrue([
      for instance in data.aws_instances.main.ids : 
        data.aws_instances.main.ids["instance"].tags["Name"] == var.instance_name
    ])
    error_message = "Aucune instance ec2 nommée '${var.instance_name}' n'a été trouvée"
  }
}

# run "valid_ami_id" {
#   command = plan

#   assert {
#     condition = anytrue([
#       for instance in data.aws_instances.main.ids : 
#         data.aws_instances.main.ids["${instance}"].ami == var.ami_id
#     ])
#     error_message = "Aucune instance ec2 avec l'image AMI '${var.ami_id}' n'a été trouvée"
#   }
# }

