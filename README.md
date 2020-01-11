# ravencoinOS
Patch/Upgrades for RavencoinOS for Restricted Assets and more

# Instructions for RPI4 upgrade 3.3.1 -> 3.3.3
Make sure you only use this on the rpi november 2019 release for rpi4's. 
i.e. ravencoinOS made using this image https://bootstrap.ravenland.org/dist/ravencoinOS/ravencoinOS-release5-nov-2019-rpi4-latest.img

Ensure you run this as the pi user only. The associated binaries are compiled by Ravenland.

```
wget https://raw.githubusercontent.com/ravenlandpush/ravencoinOS/master/patch-ravencoinOS-nov-2019-rpi4.sh
chmod +x patch-ravencoinOS-nov-2019-rpi4.sh
./patch-ravencoinOS-nov-2019-rpi4.sh
