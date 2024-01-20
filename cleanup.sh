#!/bin/bash
juju destroy-controller --destroy-storage localhost
sudo /usr/sbin/remove-juju-services
sudo snap remove juju --purge
