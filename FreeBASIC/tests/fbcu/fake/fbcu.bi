'' fbcu.bi replacement for debugging tests
'' and building tests without cunit

#ifndef NULL
#define NULL 0
#endif

#define CU_ASSERT( a )           ASSERT( a )
#define CU_ASSERT_EQUAL( a, b )  ASSERT( (a) = (b) )
#define CU_ASSERT_NOT_EQUAL( a, b )  ASSERT( (a) <> (b) )
#define CU_ASSERT_TRUE( a )      ASSERT( (a) <> 0 )
#define CU_ASSERT_FALSE( a )     ASSERT( (a) = 0 )
#define CU_FAIL( a )             fbcu.CU_FAIL_( __FILE__, __LINE__, __FUNCTION__, a )
#define CU_FAIL_FATAL( a )       fbcu.CU_FAIL_( __FILE__, __LINE__, __FUNCTION__, a )
#define CU_PASS( a )             fbcu.CU_PASS_( __FILE__, __LINE__, __FUNCTION__, a )
#define CU_TRUE 1
#define CU_FALSE 0

namespace fbcu

  dim shared fbcu_term_procs(1 to 100) as any ptr
  dim shared fbcu_term_count as integer

  '':::::
  sub CU_FAIL_ _
    ( _
      byval fil as zstring ptr, _
      byval lin as integer, _
      byval fun as zstring ptr, _
      byval a as zstring ptr _
    )

    print *fil & "(" & lin & ") : error : " & *fun

    end(1)

  end sub

  '':::::
  sub CU_PASS_ _
    ( _
      byval fil as zstring ptr, _
      byval lin as integer, _
      byval fun as zstring ptr, _
      byval a as zstring ptr _
    )

    print *fil & "(" & lin & ") : error : " & *fun

  end sub

  '':::::
  sub add_suite _
    ( _
      byval n as zstring ptr = 0, _
      init as function cdecl ( ) as integer = 0, _
      cleanup as function cdecl ( ) as integer = 0 _
    )

    if( n ) then
      print *n
    end if

    if( init ) then
      init()
    endif

    if( cleanup ) then
      fbcu_term_count += 1
	  fbcu_term_procs( fbcu_term_count ) = cleanup
    endif

  end sub

  '':::::
  sub add_test _
    ( _
      byval n as zstring ptr, _
      byval s as sub cdecl ( ) _
    )

    if( n ) then
      print "  "; *n
    end if

    if( s ) then
      s()
    end if
  
  end sub

end namespace

private sub fbc_init destructor
  dim term as function cdecl () as integer, i as integer
  for i = fbcu.fbcu_term_count to 1 step - 1
    term = fbcu.fbcu_term_procs(i)
    if( term ) then
      term()
	endif
  next i
end sub
