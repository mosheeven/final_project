#!/bin/bash 

tee /etc/consul.d/jenkins_slave.json > /dev/null <<"EOF"
{
  "service": {
    "id": "jenkins-slave",
    "name": "jenkins-slave",
    "tags": ["jenkins-salve"],
    "port": 80,
    "checks": [
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