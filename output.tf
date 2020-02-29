
output "instance_id" {
  value = ["${google_compute_instance.nginx.*.instance_id}"]
}

output "ip" {
  value = ["${google_compute_instance.nginx.*.network_interface.0.network_ip}"]
}

output "externalip" {
  value = ["${google_compute_instance.nginx.*.network_interface.0.access_config.0.nat_ip}"]
}