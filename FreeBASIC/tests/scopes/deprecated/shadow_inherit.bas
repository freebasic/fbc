# include "fbcu.bi"

# if __FB_LANG__ = deprecated

namespace fbc_test.scopes.shadow_inherit

'' SCOPE...END SCOPE creates a new local scope
'' implicit variable scope is inherited
'':::::
sub test_opt_imp_scope_imp_inherit cdecl ()
  x = 1
  CU_ASSERT( x = 1 )
  
  scope
    x += 3
    CU_ASSERT( x = 4 )
  
    scope
      x += 5
      CU_ASSERT( x = 9 )
    end scope
  
    x += 3
    CU_ASSERT( x = 12 )
  
  end scope
  
  x += 1
  CU_ASSERT( x = 13 )
end sub



'' SCOPE...END SCOPE creates a new local scope
'' DIM inside SCOPE shadows parent scope variable
'':::::
sub test_opt_imp_scope_exp_shadow cdecl ()

  x = 1
  CU_ASSERT( x = 1 )
  
  scope
    dim x
    x += 3
    CU_ASSERT( x = 3 )
  
    scope
      dim x
      x += 5
      CU_ASSERT( x = 5 )
    end scope
  
    x += 3
    CU_ASSERT( x = 6 )
  
  end scope

  x += 1
  CU_ASSERT( x = 2 )

end sub


'' IF...THEN creates a new local scope
'' implicit variable scope is inherited
'':::::
sub test_opt_imp_if_imp_inherit cdecl ()

  x = 1
  CU_ASSERT( x = 1 )
  
  if 1 then
    x += 1
    CU_ASSERT( x = 2 )
  else
    CU_ASSERT( 0 )
  end if
  
  CU_ASSERT( x = 2 )

  if 0 then
    CU_ASSERT( 0 )
  else
    x += 1
    CU_ASSERT( x = 3 )
  end if

  CU_ASSERT( x = 3 )

end sub


'' IF...THEN creates a new local scope
'' DIM inside SCOPE shadows parent scope variable
'':::::
sub test_opt_imp_if_exp_shadow cdecl ()

  x = 1
  CU_ASSERT( x = 1 )
  
  if 1 then
    dim x
    x += 2
    CU_ASSERT( x = 2 )
  else
    CU_ASSERT( 0 )
  end if
  
  CU_ASSERT( x = 1 )
  
  if 0 then
    CU_ASSERT( 0 )
  else
    dim x
    x += 2
    CU_ASSERT( x = 2 )
  end if
  
  CU_ASSERT( x = 1 )

end sub


  
'' DO...WHILE creates a new local scope
'' implicit variable scope is inherited
'' DIM inside SCOPE shadows parent scope variable
'':::::
sub test_opt_imp_do cdecl ()
  
  x = 1
  CU_ASSERT( x = 1 )
  
  do
    x += 1
    CU_ASSERT( x = 2 )
    exit do
  loop
  
  CU_ASSERT( x = 2 )
  
  x = 1
  CU_ASSERT( x = 1 )
  
  do
    dim x
    x += 1
    CU_ASSERT( x = 1 )
    exit do
  loop
  

  i = 0
  CU_ASSERT( i = 0 )
  
  x = 0
  CU_ASSERT( x = 0 )
  
  do
    dim x
    x += 1
    i += 1
  
    CU_ASSERT( x = 1 )
  
    if( i > 10 ) then
      exit do
    end if
  
  loop
  
  CU_ASSERT( i = 11 )
  CU_ASSERT( x = 0 )
  
  i = 0
  x = 0
  
  do
    x += 1
    i += 1
  
    CU_ASSERT( x = i )
  
    if( i > 10 ) then
      exit do
    end if
  
  loop
  
  CU_ASSERT( i = 11 )
  CU_ASSERT( x = 11 )

end sub



'' WHILE...WEND creates a new local scope
'' implicit variable scope is inherited
'' DIM inside SCOPE shadows parent scope variable
'':::::
sub test_opt_imp_while cdecl ()
  
  x = 1
  CU_ASSERT( x = 1 )
  
  while 1
    x += 1
    CU_ASSERT( x = 2 )
    exit while
  wend
  
  CU_ASSERT( x = 2 )
  
  x = 1
  CU_ASSERT( x = 1 )
  
  while 1
    dim x
    x += 1
    CU_ASSERT( x = 1 )
    exit while
  wend
  
  i = 0
  CU_ASSERT( i = 0 )
  
  x = 0
  CU_ASSERT( x = 0 )
  
  while 1
    dim x
    x += 1
    i += 1
  
    CU_ASSERT( x = 1 )
  
    if( i > 10 ) then
      exit while
    end if
  
  wend
  
  CU_ASSERT( i = 11 )
  CU_ASSERT( x = 0 )
  
  i = 0
  x = 0
  
  while 1
    x += 1
    i += 1
  
    CU_ASSERT( x = i )
  
    if( i > 10 ) then
      exit while
    end if
  
  wend
  
  CU_ASSERT( i = 11 )
  CU_ASSERT( x = 11 )

