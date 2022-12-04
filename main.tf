terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 2.23.1"
    }
  }
}
provider "docker" {
  host = "npipe:////.//pipe//docker_engine" # Comenta esta linea si eres usuario MacOS o Linux
}
resource "docker_image" "microservice" {
  name = "microservice"
  build {
    path = "microservicios/."
    tag = [
      "microservice:latest"
    ]
  }
}
resource "docker_container" "microservice" {
  image = docker_image.microservice.image_id
  name  = "microservice-demo"
  ports {
    internal = 5000
    external = 5000
  }
  depends_on = [
    docker_image.microservice
  ]
}