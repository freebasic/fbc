' TEST_MODE : COMPILE_AND_RUN_OK

'' This should just show the "parameter initializer mismatch" warning, but not
'' cause any compiler/linker errors.

declare sub f(byval i as integer = 0)

sub f(byval i as integer = 1)
end sub

f()
