/**
 \file SPTUSBCDCACMControl.h
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
 * Copyright (c) 1998-2003 Apple Computer, Inc.  All Rights Reserved.
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

#ifndef __APPLEUSBCDCACMControl__
#define __APPLEUSBCDCACMControl__

#include "SPTUSBCDCCommon.h"
#include "SPTUSBCDCACMData.h"

    // Miscellaneous

#define COMM_BUFF_SIZE	16

#define kDeviceSelfPowered	1
    
enum
{
    kCDCPowerOffState	= 0,
    kCDCPowerOnState	= 1,
    kNumCDCStates	= 2
};

class SPTUSBCDCACMData;

	/* SPTUSBCDCACMControl.h - This file contains the class definition for the		*/
	/* USB Communication Device Class (CDC) ACM Control driver. 				*/

class SPTUSBCDCACMControl : public IOService
{
    OSDeclareDefaultStructors(SPTUSBCDCACMControl);			// Constructor & Destructor stuff

private:
	SPTUSBCDC				*fCDCDriver;		// The CDC driver
    SPTUSBCDCACMData		*fDataDriver;       // Our Data Driver
    bool			fdataAcquired;				// Has the data port been acquired
    UInt8			fSessions;				// Active sessions (across all ports)
    bool			fTerminate;				// Are we being terminated (ie the device was unplugged)
    bool			fStopping;				// Are we being "stopped"
    UInt8			fPowerState;				// Ordinal for power management
    UInt8			fConfig;				// Configuration number
	bool			fReadDead;				// Is the Comm pipe read dead
    IOUSBPipe			*fCommPipe;				// The interrupt pipe
    IOBufferMemoryDescriptor	*fCommPipeMDP;				// Interrupt pipe memory descriptor
    UInt8			*fCommPipeBuffer;			// Interrupt pipe buffer
    IOUSBCompletion		fCommCompletionInfo;			// Interrupt completion routine
    IOUSBCompletion		fMERCompletionInfo;			// MER Completion routine
    UInt8			fCommInterfaceNumber;			// My interface number
    UInt8			fCMCapabilities;			// Call Management Capabilities
    UInt8			fACMCapabilities;			// Abstract Control Management
    
    static void			commReadComplete( void *obj, void *param, IOReturn ior, UInt32 remaining);
    static void			merWriteComplete(void *obj, void *param, IOReturn ior, UInt32 remaining);

public:

    IOUSBInterface		*fControlInterface;
    UInt8			fDataInterfaceNumber;			// Matching Data interface number

        // IOKit methods:
		
	virtual IOService   *probe(IOService *provider, SInt32 *score);
    virtual bool		start(IOService *provider);
    virtual void		stop(IOService *provider);
    virtual IOReturn 		message(UInt32 type, IOService *provider, void *argument = 0);
												
        // CDC ACM Control Driver Methods

    bool			configureACM(void);
    bool			getFunctionalDescriptors(void);
    virtual bool		dataAcquired(void);
    virtual void		dataReleased(void);
    virtual void 		USBSendSetLineCoding(UInt32 BaudRate, UInt8 StopBits, UInt8 TX_Parity, UInt8 CharLength);
    virtual void 		USBSendSetControlLineState(bool RTS, bool DTR);
    virtual void 		USBSendBreak(bool sBreak);
    IOReturn			checkPipe(IOUSBPipe *thePipe, bool devReq);
    bool 			allocateResources(void);
    void			releaseResources(void);
    bool			WakeonRing(void);
    void                        resetDevice(void);
    virtual bool		checkInterfaceNumber(SPTUSBCDCACMData *dataDriver);
    
        // Power Manager Methods
        
    bool			initForPM(IOService *provider);
    unsigned long		initialPowerStateForDomainState(IOPMPowerFlags flags);
    IOReturn			setPowerState(unsigned long powerStateOrdinal, IOService *whatDevice);
    
}; /* end class SPTUSBCDCACMControl */
#endif