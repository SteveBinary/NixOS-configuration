{
  virtualisation.oci-containers.containers.grafana = {
    image = "docker.io/grafana/grafana-oss:12.0.1";
    environment = {
      TZ = "Europe/Berlin";
    };
    ports = [
      "3000:3000"
    ];
    volumes = [
      "grafana-data:/var/lib/grafana"
    ];
  };
}
