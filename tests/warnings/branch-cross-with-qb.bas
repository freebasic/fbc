#lang "qb"

type UDT
	as integer a, b
end type

dim x as UDT
dim px as UDT __ptr
px = @x

#print "no warnings:"

goto with1:
__with *px
	with1:
	print .a, .b '' WITH pointer uninitialized
end __with