end sub



'' FOR...NEXT creates a new local scope
'' implicit variable scope is inherited
'' DIM inside SCOPE shadows parent scope variable
'':::::
sub test_opt_imp_for cdecl ()
  
  x = 1
  CU_ASSERT( x = 1 )
  
  for i = 1 to 10
    x += 1
    CU_ASSERT( x = 2 )
    exit for
  next i
  
  CU_ASSERT( x = 2 )
  
  x = 1
  CU_ASSERT( x = 1 )
  
  for i = 1 to 10
    dim x
    x += 1
    CU_ASSERT( x = 1 )
    exit for
  next i
  
  i = 0
  CU_ASSERT( i = 0 )
  
  x = 0
  CU_ASSERT( x = 0 )
  
  for i = 1 to 10
    dim x
    x += 1
  
    CU_ASSERT( x = 1 )
  
  next i
  
  CU_ASSERT( i = 11 )
  CU_ASSERT( x = 0 )
  
  for i = 1 to 10
    x += 1
  
    CU_ASSERT( x = i )
  
  next i
  
  CU_ASSERT( i = 11 )
  CU_ASSERT( x = 10 )
  
  
end sub


'' --------------------------------------

'' Explicit Variable Scope Tests
'' With/without inner explicit dim's
'' and variable name shadowing.


ASSERT(__FB_OPTION_EXPLICIT__ <> 0)


'' SCOPE...END SCOPE creates a new local scope
'' implicit variable scope is inherited
'':::::
sub test_opt_exp_scope_imp_inherit cdecl ()
  dim x

  x = 1
  CU_ASSERT( x = 1 )
  
  scope
    x += 3
    CU_ASSERT( x = 4 )
  
    scope
      x += 5
      CU_ASSERT( x = 9 )
    end scope
  
    x += 3
    CU_ASSERT( x = 12 )
  
  end scope
  
  x += 1
  CU_ASSERT( x = 13 )
end sub


'' SCOPE...END SCOPE creates a new local scope
'' DIM inside SCOPE shadows parent scope variable
'':::::
sub test_opt_exp_scope_exp_shadow cdecl ()

  dim x

  x = 1
  CU_ASSERT( x = 1 )
  
  scope
    dim x
    x += 3
    CU_ASSERT( x = 3 )
  
    scope
      dim x
      x += 5
      CU_ASSERT( x = 5 )
    end scope
  
    x += 3
    CU_ASSERT( x = 6 )
  
  end scope

  x += 1
  CU_ASSERT( x = 2 )

end sub


'' IF...THEN creates a new local scope
'' implicit variable scope is inherited
'':::::
sub test_opt_exp_if_imp_inherit cdecl ()
  dim x

  x = 1
  CU_ASSERT( x = 1 )
  
  if 1 then
    x += 1
    CU_ASSERT( x = 2 )
  else
    CU_ASSERT( 0 )
  end if
  
  CU_ASSERT( x = 2 )

  if 0 then
    CU_ASSERT( 0 )
  else
    x += 1
    CU_ASSERT( x = 3 )
  end if

  CU_ASSERT( x = 3 )

end sub


'' IF...THEN creates a new local scope
'' DIM inside SCOPE shadows parent scope variable
'':::::
sub test_opt_exp_if_exp_shadow cdecl ()

  dim x

  x = 1
  CU_ASSERT( x = 1 )
  
  if 1 then
    dim x
    x += 2
    CU_ASSERT( x = 2 )
  else
    CU_ASSERT( 0 )
  end if
  
  CU_ASSERT( x = 1 )
  
  if 0 then
    CU_ASSERT( 0 )
  else
    dim x
    x += 2
    CU_ASSERT( x = 2 )
  end if
  
  CU_ASSERT( x = 1 )

