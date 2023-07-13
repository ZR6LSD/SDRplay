# SDRplay - Software-defined radio (SDR)
ZR6LSD's Automatic SDRplay installation script for a headless linux server

These are my own custom modified installation scripts to download and install RSPTCP Server.

Especially if you are using a RSP1...
You will need to blacklist the kernel drivers before anything will work.
The way to do it on Ubuntu is to add the following lines to the ```/etc/modprobe.d/blacklist.conf``` file
 
blacklist sdr_msi3101
blacklist msi001
blacklist msi2500

My script will download the RSPTCP Server and the needed API and all other required dependencies and files.
My script also creates a systemd auto run file at boot.
My script needs to be run with sudo.

# To use the Installation Script.

1. Just clone my repository on a fresh installation of Ubuntu server .
2. cd to ```/home/SDRplay``` 
3. Make the file autosvx.sh executable with ```sudo chmod +x auto_install_sdrplay.sh ```
4. Run the script ```sudo ./auto_install_sdrplay.sh```
5. Follow the prompts and answer a few questions
6. Reboot
7. Done 

If you would like to help me improve my scripts. Feel free to contact me zr6lsd@gmail.com

# Conclusion

Have fun with it! But keep in mind that I have not tested them on every other Linux distribution available and I cannot offer support to you if they don't work on yours. I would love to hear your comments and I will happily look at any suggestions for new features or code fixes but I do not have the time or inclination to run and test your modified versions, act as a beta tester or even offer useful advice if your changes are not working. I am NOT an expert; I am simply sharing tools that I use everyday.

# Donations

However, if you find any of my work or videos on my channel enjoyable or helpful, then any small donations would be greatly appreciated, and would help towards me creating more content. If you would like to help with a donation, you can do so via.

Litecoin LTC: LMGEaMySbztMVftx6WJextU1WEQAEEnrR9





                                                  
                                                    
