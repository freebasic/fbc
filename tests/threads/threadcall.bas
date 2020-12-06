#include "fbcunit.bi"

'' !!! TODO !!! test dos port with threads
'' !!! TODO !!! arm targets fail

#ifndef ENABLE_CHECK_BUGS
#define ENABLE_CHECK_BUGS 0
#endif

#if not (defined( __FB_ARM__ ) or defined( __FB_DOS__)) or ( ENABLE_CHECK_BUGS <> 0 )

'' fbcunit is not thread-safe - wrap the CU_ASSERT_TRUE in a mutex
#undef CU_ASSERT_TRUE
#macro CU_ASSERT_TRUE( expr )
	mutexlock mutex
	CU_ASSERT( (expr) <> 0 )
	mutexunlock mutex
#endmacro

SUITE( fbc_tests.threads.threadcall_ )

    declare sub Overloaded overload ( byval i as integer )
    declare sub Overloaded( byref s as string )

    dim shared NoArgsA_Executed as integer = 0
    dim shared NoArgsB_Executed as integer = 0
    dim shared OverloadedInt_Executed as integer = 0
    dim shared OverloadedStr_Executed as integer = 0
    dim shared Namespace_Executed as integer = 0
    dim shared OtherNamespace_Executed as integer = 0

	dim shared mutex as any ptr

	SUITE_INIT
		mutex = mutexcreate()
		'' return success
		return 0
	END_SUITE_INIT

	SUITE_CLEANUP
		mutexdestroy( mutex )
		'' return success
		return 0
	END_SUITE_CLEANUP
    
    type SimpleSubUDT 
        dim aa as byte
    end type

    type SimpleUDT
        a as SimpleSubUDT
        b as double
    end type

    type ComplexUDT
        c(0 to 2) as integer
        d as string
        e:1 as integer
    end type
        
    sub SmallInt stdcall( byval b as byte, byval ub as ubyte, _
        byval s as short, byval us as ushort )
        
        CU_ASSERT_TRUE( b = 20 )
        CU_ASSERT_TRUE( ub = 1 )
        CU_ASSERT_TRUE( s = 19 )
        CU_ASSERT_TRUE( us = 2 )
    end sub

    extern "Windows-MS"
        sub testWindowsMs( )
        end sub
    end extern

    sub BigInt cdecl( byref i as integer, byref ui as uinteger, _
        byref l as longint, byref ul as ulongint, _
        byref i4 as long, byref ui4 as ulong _
		 )
        
        ' Output by reference
        i = 17
        ui = 3
        l = 16
        ul = 4
        i4 = 15
        ui4 = 5
    end sub

    sub FloatStr ( byval s as single, byref d as double, byref s1 as string )
        CU_ASSERT_TRUE( s > 14.999 and s < 15.01)
        CU_ASSERT_TRUE( s1 = "fourteen" )

        ' Output by reference
        s1 = "five"
        d = 13.00    
    end sub

    sub TypeArray ( byval su as SimpleUDT, byref cu as ComplexUDT, _
        AnArray() as string, byref bv as integer, opt as integer = 13 )
        
        CU_ASSERT_TRUE( su.a.aa = 10 )
        CU_ASSERT_TRUE( su.b > 7.99 and su.b < 8.01 )
        CU_ASSERT_TRUE( opt = 13 )

        ' Output by reference
        cu.c(0) = 7
        cu.c(1) = 11
        cu.c(2) = 8
        cu.d = "ten"
        AnArray(0) = "ten"
        AnArray(1) = "nine"
        bv = 9
    end sub

    sub NoArgsA
        NoArgsA_Executed = -1
    end sub

    sub NoArgsB
        NoArgsB_Executed = -1
    end sub

    sub Overloaded( byval i as integer )
        CU_ASSERT_TRUE( i = -10 )
        OverloadedInt_Executed = -1
    end sub

    sub Overloaded( byref s as string )
        CU_ASSERT_TRUE( s = "minus eleven" )
        OverloadedStr_Executed = -1
    end sub

    namespace ThreadCallNS
        sub ns 
            Namespace_Executed = -1
        end sub
    end namespace
    namespace ThreadCallONS
        sub ns 
            OtherNamespace_Executed = -1
        end sub
    end namespace

    TEST( default )
        dim thread as any ptr
        dim i as integer, ui as uinteger, l as longint, ul as ulongint
        dim i4 as long, iu4 as ulong
        dim d as double
        dim as string s1, s2
        dim bv as integer ptr, cu as ComplexUDT, AnArray( 0 to 1 ) as string
        dim su as SimpleUDT = Type( Type<SimpleSubUDT>( 10 ), 8.0 )
        dim as any ptr SmallInt_Thread, BigInt_Thread, FloatStr_Thread 
        dim as any ptr TypeArray_Thread, NoArgsA_Thread, NoArgsB_Thread
        dim as any ptr OvlInt_Thread, OvlStr_Thread
        dim as any ptr Namespace_Thread, ONamespace_Thread
        dim as any ptr testWindowsMs_thread

        '' call threads
	#ifdef __FB_WIN32__
        SmallInt_Thread = threadcall SmallInt( 20, 1, 19, 2 )
        testWindowsMs_thread = threadcall testWindowsMs( )
	#endif
        BigInt_Thread = threadcall BigInt( i, ui, l, ul, i4, iu4 )
        s1 = "fourteen"
        FloatStr_Thread = threadcall FloatStr( 15.00, d, s1 )
        TypeArray_Thread = threadcall TypeArray( su, cu, AnArray(), byval @bv )
        NoArgsA_Thread = threadcall NoArgsA
        NoArgsB_Thread = threadcall NoArgsB()
        OvlInt_Thread = threadcall Overloaded( -10 )
        s2 = "minus eleven"
        OvlStr_Thread = threadcall Overloaded( s2 )
        Namespace_Thread = threadcall ThreadCallNS.ns
        ONamespace_Thread = threadcall ThreadCallONS.ns

	#ifdef __FB_WIN32__
        threadwait SmallInt_Thread
        threadwait testWindowsMs_thread
	#endif
        threadwait BigInt_Thread
        threadwait FloatStr_Thread
        threadwait TypeArray_Thread
        threadwait NoArgsA_Thread
        threadwait NoArgsB_Thread
        threadwait OvlInt_Thread
        threadwait OvlStr_Thread
        threadwait Namespace_Thread
        threadwait ONamespace_Thread

        '' check byref args
        CU_ASSERT_TRUE( i = 17 and ui = 3 and l = 16 and ul = 4 and i4 = 15 and iu4 = 5 )
        CU_ASSERT_TRUE( d > 12.99 and d < 13.01 and s1 = "five" )
        CU_ASSERT_TRUE( cu.c(0) = 7 and cu.c(1) = 11 and cu.c(2) = 8 )
        CU_ASSERT_TRUE( cu.d = "ten" and AnArray(0) = "ten" )
        CU_ASSERT_TRUE( AnArray(1) = "nine" and bv = 9 )

        '' check for executed threads
        CU_ASSERT_TRUE( NoArgsA_Executed = -1 )
        CU_ASSERT_TRUE( NoArgsB_Executed = -1 )
        CU_ASSERT_TRUE( OverloadedInt_Executed = -1 )
        CU_ASSERT_TRUE( OverloadedStr_Executed = -1 )
        CU_ASSERT_TRUE( Namespace_Executed = -1 )
        CU_ASSERT_TRUE( OtherNamespace_Executed = -1 )
    END_TEST

END_SUITE

#endif
