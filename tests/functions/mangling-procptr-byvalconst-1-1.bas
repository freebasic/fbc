' TEST_MODE : COMPILE_ONLY_FAIL

'' Overloading based on BYVAL CONSTness shouldn't be allowed, as in g++/clang++.
sub f overload( byval p as sub( byval as integer       ) ) : end sub
sub f overload( byval p as sub( byval as const integer ) ) : end sub
