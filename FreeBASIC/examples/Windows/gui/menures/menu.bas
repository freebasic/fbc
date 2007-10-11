''
'' menu demo, using a resource script this time
''
'' compile as: fbc menu.bas menures.rc -s gui
''

#include once "windows.bi"
#include "menures.bi"

declare sub 			init_menus	( )

declare function        WinMain     ( byval hInstance as HINSTANCE, _
                                      byval hPrevInstance as HINSTANCE, _
                                      szCmdLine as string, _
                                      byval iCmdShow as integer ) as integer

''
'' globals
''
	dim shared menutitleTB(0 to 99) as string
                                  
                                  
    ''
    '' Entry point    
    ''
	end WinMain( GetModuleHandle( null ), null, Command, SW_NORMAL )
    
    
    


'' ::::::::
'' name: WndProc
'' desc: Processes windows messages
''
'' ::::::::
function WndProc ( byval hWnd as HWND, _
                   byval message as UINT, _
                   byval wParam as WPARAM, _
                   byval lParam as LPARAM ) as LRESULT
    
    dim rct as RECT
    dim pnt as PAINTSTRUCT
    dim hDC as HDC
    
    static lastmenuid as integer
    dim wmId as integer, wmEvent as integer
    dim menu as HMENU
    
    function = 0
    
    ''
    '' Process message
    ''
    select case ( message )
       
        ''
        ''
        ''        
        case WM_CREATE            
            init_menus( )
            exit function
        
    	''
    	'' menu item selected
    	''
		case WM_COMMAND
			wmId    = loword( wParam )
			wmEvent = hiword( wParam )
			
			menu = GetMenu( hWnd )
			
			''
			'' parse the menu selections
			''
			select case wmId
			'' quit
			case IDM_FILE_EXIT
				PostMessage( hWnd, WM_CLOSE, 0, 0 )
				exit function
			end select
			
			'' save current menuitem id
			lastmenuid = wmId
        
			'' force a repaint so the menu id and title will be drawn
			GetClientRect( hWnd, @rct )
			InvalidateRect( hWnd, @rct, TRUE )
        
        ''
        '' Windows is being repainted
        ''
        case WM_PAINT
          
            hDC = BeginPaint( hWnd, @pnt )
            GetClientRect( hWnd, @rct )
            
            if( lastmenuid <> 0 ) then
            	DrawText( hDC, _
            			 "Last menu selected: id(" & lastmenuid & ") title(" & menutitleTB(lastmenuid-IDM_BASE) & ")", _
            			 -1, _
            			 @rct, _
            			 DT_SINGLELINE or DT_CENTER or DT_VCENTER )
            end if
            
            EndPaint( hWnd, @pnt )
            
            exit function            
        
		''
		''
		''
		case WM_KEYDOWN
			if( lobyte( wParam ) = 27 ) then
				PostMessage( hWnd, WM_CLOSE, 0, 0 )
			end if

        ''
        '' Window was closed
        ''
        case WM_DESTROY
            PostQuitMessage( 0 )
            exit function
    end select
    
    ''
    '' Message doesn't concern us, send it to the default handler
    '' and get result
    ''
    function = DefWindowProc( hWnd, message, wParam, lParam )    
    
end function


sub init_menus( )
	''
	'' create a table with menu titles 
	''
	menutitleTB(IDM_FILE_NEW-IDM_BASE) 			= TITLEM_FILE_NEW
	menutitleTB(IDM_FILE_OPEN-IDM_BASE) 		= TITLEM_FILE_OPEN
	menutitleTB(IDM_FILE_EXIT-IDM_BASE) 		= TITLEM_FILE_EXIT
	menutitleTB(IDM_PROJECT_NEW-IDM_BASE) 		= TITLEM_PROJECT_NEW
	menutitleTB(IDM_PROJECT_OPEN-IDM_BASE) 		= TITLEM_PROJECT_OPEN
	menutitleTB(IDM_FILE_CLOSE-IDM_BASE) 		= TITLEM_FILE_CLOSE
	menutitleTB(IDM_EDIT_UNDO-IDM_BASE) 		= TITLEM_EDIT_UNDO
	menutitleTB(IDM_EDIT_REDO-IDM_BASE) 		= TITLEM_EDIT_REDO
	menutitleTB(IDM_EDIT_CUT-IDM_BASE) 			= TITLEM_EDIT_CUT
	menutitleTB(IDM_EDIT_COPY-IDM_BASE) 		= TITLEM_EDIT_COPY
	menutitleTB(IDM_SEARCH_FIND-IDM_BASE) 		= TITLEM_SEARCH_FIND
	menutitleTB(IDM_SEARCH_FINDNEXT-IDM_BASE) 	= TITLEM_SEARCH_FINDNEXT
	menutitleTB(IDM_SEARCH_FINDPREV-IDM_BASE) 	= TITLEM_SEARCH_FINDPREV
	menutitleTB(IDM_SEARCH_REPLACE-IDM_BASE) 	= TITLEM_SEARCH_REPLACE
end sub


'' ::::::::
'' name: WinMain
'' desc: A win2 gui program entry point
''
'' ::::::::
function WinMain ( byval hInstance as HINSTANCE, _
                   byval hPrevInstance as HINSTANCE, _
                   szCmdLine as string, _
                   byval iCmdShow as integer ) as integer    
     
    dim wMsg as MSG
    dim wcls as WNDCLASS     
    dim appName as string
    dim hWnd as HWND
    
	function = 0
     
    ''
    '' Setup window class
    ''
    appName = "MenuResource"
     
    with wcls
     	.style         = CS_HREDRAW or CS_VREDRAW
     	.lpfnWndProc   = @WndProc
     	.cbClsExtra    = 0
     	.cbWndExtra    = 0
     	.hInstance     = hInstance
     	.hIcon         = LoadIcon( null, IDI_APPLICATION )
     	.hCursor       = LoadCursor( null, IDC_ARROW )
     	.hbrBackground = GetStockObject( WHITE_BRUSH )
     	.lpszMenuName  = cast(zstring ptr, IDC_MAINMENU)
     	.lpszClassName = strptr( appName )
    end with
     
    ''
    '' Register the window class     
    ''     
    if ( RegisterClass( @wcls ) = false ) then
		MessageBox( null, "Could not register the window class", appName, MB_ICONERROR )
       	exit function
    end if
    
    ''
    '' Create the window and show it
    ''
    hWnd = CreateWindowEx( 0, _
    			 		   appName, _
                           "Menu Resource Test", _
                           WS_OVERLAPPEDWINDOW or WS_CLIPCHILDREN, _
                           CW_USEDEFAULT, _
                           CW_USEDEFAULT, _
                           CW_USEDEFAULT, _
                           CW_USEDEFAULT, _
                           null, _
                           null, _
                           hInstance, _
                           null )
                          

    ShowWindow( hWnd, iCmdShow )
    UpdateWindow( hWnd )
     
	dim hAccelTable as HACCEL
	
	hAccelTable = LoadAccelerators( hInstance, cast( LPCSTR, IDC_MAINMENU ) )

    ''
    '' Process windows messages
    ''
    while ( GetMessage( @wMsg, null, 0, 0 ) <> FALSE )    
		if( TranslateAccelerator( wMsg.hwnd, hAccelTable, @wMsg ) = 0 ) then
        	TranslateMessage( @wMsg )
        	DispatchMessage( @wMsg )
        end if
    wend
    
    ''
    '' Program has ended
    ''
    function = wMsg.wParam

end function






