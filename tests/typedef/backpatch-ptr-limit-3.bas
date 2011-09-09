' TEST_MODE : COMPILE_ONLY_FAIL

type x as y       ptr ptr ptr ptr

'' Declaring a ptr to a forward ref typedef, that's ok, making it 4 + 1 + unknown PTR's
dim as x ptr foo

'' This disallows it, but it's unknown until the back-patching is done
type y as integer ptr ptr ptr ptr

'' Without the ptrcount check during back-patching this will print 9 PTR's...
''#print typeof(foo)
