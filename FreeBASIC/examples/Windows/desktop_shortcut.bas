

#include once "windows.bi"
#include once "win/shlobj.bi"

declare function hStripFilePath( byval filename as zstring ptr ) as string
declare function hStripFileExt( byval filename as zstring ptr ) as string

declare function createDestopShortcut( byval TargetName as zstring ptr, _
							   		   byval LinkName as zstring ptr ) as integer


'' main
	randomize timer
	
	'' create a desktop shortcut to itself
	createDestopShortcut( ExePath( ) & "\" & hStripFileExt( __FILE__ ) & ".exe", _
	 					  "FB Created Link #" & cint( rnd * 100 ) & ".lnk" )
	


'':::::
function createDestopShortcut( byval TargetName as zstring ptr, _
							   byval LinkName as zstring ptr ) as integer
	dim as IShellLink ptr ISLink
	dim as IPersistFile ptr IPFile
	dim as LPITEMIDLIST PIDL
	dim as zstring * MAX_PATH InFolder
  
	function = FALSE
	
	''
	CoInitialize( NULL ) 
  
	''
	SHGetSpecialFolderLocation( 0, CSIDL_DESKTOPDIRECTORY, @PIDL )
	SHGetPathFromIDList( PIDL, InFolder )
	
	''
	CoCreateInstance( @CLSID_ShellLink, NULL, CLSCTX_INPROC_SERVER, @IID_IShellLink, @ISLink )
	
	IShellLinkA_SetPath( ISLink, TargetName )
	IShellLinkA_SetWorkingDirectory( ISLink, hStripFilePath( TargetName ) )

	'' 
	IShellLinkA_QueryInterface( ISLink, @IID_IPersistFile, @IPFile )

	IPersistFile_Save( IPFile, InFolder + "\" + *LinkName, 0 )
	
	''
	IPersistFile_Release( IPFile )
	
	IShellLinkA_Release( ISLink )
	
	CoUninitialize( ) 
	
	function = TRUE
	
end function

	
	
'':::::
private function hStripFilePath( byval filename as zstring ptr ) as string static
    dim as integer lp, p

	lp = 0
	do
		p = instr( lp+1, *filename, "\" )
        if p=0 then
	    	exit do
	    end if
	    lp = p
	loop

	if( lp > 0 ) then
		function = mid( *filename, lp+1 )
	else
		function = *filename
	end if

end function

'':::::
private function hStripFileExt( byval filename as zstring ptr ) as string static
    dim p as integer, lp as integer

	lp = 0
	do
		p = instr( lp+1, *filename, "." )
	    if( p = 0 ) then
	    	exit do
	    end if
	    lp = p
	loop

	if( lp > 0 ) then
		function = left( *filename, lp-1 )
	else
		function = *filename
	end if

end function
