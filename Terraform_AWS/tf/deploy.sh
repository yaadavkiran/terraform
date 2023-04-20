#!/bin/bash
basedir="terraform"
JOBID=$1
python3 main.py ${basedir}

###


cd ${basedir}
terraform init
terraform plan
terraform apply -auto-approve