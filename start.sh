#!/bin/sh
env
set -x
chown -R icecast /var/log/icecast
supervisord -n -c /etc/supervisord.conf