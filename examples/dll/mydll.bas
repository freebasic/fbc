''
'' mydll -- simple dll test
''
'' compile as: fbc -dll mydll.bas
''
'' (will create mydll.dll and libmydll.dll.a under Win32,
''  or libmydll.so under Linux)
''
'' note: libmydll.dll.a is an import library, it's only needed when creating 
''       an executable that calls any of mydll's functions, only distribute 
''       the DLL files with your apps, do not include the import libraries, 
''       they are useless to end-users
''

#include once "mydll.bi"

'' simple exported function, the full prototype is in mydll.bi.
'' (the EXPORT clause must be used here)
function AddNumbers( byval a as integer, byval b as integer) as integer export
	function = a + b
end function
