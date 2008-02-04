' TEST_MODE : COMPILE_ONLY_FAIL

/'
function foo2 overload ( byref a as integer, byref b as integer ) as integer
  return 2
end function
'/

function foo2 overload ( byref a as integer, byref b as const integer ) as integer
  return 2
end function

function foo2 overload ( byref a as const integer, byref b as integer ) as integer
  return 3
end function

function foo2 overload ( byref a as const integer, byref b as const integer ) as integer
  return 4
end function

dim a as integer

'' ambiguous call
foo2( a, a )

