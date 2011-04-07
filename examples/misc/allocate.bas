''
'' dynamic memory allocation example
''

Type sometype
	x As Integer
	y As Integer
End Type

Declare Function somefunc() As sometype ptr

	Dim t as sometype, p as sometype ptr

	p = somefunc()
	t = *p
	print "x ="; p->x;
	deallocate p
	print " x ="; t.x	

	t = *somefunc()
	'''''deallocate -- returned pointer will leak here, just testing	
	print "y ="; t.y
	
	sleep

'':::::
Function somefunc() As sometype ptr
	dim p as sometype ptr
	
	p = allocate( len( sometype ) )
	
	p->x = 1234
	p->y = 5678
	
	somefunc = p

end function
