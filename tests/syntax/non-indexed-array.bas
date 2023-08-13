#print "---"

#print "-- no errors expected"
	type udt_int_array
	    dim as integer array(10)
	end type
	
	sub proc_int_array(array() as integer)
	end sub

	scope	
		dim as udt_int_array u
		dim as integer array(10)
		
		proc_int_array(u.array())   '' OK
		proc_int_array(array())     '' OK
		
#print "-- 4 errors expected"
		proc_int_array(u.array(0))  '' type mismatch
		proc_int_array(u.array(5))  '' type mismatch
		proc_int_array(array(1))    '' type mismatch
		proc_int_array(array(5))    '' type mismatch
	end scope

#print "-- no errors expected"
	sub proc_fptr_array( array() as sub (byval x as integer) )
	end sub
	
	sub proc_callback( byval x as integer )
	    print x
	end sub
	
	type udt_fptr_array
	    dim fptr_array(10) as sub ( byval as integer )
	end type

	scope	
		dim udtptr as udt_fptr_array ptr
		dim udtinst as udt_fptr_array
		
		dim fptr_array(10) as sub (byval as integer)
		
		proc_fptr_array(fptr_array())          '' OK
		proc_fptr_array(udtinst.fptr_array())  '' OK
		proc_fptr_array(udtptr->fptr_array())  '' OK
#print "-- 2 errors expected"	
		proc_fptr_array(udtinst.fptr_array(0)) '' type mismatch
		proc_fptr_array(udtptr->fptr_array(0)) '' type mismatch
	end scope	

#print "-- no errors expected"
	type udt_with_dtors
		i as integer
		array(-2 to 2) as string
	end type

	type udt_dynamic_array
		array1(any) as integer
	end type

#print "-- no errors expected"
	redim dynamic_array( 1 to 10 ) as integer
	'' REDIM using expression
	redim (dynamic_array)(1 to 1)


#print "-- no errors expected"
	scope
		dim array(0 to 100) as ubyte
		get (0,0)-(1,1),array
		get (0,0)-(1,1),array(0)
		get (0,0)-(1,1),array(1)
	
		type udt_gfx
			array(0 to 100-1) as ubyte
		end type
	
		dim udt as udt_gfx
		get (0,0)-(1,1),udt.array
		get (0,0)-(1,1),udt.array(0)
		get (0,0)-(1,1),udt.array(1)
	end scope

#print "-- no errors expected"
	scope
		dim array4b(0 to 3) as byte
		get #1,,array4b()
	end scope

#print "-- no errors expected"
	'' run-time array bounds
	sub proc_array_bounds( array() as integer )
		? lbound( array )
		? ubound( array )
	end sub

	dim shared array9(11 to ...) as integer = { 1, lbound( array9 ), 3 }
