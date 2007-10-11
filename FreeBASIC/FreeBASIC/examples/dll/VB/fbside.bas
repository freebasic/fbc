''
'' compile as: fbc fbside.bas -dll
''

#include once "windows.bi"
#include once "win/ole2.bi"

'' notice the mangling method, it must be "windows-ms" or VB won't find any function
extern "windows-ms"

	'':::::
	function dupme ( byval arg as zstring ptr ) as BSTR export
		dim res as BSTR
		
		'' Note: according to MSDN, VB will only accept an BSTR result in
		'' 		 Unicode format *if* a COM type-library is created for the
		''       DLL that is been called, otherwise the BSTR result must
		''		 be in ANSI format, what is this case
		
		'' allocate a ANSI BSTR with twice the size
		res = SysAllocStringByteLen( arg, len( *arg ) * 2 )
		
		'' duplicate (BSTR's point to the data stream so just a cast is enough)
		*cast( zstring ptr, res ) += *arg
		
		'' return as-is
		function = res
	   
	end function
	
end extern