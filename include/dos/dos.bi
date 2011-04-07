' Copyright (C) 1999 DJ Delorie, see COPYING.DJ for details
' Copyright (C) 1998 DJ Delorie, see COPYING.DJ for details
' Copyright (C) 1995 DJ Delorie, see COPYING.DJ for details
#ifndef __dj_include_dos_h_
#define __dj_include_dos_h_

#include "dos/pc.bi"

extern _8087 alias "_8087" as integer

declare function _detect_80387 cdecl alias "_detect_80387"	( ) as integer

type DWORDREGS
	edi	as uinteger
	esi	as uinteger
	ebp	as uinteger
	cflag	as uinteger
	ebx	as uinteger
	edx	as uinteger
	ecx	as uinteger
	eax	as uinteger
	eflags	as ushort
end type

type DWORDREGS_W
	di	as uinteger
	si	as uinteger
	bp	as uinteger
	cflag	as uinteger
	bx	as uinteger
	dx	as uinteger
	cx	as uinteger
	ax	as uinteger
	flags	as ushort
end type

type WORDREGS
	di		as ushort
	_uppder_di	as ushort
	si		as ushort
	_upper_si	as ushort
	cflag		as ushort
	_upper_cflag	as ushort
	bx		as ushort
	_upper_bx	as ushort
	dx		as ushort
	_upper_dx	as ushort
	cx		as ushort
	_upper_cx	as ushort
	ax		as ushort
	_upper_ax	as ushort
	flags		as ushort
end type

type BYTEREGS
	di		as ushort
	_upper_di	as ushort
	bp		as ushort
	_upper_bp	as ushort
	cflag		as uinteger
	bl		as ubyte
	bh		as ubyte
	_upper_dx	as ushort
	cl		as ubyte
	ch		as ubyte
	_upper_cx	as ushort
	al		as ubyte
	ah		as ubyte
	_upper_ax	as ushort
	flags		as ushort
end type

union REGS		' Compatible with DPMI structure, except cflag
	d	as DWORDREGS
#ifdef _NAIVE_DOS_REGS
	x	as WORDREGS
#else
#ifdef _BORLAND_DOS_REGS
	x	as DWORDREGS
#else
	x	as DWORDREGS_W
#endif
#endif
	w	as WORDREGS
	h	as BYTEREGS
end union

type SREGS
	es	as ushort
	ds	as ushort
	fs	as ushort
	gs	as ushort
	cs	as ushort
	ss	as ushort
end type

type ftime
	ft_tsec:5 as uinteger
	ft_min:6 as uinteger
	ft_hour:5 as uinteger
	ft_day:5 as uinteger
	ft_month:4 as uinteger
	ft_year:7 as uinteger
end type

type date
	da_year	as short
	da_day	as byte
	da_mon	as byte
end type

type time
	ti_min	as ubyte
	ti_hour	as ubyte
	ti_hund	as ubyte
	ti_sec	as ubyte
end type

type dfree
	df_avail	as uinteger
	df_total	as uinteger
	df_bsec		as uinteger
	df_sclus	as uinteger
end type

extern _osmajor alias "_osmajor"	as ushort
extern _os_flavor alias "_os_flavor"	as byte ptr
extern _doserrno alias "_doserrno"	as integer

declare function	_get_dos_version cdecl alias "_get_dos_version"	( byval a as integer ) as uinteger

declare function	int86 cdecl alias "int86"	( byval ivec as integer, byval in as REGS ptr, byval out as REGS ptr ) as integer
declare function	int86x cdecl alias "int86x"	( byval ivec as integer, byval in as REGS ptr, byval out as REGS ptr, byval seg as SREGS ptr ) as integer
'declare function	intdos cdecl alias "intdos"	( byval in as REGS ptr, byval out as REGS ptr ) as integer
'declare function	intdosx cdecl alias "intdosx"	( byval in as REGS ptr, byval out as REGS ptr, byval seg as SREGS ptr ) as integer
declare function	bdos cdecl alias "bdos"		( byval func as integer, byval dx as uinteger, byval al as uinteger ) as integer
'declare function	bdosptr cdecl alias "bdosptr"	( byval func as integer, byval dx as any ptr, byval al as uinteger ) as integer

#define bdosptr(a, b, c) bdos(a, cast(uinteger, (b)), c)
#define intdos(a, b) int86(0x21, a, b)
#define intdosx(a, b, c) int86x(0x21, a, b, c)

declare function	enable cdecl alias "enable"	( ) as integer
declare function	disable cdecl alias "disable"	( ) as integer

declare function	getftime cdecl alias "getftime"	( byval handle as integer, byval ftimep as ftime ptr ) as integer
declare function	setftime cdecl alias "setftime"	( byval handle as integer, byval ftimep as ftime ptr ) as integer

declare function	getcbrk cdecl alias "getcbrk"	( ) as integer
declare function	setcbrk cdecl alias "setcbrk"	( byval new_value as integer ) as integer

declare sub		getdate cdecl alias "getdate"	( byval dp as date ptr )
declare sub		gettime cdecl alias "gettime"	( byval tp as time ptr )
declare sub		dos_setdate cdecl alias "setdate"	( byval dp as date ptr )
declare sub		dos_settime cdecl alias "settime"	( byval tp as time ptr )

