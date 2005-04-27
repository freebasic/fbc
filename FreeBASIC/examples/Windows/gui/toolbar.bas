''
'' toolbar demo, code by zydon (...@...)
''

option explicit
option private

'$include once:'win\kernel32.bi' 
'$include once:'win\user32.bi' 
'$include once:'win\commctrl32.bi'

const TBSTYLES = TBSTYLE_FLAT or CCS_ADJUSTABLE or CCS_NODIVIDER 

	dim shared hInstance as long 
	
	hInstance = GetModuleHandle( null )
	

'' 
'' Window Procedure Handler 
'' 
function WndProc ( byval hWnd as long, _ 
                   byval uMsg as long, _ 
                   byval wParam as long, _ 
                   byval lParam as long ) as integer 

    WndProc = 0 
    
    select case ( uMsg ) 
	case WM_CREATE 
		dim i as LONG 
              
        '' Toolbar object handle    
        dim hTools as LONG 
              
        '' Toolbar class string 
        dim szTBClass as STRING 
        szTBClass = "ToolbarWindow32" 

        '' Toolbar button constructors 
        dim tbAddBmp as TBADDBITMAP 
        dim tbb as TBBUTTON 

        '' setting common control mode 
        dim iccx as INITCOMMONCONTROLSEX 
        iccx.dwSize = len( iccx ) 
        iccx.dwICC  = ICC_BAR_CLASSES 

        '' bitmap for each button 
        dim tbBmp(7) as BYTE 
        tbBmp(0) = STD_FILENEW 
        tbBmp(1) = STD_FILEOPEN 
        tbBmp(2) = STD_FILESAVE 
        tbBmp(4) = STD_CUT 
        tbBmp(5) = STD_COPY 
        tbBmp(6) = STD_PASTE 

        '' initialize common controls 32 
        InitCommonControlsEx iccx 

        '' Lets build a new toolbar 
        hTools = CreateWindowEx( WS_EX_DLGMODALFRAME, _ 
        						 szTBClass, "", _ 
                       			 WS_CHILD or WS_VISIBLE or TBSTYLES, _ 
                       			 0, 0, 0, 0, _ 
                       			 hWnd, null, _ 
                       			 hInstance, null ) 
              
		'' paint toolbar buttons now 
    	if ( hTools <> NULL ) then                 
        	'' draw toolbar panel 
            SendMessage( hTools, TB_BUTTONSTRUCTSIZE, len( tbb ), byval NULL ) 
            tbAddBmp.handle = HINST_COMMCTRL 
            tbAddBmp.nID    = IDB_STD_SMALL_COLOR 
            SendMessage( hTools, TB_ADDBITMAP, 0, tbAddBmp ) 

            '' apply bitmap to toolbar buttons 
            for i = 0 to 6 
				tbb.iBitmap   = tbBmp(i) 
                tbb.fsState   = TBSTATE_ENABLED 
                if ( i = 3 ) then 
                	tbb.fsStyle   = TBSTYLE_SEP 
                else 
                	tbb.fsStyle   = TBSTYLE_BUTTON 
                end if 
                tbb.idCommand = -1 
                tbb.dwData    = 0 
                SendMessage( hTools, TB_ADDBUTTONS, 1, tbb ) 
			next 
		end if 
        
	case WM_KEYDOWN 
    	if( lobyte( wParam ) = 27 ) then 
			PostMessage hWnd, WM_CLOSE, 0, 0 
		end if 
        
	case WM_DESTROY 
		PostQuitMessage 0            
        exit function 
    end select 
    
    WndProc = DefWindowProc( hWnd, uMsg, wParam, lParam )    

end function 


	'' 
	'' Program entry 
	'' 
	dim wMsg as MSG 
	dim wcls as WNDCLASS      
	dim hWnd as unsigned long 
	
	dim szAppName as string 
    szAppName = "WinToolBar" 
    
	with wcls
		.style         = CS_HREDRAW or CS_VREDRAW 
		.lpfnWndProc   = @WndProc
		.cbClsExtra    = 0 
		.cbWndExtra    = 0 
		.hInstance     = hInstance 
		.hIcon         = LoadIcon( null, byval IDI_APPLICATION ) 
		.hCursor       = LoadCursor( null, byval IDC_ARROW ) 
		.hbrBackground = 16  ' btnface color 
		.lpszMenuName  = null 
		.lpszClassName = strptr( szAppName ) 
	end with
      
	if ( RegisterClass( wcls ) = false ) then 
   		MessageBox null, "Failed to register wcls!",  szAppName, MB_ICONERROR 
   		end 1
	end if 
    
	hWnd = CreateWindowEx( 0, _ 
                           szAppName, "ToolBar Demo", _ 
         			  	   WS_OVERLAPPEDWINDOW or WS_VISIBLE, _ 
         				   100, 100, 300, 200, _ 
         				   null, null, hInstance, null ) 
                          
	'' 
	'' messages loop 
	'' 
	do until( GetMessage( wMsg, null, 0, 0 ) = FALSE )
		TranslateMessage wMsg 
   		DispatchMessage  wMsg 
	loop
	
	end 0
