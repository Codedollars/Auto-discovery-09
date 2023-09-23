output "Load_Balancer_dns" {
  value = aws_lb.stage_alb.dns_name
}
output "Load_Balancer_zone_id" {
  value = aws_lb.stage_alb.zone_id
}
output "Load_Balancer_arn" {
  value  = aws_lb.stage_alb.arn
}
output "tg_arn" {
  value = aws_lb_target_group.stage_tg.arn
}