''
'' shell folder example, code by UBE (...@...)
''

option explicit

#include once "windows.bi"
#include once "win/shlobj.bi"


	dim Shared sFolder as string 

''
function BrowseCallbackProc(byval hWnd as HWND, _
							byval uMsg as UINT, _ 
                            byval lParam as LPARAM, _
                            byval lpData as LPARAM) as integer 

    select case uMsg 
    case BFFM_INITIALIZED 
        SendMessage( hWnd, BFFM_SETSELECTIONA, -1, strptr( sFolder ) ) 
    
    case BFFM_SELCHANGED 
        dim as zstring * MAX_PATH sPath
      	
      	if SHGetPathFromIDList( cptr( LPCITEMIDLIST, lParam ), sPath) = 0 then 
            sPath = "Unknown"
        else 
            sPath = "PATH: " + sPath
        end if 
        
        SendMessage( hWnd, BFFM_SETSTATUSTEXTA, 0, @sPath )
   end select 
   
   function = 0 

end function 

''
function BrowseForFolder(byval hWnd as HWND, _
						 byval Prompt as string, _ 
                         byval Flags as integer, _
                         byval DefaultFolder as string) as string 
    
    dim bi         as BROWSEINFO 
    dim pidlReturn as LPITEMIDLIST
    dim pidlStart  as LPITEMIDLIST

    CoInitialize( NULL ) 
    SHGetSpecialFolderLocation( NULL, CSIDL_DRIVES, @pidlStart ) 

    with bi
	    .pidlRoot   = pidlStart 
	    .hwndOwner  = hWnd 
	    .lpszTitle  = @Prompt
	    .ulFlags    = Flags 
	   	.lpfn       = @BrowseCallbackProc 
	end with
    sFolder       	= DefaultFolder
    
   	pidlReturn = SHBrowseForFolder( @bi ) 
   
   	CoTaskMemFree( pidlStart ) 
   
   	if( pidlReturn <> NULL ) Then 
        dim as zstring * MAX_PATH path
        SHGetPathFromIDList( pidlReturn, path ) 
        CoTaskMemFree( pidlReturn ) 
        function = path    
    else
    	function = ""
    end if 
    
    CoUninitialize( ) 
    
end function


''
	print BrowseForFolder( NULL, "Shell Folder Test", BIF_RETURNONLYFSDIRS Or BIF_USENEWUI, "c:\" ) 
