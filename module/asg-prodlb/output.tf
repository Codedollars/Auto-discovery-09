output "Load_Balancer_dns" {
  value = aws_lb.prod_alb.dns_name
}
output "Load_Balancer_zone_id" {
  value = aws_lb.prod_alb.zone_id
}
output "Load_Balancer_arn" {
  value  = aws_lb.prod_alb.arn
}
output "tg_arn" {
  value = aws_lb_target_group.prod_tg.arn
}