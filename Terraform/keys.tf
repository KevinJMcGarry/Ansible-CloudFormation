// actual key file path stored in vars

resource "aws_key_pair" "mykeypair" {
  key_name = "Ansible-TF-Docker-Keypair"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}