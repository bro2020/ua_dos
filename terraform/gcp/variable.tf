variable "alias_prov" {
  type = map(any)
  default = {
    Frankfurt = {
      project_id = "ua-dos"
      cred       = "./keys/ua-dos-066ea1882365.json"
      regs       = "europe-west3"
      zones      = "europe-west3-b"
    }
  }
}

variable "node_var" {
  type = map(any)
  default = {
    type_instance = [
      "e2-micro",
      #"e2-micro"
    ]
    distr = [
      "debian-cloud/debian-11",
      "debian-cloud/debian-11"
    ]
    ssh_users = [
      "bro",
      "bro"
    ]
    ssh_key_files = [
      "./keys/id_rsa.pub",
      "./keys/id_rsa2.pub"
    ]
  }
}
