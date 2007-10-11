''
'' mydll -- simple dll test
''
'' compile as: fbc -dll mydll.bas (will create mydll.dll and libmydll.dll.a under Win32,
''                                 or libmydll.so under Linux)
''
'' note: libmydll.dll.a is an import library, it's only needed when creating 
''       an executable that calls any of mydll's functions, only distribute 
''       the DLL files with your apps, do not include the import libraries, 
''       they are useless to end-users
''

#include once "mydll.bi"

	''
	'' note: do not add any executable code to the main module (ie: outside 
	'' any function), because that code will never be executed as only DllMain 
	'' is invoked by Windows at the initialization
	''
	

''::::::
''
'' simple exported function, the full prototype is at mydll.bi (the EXPORT clause must be used here)
''
function AddNumbers ( byval operand1 as integer, byval operand2 as integer ) as integer export

	function = operand1 + operand2
	
end function

