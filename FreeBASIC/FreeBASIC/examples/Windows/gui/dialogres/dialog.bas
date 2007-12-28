'' 
'' Dialog Example, by fsw
'' 
'' compile with:  fbc -s gui dialog.rc dialog.bas 
'' 
'' 
 

#include once "windows.bi" 
#include "dialog.bi"

declare function DlgProc (byval hwnd as HWND, byval umsg as UINT, byval wparam as WPARAM, byval lparam as LPARAM) as BOOL
                                

''' 
''' Program start 
'''      

    '' 
    '' Create the Dialog 
    '' 
    DialogBoxParam( GetModuleHandle( NULL ), cast( LPCSTR, IDD_DLG1 ), NULL, @DlgProc, NULL ) 
    
    
    '' 
    '' Program has ended 
    '' 
    end 

''' 
''' Program end 
'''      

                                  

function DlgProc (byval hwnd as HWND, byval umsg as UINT, byval wparam as WPARAM, byval lparam as LPARAM) as BOOL
    dim as long id, event
    
    '' 
    '' Process message 
    '' 
    select case uMsg
    case WM_INITDIALOG
        
    '' 
    '' Window was closed 
    '' 
    case WM_CLOSE
    	EndDialog( hwnd, 0 ) 

    case WM_COMMAND
		id    = loword( wParam )
		event = hiword( wParam )

        select case id
        case IDC_BTN1
        	EndDialog( hwnd, 0 )
    	end select
        
    case else
    	return FALSE
    
    end select
    
   return TRUE
end function 
