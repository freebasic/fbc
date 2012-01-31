' TEST_MODE : COMPILE_ONLY_OK

sub test()
end sub

dim as sub() p = @test

'' Should be allowed, with casting
print *cptr(uinteger ptr, p)

'' ditto, even though it will probably cause bad things to happen at runtime
*cptr(uinteger ptr, p) = 1
