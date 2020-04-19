#get region details
data "aws_region" "myregion" {}
#get availability zone details
data "aws_availability_zones" "myavailabilityzones" {}
#get account details
data "aws_caller_identity" "myidentity" {}
