''
'' WITH test
''

type MYTYPE
	c			as integer
	d			as double
	e			as string * 4
end type

	dim shared t(10) as MYTYPE
	
	t(0).c = 1
	t(0).d = 2.0
	t(0).e = "3"
	
	dim as integer i = 5
	
	print t(0).c, t(0).d, t(0).e
	
	with t(i)
		.c = t(0).c
		.d = t(0).d
		.e = t(0).e
		print .c, .d, .e
	end	with
	
	print t(i).c, t(i).d, t(i).e
	
	''-------------------
	
type bar
	abc		as integer
end type

type foo
	bar		as bar
end type
	
	dim foo as foo
	dim bar as bar
	
	with foo
		with .bar
			.abc = 1234
		end with

		with bar
			.abc = 5678
		end with
		
		print "1234 ="; .bar.abc
		print "5678 ="; bar.abc
	end with
	
	sleep
