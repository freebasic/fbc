'' 
'' Dialog Example, by fsw
'' 
'' compile with:  fbc -s gui dialog.rc dialog.bas 
'' 
'' 
option explicit 

#INCLUDE ONCE "win/kernel32.bi" 
#INCLUDE ONCE "win/user32.bi" 

#include "dialog.bi"

declare function DlgProc ( byval hWnd as long, byval uMsg as long, byval wParam as long, byval lParam as long ) as integer 
                                

''' 
''' Program start 
'''      

    '' 
    '' Create the Dialog 
    '' 
    DialogBoxParam(GetModuleHandle (NULL), byval IDD_DLG1, NULL, @DlgProc, NULL) 
    
    
    '' 
    '' Program has ended 
    '' 
    ExitProcess (0) 
    end 

''' 
''' Program end 
'''      

                                  

function DlgProc ( byval hDlg as long, byval uMsg as long, byval wParam as long, byval lParam as long ) as integer 
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
        EndDialog( hDlg, 0 ) 

    case WM_COMMAND
		id    = loword( wParam )
		event = hiword( wParam )

        select case id
        case IDC_BTN1
        	EndDialog( hDlg, 0 )
    	end select
        
    case else
    	return 0 
    
    end select
    
   return 1 
end function 
