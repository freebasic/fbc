
type MYTYPE
	a			as integer
	b			as double
	c			as string * 4
end type

	dim shared t(10) as MYTYPE
	
	t(0).a = 1
	t(0).b = 2.0
	t(0).c = "3"
	
	i = 5
	
	print t(0).a, t(0).b, t(0).c
	
	with t(i)
		.a = t(0).a
		.b = t(0).b
		.c = t(0).c
		print .a, .b, .c
	end	with
	
	print t(i).a, t(i).b, t(i).c
	
	sleep