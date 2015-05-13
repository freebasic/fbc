' TEST_MODE : COMPILE_ONLY_FAIL

'' Overloading based on BYVAL CONSTness shouldn't be allowed, as in g++/clang++.
'' Using ALIAS'es to ensure we test the compiler's duplicated definition error,
'' not the assembler's one.
sub f overload alias "f1"( byval p as sub( byval as integer       ) ) : end sub
sub f overload alias "f2"( byval p as sub( byval as const integer ) ) : end sub
