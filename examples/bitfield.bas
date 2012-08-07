type MyType
	as integer flag0 : 1, flag1 : 1
	foo : 7 as integer
end type

type MyTypeRegular
	as integer flag0, flag1
	foo as integer
end type

'' Bitfields will only use up the specified amount of bits in the structure,
'' so the structure will take up less bytes in memory compared to the one with
'' regular fields.
print "sizeof(MyType) = "; sizeof(MyType)
print "sizeof(MyTypeRegular) = "; sizeof(MyTypeRegular)

dim as MyType x

'' You can use 1-bit bitfields to hold true/false flags
x.flag0 = 1
x.flag1 = 1

if x.flag0 and x.flag1 then
	print "both flags set!"
elseif x.flag0 then
	print "only flag 0 set"
elseif x.flag1 then
	print "only flag 1 set"
else
	print "no flag set"
end if

'' Bitfields with more bits can store bigger numbers
x.foo = 123
print x.foo

'' Although, if the number is too big, it will be cut off
x.foo = 1234
print 1234, bin(1234, 32)
print x.foo, bin(x.foo, 32)
