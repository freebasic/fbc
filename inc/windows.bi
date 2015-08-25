'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DISCLAIMER
''   This file has no copyright assigned and is placed in the Public Domain.
''   This file is part of the mingw-w64 runtime package.
''
''   The mingw-w64 runtime package and its code is distributed in the hope that it 
''   will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR 
''   IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to 
''   warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/stdarg.bi"
#include once "win/windef.bi"
#include once "win/winbase.bi"
#include once "win/wingdi.bi"
#include once "win/winuser.bi"
#include once "win/winnls.bi"
#include once "win/wincon.bi"
#include once "win/winver.bi"
#include once "win/winreg.bi"
#include once "win/winnetwk.bi"
#include once "win/virtdisk.bi"

#ifdef WIN_INCLUDEALL
	#include once "win/cderr.bi"
	#include once "win/dde.bi"
	#include once "win/ddeml.bi"
	#include once "win/dlgs.bi"
	#include once "win/lzexpand.bi"
	#include once "win/mmsystem.bi"
	#include once "win/nb30.bi"
	#include once "win/rpc.bi"
	#include once "win/shellapi.bi"
	#include once "win/winperf.bi"
	#ifdef __USE_W32_SOCKETS
		#include once "win/winsock2.bi"
	#endif
	#include once "win/wincrypt.bi"
	#include once "win/winefs.bi"
	#include once "win/winscard.bi"
	#include once "win/winspool.bi"
	#include once "win/ole2.bi"
	#include once "win/commdlg.bi"
#endif

#include once "win/winsvc.bi"
#include once "win/mcx.bi"
#include once "win/imm.bi"

#define _WINDOWS_
#define _INC_WINDOWS

#ifdef __FB_64BIT__
	#define _AMD64_
#endif
