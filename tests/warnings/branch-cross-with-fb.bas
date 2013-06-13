type UDT
	as integer a, b
end type

dim x as UDT
dim px as UDT ptr = @x

#print "WITH, 2 warnings:"

goto with1:
with *px
	with1:
	print .a, .b '' WITH pointer uninitialized
end with

goto with2:
scope
	with *px
		with2:
		print .a, .b '' WITH pointer uninitialized
	end with
end scope
