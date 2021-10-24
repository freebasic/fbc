' TEST_MODE : COMPILE_ONLY_OK

'' reserved extern symbols can still be used in the current module
'' if they are not exported as any public symbol

#pragma reserve (extern) symbol1
#pragma reserve (extern) symbol2
#pragma reserve (extern) symbol3
#pragma reserve (extern) symbol4
#pragma reserve (extern) symbol5
#pragma reserve (extern) symbol6
#pragma reserve (extern) symbol7
#pragma reserve (extern) symbol8

type symbol1
	__ as integer
end type

type symbol2 as symbol1

union symbol3
	__ as integer
end union

enum symbol4
	symbol5
end enum

namespace symbol6
end namespace

const symbol7 = 0

var symbol8 = 0

#define symbol9 0

