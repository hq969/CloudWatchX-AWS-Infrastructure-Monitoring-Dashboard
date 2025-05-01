#!/bin/bash
sudo yum install -y grafana
sudo systemctl start grafana-server
sudo systemctl enable grafana-server
