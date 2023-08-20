##########################
# TAGGING MODULE
##########################

module "tagging" {
  source = "../common_modules/tagging"

  environment    = local.global_tags.environment
  provisioned_by = local.global_tags.provisioned_by
  project        = local.global_tags.project
  owner          = local.global_tags.owner
  name           = local.global_tags.name
}

########################
#S3 MODULE LAB04
########################

# module "s3" {
#   source = "../common_modules/s3_lab04"

#   for_each = local.configuration.s3

#   global_variables = local.global_variables
#   #module_name      = each.value.module_name
#   bucket_name = each.value.bucket_name
#   suffix = each.value.suffix
#   error = each.value.error
#   acl = each.value.acl
#   tags             = module.tagging.tags
# }


#########################
#S3 MODULE
#########################

# module "s3" {
#   source = "../common_modules/s3"

#   for_each = local.configuration.s3

#   global_variables = local.global_variables
#   module_name      = each.value.module_name
#   tags             = module.tagging.tags
# }

# module "ec2" {
#   source = "../common_modules/ec2"

#   for_each = local.configuration.ec2

#   tags = module.tagging.tags
#   instance_type = each.value.instance_type
#   ami = each.value.ami
#   key_name = each.value.key_name
#   user_data = each.value.user_data

#########################
#EC2 MODULE LAB03
#########################
# module "ec2" {
#   source = "../common_modules/ec2"
#   depends_on = [module.vpc]

#   for_each = local.configuration.ec2

#   # global_variables = local.global_variables
#   name             = each.value.name
#   tags             = module.tagging.tags
#   instance_type    = each.value.instance_type
#   ami              = each.value.ami
#   key_pair         = each.value.key_pair
#   user_data        = each.value.user_data
#   subnet_ids       = module.vpc[each.value.vpc_name].subnets
#   sg_ids           = module.vpc[each.value.vpc_name].sg
#   subnet_name      = each.value.subnet_name
#   sg_name          = each.value.sg_name
#   vpc_name         = each.value.vpc_name
# }


# # }

# ##########################
# # VPC MODULE
# ##########################

module "vpc" {
  source = "../common_modules/networking"

  for_each = local.configuration.vpc

  tags                   = module.tagging.tags
  vpc_name               = each.value.vpc_name
  vpc_cidr_block         = each.value.vpc_cidr_block
  subnet_configs         = each.value.subnet_configs
  cidr_block_rtb_public  = each.value.cidr_block_rtb_public
  cidr_block_rtb_private = each.value.cidr_block_rtb_private
  sg_configs             = each.value.sg_configs
}

###########################
# # ASG MODULE
# ##########################

module "asg" {
  source = "../common_modules/asg"

  for_each = local.configuration.asg

  ami                = each.value.ami
  instance_type      = each.value.instance_type
  key_pair           = each.value.key_pair
  user_data          = each.value.user_data
  web_name           = each.value.web_name
  sg_asg             = module.vpc["vpc_test"].sg_private
  autoscalling_web   = each.value.autoscalling_web
  desired_capacity   = each.value.desired_capacity
  min_size           = each.value.min_size
  max_size           = each.value.max_size
  private_subnet_asg = module.vpc["vpc_test"].private_subnets_id
  target_group_arns  = module.alb["alb-web"].aws_lb_target_group_web_arn

}

# ##########################
# # ALB MODULE
# ##########################

module "alb" {
  source = "../common_modules/alb"

  for_each = local.configuration.alb

  alb_name           = each.value.alb_name
  internal           = each.value.internal
  load_balancer_type = each.value.load_balancer_type
  sg_alb             = module.vpc["vpc_test"].sg_public
  subnet_alb         = module.vpc["vpc_test"].public_subnets_id
  alb_tg_name        = each.value.alb_tg_name
  port               = each.value.port
  protocol           = each.value.protocol
  vpc_id             = module.vpc["vpc_test"].vpc_name.id
  alb_listener_port  = each.value.alb_listener_port
}

