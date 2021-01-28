#!/bin/bash

tee /etc/consul.d/jenkins_master.json > /dev/null <<"EOF"
{
  "service": {
    "id": "jenkins-8080",
    "name": "jenkins",
    "tags": ["jenkins"],
    "port": 80,
    "checks": [
      {
        "id": "tcp",
        "name": "TCP on port 8080",
        "tcp": "localhost:8080",
        "interval": "10s",
        "timeout": "1s"
      },
      {
        "id": "http",
        "name": "HTTP on port 8080",
        "http": "http://localhost:8080/",
        "interval": "30s",
        "timeout": "1s"
      },
      {
        "id": "service",
        "name": "docker service",
        "args": ["systemctl", "status", "docker.service"],
        "interval": "60s"
      }
    ]
  }
}
EOF

systemctl stop consul.service
systemctl start consul.service

exit 0