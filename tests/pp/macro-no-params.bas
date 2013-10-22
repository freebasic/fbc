' TEST_MODE : COMPILE_ONLY_OK

#macro M1
	const N = 5
#endmacro

M1

#assert N = 5

#macro M2
	#define ABC
#endmacro

M2

#assert defined( M2 )

#macro M3
	"a"
#endmacro

print M3
