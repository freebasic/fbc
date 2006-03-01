''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
''
''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.


'' intrinsic runtime lib system functions (END, COMMAND, BEEP, SLEEP, TIMER, ...)
''
'' chng: oct/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ast.bi"
#include once "inc\rtl.bi"

declare function 	hMultithread_cb		( byval sym as FBSYMBOL ptr ) as integer


'' name, alias, _
'' type, mode, _
'' callback, checkerror, overloaded, _
'' args, _
'' [arg typ,mode,optional[,value]]*args
funcdata:

'' fb_CpuDetect ( ) as uinteger
data @FB_RTL_CPUDETECT,"", _
	 FB_DATATYPE_UINT,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 0

'' fb_Init ( byval argc as integer, byval argv as zstring ptr ptr ) as void
data @FB_RTL_INIT,"", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_DATATYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_POINTER+FB_DATATYPE_CHAR,FB_ARGMODE_BYVAL, FALSE

'' fb_RtInit ( ) as void
data @FB_RTL_RTINIT,"", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0

'' fb_InitSignals ( ) as void
data @FB_RTL_INITSIGNALS,"", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0

'' fb_InitProfile ( ) as void
data @FB_RTL_INITPROFILE,"", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0

'' __main CDECL ( ) as void
data @FB_RTL_INITCRTCTOR,"", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 0

'' fb_End ( byval errlevel as integer ) as void
data @FB_RTL_END,"", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' command ( byval argc as integer = -1 ) as string
data @"command","fb_Command", _
	 FB_DATATYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,-1

'' curdir ( ) as string
data @"curdir","fb_CurDir", _
	 FB_DATATYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0

'' exepath ( ) as string
data @"exepath","fb_ExePath", _
	 FB_DATATYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0

'' timer ( ) as double
data @"timer","fb_Timer", _
	 FB_DATATYPE_DOUBLE,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0

'' time ( ) as string
data @"time","fb_Time", _
	 FB_DATATYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0

'' date ( ) as string
data @"date","fb_Date", _
	 FB_DATATYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0

'' shell ( byval cmm as string = "" ) as integer
data @"shell","fb_Shell", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_STRING,FB_ARGMODE_BYREF, TRUE,""

'' system ( ) as void
data @"system","fb_End", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0

'' stop ( ) as void
data @"stop","fb_End", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0

'' run ( byref exename as string, byref arguments as string = "" ) as integer
data @"run","fb_RunEx", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_DATATYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_DATATYPE_STRING,FB_ARGMODE_BYREF, TRUE,""

'' chain ( exename as string ) as integer
data @"chain","fb_Chain", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' exec ( byref exename as string, byref arguments as string ) as integer
data @"exec","fb_Exec", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_DATATYPE_STRING,FB_ARGMODE_BYREF, FALSE, _
	 FB_DATATYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' environ ( byref varname as string ) as string
data @"environ","fb_GetEnviron", _
	 FB_DATATYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' setenviron ( byref varname as string ) as integer
data @"setenviron","fb_SetEnviron", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' sleep ( byval msecs as integer ) as void
data @"sleep","fb_Sleep", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @rtlMultinput_cb, FALSE, TRUE, _
	 1, _
	 FB_DATATYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE, -1

'' sleepex ( byval msecs as integer, byval kind as integer ) as integer
data @"sleep","fb_SleepEx", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @rtlMultinput_cb, TRUE, TRUE, _
	 2, _
	 FB_DATATYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' dir ( mask as string, byval v as integer = &h33 ) as string
data @"dir","fb_Dir", _
	 FB_DATATYPE_STRING,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_DATATYPE_STRING,FB_ARGMODE_BYREF, TRUE,"", _
	 FB_DATATYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,&h33

'' settime ( byref time as string ) as integer
data @"settime","fb_SetTime", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' setdate ( byref date as string ) as integer
data @"setdate","fb_SetDate", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' threadcreate ( byval proc as sub( byval param as integer ), byval param as integer = 0) as integer
data @"threadcreate", "fb_ThreadCreate", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @hMultithread_cb, FALSE, FALSE, _
	 2, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_VOID,FB_ARGMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,0

'' threadwait ( byval id as integer ) as void
data @"threadwait","fb_ThreadWait", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 @hMultithread_cb, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' mutexcreate ( ) as integer
data @"mutexcreate","fb_MutexCreate", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0

'' mutexdestroy ( byval id as integer ) as void
data @"mutexdestroy","fb_MutexDestroy", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' mutexlock ( byval id as integer ) as void
data @"mutexlock","fb_MutexLock", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' mutexunlock ( byval id as integer ) as void
data @"mutexunlock","fb_MutexUnlock", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' condcreate ( ) as integer
data @"condcreate","fb_CondCreate", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0

'' conddestroy ( byval id as integer ) as void
data @"conddestroy","fb_CondDestroy", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' condsignal ( byval id as integer ) as void
data @"condsignal","fb_CondSignal", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' condbroadcast ( byval id as integer ) as void
data @"condbroadcast","fb_CondBroadcast", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' condwait ( byval id as integer ) as void
data @"condwait","fb_CondWait", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' dylibload ( filename as string ) as integer
data @"dylibload","fb_DylibLoad", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' dylibsymbol ( byval library as integer, symbol as string) as any ptr
data @"dylibsymbol","fb_DylibSymbol", _
	 FB_DATATYPE_POINTER+FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_DATATYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_DATATYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' dylibfree ( byval library as integer ) as void
data @"dylibfree","fb_DylibFree", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE

