#include once "real10.bi"

dim as ext x, y, z
For x=1 To 10 step 10'extended variable used in For Next loop
	y = xlog10(x)
	z = xexp10(y)
	Print Using("###"); x; 'Print Using an extended variable
	Print Using("##.################");y;'is limited 16 digits
	Print "        ";
	Print Using("##.################");z
Next
Print "-------------------------"
For x=1 To 10
	y = xlog10(x)
	z = xexp10(y)
	Print Using("###"); x;
	Print y;"   ";z
Next
print
x="1e+1900"
x=x/3
print x
x=-x*x
print x
x=" 3.1415926535897932384626433832795e-4000"
? x
Print "press Return to End ";
Sleep
