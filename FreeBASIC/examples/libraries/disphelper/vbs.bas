
#define UNICODE
#include "disphelper/disphelper.bi"

'' **************************************************************************
'' RunScript:
''   Run a script using the MSScriptControl. Optionally return a result.
''
sub RunScript ( byval szRetIdentifier as LPWSTR, _
			    byval pResult as LPVOID, _
			    byval szScript as LPWSTR, _
			    byval szLanguage as LPWSTR )
			  
	DISPATCH_OBJ(scrCtl)

	if( SUCCEEDED( dhCreateObject( "MSScriptControl.ScriptControl", NULL, @scrCtl )  ) ) then
		if( SUCCEEDED( dhPutValue( scrCtl, ".Language = %T", szLanguage ) ) ) then
			dhPutValue(scrCtl, ".AllowUI = %b", TRUE)
			dhPutValue(scrCtl, ".UseSafeSubset = %b", FALSE)
	
			if( pResult = FALSE ) then
				dhCallMethod( scrCtl, ".Eval(%T)", szScript )
			else
				dhGetValue( szRetIdentifier, pResult, scrCtl, ".Eval(%T)", szScript )
			end if
		end if
	end if

	SAFE_RELEASE( scrCtl )
	
end sub

	dim as integer nResult

	dhInitialize( TRUE )
	dhToggleExceptions( TRUE )

	'' VBScript sample
	RunScript( NULL, NULL, !"MsgBox(\"This is a VBScript test.\" & vbcrlf & \"It worked!\",64 Or 3)", "VBScript" )

	'' JScript sample
	RunScript( "%d", @nResult, "Math.round(Math.pow(5, 2) * Math.PI)", "JScript" )
	print "Result ="; nResult

	print "Press any key to exit..."
	sleep

	dhUninitialize(TRUE)
