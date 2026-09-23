#!/bin/bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

apt-get update -y
apt-get install -y nginx

TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600" -s)

INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" \
  -s http://169.254.169.254/latest/meta-data/instance-id)

PUBLIC_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" \
  -s http://169.254.169.254/latest/meta-data/public-ipv4)

PRIVATE_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" \
  -s http://169.254.169.254/latest/meta-data/local-ipv4)

AVAILABILITY_ZONE=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" \
  -s http://169.254.169.254/latest/meta-data/placement/availability-zone)

INSTANCE_TYPE=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" \
  -s http://169.254.169.254/latest/meta-data/instance-type)

cat <<HTML > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>${project_name}</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background: #f0f0f0; }
        .container { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        h1 { color: #333; }
        .info-item { margin: 10px 0; padding: 10px; background: #f9f9f9; border-left: 3px solid #4CAF50; }
        .label { font-weight: bold; color: #555; }
    </style>
</head>
<body>
    <div class="container">
        <h1>${project_name}</h1>
        <p>Hello from Terraform practice instance!</p>

        <div class="info-item">
            <span class="label">Instance ID:</span> $INSTANCE_ID
        </div>
        <div class="info-item">
            <span class="label">Instance Type:</span> $INSTANCE_TYPE
        </div>
        <div class="info-item">
            <span class="label">Public IP:</span> $PUBLIC_IP
        </div>
        <div class="info-item">
            <span class="label">Private IP:</span> $PRIVATE_IP
        </div>
        <div class="info-item">
            <span class="label">Availability Zone:</span> $AVAILABILITY_ZONE
        </div>
    </div>
</body>
</html>
HTML

systemctl enable nginx
systemctl restart nginx
