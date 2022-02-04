module "remote_exec" {
  source = "../module"
  project_id = var.mproject_id
  region = var.mregion
  zone = var.mzone
  path = var.mpath
  privatekeypath = var.mprivatekeypath
  user = var.muser
}