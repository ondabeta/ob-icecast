#!/bin/bash

cat /etc/icecast.xml.base | gomplate > /etc/icecast.xml
 
exec "/start.sh" "$@"