' Copyright (C) 1999 DJ Delorie, see COPYING.DJ for details
' Copyright (C) 1998 DJ Delorie, see COPYING.DJ for details
' Copyright (C) 1995 DJ Delorie, see COPYING.DJ for details
#ifndef __dj_include_pc_h_
#define __dj_include_pc_h_

declare function	inportb cdecl alias "inportb"		( byval _port as ushort ) as ubyte
declare function	inportw cdecl alias "inportw"		( byval _port as ushort ) as ushort
declare function	inportl cdecl alias "inportl"		( byval _port as ushort ) as uinteger
declare sub		inportsb cdecl alias "inportsb"		( byval _port as ushort, byval _buf as ubyte ptr, byval _len as uinteger )
declare sub		inportsw cdecl alias "inportsw"		( byval _port as ushort, byval _buf as ubyte ptr, byval _len as uinteger )
declare sub		inportsl cdecl alias "inportsl"		( byval _port as ushort, byval _buf as ubyte ptr, byval _len as uinteger )
declare sub		outportb cdecl alias "outportb" 	( byval _port as ushort, byval _data as ubyte )
declare sub		outportw cdecl alias "outportw" 	( byval _port as ushort, byval _data as ushort )
declare sub		outportl cdecl alias "outportl" 	( byval _port as ushort, byval _data as uinteger )
declare sub		outportsb cdecl alias "outportsb"	( byval _port as ushort, byval _buf as ubyte ptr, byval _len as uinteger )
declare sub		outportsw cdecl alias "outportsw"	( byval _port as ushort, byval _buf as ushort ptr, byval _len as uinteger )
declare sub		outportsl cdecl alias "outportsl"	( byval _port as ushort, byval _buf as uinteger ptr, byval _len as uinteger )

declare function	dos_inp cdecl alias "inp"		( byval _port as ushort ) as ubyte '' originally called 'inp'
declare function	inpw cdecl alias "inpw"			( byval _port as ushort ) as ushort
declare sub		outp cdecl alias "outp"			( byval _port as ushort, byval _data as ubyte )
declare sub		outpw cdecl alias "outpw"		( byval _port as ushort, byval _data as ushort )

#ifndef kbhit
declare function	kbhit cdecl alias "kbhit"		( ) as integer
#endif
declare function	pc_getkey cdecl alias "getkey"		( ) as integer	' ALT's have 0x100 set
declare function	getxkey cdecl alias "getxkey"		( ) as integer	' ALT's have 0x100 set, 0xe0 sets 0x200

declare sub		sound cdecl alias "sound"		( byval _frequency as integer )
#define	nosound		sound 0

extern ScreenAttrib alias "ScreenAttrib" as ubyte

#define ScreenPrimary _go32_info_block.linear_address_of_primary_screen
#define ScreenSecondary _go32_info_block.linear_address_of_secondary_screen

declare function	ScreenMode cdecl alias "ScreenMode"		( ) as integer
declare function	ScreenRows cdecl alias "ScreenRows"		( ) as integer
declare function	ScreenCols cdecl alias "ScreenCols"		( ) as integer
declare sub		ScreenPutChar cdecl alias "ScreenPutChar"	( byval _ch as integer, byval _attr as integer, byval _x as integer, byval _y as integer )
declare sub		ScreenGetChar cdecl alias "ScreenGetChar"	( byval _ch as integer ptr, byval _attr as integer ptr, byval _x as integer, byval _y as integer )
declare sub		ScreenPutString cdecl alias "ScreenPutString"	( byval _ch as zstring ptr, byval _attr as integer, byval _x as integer, byval _y as integer )
declare sub		ScreenSetCursor cdecl alias "ScreenSetCursor"	( byval _row as integer, byval _col as integer )
declare sub		ScreenGetCursor cdecl alias "ScreenGetCursor"	( byval _row as integer ptr, byval _col as integer ptr )
declare sub		ScreenClear cdecl alias "ScreenClear"		( )
declare sub		ScreenUpdate cdecl alias "ScreenUpdate"		( byval _virtual_screen as any ptr )
declare sub		ScreenUpdateLine cdecl alias "ScreenUpdateLine"	( byval _virtual_screen_line as any ptr, byval _row as integer )
declare sub		ScreenRetrieve cdecl alias "ScreenRetrieve"	( byval _virtual_screen as any ptr )
declare sub		ScreenVisualBell cdecl alias "ScreenVisualBell"	( )

#include "dos/inlines/pc.bi"

#endif ' !__dj_include_pc_h_

