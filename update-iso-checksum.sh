#!/bin/bash -x

# Author: Aysad Kozanoglu
#  email: aysadx@gmail.com
#    web: aysad.pe.hu
#    git: https://github.com/AysadKozanoglu/packer_build_automation
#
#    NOT:
#      en son iso versiyonu indirir ve degiskenleri aktüellestirir
#      
#

#
# Build for Tübitak
#


TEMPLATE_FILENAME="packer-debStretch-qemu-kvm.json"


for paket in jq curl sed awk; do which $paket || { echo "HATA: '$paket' bulunamadi"; exit 1; }; done

iso_checksum_type="$(jq --raw-output '.variables.iso_checksum_type' ${TEMPLATE_FILENAME})"
     iso_file_url="$(jq --raw-output '.variables.dynamic_mirror_url' ${TEMPLATE_FILENAME})"
    iso_file_name="$(jq --raw-output '.variables.iso_name' ${TEMPLATE_FILENAME})"
 new_iso_checksum=$(curl -svL ${iso_file_url}/$(echo ${iso_checksum_type} | awk '{print toupper($0)}')SUMS | grep ${iso_file_name} | awk '{ print $1 }')

sed -r -e "s/(\"iso_checksum\"\:\ \")([a-fA-F0-9]+)(\",)/\1${new_iso_checksum}\3/g" -i ${TEMPLATE_FILENAME}
