resource "helm_release" "prowler_release" {
  name      = "prowler"
  namespace = "prowler"
  create_namespace = true
  
  repository          = "oci://897729109735.dkr.ecr.us-east-1.amazonaws.com"
  chart               = "prowler-api"
  version             = "0.1.0"
  values = [
    "${file("prowler.yaml")}"
  ] 
 
}

