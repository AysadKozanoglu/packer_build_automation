#!/bin/bash

# Author: Aysad Kozanoglu
#  email: aysadx@gmail.com
#    web: aysad.pe.hu
#    git: https://github.com/AysadKozanoglu/packer_build_automation

#
# Build for Tübitak
#


      KURULUM_TIPI=$1

  QEMUPACKERBUILDER=packer-debStretchi-qemu-kvm.json

    INFO_ERR_PACKER="HATA: 'packer' bulunamadi. \n Devam etmek icin önce packer kur. \n YARDIM LINK:\n https://www.packer.io/intro/getting-started/install.html "
    
       INFO_ERR_KVM="HATA: 'qemu-system-x86_64' bulunamadi. \n Devam etmek icin önce qemu-kvm kur.\n YARDIM: \n DEBIAN: apt install qemu qemu-kvm \n CENTOS: yum install qemu-kvm libvirt libvirt-python libguestfs-tools virt-install "

#  INFO_ERR_ANSIBLE="HATA: 'ansible' bulunamadi. \n Devam etmek icin  önce ansible  kur.\n YARDIM: \n DEBIAN: apt install ansible \n CENTOS(7): yum install ansible "


function YARDIM() {
    echo -e "

    Debian 9 Stretch preesed kurulum bazinda KVM QEMU icin packer ile otomatik  kurulum yapmaktadir

    örnek: $0 qemu-kvm

    
    Ana sistemde gereken paketler:
    + packer, qemu-kvm

    packer kurmak  icin oku:
    WEB: https://www.packer.io/intro/getting-started/install.html

    qemu-kvm kurmak icin:
    DEBIAN: apt install qemu qemu-kvm 
    CENTOS: yum install qemu-kvm libvirt libvirt-python libguestfs-tools virt-install 


    --
    Aysad Kozanoglu - Build for Tuebitak
"
    exit 1
}


if [[ $1 != "qemu-kvm" ]] ; then
    echo "Kurulum opsiyonu bulunamadi. opsiyonlar: qemu-kvm"
    YARDIM
    exit 1
fi

function KURULUM_BASLAT() {
   packer build $@ ./$QEMUPACKERBUILDER
}

GET_OSINFO=`echo $GET_OSINFO | grep  -E -i "debian" -c`

if [[ $GET_OSINFO == "1" ]] ; then
	which  qemu-system-x86_64 >  /dev/null || {  echo -e $INFO_ERR_PACKER; exit 1; }
  else
	which  qemu-kvm >  /dev/null || {  echo -e $INFO_ERR_PACKER; exit 1; }  	
fi

which packer  >  /dev/null || {  echo -e $INFO_ERR_PACKER; exit 1; }
# which ansible > /dev/null  || { echo -e $INFO_ERR_ANSIBLE; exit 1; }


#
# NOT: ilerde BUILD_REF kullanmak icin hazirlik
# [[ -z ${BUILD_REF+x} ]] || [[ ${BUILD_REF} == "" ]] && export BUILD_REF=$(git describe --tags)
#

if [[ $KURULUM_TIPI == "qemu-kvm" ]] ; then
    shift 1
    KURULUM_BASLAT
else
    YARDIM
fi
