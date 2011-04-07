''
'' compile as: fbc onerror.bas -ex
''

#lang "fblite"

'':::::
function hFileExists( filename as string ) as integer static
    dim f as integer

	hFileExists = 0
	
	on local error goto exitfunction
	
	f = freefile
	open filename for input as #f
	
	close #f

	hFileExists = -1

exitfunction:
    exit function
end function


	print "File exists (0=false): "; hFileExists( command )
	
	on error goto errhandler	
	error 1234
	print "back from resume next"
	end 0
	
errhandler:	
	print "error number: " + str( err ) + " at line: " + str( erl )
	resume next
