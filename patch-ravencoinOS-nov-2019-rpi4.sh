# RavencoinOS Upgrade from Ravencoin 3.1.0 (develop) to 3.3.0 (production restricted assets)
# QT 5 support (GUI included).
# Official Download only at
# https://bootstrap.ravenland.org/ravencoinOS/restricted-assets-patch-rpi4-raven3.3.0-qt-latest.tar.gz
# author: push@ravenland.org, ravencoinos.org by extension.
# description: A simple script for upgrading the latest ravencoin rpi4 image to support the restricted assets fork
# includes some extra stuff to tidy up a bit.
# WARNING only use on ravencoinOS-release5-nov-2019-rpi4-latest.img release (THIS WILL LIKELY BREAK VERSIONS OLDER THAN THIS)
# IF YOU RUN RPI3 wait for the RPI3 PATCH OR RE-RELEASE.


cd ~pi

echo "stopping ipfs and ravend services...";
sleep 2;
sudo systemctl stop ipfs
sudo systemctl stop ravend

echo "Please wait patiently.... do not interupt me";
echo "Don't worry your wallet wont be overwritten...";
sleep 5;

echo "Removing old installations..."
rm -rf ~pi/raven-3.2.0-qt 

# wget ravencoinOS release
wget https://bootstrap.ravenland.org/ravencoinOS/restricted-assets-patch-rpi4-raven3.3.0-qt-latest.tar.gz

# untar contents
tar zxvf restricted-assets-patch-rpi4-raven3.3.0-qt-latest.tar.gz


echo "deleting old binaries..."
sudo rm /bin/ravend;sudo rm /bin/raven-qt;sudo rm /bin/raven-cli

echo "replacing new binaries..."
sudo cp -rp ~pi/raven-3.3.0-qt/bin/* /bin;

echo "updating systemctl unit files..."; sleep 2;
sudo sed -i "s,raven-3.2.0,raven-3.3.0,g" /etc/systemd/system/multi-user.target.wants/ravend.service
sudo sed -i "s,raven-3.2.0,raven-3.3.0,g" /lib/systemd/system/ravend.service

echo "refreshing systemctl unit files"; sleep 2;
sudo systemctl daemon-reload;
sudo sed -i 's/raven-3.2.0/raven-3.3.0/g' /home/pi/launchwalletnow.sh





echo "add correct permissions and put raven-qt in correct path..."
sudo mv /home/pi/raven-3.3.0-qt/bin/* /home/pi/raven-3.3.0-qt/
sudo chmod +x /home/pi/raven-3.3.0-qt/*

# Resetting Permissions for pi user and binary execution bit
sudo chmod +x /bin/ravend; sudo chmod +x /bin/raven-cli; sudo chmod +x /bin/raven-qt;
sudo chown -R pi:pi /home/pi;

echo "Attempting to restart ravend and ipfs services..."
sudo systemctl start ravend;
sudo systemctl start ipfs;
