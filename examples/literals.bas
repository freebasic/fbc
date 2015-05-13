dim b as byte
dim sh as short
dim i as integer
dim l as long
dim ll as longint
b  = -128
sh = -32768
i  = -2147483648u
l  = -2147483648u
ll = -9223372036854775808ull
print b, sh, i, l, ll

b  =  127
sh =  32767
i  =  2147483647
l  =  2147483647
ll =  9223372036854775807ll
print b, sh, i, l, ll

dim ub as ubyte
dim ush as ushort
dim ui as uinteger
dim ul as ulong
dim ull as ulongint
ub  = 255
ush = 65535
ui  = 4294967295u
ul  = 4294967295u
ull = 18446744073709551615ull
print ub, ush, ui, ul, ull

print 1.1f, 1.1e+1f, 1.1e-1f, 2.2, 2.2d

print "---"
print !"hello\nworld"
print "---"
print wstr("hello")
