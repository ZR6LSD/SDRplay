# SDRplay - Software-defined radio (SDR)
SDRplay installation scripts for a headless linux server

TCP Server is a product of SDRplay

These are my own custom modified installation scripts to download and install RSPTCP Server.

                                                    # Installation steps

                                                     Especially if you are using a RSP1...
                                                     You will need to blacklist the kernel drivers before anything will work...

The way to do it on Ubuntu is to add the following lines to the /etc/modprobe.d/blacklist.conf file
 
blacklist sdr_msi3101
blacklist msi001
blacklist msi2500
