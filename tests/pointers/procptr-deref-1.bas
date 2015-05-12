' TEST_MODE : COMPILE_ONLY_FAIL

sub test()
end sub

dim as sub() p = @test

'' Only 'p(params)' should be allowed
*p = 1
