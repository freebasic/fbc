# include "fbcu.bi"

#ifndef __FB_DOS__

namespace fbc_tests.threads.threadcall_tests

    declare sub Overloaded overload ( byval i as integer )
    declare sub Overloaded( byref s as string )

    dim shared NoArgsA_Executed as integer = 0
    dim shared NoArgsB_Executed as integer = 0
    dim shared OverloadedInt_Executed as integer = 0
    dim shared OverloadedStr_Executed as integer = 0
    dim shared Namespace_Executed as integer = 0
    dim shared OtherNamespace_Executed as integer = 0
    
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

    sub BigInt cdecl( byref i as integer, byref ui as uinteger, _
        byref l as longint, byref ul as ulongint )
        
        ' Output by reference
        i = 17
        ui = 3
        l = 16
        ul = 4
    end sub

    sub FloatStr ( byval s as single, byref d as double, byval strval as string, _
        byref strref as string )
        CU_ASSERT_TRUE( s > 14.999 and s < 15.01)
        CU_ASSERT_TRUE( strval = "fourteen" )
        
        ' Output by reference
        strref = "five"
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

    sub threadcall_test() 
        dim thread as any ptr
        dim i as integer, ui as uinteger, l as longint, ul as ulongint
        dim d as double, strref as string
        dim bv as integer ptr, cu as ComplexUDT, AnArray( 0 to 1 ) as string
        dim su as SimpleUDT = Type( Type<SimpleSubUDT>( 10 ), 8.0 )
        dim as any ptr SmallInt_Thread, BigInt_Thread, FloatStr_Thread 
        dim as any ptr TypeArray_Thread, NoArgsA_Thread, NoArgsB_Thread
        dim as any ptr OvlInt_Thread, OvlStr_Thread
        dim as any ptr Namespace_Thread, ONamespace_Thread

        '' call threads
        SmallInt_Thread = threadcall SmallInt( 20, 1, 19, 2 )
        BigInt_Thread = threadcall BigInt( i, ui, l, ul )
        FloatStr_Thread = threadcall FloatStr( 15.00, d, "fourteen", strref )
        TypeArray_Thread = threadcall TypeArray( su, cu, AnArray(), byval @bv )
        NoArgsA_Thread = threadcall NoArgsA
        NoArgsB_Thread = threadcall NoArgsB()
        OvlInt_Thread = threadcall Overloaded( -10 )
        OvlStr_Thread = threadcall Overloaded( "minus eleven" )
        Namespace_Thread = threadcall ThreadCallNS.ns
        ONamespace_Thread = threadcall ThreadCallONS.ns

        threadwait SmallInt_Thread
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
        CU_ASSERT_TRUE( i = 17 and ui = 3 and l = 16 and ul = 4 )
        CU_ASSERT_TRUE( d > 12.99 and d < 13.01 and strref = "five" )
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
    end sub

    private sub ctor () constructor
        fbcu.add_suite( "fbc_tests.threads:threadcall_tests" )
        fbcu.add_test( "threadcall_test", @threadcall_test )
    end sub

end namespace

#endif 