#!/bin/bash

cd usr/share/aws-vpn/

echo -e "\n\033[1;34mBuilding go_server\033[m\n"

go mod init go_server
go build
rm go_server.go

echo -e "\n\033[1;34mBuilding go_server done\033[m\n"

exit 0
