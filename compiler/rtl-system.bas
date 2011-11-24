'' intrinsic runtime lib system functions (END, COMMAND, BEEP, SLEEP, TIMER, ...)
''
'' chng: oct/2004 written [v1ctor]
''       jan/2007 fb_DylibSymbolByOrd [voodooattack]

#include once "fb.bi"
#include once "fbint.bi"
#include once "ast.bi"
#include once "rtl.bi"

declare function 	hMultithread_cb		( byval sym as FBSYMBOL ptr ) as integer
declare function 	hThreadCall_cb		( byval sym as FBSYMBOL ptr ) as integer

	dim shared as FB_RTL_PROCDEF funcdata( 0 to ... ) = _
	{ _
		/' fb_CpuDetect cdecl ( ) as uinteger '/ _
		( _
			@FB_RTL_CPUDETECT, NULL, _
	   	 	FB_DATATYPE_UINT, FB_FUNCMODE_CDECL, _
	   	 	NULL, FB_RTL_OPT_NONE, _
	   	 	0 _
		), _
		/' fb_Init ( byval argc as integer, byval argv as zstring ptr ptr, byval lang as integer ) as void '/ _
		( _
			@FB_RTL_INIT, NULL, _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		3, _
	 		{ _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeMultAddrOf( FB_DATATYPE_CHAR, 2 ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
		/' fb_InitSignals ( ) as void '/ _
		( _
			@FB_RTL_INITSIGNALS, NULL, _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		0 _
	 	), _
		/' __main CDECL ( ) as void '/ _
		( _
			@FB_RTL_INITCRTCTOR, NULL, _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		0 _
	 	), _
		/' fb_End ( byval errlevel as integer ) as void '/ _
		( _
			@FB_RTL_END, NULL, _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
		/' atexit CDECL ( byval proc as sub cdecl() ) as void '/ _
		( _
			@FB_RTL_ATEXIT, @"atexit", _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
		/' command ( byval argc as integer = -1 ) as string '/ _
		( _
			@"command", @"fb_Command", _
	 		FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_STRSUFFIX, _
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
	 		FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NOQB, _
	 		0 _
	 	), _
		/' exepath ( ) as string '/ _
		( _
			@"exepath", @"fb_ExePath", _
	 		FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NOQB, _
	 		0 _
	 	), _
		/' timer ( ) as double '/ _
		( _
			@"timer", @"fb_Timer", _
	 		FB_DATATYPE_DOUBLE, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		0 _
	 	), _
		/' time ( ) as string '/ _
		( _
			@"time", @"fb_Time", _
	 		FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_STRSUFFIX, _
	 		0 _
	 	), _
		/' date ( ) as string '/ _
		( _
			@"date", @"fb_Date", _
	 		FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_STRSUFFIX, _
	 		0 _
	 	), _
		/' shell ( byval cmm as string = "" ) as integer '/ _
		( _
			@"shell", @"fb_Shell", _
	 		FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
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
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
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
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
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
	 		FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
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
	 		FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
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
	 		FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NOQB, _
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
	 		FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_STRSUFFIX, _
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
	 		FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
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
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		@rtlMultinput_cb, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, -1 _
	 			) _
	 		} _
	 	), _
		/' sleep ( byval secs as integer ) as void '/ _
		( _
			@"sleep", @"fb_SleepQB", _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		@rtlMultinput_cb, FB_RTL_OPT_OVER or FB_RTL_OPT_QBONLY, _
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
	 		FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
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
	 		FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
	 		1, _
	 		{ _
	 			( _
	 				typeAddrOf( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, TRUE, NULL _
	 			) _
	 		} _
	 	), _
		/' dir overload ( byref out_attrib as integer ) as string '/ _
		( _
			@"dir", @"fb_DirNext", _
	 		FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
	 	), _
		/' dir overload ( byref mask as string, _
						  byval attrib_mask as integer = &h21, _
						  byval out_attrib as integer ptr = NULL ) as string '/ _
		( _
			@"dir", @"fb_Dir", _
	 		FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
	 		3, _
	 		{ _
	 			( _
	 				FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, &h21 _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, TRUE, NULL _
	 			) _
	 		} _
	 	), _
		/' dir overload ( byref mask as string, _
						  byval attrib_mask as integer = &h21, _
						  byref out_attrib as integer ) as string '/ _
		( _
			@"dir", @"fb_Dir", _
	 		FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
	 		3, _
	 		{ _
	 			( _
	 				FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, &h21 _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
	 	), _
		/' settime ( byref time as string ) as integer '/ _
		( _
			@"settime", @"fb_SetTime", _
	 		FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
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
	 		FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
	 	), _
		/' threadcreate ( byval proc as sub( byval param as any ptr ),
						  byval param as any ptr = 0) as any ptr '/ _
		( _
			@"threadcreate", @"fb_ThreadCreate", _
	 		typeAddrOf( FB_DATATYPE_VOID ), FB_USE_FUNCMODE_FBCALL, _
	 		@hMultithread_cb, FB_RTL_OPT_MT or FB_RTL_OPT_NOQB, _
	 		5, _
	 		{ _
	 			( _
	 				typeAddrOf( FB_DATATYPE_FUNCTION ), FB_PARAMMODE_BYVAL, TRUE, 1 _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_VOID, NULL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			) _
	 		} _
	 	), _
		/' threadwait ( byval id as any ptr ) as void '/ _
		( _
			@"threadwait", @"fb_ThreadWait", _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		@hMultithread_cb, FB_RTL_OPT_MT or FB_RTL_OPT_NOQB, _
	 		1, _
	 		{ _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
        /' threadcall cdecl ( byval proc as any ptr, byval abi as integer, 
            byval stack_size as integer, byval num_args as integer, 
            byval num_args as integer, ... ) as any ptr '/ _
        ( _
            @"fb_ThreadCall", @"fb_ThreadCall", _
            typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_CDECL, _
            @hThreadCall_cb, FB_RTL_OPT_MT or FB_RTL_OPT_NOQB, _
            5, _
            { _
                ( _
                    typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
                ), _
                ( _
                    FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
                ), _
                ( _
                    FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
                ), _
                ( _
                    FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
                ), _
                ( _
                    FB_DATATYPE_INVALID, FB_PARAMMODE_VARARG, FALSE _
                ) _
           } _
        ), _
		/' mutexcreate ( ) as any ptr '/ _
		( _
			@"mutexcreate", @"fb_MutexCreate", _
	 		typeAddrOf( FB_DATATYPE_VOID ), FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_MT or FB_RTL_OPT_NOQB, _
	 		0 _
	 	), _
		/' mutexdestroy ( byval id as any ptr ) as void '/ _
		( _
			@"mutexdestroy", @"fb_MutexDestroy", _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_MT or FB_RTL_OPT_NOQB, _
	 		1, _
	 		{ _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
		/' mutexlock ( byval id as any ptr ) as void '/ _
		( _
			@"mutexlock", @"fb_MutexLock", _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_MT or FB_RTL_OPT_NOQB, _
	 		1, _
	 		{ _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
		/' mutexunlock ( byval id as any ptr ) as void '/ _
		( _
			@"mutexunlock", @"fb_MutexUnlock", _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_MT or FB_RTL_OPT_NOQB, _
	 		1, _
	 		{ _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
		/' condcreate ( ) as any ptr '/ _
		( _
			@"condcreate", @"fb_CondCreate", _
	 		typeAddrOf( FB_DATATYPE_VOID ), FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_MT or FB_RTL_OPT_NOQB, _
	 		0 _
	 	), _
		/' conddestroy ( byval id as any ptr ) as void '/ _
		( _
			@"conddestroy", @"fb_CondDestroy", _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_MT or FB_RTL_OPT_NOQB, _
	 		1, _
	 		{ _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
		/' condsignal ( byval id as any ptr ) as void '/ _
		( _
			@"condsignal", @"fb_CondSignal", _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_MT or FB_RTL_OPT_NOQB, _
	 		1, _
	 		{ _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
		/' condbroadcast ( byval id as any ptr ) as void '/ _
		( _
			@"condbroadcast", @"fb_CondBroadcast", _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_MT or FB_RTL_OPT_NOQB, _
	 		1, _
	 		{ _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
		/' condwait ( byval id as any ptr, byval mutex as any ptr ) as void '/ _
		( _
			@"condwait", @"fb_CondWait", _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_MT or FB_RTL_OPT_NOQB, _
	 		2, _
	 		{ _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
		/' dylibload ( filename as string ) as any ptr '/ _
		( _
			@"dylibload", @"fb_DylibLoad", _
	 		typeAddrOf( FB_DATATYPE_VOID ), FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NOQB, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
	 	), _
		/' dylibsymbol overload ( byval library as any ptr, symbol as string) as any ptr '/ _
		( _
			@"dylibsymbol", @"fb_DylibSymbol", _
	 		typeAddrOf( FB_DATATYPE_VOID ), FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
	 		2, _
	 		{ _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
	 	), _
		/' dylibsymbol overload ( byval library as any ptr, symbol as short) as any ptr '/ _
		( _
			@"dylibsymbol", @"fb_DylibSymbolByOrd", _
	 		typeAddrOf( FB_DATATYPE_VOID ), FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
	 		2, _
	 		{ _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_SHORT, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
		/' dylibfree ( byval library as any ptr ) as void '/ _
		( _
			@"dylibfree", @"fb_DylibFree", _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NOQB, _
	 		1, _
	 		{ _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' beep ( ) as void '/ _
		( _
			@"beep", @"fb_Beep", _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		0 _
	 	), _
		/' mkdir ( byref path as string ) as integer '/ _
		( _
			@"mkdir", @"fb_MkDir", _
	 		FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
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
	 		FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
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
	 		FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
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
	proc = astNewCALL( PROCLOOKUP( CPUDETECT ), NULL )

	'' cpu = fb_CpuDetect shr 28
	cpu = astNewBOP( AST_OP_SHR, proc, astNewCONSTi( 28, FB_DATATYPE_UINT ) )

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
	proc = astNewCALL( PROCLOOKUP( END ), NULL )
	if( astNewARG( proc, astNewCONSTi( 1, FB_DATATYPE_INTEGER ) ) = NULL ) then
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
		rtlPrint( astNewCONSTi( 0, FB_DATATYPE_INTEGER ), _
					  FALSE, _
					  FALSE, _
					astNewVAR( s, 0, FB_DATATYPE_CHAR ) )
		'' end 1
		proc = astNewCALL( PROCLOOKUP( END ), NULL )
		if( astNewARG( proc, astNewCONSTi( 1, FB_DATATYPE_INTEGER ) ) = NULL ) then
			exit function
		end if
		astAdd( proc )


		'' end if
		astAdd( astNewLABEL( label ) )
	end if

	function = TRUE

end function

'':::::
function rtlInitSignals( ) as integer static
    dim as ASTNODE ptr proc

	function = FALSE

	'' init( )
    proc = astNewCALL( PROCLOOKUP( INITSIGNALS ), NULL )

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

	if( irGetOption( IR_OPT_HIGHLEVEL ) = FALSE ) then
		'' call __monstartup() on win32/cygwin if profiling
		select case env.clopt.target
		case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
			if( env.clopt.profile ) then
				'' __monstartup()
    			proc = rtlProfileCall_monstartup( )
    			astAdd( proc )
			end if
		end select

    	'' call default CRT0 constructors (only required for Win32)
		if( env.clopt.target = FB_COMPTARGET_WIN32 ) then
			'' __main()
    		proc = astNewCALL( PROCLOOKUP( INITCRTCTOR ), NULL )
    		astAdd( proc )
    	end if
    end if

	'' init( argc, argv, lang )
    proc = astNewCALL( PROCLOOKUP( INIT ), NULL )

    '' argc
    if( argc = NULL ) then
    	argc = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    end if
    if( astNewARG( proc, argc ) = NULL ) then
    	exit function
    end if

    '' argv
    if( argv = NULL ) then
    	argv = astNewCONSTi( 0, typeAddrOf( FB_DATATYPE_VOID ) )
    end if
    if( astNewARG( proc, argv ) = NULL ) then
    	exit function
    end if

	'' lang
	if( astNewARG( proc, astNewCONSTi( env.clopt.lang, FB_DATATYPE_INTEGER ) ) = NULL ) then
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

    '' if error checking is on, check the CPU type
    if( env.clopt.errorcheck ) then
    	if( isdllmain = FALSE ) then
    		rtlCpuCheck( )
    	end if
    end if

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

    '' end( level )
    proc = astNewCALL( PROCLOOKUP( END ), NULL )

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

'':::::
private function hThreadCall_cb _
	( _
		byval sym as FBSYMBOL ptr _
	) as integer

    static as integer libsAdded = FALSE

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



