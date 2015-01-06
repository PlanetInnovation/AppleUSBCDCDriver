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
cwd  := $(shell pwd)

#Path1 := "/Developer/Applications/Utilities/PackageMaker.app"
#Path2 := "/DevTools/Utilities/PackageMaker.app"
#PPATH := $(shell if [ -d ${Path1} ]; then echo ${Path1}; else if [ -d ${Path2} ]; then echo ${Path2}; fi; fi)
#PM := "${PPATH}/Contents/MacOS/PackageMaker"

# grab the long version number out of my prefix file
version  := $(word 3, $(shell grep VersionNumber ../Common/SPTUSBCDCCommon.h))

NAME := SPTUSBCDCDriver-${version}
PKG  := ../build/${NAME}.pkg
TMP  := /tmp/cdc.root/
#DMG  := ../build/${NAME}.dmg
TARBALL  := "${cwd}/../build/${NAME}-Root.tar.gz"


all:	${PKG}

clean:
	sudo rm -rf ${TMP}

#${PKG}:
#	${PM} --doc SPTUSBCDCDriver.pmdoc --out "${PKG}"

#${DMG}:	${PKG}
#	rm -f ${DMG}
#	/usr/bin/perl buildDMG.pl -buildDir ../build/ -compressionLevel 9 -dmgName ${NAME} -volName ${NAME} ${PKG}

${PKG}:
	(cd .. ; sudo xcodebuild ARCHS="${ARCHS}" install DSTROOT="${TMP}" )
	sudo pkgbuild --root=${TMP} --identifier com.apple.iokit.SPTUSBCDCDriver --version ${version} ${PKG}
	(cd ${TMP} ; sudo tar cvzf ${TARBALL} .)
	ls -ltr ../build
