''
'' dynamic importing example
''
'' compile as: fbc import.bas export.bas
''

'$include: 'win\kernel32.bi'

	'' create a function pointer, arguments must be the same as in the original function
	dim AddNumbers as function ( byval operand1 as integer, byval operand2 as integer ) as integer

	'' get our handler
	dim exehandle as integer
	exehandle = GetModuleHandle( NULL )
	
	'' find the proc address (case matters!)
	AddNumbers = GetProcAddress( exehandle, "AddNumbers" )
		
	'' call it..
	print "1 + 2 ="; AddNumbers( 1, 2 )
	
	sleep
	
	