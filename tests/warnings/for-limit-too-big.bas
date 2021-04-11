#macro testForLimits(T, L, U)
for i as T = 0 to U
next i
for i as T = 0 to L step -1
next i
#endmacro

testForLimits(ubyte, 0, 255)
testForLimits(ushort, 0, 65535)
testForLimits(ulong, 0, 4294967295)
testForLimits(ulongint, 0, 18446744073709551615)

testForLimits(byte, -128, 127)
testForLimits(short, -32768, 32767)
testForLimits(long, -2147483648, 2147483647)
testForLimits(longint,   -9223372036854775808, 9223372036854775807)
