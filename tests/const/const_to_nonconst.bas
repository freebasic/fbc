' TEST_MODE : COMPILE_ONLY_FAIL

sub foo( byref bas as string )
end sub

dim as const string bar = "hi"
foo( bar )
