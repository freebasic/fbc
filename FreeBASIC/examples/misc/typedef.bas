''
'' forward type definitions test
''

type foo as bar

type sometype
	f   as foo ptr
end type

type bar
	st  as sometype
    a   as integer
end type

    dim s as sometype, b as bar
      
    b.st.f = @b
    s.f = @b
      
    s.f->st.f->a = 1234
      
	print "1234 ="; s.f->st.f->a
	
	
	type y as z ptr
	dim f1 as y, f2 as y ptr, f3 as y ptr ptr
	type z as short
	dim n as short
	
	f1 = @n
	f2 = @f1
	f3 = @f2
	
	***f3 = 123
	
	print "123 ="; ***f3


	sleep
