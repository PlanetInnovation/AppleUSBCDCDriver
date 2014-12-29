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
	ls -ld /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCECMControl.kext
	ls -ld /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCECMData.kext
	ls -ld /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCWCM.kext
	ls -ld /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCDMM.kext	
	sudo kextutil -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDC.kext
	sudo kextutil -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCACMControl.kext
	sudo kextutil -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCACMData.kext
	sudo kextutil -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCECMControl.kext
	sudo kextutil -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCECMData.kext
	sudo kextutil -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCWCM.kext
	sudo kextutil -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCDMM.kext
	

uninstall:
	sudo rm -rf /System/Library/Extensions/IONetworkingFamily.kext/Contents/PlugIns/AppleUSBEthernet.kext
	sudo rm -rf /System/Library/Extensions/IONetworkingFamily.kext/Contents/PlugIns/AppleUSBEthernet.old

	sudo rm -rf -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDC.kext
	sudo rm -rf -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDC.old

	sudo kextutil -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCACMControl.kext
	sudo kextutil -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCACMControl.old

	sudo kextutil -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCACMData.kext
	sudo kextutil -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCACMData.old

	sudo kextutil -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCECMControl.kext
	sudo kextutil -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCECMControl.old

	sudo kextutil -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCECMData.kext
	sudo kextutil -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCECMData.old

	sudo kextutil -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCWCM.kext
	sudo kextutil -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCWCM.old

	sudo kextutil -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCDMM.kext
	sudo kextutil -k /mach_kernel -nt /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/SPTUSBCDCDMM.old