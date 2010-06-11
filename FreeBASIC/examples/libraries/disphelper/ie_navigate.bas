''
'' IExplorer example
''

#define UNICODE
#include "disphelper/disphelper.bi"

sub navigate( byval url as string )
	DISPATCH_OBJ(ieApp)

	dhInitialize( TRUE )
	dhToggleExceptions( TRUE )

	dhCreateObject( "InternetExplorer.Application", NULL, @ieApp )
	
	dhPutValue( ieApp, "Visible = %b", TRUE )
	
	dhCallMethod( ieApp, ".Navigate(%s)", url )

	SAFE_RELEASE( ieApp )
	dhUninitialize( TRUE )
end sub
	
	navigate "www.freebasic.net"