end sub

  
'' DO...WHILE creates a new local scope
'' implicit variable scope is inherited
'' DIM inside SCOPE shadows parent scope variable
'':::::
sub test_opt_exp_do cdecl ()

  dim x, i
    
  x = 1
  CU_ASSERT( x = 1 )
  
  do
    x += 1
    CU_ASSERT( x = 2 )
    exit do
  loop
  
  CU_ASSERT( x = 2 )
  
  x = 1
  CU_ASSERT( x = 1 )
  
  do
    dim x
    x += 1
    CU_ASSERT( x = 1 )
    exit do
  loop
  

  i = 0
  CU_ASSERT( i = 0 )
  
  x = 0
  CU_ASSERT( x = 0 )
  
  do
    dim x
    x += 1
    i += 1
  
    CU_ASSERT( x = 1 )
  
    if( i > 10 ) then
      exit do
    end if
  
  loop
  
  CU_ASSERT( i = 11 )
  CU_ASSERT( x = 0 )
  
  i = 0
  x = 0
  
  do
    x += 1
    i += 1
  
    CU_ASSERT( x = i )
  
    if( i > 10 ) then
      exit do
    end if
  
  loop
  
  CU_ASSERT( i = 11 )
  CU_ASSERT( x = 11 )

end sub


'' WHILE...WEND creates a new local scope
'' implicit variable scope is inherited
'' DIM inside SCOPE shadows parent scope variable
'':::::
sub test_opt_exp_while cdecl ()

  dim x, i
  
  x = 1
  CU_ASSERT( x = 1 )
  
  while 1
    x += 1
    CU_ASSERT( x = 2 )
    exit while
  wend
  
  CU_ASSERT( x = 2 )
  
  x = 1
  CU_ASSERT( x = 1 )
  
  while 1
    dim x
    x += 1
    CU_ASSERT( x = 1 )
    exit while
  wend
  
  i = 0
  CU_ASSERT( i = 0 )
  
  x = 0
  CU_ASSERT( x = 0 )
  
  while 1
    dim x
    x += 1
    i += 1
  
    CU_ASSERT( x = 1 )
  
    if( i > 10 ) then
      exit while
    end if
  
  wend
  
  CU_ASSERT( i = 11 )
  CU_ASSERT( x = 0 )
  
  i = 0
  x = 0
  
  while 1
    x += 1
    i += 1
  
    CU_ASSERT( x = i )
  
    if( i > 10 ) then
      exit while
    end if
  
  wend
  
  CU_ASSERT( i = 11 )
  CU_ASSERT( x = 11 )

end sub


'' FOR...NEXT creates a new local scope
'' implicit variable scope is inherited
'' DIM inside SCOPE shadows parent scope variable
'':::::
sub test_opt_exp_for cdecl ()

  dim x, i

  x = 1
  CU_ASSERT( x = 1 )
  
  for i = 1 to 10
    x += 1
    CU_ASSERT( x = 2 )
    exit for
  next i
  
  CU_ASSERT( x = 2 )
  
  x = 1
  CU_ASSERT( x = 1 )
  
  for i = 1 to 10
    dim x
    x += 1
    CU_ASSERT( x = 1 )
    exit for
  next i
  
  i = 0
  CU_ASSERT( i = 0 )
  
  x = 0
  CU_ASSERT( x = 0 )
  
  for i = 1 to 10
    dim x
    x += 1
  
    CU_ASSERT( x = 1 )
  
  next i
  
  CU_ASSERT( i = 11 )
  CU_ASSERT( x = 0 )
  
  for i = 1 to 10
    x += 1
  
    CU_ASSERT( x = i )
  
  next i
  
  CU_ASSERT( i = 11 )
  CU_ASSERT( x = 10 )
  
  
end sub

sub ctor () constructor

	fbcu.add_suite("fbc_test.scopes.shadow inherit")
	fbcu.add_test("test_opt_imp_scope_imp_inherit", @test_opt_imp_scope_imp_inherit)
	fbcu.add_test("test_opt_imp_scope_exp_shadow", @test_opt_imp_scope_exp_shadow)
	fbcu.add_test("test_opt_imp_if_imp_inherit", @test_opt_imp_if_imp_inherit)
	fbcu.add_test("test_opt_imp_if_exp_shadow", @test_opt_imp_if_exp_shadow)
	fbcu.add_test("test_opt_imp_do", @test_opt_imp_do)
	fbcu.add_test("test_opt_imp_while", @test_opt_imp_while)
	fbcu.add_test("test_opt_imp_for", @test_opt_imp_for)

	fbcu.add_test("test_opt_exp_scope_imp_inherit", @test_opt_exp_scope_imp_inherit)
	fbcu.add_test("test_opt_exp_scope_exp_shadow", @test_opt_exp_scope_exp_shadow)
	fbcu.add_test("test_opt_exp_if_imp_inherit", @test_opt_exp_if_imp_inherit)
	fbcu.add_test("test_opt_exp_if_exp_shadow", @test_opt_exp_if_exp_shadow)
	fbcu.add_test("test_opt_exp_do", @test_opt_exp_do)
	fbcu.add_test("test_opt_exp_while", @test_opt_exp_while)
	fbcu.add_test("test_opt_exp_for", @test_opt_exp_for)
end sub

end namespace

# endif