declare sub		getdfree cdecl alias "getdfree"	( byval drive as ubyte, byval pt as dfree ptr )

declare sub		delay cdecl alias "delay"	( byval msec as uinteger )

'/* int _get_default_drive(void);
'void _fixpath(const char *, char *); */


'
'  For compatibility with other DOS C compilers.
'

#define _A_NORMAL	&H00    ' Normal file - No read/write restrictions
#define _A_RDONLY	&H01    ' Read only file
#define _A_HIDDEN	&H02    ' Hidden file
#define _A_SYSTEM	&H04    ' System file
#define _A_VOLID	&H08    ' Volume ID file
#define _A_SUBDIR	&H10    ' Subdirectory
#define _A_ARCH		&H20    ' Archive file

#define _enable   enable
#define _disable  disable

type _dosdate_t
	day		as ubyte	' 1-31
	month		as ubyte	' 1-12
	year		as ushort	' 1980-2099
	dayofweek	as ubyte	' 0-6, 0=Sunday
end type
#define dosdate_t _dosdate_t

type _dostime_t
	hour	as ubyte	' 0-23
	minute	as ubyte	' 0-59
	second	as ubyte	' 0-59
	hsecond	as ubyte	' 0-99
end type
#define dostime_t _dostime_t

type _find_t field = 1
	reserved(0 to 20)	as byte
	attrib			as ubyte
	wr_time			as ushort
	wr_date			as ushort
	size			as uinteger
	name(0 to 255)		as byte
end type
#define find_t _find_t

type _diskfree_t
	total_clusters		as ushort
	avail_clusters		as ushort
	sectors_per_cluster	as ushort
	bytes_per_sector	as ushort
end type
#define diskfree_t _diskfree_t

type _DOSERROR
	exterror	as integer
	errclass	as byte
	action		as byte
	locus		as byte
end type
#define DOSERROR _DOSERROR

declare function	_dos_creat cdecl alias "_dos_creat"		( byval _filename as zstring ptr, byval _attr as uinteger, byval _handle as integer ptr ) as uinteger
declare function	_dos_creatnew cdecl alias "_dos_creatnew"	( byval _filename as zstring ptr, byval _attr as uinteger, byval _handle as integer ptr ) as uinteger
declare function	_dos_open cdecl alias "_dos_open"		( byval _filename as zstring ptr, byval _mode as uinteger, byval _handle as integer ptr ) as uinteger
declare function	_dos_write cdecl alias "_dos_write"		( byval _handle as integer, byval _buffer as any ptr, byval _count as uinteger, byval _result as uinteger ptr ) as uinteger
declare function	_dos_read cdecl alias "_dos_read"		( byval _handle as integer, byval _buffer as any ptr, byval _count as uinteger, byval _result as uinteger ptr ) as uinteger
declare function	_dos_close cdecl alias "_dos_close"		( byval _handle as integer ) as uinteger
declare function	_dos_commit cdecl alias "_dos_commit"		( byval _handle as integer ) as uinteger

declare function	_dos_findfirst cdecl alias "_dos_findfirst"	( byval _name as zstring ptr, byval _attr as uinteger, byval _result as _find_t ptr ) as uinteger
declare function	_dos_findnext cdecl alias "_dos_findnext"	( byval _result as _find_t ptr ) as uinteger

declare sub		_dos_getdate cdecl alias "_dos_getdate"		( byval _date as _dosdate_t ptr )
declare function	_dos_setdate cdecl alias "_dos_setdate"		( byval _date as _dosdate_t ptr ) as uinteger
declare sub		_dos_gettime cdecl alias "_dos_gettime"		( byval _time as _dostime_t ptr )
declare function	_dos_settime cdecl alias "_dos_settime"		( byval _time as _dostime_t ptr ) as uinteger

declare function	_dos_getftime cdecl alias "_dos_getftime"	( byval _handle as integer, byval _p_date as uinteger ptr, byval _p_time as uinteger ptr ) as uinteger
declare function	_dos_setftime cdecl alias "_dos_setftime"	( byval _handle as integer, byval _date as uinteger, byval _time as uinteger ) as uinteger
declare function	_dos_getfileattr cdecl alias "_dos_getfileattr"	( byval _filename as zstring ptr, byval _p_attr as uinteger ptr ) as uinteger
declare function	_dos_setfileattr cdecl alias "_dos_setfileattr"	( byval _filename as zstring ptr, byval _attr as uinteger ) as uinteger

declare sub		_dos_getdrive cdecl alias "_dos_getdrive"	( byval _p_drive as uinteger ptr )
declare sub		_dos_setdrive cdecl alias "_dos_setdrive"	( byval _drive as uinteger, byval _p_drives as uinteger ptr )
declare function	_dos_getdiskfree cdecl alias "_dos_getdiskfree"	( byval _drive as uinteger, byval _diskspace as _diskfree_t ptr ) as uinteger

declare function	_dosexterr cdecl alias "_dosexterr"		( byval _p_error as _DOSERROR ptr ) as integer
#define dosexterr(_ep) _dosexterr(_ep)

#define int386(_i, _ir, _or)         int86(_i, _ir, _or)
#define int386x(_i, _ir, _or, _sr)   int86x(_i, _ir, _or, _sr)

#endif ' !__dj_include_dos_h_
