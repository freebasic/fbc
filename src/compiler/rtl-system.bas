'' intrinsic runtime lib system functions (END, COMMAND, BEEP, SLEEP, TIMER, ...)
''
'' chng: oct/2004 written [v1ctor]
''       jan/2007 fb_DylibSymbolByOrd [voodooattack]

#include once "fb.bi"
#include once "fbint.bi"
#include once "ast.bi"
#include once "rtl.bi"

declare function    hMultithread_cb     ( byval sym as FBSYMBOL ptr ) as integer
declare function    hThreadCall_cb      ( byval sym as FBSYMBOL ptr ) as integer

	dim shared as FB_RTL_PROCDEF funcdata( 0 to ... ) = _
	{ _
		/' function fb_CpuDetect cdecl( ) as ulong '/ _
		( _
			@FB_RTL_CPUDETECT, NULL, _
			FB_DATATYPE_ULONG, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_X86ONLY, _
			0 _
		), _
		/' sub fb_Init( byval argc as long, byval argv as zstring ptr ptr, byval lang as long ) '/ _
		( _
			@FB_RTL_INIT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( typeMultAddrOf( FB_DATATYPE_CHAR, 2 ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_InitSignals( ) '/ _
		( _
			@FB_RTL_INITSIGNALS, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			0 _
		), _
		/' sub __main cdecl( ) '/ _
		( _
			@FB_RTL_INITCRTCTOR, @"__main", _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			0 _
		), _
		/' sub fb_End( byval errlevel as const long ) '/ _
		( _
			@FB_RTL_END, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function atexit cdecl( byval proc as sub cdecl() ) as long '/ _
		( _
			@FB_RTL_ATEXIT, @"atexit", _
			FB_DATATYPE_LONG, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function command( byval argc as const long = -1 ) as string '/ _
		( _
			@"command", @"fb_Command", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_STRSUFFIX, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ) _
			} _
		), _
		/' function curdir( ) as string '/ _
		( _
			@"curdir", @"fb_CurDir", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			0 _
		), _
		/' function exepath( ) as string '/ _
		( _
			@"exepath", @"fb_ExePath", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			0 _
		), _
		/' function timer( ) as double '/ _
		( _
			@"timer", @"fb_Timer", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			0 _
		), _
		/' function time( ) as string '/ _
		( _
			@"time", @"fb_Time", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_STRSUFFIX, _
			0 _
		), _
		/' function date( ) as string '/ _
		( _
			@"date", @"fb_Date", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_STRSUFFIX, _
			0 _
		), _
		/' function shell( byref program as const string = "" ) as long '/ _
		( _
			@"shell", @"fb_Shell", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, TRUE, NULL ) _
			} _
		), _
		/' sub system( byval errlevel as const long = 0 ) '/ _
		( _
			@"system", @"fb_End", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ) _
			} _
		), _
		/' sub stop( byval errlevel as const long = 0 ) '/ _
		( _
			@"stop", @"fb_End", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ) _
			} _
		), _
		/' function run( byref program as const string, byref arguments as const string = "" ) as long '/ _
		( _
			@"run", @"fb_Run", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, TRUE, NULL ) _
			} _
		), _
		/' function chain( byref program as const string ) as long '/ _
		( _
			@"chain", @"fb_Chain", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function exec( byref program as const string, byref args as const string ) as long '/ _
		( _
			@"exec", @"fb_Exec", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function environ( byref varname as const string ) as string '/ _
		( _
			@"environ", @"fb_GetEnviron", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_STRSUFFIX, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function setenviron( byref varname as const string ) as long '/ _
		( _
			@"setenviron", @"fb_SetEnviron", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' sub sleep overload( byval msecs as const long ) '/ _
		( _
			@"sleep", @"fb_Sleep", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ) _
			} _
		), _
		/' sub sleep overload( byval secs as const long ) '/ _
		( _
			@"sleep", @"fb_SleepQB", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_QBONLY, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ) _
			} _
		), _
		/' function sleep overload( byval msecs as const long, byval kind as const long ) as long '/ _
		( _
			@"sleep", @"fb_SleepEx", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_ERROR, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function dir overload( byval out_attrib as long ptr = NULL ) as string '/ _
		( _
			@"dir", @"fb_DirNext", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeAddrOf( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, NULL ) _
			} _
		), _
		/' function dir overload( byval out_attrib as longint ptr ) as string '/ _
		( _
			@"dir", @"fb_DirNext64", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeAddrOf( FB_DATATYPE_LONGINT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function dir overload( byref out_attrib as long ) as string '/ _
		( _
			@"dir", @"fb_DirNext", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function dir overload( byref out_attrib as longint ) as string '/ _
		( _
			@"dir", @"fb_DirNext64", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function dir overload( byref mask as const string, _
				byval attrib_mask as const long = &h21, _
				byval out_attrib as long ptr = NULL ) as string '/ _
		( _
			@"dir", @"fb_Dir", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			3, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, &h21 ), _
				( typeAddrOf( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, NULL ) _
			} _
		), _
		/' function dir overload( byref mask as const string, _
				byval attrib_mask as const long = &h21, _
				byval out_attrib as longint ptr ) as string '/ _
		( _
			@"dir", @"fb_Dir64", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			3, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, &h21 ), _
				( typeAddrOf( FB_DATATYPE_LONGINT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function dir overload( byref mask as const string, _
				byval attrib_mask as const long = &h21, _
				byref out_attrib as long ) as string '/ _
		( _
			@"dir", @"fb_Dir", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			3, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, &h21 ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function dir overload( byref mask as const string, _
				byval attrib_mask as const long = &h21, _
				byref out_attrib as longint ) as string '/ _
		( _
			@"dir", @"fb_Dir64", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			3, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, &h21 ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function settime( byref time as const string ) as long '/ _
		( _
			@"settime", @"fb_SetTime", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function setdate( byref date as const string ) as long '/ _
		( _
			@"setdate", @"fb_SetDate", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function threadcreate _
			( _
				byval proc as sub( byval param as any ptr ),
				byval param as any ptr = 0, _
				byval stack_size as const integer = 0 _
			) as any ptr '/ _
		( _
			@"threadcreate", @"fb_ThreadCreate", _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_FBCALL, _
			@hMultithread_cb, FB_RTL_OPT_MT or FB_RTL_OPT_NOQB, _
			5, _
			{ _
				( typeAddrOf( FB_DATATYPE_FUNCTION ), FB_PARAMMODE_BYVAL, TRUE, 1 ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_VOID, NULL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, TRUE, 0 ) _
			} _
		), _
		/' sub threadwait( byval thread as any ptr ) '/ _
		( _
			@"threadwait", @"fb_ThreadWait", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			@hMultithread_cb, FB_RTL_OPT_MT or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_ThreadCall cdecl( byval proc as any ptr, byval abi as const long, _
				byval stack_size as const integer, byval num_args as const long, ... ) as any ptr '/ _
		( _
			@"fb_ThreadCall", NULL, _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_CDECL, _
			@hThreadCall_cb, FB_RTL_OPT_MT or FB_RTL_OPT_NOQB, _
			5, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_INVALID, FB_PARAMMODE_VARARG, FALSE ) _
			} _
		), _
		/' function mutexcreate( ) as any ptr '/ _
		( _
			@"mutexcreate", @"fb_MutexCreate", _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_MT or FB_RTL_OPT_NOQB, _
			0 _
		), _
		/' sub mutexdestroy( byval mutex as any ptr ) '/ _
		( _
			@"mutexdestroy", @"fb_MutexDestroy", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_MT or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub mutexlock( byval mutex as any ptr ) '/ _
		( _
			@"mutexlock", @"fb_MutexLock", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_MT or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub mutexunlock( byval mutex as any ptr ) '/ _
		( _
			@"mutexunlock", @"fb_MutexUnlock", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_MT or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function condcreate( ) as any ptr '/ _
		( _
			@"condcreate", @"fb_CondCreate", _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_MT or FB_RTL_OPT_NOQB, _
			0 _
		), _
		/' sub conddestroy( byval cond as any ptr ) '/ _
		( _
			@"conddestroy", @"fb_CondDestroy", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_MT or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub condsignal( byval cond as any ptr ) '/ _
		( _
			@"condsignal", @"fb_CondSignal", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_MT or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub condbroadcast( byval cond as any ptr ) '/ _
		( _
			@"condbroadcast", @"fb_CondBroadcast", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_MT or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub condwait( byval cond as any ptr, byval mutex as any ptr ) '/ _
		( _
			@"condwait", @"fb_CondWait", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_MT or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function dylibload( byref filename as const string ) as any ptr '/ _
		( _
			@"dylibload", @"fb_DylibLoad", _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function dylibsymbol overload( byval library as any ptr, byref symbol as const string ) as any ptr '/ _
		( _
			@"dylibsymbol", @"fb_DylibSymbol", _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function dylibsymbol overload( byval library as any ptr, byval symbol as const short ) as any ptr '/ _
		( _
			@"dylibsymbol", @"fb_DylibSymbolByOrd", _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_SHORT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub dylibfree( byval library as any ptr ) '/ _
		( _
			@"dylibfree", @"fb_DylibFree", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub beep( ) '/ _
		( _
			@"beep", @"fb_Beep", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			0 _
		), _
		/' function mkdir( byref path as const string ) as long '/ _
		( _
			@"mkdir", @"fb_MkDir", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function rmdir( byref path as const string ) as long '/ _
		( _
			@"rmdir", @"fb_RmDir", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function chdir( byref path as const string ) as long '/ _
		( _
			@"chdir", @"fb_ChDir", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
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

private function rtlX86CpuCheck( ) as integer
	dim as ASTNODE ptr proc = any, cpu = any
	dim as FBSYMBOL ptr s = any, label = any
	dim as integer family = any
	dim as string familystr

	function = FALSE

	'' Trim to 686, using higher values from the FB_CPUTYPE_* constants
	'' doesn't make sense, 786 represents the Intel Itanium (IA-64),
	'' not FB_CPUTYPE_ATHLON, and so on.
	family = env.clopt.cputype
	if( family > FB_CPUTYPE_686 ) then
		family = FB_CPUTYPE_686
	end if

	select case( family )
	case FB_CPUTYPE_386 : familystr = "386" : family = 3
	case FB_CPUTYPE_486 : familystr = "486" : family = 4
	case FB_CPUTYPE_586 : familystr = "586" : family = 5
	case else           : familystr = "686" : family = 6
	end select

	''
	proc = astNewCALL( PROCLOOKUP( CPUDETECT ), NULL )

	'' cpu = fb_CpuDetect shr 28
	cpu = astNewBOP( AST_OP_SHR, proc, astNewCONSTi( 28, FB_DATATYPE_UINT ) )

	'' if( cpu < family ) then
	label = symbAddLabel( NULL )
	astAdd( astNewBOP( AST_OP_GE, cpu, astNewCONSTi( family, FB_DATATYPE_UINT ), label, AST_OPOPT_NONE ) )

	'' print "This program requires at least a <cpu> to run."
	s = symbAllocStrConst( "This program requires at least a " + familystr + " to run.", -1 )
	rtlPrint( astNewCONSTi( 0 ), FALSE, FALSE, astNewVAR( s ) )

	'' end 1
	proc = astNewCALL( PROCLOOKUP( END ), NULL )
	if( astNewARG( proc, astNewCONSTi( 1 ) ) = NULL ) then
		exit function
	end if
	astAdd( proc )

	'' end if
	astAdd( astNewLABEL( label ) )

	if( env.clopt.fputype = FB_FPUTYPE_SSE ) then
		proc = astNewCALL( PROCLOOKUP( CPUDETECT ), NULL )

		'' cpu = fb_CpuDetect And &h6000000
		cpu = astNewBOP( AST_OP_AND, proc, astNewCONSTi( &h6000000, FB_DATATYPE_UINT ) )

		'' if( fpu <> &h6000000 ) then
		label = symbAddLabel( NULL )
		astAdd( astNewBOP( AST_OP_EQ, _
						   cpu, _
						   astNewCONSTi( &h6000000, FB_DATATYPE_UINT ), _
						   label, _
						   AST_OPOPT_NONE ) )

		'' print "This program requires SSE and SSE2 instructions to run."
		s = symbAllocStrConst( "This program requires SSE and SSE2 instructions to run.", -1 )
		rtlPrint( astNewCONSTi( 0 ), FALSE, FALSE, astNewVAR( s ) )

		'' end 1
		proc = astNewCALL( PROCLOOKUP( END ), NULL )
		if( astNewARG( proc, astNewCONSTi( 1 ) ) = NULL ) then
			exit function
		end if
		astAdd( proc )

		'' end if
		astAdd( astNewLABEL( label ) )
	end if

	function = TRUE
end function

'':::::
function rtlInitApp _
	( _
		byval argc as ASTNODE ptr, _
		byval argv as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as integer is_exe = any

	is_exe = (env.clopt.outtype <> FB_OUTTYPE_DYNAMICLIB)

	if( env.clopt.backend = FB_BACKEND_GAS ) then
		'' call __monstartup() on win32/cygwin if profiling
		select case( env.clopt.target )
		case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
			if( env.clopt.profile ) then
				'' __monstartup()
				rtlProfileCall_monstartup( )
			end if
		end select

		'' call default CRT0 constructors (only required for Win32)
		if( env.clopt.target = FB_COMPTARGET_WIN32 ) then
			'' __main()
			astAdd( astNewCALL( PROCLOOKUP( INITCRTCTOR ), NULL ) )
		end if
	end if

	'' fb_Init( argc, argv, lang )
	proc = astNewCALL( PROCLOOKUP( INIT ), NULL )
	astNewARG( proc, argc )
	astNewARG( proc, argv )
	astNewARG( proc, astNewCONSTi( env.clopt.lang ) )
	astAdd( proc )

	'' Error checking enabled and not a DLL?
	if( env.clopt.errorcheck and is_exe ) then
		'' fb_InitSignals( )
		astAdd( astNewCALL( PROCLOOKUP( INITSIGNALS ), NULL ) )

		'' Checking the CPU for features on x86
		if( fbGetCpuFamily( ) = FB_CPUFAMILY_X86 ) then
			'' Check CPU type
			rtlX86CpuCheck( )
		end if
	end if

	function = proc
end function

function rtlExitApp( byval errlevel as ASTNODE ptr ) as integer
	dim as ASTNODE ptr proc = any

	function = FALSE

	'' fb_End( errlevel )
	proc = astNewCALL( PROCLOOKUP( END ), NULL )

	if( errlevel = NULL ) then
		errlevel = astNewCONSTi( 0 )
	end if
	if( astNewARG( proc, errlevel ) = NULL ) then
		exit function
	end if

	astAdd( proc )

	function = TRUE
end function

'':::::
private function hMultithread_cb _
	( _
		byval sym as FBSYMBOL ptr _
	) as integer

	if( env.clopt.multithreaded = FALSE ) then
		'' restart the parser so __FB_MT__ can be checked on the next pass
		if( ( env.restart_status and FB_RESTART_PARSER_MT ) = 0 ) then
			fbRestartBeginRequest( FB_RESTART_PARSER_MT )
		end if
	end if

	env.clopt.multithreaded = TRUE

	return TRUE

end function

'':::::
private function hThreadCall_cb _
	( _
		byval sym as FBSYMBOL ptr _
	) as integer

	'' minor optimization to avoid having to lookup env.libs hash
	fbRestartableStaticVariable( integer, libsAdded, FALSE )

	if( libsadded = FALSE ) then
		libsAdded = TRUE
		fbAddLib( "ffi" )
	end if

	return hMultithread_cb( sym )
end function

'':::::
function rtlAtExit _
	( _
		byval procexpr as ASTNODE ptr _
	) as ASTNODE ptr static

	dim as ASTNODE ptr proc

	function = NULL

	'' atexit( proc )
	proc = astNewCALL( PROCLOOKUP( ATEXIT ) )

	if( astNewARG( proc, procexpr ) = NULL ) then
		exit function
	end if

	function = proc

end function



