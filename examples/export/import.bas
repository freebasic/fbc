''
'' dynamic importing example
''
'' compile as: fbc import.bas export.bas
''

	'' create a function pointer, arguments must be the same as in the original function
	dim AddNumbers as function ( byval operand1 as integer, byval operand2 as integer ) as integer

	'' find the proc address (case matters!)
	AddNumbers = dylibsymbol( 0, "AddNumbers" )
		
	'' call it..
	print "1 + 2 ="; AddNumbers( 1, 2 )
	
	sleep
	
	