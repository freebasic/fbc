

#include "windows.bi" 
#include "win/commdlg.bi" 

function selectPrinter( ) as string
	dim as PRINTDLG pd
	pd.lStructSize = sizeof( PRINTDLG ) 

	if PrintDlg( @pd ) = FALSE then 
		exit function
	end if
	
	dim as DEVNAMES ptr dn = GlobalLock( pd.hDevNames )
	
	function = *cast( zstring ptr, cast( byte ptr, dn ) + dn->wDeviceOffset )
	
	GlobalUnlock( dn )
	
end function


	dim as string printerName
	
	printerName = selectPrinter( )
	
	if( len( printerName ) = 0 ) then
		print "No printer selected"
		end 1
	end if
	
	if( open lpt( "LPT:" + printerName + ",EMU=TTY", for output, as #1 ) <> 0 ) then
		print "Error: Open failed"
		end 1
	end if
	
	print "Printing to: "; printerName
	
	print #1, "Hello, world!"
	
	close #1
