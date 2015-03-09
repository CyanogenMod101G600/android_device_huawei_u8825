#!/system/bin/sh

#
#  FRANDOM enabler
#        by moddingg33k
#
# This script will replace the kernel's default
# random number generator device with FRANDOM
# (if supported by the kernel).
#
# Although Android's Dalvik-Engine doesn't seem
# to make use of '/dev/random', some drivers however do.
# Especially TCP related tasks might profit from the
# fast random number generator.
#
# Figure it out by your own. Good luck and happy testing! :)
#
# NOTE: set 'persist.synopsis.frandom' to '1' to auto-start
#       this script at boot.
#

########################################
# DO NOT EDIT THE CODE BELOW
# (unless you know what you are doing)
########################################

# load the module if not built into the kernel
if [ -e /system/lib/modules/frandom.ko ]; then
	insmod /system/lib/modules/frandom.ko
fi

if [ ! -e /dev/random.orig ]; then
	if [ -e /dev/frandom ]; then
		mv /dev/random /dev/random.orig
		ln -s /dev/frandom /dev/random
		chmod 0666 /dev/random
		
		log -p I -t synopsis *** FRANDOM *** /dev/random replaced by /dev/frandom
	fi
fi

if [ ! -e /dev/urandom.orig ]; then
	if [ -e /dev/frandom ]; then
		mv /dev/urandom /dev/urandom.orig
		ln -s /dev/frandom /dev/urandom
		chmod 0666 /dev/urandom
		
		log -p I -t synopsis *** FRANDOM *** /dev/urandom replaced by /dev/frandom
	fi
fi

#
# END OF SCRIPT
#

