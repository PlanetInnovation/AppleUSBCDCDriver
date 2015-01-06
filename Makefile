###########################################################################
# \file: 
# 
# \brief: Makefile to build SPT GPS Driver for OSX 10.10
# 
# Copyright (c) 2015, Planet Innovation
# 436 Elgar Road, Box Hill VIC 3128 Australia
# Phone: +61 3 9945 7510
# 
# The copyright to the computer program(s) herein is the property of
# Planet Innovation, Australia.
# The program(s) may be used and/or copied only with the written permission
# of Planet Innovation or in accordance with the terms and conditions
# stipulated in the agreement/contract under which the program(s) have
# been supplied.
# 
# \created: 06-01-2015
# \author: Andrew Leech
###########################################################################

ARCHS   ?= x86_64
DSTROOT ?= /
#cwd  := $(shell pwd)

all:
	make clean
	xcodebuild ARCHS="${ARCHS}"
	sudo chown -R root:wheel build/*/*.kext
	sudo chmod 755 build/*/*.kext/Contents/MacOS/*

install:
	make clean
	xcodebuild ARCHS="${ARCHS}"
	sudo xcodebuild ARCHS="${ARCHS}" install DSTROOT="${DSTROOT}"
	sudo touch /System/Library/Extensions
	sync

pkg:
	make clean
	( cd Package ; make ARCHS="${ARCHS}")

clean:
	sudo rm -rf build DerivedData

check:
	ls -ld /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDC.kext
	ls -ld /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCACMControl.kext
	ls -ld /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCACMData.kext
	sudo kextutil -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDC.kext
	sudo kextutil -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCACMControl.kext
	sudo kextutil -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCACMData.kext
	

uninstall:
	sudo rm -rf -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDC.kext
	sudo rm -rf -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDC.old

	sudo kextutil -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCACMControl.kext
	sudo kextutil -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCACMControl.old

	sudo kextutil -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCACMData.kext
	sudo kextutil -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCACMData.old