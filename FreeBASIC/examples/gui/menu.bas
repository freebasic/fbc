''
'' menu demo
''

defint a-z
option explicit
option private

'$include once:'win\kernel32.bi'
'$include once:'win\user32.bi'
'$include once:'win\gdi32.bi'

''
'' internal structs
''
type TMENU
	hnd		as integer
end type

type TMENUITEM
	title	as string
	id		as integer
end type

''
'' menu ID's
''
const MENUID_BASE		= 100

enum MENUID_ENUM
	MENUID_FILE_NEW		= MENUID_BASE
	MENUID_FILE_OPEN
	MENUID_FILE_EXIT
	MENUID_PROJECT_NEW
	MENUID_PROJECT_OPEN
	MENUID_FILE_CLOSE
    MENUID_EDIT_UNDO
    MENUID_EDIT_REDO
    MENUID_EDIT_CUT
    MENUID_EDIT_COPY
    MENUID_SEARCH_FIND
    MENUID_SEARCH_FINDNEXT
    MENUID_SEARCH_FINDPREV
    MENUID_SEARCH_REPLACE
end enum

const MAXMENUS			= 10
const MAXMENUITEMS 		= 50


declare sub init_menus( byval hWnd as integer )                                  
                                  

declare function        WinMain     ( byval hInstance as long, _
                                      byval hPrevInstance as long, _
                                      szCmdLine as string, _
                                      byval iCmdShow as integer ) as integer

	''
	'' globals
	''
	dim shared submenuTB(0 to MAXMENUS) as TMENU
	dim shared menuitemTB(0 to MAXMENUITEMS-1) as TMENUITEM

    ''
    '' Entry point    
    ''
	end WinMain( GetModuleHandle( null ), null, Command$, SW_NORMAL )
    
    
    


'' ::::::::
'' name: WndProc
'' desc: Processes windows messages
''
'' ::::::::
defint a-z
function WndProc ( byval hWnd as long, _
                   byval message as long, _
                   byval wParam as long, _
                   byval lParam as long ) as integer
    dim rct as RECT
    dim pnt as PAINTSTRUCT
    dim hDC as long
    
    static lastmenuid  as integer
    dim wmId as integer, wmEvent as integer
    dim menu as integer
    
    WndProc = 0
    
    ''
    '' Process message
    ''
    select case ( message )
       
        ''
        '' window created
        ''        
        case WM_CREATE            
            '' create and show the menus
            init_menus hWnd
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
			case MENUID_FILE_EXIT
				PostMessage hWnd, WM_CLOSE, 0, 0
				exit function
			end select
			
			'' save current menuitem id
			lastmenuid = wmId
        
			'' force a repaint so the menu id and title will be drawn
			dim rc as RECT
			GetClientRect hWnd, rc		
			InvalidateRect hWnd, rc, TRUE
        
        ''
        '' Windows is being repainted
        ''
        case WM_PAINT
          
            hDC = BeginPaint( hWnd, pnt )
            GetClientRect hWnd, rct
            
            if( lastmenuid <> 0 ) then
            	DrawText hDC, "Last menu selected: id(" + str$( lastmenuid ) + ") title(" _
            				  + menuitemTB(lastmenuid-MENUID_BASE).title + ")", -1, rct, DT_SINGLELINE or DT_CENTER or DT_VCENTER
            end if
            
            EndPaint hWnd, pnt
            
            exit function            
        
		''
		''
		''
		case WM_KEYDOWN
			if( lobyte( wParam ) = 27 ) then
				PostMessage hWnd, WM_CLOSE, 0, 0
			end if

        ''
        '' Window was closed
        ''
        case WM_DESTROY
            PostQuitMessage 0            
            exit function
    end select
    
    ''
    '' Message doesn't concern us, send it to the default handler
    ''
    WndProc = DefWindowProc( hWnd, message, wParam, lParam )    
    
end function




