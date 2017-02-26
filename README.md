# PiLFS Bootscripts 20170225 v1.0
## Raspberry Pi specific bootscripts for LFS
### http://www.intestinate.com/pilfs

Contains the following install targets:
* networkfix          - Tells the kernel to keep 8MB of RAM free at all times for incoming network traffic
* swapfix             - Workaround for a problem with using swapfiles on boot
* fake-hwclock        - Adds a script to save/restore time between reboots
* rngd                - Stop/start script for the hardware random number generator daemon
* sshd-keygen         - Simple modification to the BLFS sshd script that will generate new keys if missing
* switch-cpu-governor - Sets the cpufreq governor to ondemand which allows for overclocking the Pi
