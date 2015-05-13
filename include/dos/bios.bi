' Copyright (C) 1996 DJ Delorie, see COPYING.DJ for details 
' Copyright (C) 1995 DJ Delorie, see COPYING.DJ for details
' converted by DrV for FreeBASIC 07-Feb-2005

#ifndef __dj_include_bios_h_
#define __dj_include_bios_h_

#inclib "c"

declare function	bioscom		cdecl alias "bioscom"		(byval cmd as integer, byval dat as byte, byval port as integer) as integer
declare function	biosdisk	cdecl alias "biosdisk"		(byval cmd as integer, byval drive as integer, byval head as integer, byval track as integer, byval sector as integer, byval nsects as integer, byval buffer as any ptr) as integer
declare function	biosequip	cdecl alias "biosequip"		() as integer
declare function	bioskey		cdecl alias "bioskey"		(byval cmd as integer) as integer
declare function	biosmemory	cdecl alias "biosmemory"	() as integer
declare function	biosprint	cdecl alias "biosprint"		(byval cmd as integer, byval byt as integer, byval port as integer) as integer
declare function	biostime	cdecl alias "biostime"		(byval cmd as integer, byval newtime as integer) as integer

'
'  For compatibility with other DOS C compilers.
'

' Disk parameters for _bios_disk() function. 

type diskinfo_t
	drive as uinteger	' Drive number.
	head as uinteger	' Head number.
	track as uinteger	' Track number.
	sector as uinteger	' Sector number.
	nsectors as uinteger	' Number of sectors to read/write/verify.
	buffer as any ptr	' Buffer for reading/writing/verifying.
end type


' Constants for _bios_disk() function

#define _DISK_RESET		0	' Reset disk controller.
#define _DISK_STATUS		1	' Get disk status.
#define _DISK_READ		2	' Read disk sectors.
#define _DISK_WRITE		3	' Write disk sectors.
#define _DISK_VERIFY		4	' Verify disk sectors.
#define _DISK_FORMAT		5	' Format disk track.

' Constants fot _bios_serialcom() function.
#define _COM_INIT		0	' Init serial port.
#define _COM_SEND		1	' Send character.
#define _COM_RECEIVE		2	' Receive character.
#define _COM_STATUS		3	' Get serial port status.

#define _COM_CHR7		2	' 7 bits characters.
#define _COM_CHR8		3	' 8 bits characters.

#define _COM_STOP1		0	' 1 stop bit.
#define _COM_STOP2		4	' 2 stop bits.
#define _COM_NOPARITY		0	' No parity.
#define _COM_ODDPARITY		8	' Odd parity.
#define _COM_SPACEPARITY	16	' Space parity.
#define _COM_EVENPARITY		24	' Even parity.

#define _COM_110		0	' 110 baud.
#define _COM_150		32	' 150 baud.
#define _COM_300		6	' 300 baud.
#define _COM_600		96	' 600 baud.
#define _COM_1200		128	' 1200 baud.
#define _COM_2400		160	' 2400 baud.
#define _COM_4800		192	' 4800 baud.
#define _COM_9600		224	' 9600 baud.

' Constants for _bios_keybrd() function. 
#define _KEYBRD_READ		0	' Read character.
#define _KEYBRD_READY		1	' Check character.
#define _KEYBRD_SHIFTSTATUS	2	' Get shift status.

#define _NKEYBRD_READ		&H10	' Read extended character.
#define _NKEYBRD_READY		&H11	' Check extended character.
#define _NKEYBRD_SHIFTSTATUS	&H12	' Get exteded shift status.

' Constans for _bios_printer() function.
#define _PRINTER_WRITE		0	' Write character.
#define _PRINTER_INIT		1	' Initialize printer.
#define _PRINTER_STATUS		2	' Get printer status.

' Constants for _bios_timeofday() function.
#define _TIME_GETCLOCK		0	' Get current clock count.
#define _TIME_SETCLOCK		1	' Set current clock count.

#define _bios_equiplist		biosequip
#define _bios_memsize		biosmemory
#define _bios_printer(_c, _p, _d)   cast(uinteger, biosprint(_c, _d, _p))
#define _bios_serialcom(_c, _p, _d) cast(uinteger, bioscom(_c, _d, _p))
#define _bios_keybrd(_c)            cast(uinteger, bioskey(_c))


declare function _bios_disk	cdecl alias "_bios_disk"	(byval cmd as uinteger, byref di as diskinfo_t) as uinteger
declare function _bios_timeofday	cdecl alias "_bios_timeofday"	(byval cmd as integer, byval timeval as uinteger ptr) as uinteger

' For int86(), int86x() and union REGS. 
#include "dos/dos.bi"

#endif ' !__dj_include_bios_h_
