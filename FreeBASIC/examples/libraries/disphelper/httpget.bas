''
'' HTTP GET example, using MSXML2
''



#define UNICODE
#include "disphelper/disphelper.bi"

	DISPATCH_OBJ(objHTTP)
	dim as zstring ptr szResponse

    dhInitialize( TRUE )
    dhToggleExceptions( TRUE )

	dhCreateObject( "MSXML2.XMLHTTP.4.0", NULL, @objHTTP )
	
	dhCallMethod( objHTTP, ".Open(%s, %s, %b)", "GET", "http://sourceforge.net", FALSE )
	dhCallMethod( objHTTP, ".Send" )

	dhGetValue( "%s", @szResponse, objHTTP, ".ResponseText" )

	print "Response: "; *szResponse
	dhFreeString( szResponse )

	SAFE_RELEASE( objHTTP )
	dhUninitialize( TRUE )