'' ::::::::
'' name: WinMain
'' desc: A win2 gui program entry point
''
'' ::::::::
defint a-z
function WinMain ( byval hInstance as long, _
                   byval hPrevInstance as long, _
                   szCmdLine as string, _
                   byval iCmdShow as integer ) as integer    
     
     dim wMsg as MSG
     dim wcls as WNDCLASS     
     dim szAppName as string
     dim hWnd as unsigned long

     
     WinMain = 0
     
     ''
     '' Setup window class
     ''
     szAppName = "Menu Test"
     
     with wcls
     	.style         = CS_HREDRAW or CS_VREDRAW
     	.lpfnWndProc   = @WndProc
     	.cbClsExtra    = 0
     	.cbWndExtra    = 0
     	.hInstance     = hInstance
     	.hIcon         = LoadIcon( null, IDI_APPLICATION )
     	.hCursor       = LoadCursor( null, IDC_ARROW )
     	.hbrBackground = GetStockObject( WHITE_BRUSH )
     	.lpszMenuName  = null
     	.lpszClassName = strptr( szAppName )
     end with
     
     
     ''
     '' Register the window class     
     ''     
     if ( RegisterClass( wcls ) = false ) then
        MessageBox null, "Failed to register the window class", szAppName, MB_ICONERROR               
        exit function
    end if
    
    

    ''
    '' Create the window and show it
    ''
    hWnd = CreateWindowEx( 0, _
    			 szAppName, _
                         "Menu test", _
                          WS_OVERLAPPEDWINDOW, _
                          CW_USEDEFAULT, _
                          CW_USEDEFAULT, _
                          CW_USEDEFAULT, _
                          CW_USEDEFAULT, _
                          null, _
                          null, _
                          hInstance, _
                          null )
                          

    ShowWindow   hWnd, iCmdShow
    UpdateWindow hWnd
     

    ''
    '' Process windows messages
    ''
    while ( GetMessage( wMsg, null, 0, 0 ) <> false )    
        TranslateMessage wMsg
        DispatchMessage  wMsg
    wend
    
    
    ''
    '' Program has ended
    ''
    WinMain = wMsg.wParam

end function

'':::::
sub menu_insert( byval hmenu as integer, byval submenu as integer, title as string, byval flags as integer = 0 )
    
    with submenuTB(submenu)
    
    	.hnd 	= CreatePopupMenu 
    
    	InsertMenu hmenu, submenu, MF_BYPOSITION Or MF_POPUP Or MF_STRING or flags, .hnd, ByVal title
    	
    end with
    
end sub

'':::::
sub menu_append( byval submenu as integer, byval id as integer, title as string, byval flags as integer = 0 )
    
    with menuitemTB(id-MENUID_BASE) 
    
    	.id = id
    	.title = title
    	
    	AppendMenu submenuTB(submenu).hnd, MF_STRING or flags, id, Byval title
    	
    end with
   
end sub

'':::::
sub menu_separator( byval submenu as integer )

    AppendMenu submenuTB(submenu).hnd, MF_SEPARATOR, 0, Byval NULL
   
end sub

'':::::
sub init_menus( byval hWnd as integer )
	dim menu as integer
 	
 	menu = CreateMenu 
 	
 	'' File
 	menu_insert menu, 0, "&File"
    
    menu_append 0, MENUID_FILE_NEW, "&New"
    menu_append 0, MENUID_FILE_OPEN, "&Open..." 

	menu_insert submenuTB(0).hnd, 3, "&Project"
    menu_append 3, MENUID_PROJECT_NEW, "&New" 
	menu_append 3, MENUID_PROJECT_OPEN, "&Open..." 
    
    menu_append 0, MENUID_FILE_CLOSE, "&Close" 
    menu_separator 0
    menu_append 0, MENUID_FILE_EXIT, "&Exit"
    
	'' Edit
 	menu_insert menu, 1, "&Edit"
 	
    menu_append 1, MENUID_EDIT_UNDO, "&Undo" 
    menu_append 1, MENUID_EDIT_REDO, "&Redo" 
    menu_separator 1
    menu_append 1, MENUID_EDIT_CUT, "&Cut" 
    menu_append 1, MENUID_EDIT_COPY, "C&opy" 

 	'' Search
 	menu_insert menu, 2, "&Search"

    menu_append 2, MENUID_SEARCH_FIND, "&Find"
    menu_append 2, MENUID_SEARCH_FINDNEXT, "Find &Next"
    menu_append 2, MENUID_SEARCH_FINDPREV, "Find &Prev"
    menu_append 2, MENUID_SEARCH_REPLACE, "&Replace", MF_MENUBARBREAK

    ''
    SetMenu hWnd, menu 
    
    DrawMenuBar hWnd
    
end sub