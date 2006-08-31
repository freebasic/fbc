''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2006 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ast.bi"
#include once "inc\rtl.bi"

declare function 	hMultithread_cb		( byval sym as FBSYMBOL ptr ) as integer

	dim shared as FB_RTL_PROCDEF funcdata( 0 to 49 ) = _
	{ _
		/' fb_CpuDetect ( ) as uinteger '/ _
		( _
			@FB_RTL_CPUDETECT, NULL, _
	   	 	FB_DATATYPE_UINT,FB_FUNCMODE_CDECL, _
	   	 	NULL, FB_RTL_OPT_NONE, _
	   	 	0 _
		), _
		/' fb_Init ( byval argc as integer, byval argv as zstring ptr ptr ) as void '/ _
		( _
			@FB_RTL_INIT, NULL, _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		2, _
	 		{ _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_POINTER+FB_DATATYPE_POINTER+FB_DATATYPE_CHAR, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
		/' fb_RtInit ( ) as void '/ _
		( _
			@FB_RTL_RTINIT, NULL, _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		0 _
	 	), _
		/' fb_InitSignals ( ) as void '/ _
		( _
			@FB_RTL_INITSIGNALS, NULL, _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		0 _
	 	), _
		/' fb_InitProfile ( ) as void '/ _
		( _
			@FB_RTL_INITPROFILE, NULL, _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		0 _
	 	), _
		/' __main CDECL ( ) as void '/ _
		( _
			@FB_RTL_INITCRTCTOR, NULL, _
	 		FB_DATATYPE_VOID,FB_FUNCMODE_CDECL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		0 _
	 	), _
		/' fb_End ( byval errlevel as integer ) as void '/ _
		( _
			@FB_RTL_END, NULL, _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
		/' command ( byval argc as integer = -1 ) as string '/ _
		( _
			@"command", @"fb_Command", _
	 		FB_DATATYPE_STRING, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
	 			) _
	 		} _
	 	), _
		/' curdir ( ) as string '/ _
		( _
			@"curdir", @"fb_CurDir", _
	 		FB_DATATYPE_STRING, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		0 _
	 	), _
		/' exepath ( ) as string '/ _
		( _
			@"exepath", @"fb_ExePath", _
	 		FB_DATATYPE_STRING, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		0 _
	 	), _
		/' timer ( ) as double '/ _
		( _
			@"timer", @"fb_Timer", _
	 		FB_DATATYPE_DOUBLE, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		0 _
	 	), _
		/' time ( ) as string '/ _
		( _
			@"time", @"fb_Time", _
	 		FB_DATATYPE_STRING, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		0 _
	 	), _
		/' date ( ) as string '/ _
		( _
			@"date", @"fb_Date", _
	 		FB_DATATYPE_STRING, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		0 _
	 	), _
		/' shell ( byval cmm as string = "" ) as integer '/ _
		( _
			@"shell", @"fb_Shell", _
	 		FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, TRUE, NULL _
	 			) _
	 		} _
	 	), _
		/' system ( ) as void '/ _
		( _
			@"system", @"fb_End", _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			) _
	 		} _
	 	), _
		/' stop ( ) as void '/ _
		( _
			@"stop", @"fb_End", _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			) _
	 		} _
	 	), _
		/' run ( byref exename as string, byref arguments as string = "" ) as integer '/ _
		( _
			@"run", @"fb_RunEx", _
	 		FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		2, _
	 		{ _
	 			( _
	 				FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, TRUE, NULL _
	 			) _
	 		} _
	 	), _
		/' chain ( exename as string ) as integer '/ _
		( _
			@"chain", @"fb_Chain", _
	 		FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
	 	), _
		/' exec ( byref exename as string, byref arguments as string ) as integer '/ _
		( _
			@"exec", @"fb_Exec", _
	 		FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		2, _
	 		{ _
	 			( _
	 				FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
	 	), _
		/' environ ( byref varname as string ) as string '/ _
		( _
			@"environ", @"fb_GetEnviron", _
	 		FB_DATATYPE_STRING, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
	 	), _
		/' setenviron ( byref varname as string ) as integer '/ _
		( _
			@"setenviron", @"fb_SetEnviron", _
	 		FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_STRING,FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
	 	), _
		/' sleep ( byval msecs as integer ) as void '/ _
		( _
			@"sleep", @"fb_Sleep", _
	 		FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
	 		@rtlMultinput_cb, FB_RTL_OPT_OVER, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
	 			) _
	 		} _
	 	), _
		/' sleepex ( byval msecs as integer, byval kind as integer ) as integer '/ _
		( _
			@"sleep", @"fb_SleepEx", _
	 		FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
	 		@rtlMultinput_cb, FB_RTL_OPT_OVER or FB_RTL_OPT_ERROR, _
	 		2, _
	 		{ _
	 			( _
	 				FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
		/' dir overload ( byval out_attrib as integer ptr = NULL ) as string '/ _
		( _
			@"dir", @"fb_DirNext", _
	 		FB_DATATYPE_STRING, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_OVER, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_POINTER+FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, NULL _
	 			) _
	 		} _
	 	), _
		/' dir overload ( byref mask as string, _
						  byval attrib_mask as integer = &h21, _
						  byval out_attrib as integer ptr = NULL ) as string '/ _
		( _
			@"dir", @"fb_Dir", _
	 		FB_DATATYPE_STRING, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_OVER, _
	 		3, _
	 		{ _
	 			( _
	 				FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, &h21 _
	 			), _
	 			( _
	 				FB_DATATYPE_POINTER+FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, NULL _
	 			) _
	 		} _
	 	), _
		/' settime ( byref time as string ) as integer '/ _
		( _
			@"settime", @"fb_SetTime", _
	 		FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
	 	), _
		/' setdate ( byref date as string ) as integer '/ _
		( _
			@"setdate", @"fb_SetDate", _
	 		FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
	 	), _
		/' threadcreate ( byval proc as sub( byval param as integer ),
						  byval param as integer = 0) as any ptr '/ _
		( _
			@"threadcreate", @"fb_ThreadCreate", _
	 		FB_DATATYPE_POINTER+FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		@hMultithread_cb, FB_RTL_OPT_MT, _
	 		2, _
	 		{ _
	 			( _
	 				FB_DATATYPE_POINTER+FB_DATATYPE_VOID, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			) _
	 		} _
	 	), _
		/' threadwait ( byval id as any ptr ) as void '/ _
		( _
			@"threadwait", @"fb_ThreadWait", _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		@hMultithread_cb, FB_RTL_OPT_MT, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_POINTER+FB_DATATYPE_VOID, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
		/' mutexcreate ( ) as any ptr '/ _
		( _
			@"mutexcreate", @"fb_MutexCreate", _
	 		FB_DATATYPE_POINTER+FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_MT, _
	 		0 _
	 	), _
		/' mutexdestroy ( byval id as any ptr ) as void '/ _
		( _
			@"mutexdestroy", @"fb_MutexDestroy", _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_MT, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_POINTER+FB_DATATYPE_VOID, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
		/' mutexlock ( byval id as any ptr ) as void '/ _
		( _
			@"mutexlock", @"fb_MutexLock", _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_MT, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_POINTER+FB_DATATYPE_VOID, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
		/' mutexunlock ( byval id as any ptr ) as void '/ _
		( _
			@"mutexunlock", @"fb_MutexUnlock", _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_MT, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_POINTER+FB_DATATYPE_VOID, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
		/' condcreate ( ) as any ptr '/ _
		( _
			@"condcreate", @"fb_CondCreate", _
	 		FB_DATATYPE_POINTER+FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_MT, _
	 		0 _
	 	), _
		/' conddestroy ( byval id as any ptr ) as void '/ _
		( _
			@"conddestroy", @"fb_CondDestroy", _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_MT, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_POINTER+FB_DATATYPE_VOID, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
		/' condsignal ( byval id as any ptr ) as void '/ _
		( _
			@"condsignal", @"fb_CondSignal", _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_MT, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_POINTER+FB_DATATYPE_VOID, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
		/' condbroadcast ( byval id as any ptr ) as void '/ _
		( _
			@"condbroadcast", @"fb_CondBroadcast", _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_MT, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_POINTER+FB_DATATYPE_VOID, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
		/' condwait ( byval id as any ptr ) as void '/ _
		( _
			@"condwait", @"fb_CondWait", _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_MT, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_POINTER+FB_DATATYPE_VOID, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
		/' dylibload ( filename as string ) as any ptr '/ _
		( _
			@"dylibload", @"fb_DylibLoad", _
	 		FB_DATATYPE_POINTER+FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
	 	), _
		/' dylibsymbol ( byval library as any ptr, symbol as string) as any ptr '/ _
		( _
			@"dylibsymbol", @"fb_DylibSymbol", _
	 		FB_DATATYPE_POINTER+FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		2, _
	 		{ _
	 			( _
	 				FB_DATATYPE_POINTER+FB_DATATYPE_VOID, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
	 	), _
		/' dylibfree ( byval library as any ptr ) as void '/ _
		( _
			@"dylibfree", @"fb_DylibFree", _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_POINTER+FB_DATATYPE_VOID, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' beep ( ) as void '/ _
		( _
			@"beep", @"fb_Beep", _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		0 _
	 	), _
		/' mkdir ( byref path as string ) as integer '/ _
		( _
			@"mkdir", @"fb_MkDir", _
	 		FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
	 	), _
		/' rmdir ( byref path as string ) as integer '/ _
		( _
			@"rmdir", @"fb_RmDir", _
	 		FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
		), _
		/' chdir ( byref path as string ) as integer '/ _
		( _
			@"chdir", @"fb_ChDir", _
	 		FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_STRING,FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
	 	), _
	 	/' EOL '/ _
	 	( _
	 		NULL _
	 	) _
	 }


'':::::
sub rtlSystemModInit( )

	rtlAddIntrinsicProcs( @funcdata(0) )

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
	proc = astNewCALL( PROCLOOKUP( CPUDETECT ), NULL, TRUE )

	'' cpu = fb_CpuDetect shr 24
	cpu = astNewBOP( AST_OP_SHR, proc, astNewCONSTi( 24, FB_DATATYPE_UINT ) )

	'' if( cpu < env.clopt.cputype ) then
	label = symbAddLabel( NULL )
	astAdd( astNewBOP( AST_OP_GE, _
					   cpu, _
					   astNewCONSTi( env.clopt.cputype, FB_DATATYPE_UINT ), _
					   label, _
					   AST_OPOPT_NONE ) )

	'' print "This program requires at least a <cpu> to run."
	s = symbAllocStrConst( "This program requires at least a " & env.clopt.cputype & "86 to run.", -1 )
	rtlPrint( astNewCONSTi( 0, FB_DATATYPE_INTEGER ), _
			  FALSE, _
			  FALSE, _
			  astNewVAR( s, 0, FB_DATATYPE_CHAR ) )

	'' end 1
    proc = astNewCALL( PROCLOOKUP( END ), NULL, TRUE )
    if( astNewARG( proc, astNewCONSTi( 1, FB_DATATYPE_INTEGER ) ) = NULL ) then
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
    proc = astNewCALL( PROCLOOKUP( INITSIGNALS ), NULL, TRUE )

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlInitProfile( ) as integer static
    dim as ASTNODE ptr proc

	function = FALSE

	'' init( )
    proc = astNewCALL( PROCLOOKUP( INITPROFILE ), NULL, TRUE )

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlInitApp _
	( _
		byval argc as ASTNODE ptr, _
		byval argv as ASTNODE ptr, _
		byval isdllmain as integer _
	) as ASTNODE ptr static

    dim as ASTNODE ptr proc

	function = NULL

    '' call default CRT0 constructors (only required for Win32) */
	if( env.clopt.target = FB_COMPTARGET_WIN32 ) then
		'' __main()
    	proc = astNewCALL( PROCLOOKUP( INITCRTCTOR ), NULL, TRUE )
    	astAdd( proc )
    end if

	'' init( argc, argv )
    proc = astNewCALL( PROCLOOKUP( INIT ), NULL, TRUE )

    '' argc
    if( argc = NULL ) then
    	argc = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    end if
    if( astNewARG( proc, argc ) = NULL ) then
    	exit function
    end if

    '' argv
    if( argv = NULL ) then
    	argv = astNewCONSTi( 0, FB_DATATYPE_POINTER+FB_DATATYPE_VOID )
    end if
    if( astNewARG( proc, argv ) = NULL ) then
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
    proc = astNewCALL( PROCLOOKUP( RTINIT ), NULL, TRUE )

    function = proc

end function

'':::::
function rtlExitApp _
	( _
		byval errlevel as ASTNODE ptr _
	) as integer static

    dim as ASTNODE ptr proc

	function = FALSE

    if( errlevel = NULL ) then
    	errlevel = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    end if

	'' exit profiling?
	if( env.clopt.profile ) then
		proc = astNewCALL( PROCLOOKUP( PROFILEEND ), NULL, TRUE )
    	'' errlevel
    	if( astNewARG( proc, errlevel ) = NULL ) then
    		exit function
    	end if
    	errlevel = proc
	end if

    '' end( level )
    proc = astNewCALL( PROCLOOKUP( END ), NULL, TRUE )

    '' errlevel
    if( astNewARG( proc, errlevel ) = NULL ) then
    	exit function
    end if

    astAdd( proc )

end function

'':::::
private function hMultithread_cb _
	( _
		byval sym as FBSYMBOL ptr _
	) as integer

	env.clopt.multithreaded = TRUE

	return TRUE

end function


