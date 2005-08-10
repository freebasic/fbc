''
'' tests for implicit number conversion due to math overflows
''


'' these ensure numeric constants are properly parsed, so that corrent types
'' get assigned to them (taking care of signedness and number length). If bad
'' types get assigned, wrong print rtlib functions will get called to print
'' the value.
print 1
print -1
print &h00000003
print &b00000011
print 2147483647
print -2147483648
print 4294967295
print 2147483648
print 9223372036854775807
print -9223372036854775808
print 18446744073709551615
print 9223372036854775808


dim b as byte
dim ub as ubyte
dim s as short
dim us as ushort
dim i as integer
dim ui as uinteger
dim l as longint
dim ul as ulongint

b = -128
b = 127
'' these should issue 2 warnings
b = -129
b = 128

ub = 0
ub = 255
'' these should issue 2 warnings
ub = -1
ub = 256

s = -32768
s = 32767
'' these should issue 2 warnings
s = -32769
s = 32768

us = 0
us = 65535
'' these should issue 2 warnings
us = -1
us = 65536

i = -2147483648
i = 2147483647
'' these should issue 2 warnings
i = -2147483649
i = 2147483648

ui = 0
ui = 4294967295
'' these should issue 2 warnings
ui = -1
ui = 4294967296

l = -9223372036854775808
l = 9223372036854775807
'' these should issue 2 warnings
l = -9223372036854775809
l = 9223372036854775808

ul = 0
ul = 18446744073709551615
'' this should issue a warning
ul = -1
'' this should issue an error if uncommented
'ul = 18446744073709551616

