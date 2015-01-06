/**
 \file SPTUSBCDCACMDataUser.h
 \brief SPT GPS Driver for OSX 10.10

    Copyright (c) 2015, Planet Innovation
    436 Elgar Road, Box Hill VIC 3128 Australia
    Phone: +61 3 9945 7510

    The copyright to the computer program(s) herein is the property of 
    Planet Innovation, Australia.
    The program(s) may be used and/or copied only with the written permission
    of Planet Innovation or in accordance with the terms and conditions 
    stipulated in the agreement/contract under which the program(s) have been
    supplied.

\created: 06-01-2015
\author: Andrew Leech
*/

/*
 *
 * @APPLE_LICENSE_HEADER_START@
 * 
 * Copyright (c) 1998-2005 Apple Computer, Inc.  All Rights Reserved.
 * 
 * This file contains Original Code and/or Modifications of Original Code
 * as defined in and that are subject to the Apple Public Source License
 * Version 2.0 (the 'License'). You may not use this file except in
 * compliance with the License. Please obtain a copy of the License at
 * http://www.opensource.apple.com/apsl/ and read it before using this
 * file.
 * 
 * The Original Code and all software distributed under the License are
 * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
 * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
 * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT.
 * Please see the License for the specific language governing rights and
 * limitations under the License.
 * 
 * @APPLE_LICENSE_HEADER_END@
 */

#ifndef __APPLEUSBCDCACMDATAUSER__
#define __APPLEUSBCDCACMDATAUSER__
       
#define kUserClientdoRequest	0

#define kSuccess		0
#define kError			1

    // Command codes to pass between user-client and the kext
    // values are arbitrary, but must fit in a byte.
    
enum
{
    cmdACMData_Message	= 100,
    ACMData_Magic_Key	= 'ACM!'			// Magic cookie for connect
};

    // Messages

enum
{
    noWarning		= 0x2000,			// Arbitrary values for now
	warning
};

typedef struct 
{
    UInt8		command;
	UInt8		filler;
    UInt16		message;
    UInt16		vendor;
	UInt16		product;
} dataParms;

typedef struct 
{
    UInt16		status;
} statusData;

#endif	// __APPLEUSBCDCACMDATAUSER__
