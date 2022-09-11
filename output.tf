output "cicd-appip" {
 value =   
}

output "cicd-pubdns" {
value = aws_instance.apache.public_dns
}



output "apacheip" {
value = aws_instance.apache.public_ip
}

output "apachepubdns" {
value = aws_instance.apache.public_dns
}