'' beep ( ) as void
data @"beep","fb_Beep", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0

'' mkdir ( byref path as string ) as integer
data @"mkdir","fb_MkDir", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' rmdir ( byref path as string ) as integer
data @"rmdir","fb_RmDir", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' chdir ( byref path as string ) as integer
data @"chdir","fb_ChDir", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_STRING,FB_ARGMODE_BYREF, FALSE

'' EOL
data NULL


'':::::
sub rtlSystemModInit( )

	restore funcdata
	rtlAddIntrinsicProcs( )

end sub

'':::::
sub rtlSystemModEnd( )

	'' procs will be deleted when symbEnd is called

end sub



'':::::
function rtlCpuCheck( ) as integer static
	dim as ASTNODE ptr proc, cpu
	dim as FBSYMBOL ptr s, label

	function = FALSE

	''
	proc = astNewFUNCT( PROCLOOKUP( CPUDETECT ), NULL, TRUE )

	'' cpu = fb_CpuDetect shr 24
	cpu = astNewBOP( AST_OP_SHR, proc, astNewCONSTi( 24, FB_DATATYPE_UINT ) )

	'' if( cpu < env.clopt.cputype ) then
	label = symbAddLabel( NULL )
	astAdd( astNewBOP( AST_OP_GE, cpu, astNewCONSTi( env.clopt.cputype, FB_DATATYPE_UINT ), label, FALSE ) )

	'' print "This program requires at least a <cpu> to run."
	s = symbAllocStrConst( "This program requires at least a " & env.clopt.cputype & "86 to run.", -1 )
	rtlPrint( astNewCONSTi( 0, FB_DATATYPE_INTEGER ), _
			  FALSE, _
			  FALSE, _
			  astNewVAR( s, 0, FB_DATATYPE_CHAR ) )

	'' end 1
    proc = astNewFUNCT( PROCLOOKUP( END ), NULL, TRUE )
    if( astNewPARAM( proc, astNewCONSTi( 1, FB_DATATYPE_INTEGER ) ) = NULL ) then
    	exit function
    end if
    astAdd( proc )

	'' end if
	astAdd( astNewLABEL( label ) )

	function = TRUE

end function

'':::::
function rtlInitSignals( ) as integer static
    dim as ASTNODE ptr proc

	function = FALSE

	'' init( )
    proc = astNewFUNCT( PROCLOOKUP( INITSIGNALS ), NULL, TRUE )

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlInitProfile( ) as integer static
    dim as ASTNODE ptr proc

	function = FALSE

	'' init( )
    proc = astNewFUNCT( PROCLOOKUP( INITPROFILE ), NULL, TRUE )

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlInitApp( byval argc as ASTNODE ptr, _
					 byval argv as ASTNODE ptr, _
					 byval isdllmain as integer _
				   ) as ASTNODE ptr static

    dim as ASTNODE ptr proc

	function = NULL

    '' call default CRT0 constructors (only required for Win32) */
	if( env.clopt.target = FB_COMPTARGET_WIN32 ) then
		'' __main()
    	proc = astNewFUNCT( PROCLOOKUP( INITCRTCTOR ), NULL, TRUE )
    	astAdd( proc )
    end if

	'' init( argc, argv )
    proc = astNewFUNCT( PROCLOOKUP( INIT ), NULL, TRUE )

    '' argc
    if( argc = NULL ) then
    	argc = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    end if
    if( astNewPARAM( proc, argc ) = NULL ) then
    	exit function
    end if

    '' argv
    if( argv = NULL ) then
    	argv = astNewCONSTi( 0, FB_DATATYPE_POINTER+FB_DATATYPE_VOID )
    end if
    if( astNewPARAM( proc, argv ) = NULL ) then
    	exit function
    end if

    astAdd( proc )

    function = proc

    '' if error checking is on, call initSignals
    if( env.clopt.errorcheck ) then
    	if( isdllmain = FALSE ) then
    		rtlInitSignals( )
    	end if
	end if

    '' start profiling if requested
    if( env.clopt.profile ) then
	    if( isdllmain = FALSE ) then
	    	rtlInitProfile( )
	    end if
    end if

    '' if error checking is on, check the CPU type
    if( env.clopt.errorcheck ) then
    	if( isdllmain = FALSE ) then
    		rtlCpuCheck( )
    	end if
    end if

end function

'':::::
function rtlInitRt( ) as ASTNODE ptr static

    dim as ASTNODE ptr proc

	function = NULL

	'' RtInit( )
    proc = astNewFUNCT( PROCLOOKUP( RTINIT ), NULL, TRUE )

    function = proc

end function

'':::::
function rtlExitApp( byval errlevel as ASTNODE ptr ) as integer static
    dim as ASTNODE ptr proc

	function = FALSE

    if( errlevel = NULL ) then
    	errlevel = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    end if

	'' exit profiling?
	if( env.clopt.profile ) then
		proc = astNewFUNCT( PROCLOOKUP( PROFILEEND ), NULL, TRUE )
    	'' errlevel
    	if( astNewPARAM( proc, errlevel ) = NULL ) then
    		exit function
    	end if
    	errlevel = proc
	end if

    '' end( level )
    proc = astNewFUNCT( PROCLOOKUP( END ), NULL, TRUE )

    '' errlevel
    if( astNewPARAM( proc, errlevel ) = NULL ) then
    	exit function
    end if

    astAdd( proc )

end function

'':::::
private function hMultithread_cb( byval sym as FBSYMBOL ptr ) as integer

	env.clopt.multithreaded = TRUE

	return TRUE

end function


