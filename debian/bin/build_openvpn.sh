#!/bin/bash

# This script build a patched version of openvpn
# It except a version as argument ex: 2.5.1
# A patch for this version is mandatory
# Patches are loacated in patches/openvpn-v<version>-aws.patch

[[ -z $1 ]] && echo "need to pass a version as first argument ex: 2.6.8" && exit 1
[[ ! -f "patches/openvpn-v$1-aws.patch" ]] && echo "no patch available for this version" && exit 1

rm -rf build_openvpn || True
mkdir build_openvpn
cd build_openvpn

echo -e "\n\033[1;34mRetrieving openvpn-$1 source...\033[m\n"
wget https://swupdate.openvpn.org/community/releases/openvpn-$1.tar.gz
tar xzvf openvpn-$1.tar.gz &>/dev/null
cd openvpn-$1

echo -e "\033[1;34mPatching openvpn...\033[m\n"
patch -p1 < ../../patches/openvpn-v$1-aws.patch

echo -e "\n\033[1;34mBuilding patched openvpn...\033[m\n"
./configure &>/dev/null
make &>/dev/null

echo -e "\033[1;34mCleaning...\033[m\n"
mv ./src/openvpn/openvpn ../../usr/share/aws-vpn/openvpn
cd ../../
rm -rf build_openvpn
echo -e "\033[0;32mPatched openvpn-v$1 done\033[m\n"

exit 0
