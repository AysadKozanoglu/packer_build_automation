#### packer qmeu-kvm template for debian / pardus 

Fully automated installation for  Debian 9 stretch, 10 buster, pardus 19.0 with packer preseed automation into qemu-kvm Virtualisation


### supported platforms
QEMU-KVM (qcow2)


### QEMU-KVM 
 - QEMU with KVM
 - Debian Preseed
 - Ansible

### Key Features

- Partitioning with LVM
- Enables persistent network names
- Enables serial console

packer automatation for qemu-kvm debian stretch
<pre>
./build.sh qemu-kvm
</pre>


update iso checksum
<pre>
./update-iso-checksum.sh
</pre>


### CD-IMAGES and CheckSum Repo
http://aysad.pe.hu/packages/cd-images/


### Screencast

![screenhot](https://github.com/AysadKozanoglu/packer_build_automation/raw/master/packer_build_screenshot.png)


this repo is Build for Tübitak


Aysad Kozanoglu



