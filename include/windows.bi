''
''
'' windows -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __windows_bi__
#define __windows_bi__

#define _X86_

#include once "win/windef.bi"
#include once "win/wincon.bi"
#include once "win/winbase.bi"
#include once "win/wingdi.bi"
#include once "win/winuser.bi"
#include once "win/winnls.bi"
#include once "win/winver.bi"
#include once "win/winnetwk.bi"
#include once "win/winreg.bi"
#include once "win/winsvc.bi"

#ifdef WIN_INCLUDEALL
# include once "win/cderr.bi"
# include once "win/dde.bi"
# include once "win/ddeml.bi"
# include once "win/dlgs.bi"
# include once "win/imm.bi"
# include once "win/lzexpand.bi"
# include once "win/mmsystem.bi"
# include once "win/nb30.bi"
# include once "win/rpc.bi"
# include once "win/shellapi.bi"
# include once "win/winperf.bi"
# include once "win/commdlg.bi"
# include once "win/winspool.bi"
# if defined(__USE_W32_SOCKETS)
#  include once "win/winsock2.bi"
# endif
# include once "win/ole2.bi"
#endif

#endif
