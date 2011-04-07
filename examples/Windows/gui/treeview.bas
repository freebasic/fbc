'-------------------------------------------------------------- 
'        TreeViewEx and ImageList Demo for FreeBasic. 
'                    by zydon@mesra.net 
'-------------------------------------------------------------- 

#include once "windows.bi"
#include once "win/commctrl.bi"
#include once "win/shellapi.bi"

	dim shared hInstance as HINSTANCE
	dim shared rc as RECT 
	dim shared htv as HWND
	dim shared ilist as HIMAGELIST
	dim shared iccx as INITCOMMONCONTROLSEX 

    hInstance = GetModuleHandle( null ) 
    
    ilist  = ImageList_Create( GetSystemMetrics(SM_CXSMICON), _
    						   GetSystemMetrics(SM_CYSMICON), _
    						   ILC_COLOR8 or ILC_MASK, _
    						   1, _
    						   1 ) 
    
    iccx.dwSize = len( INITCOMMONCONTROLSEX ) 
    iccx.dwICC  = ICC_TREEVIEW_CLASSES or ICC_WIN95_CLASSES 

    InitCommonControlsEx( @iccx ) 


'' 
'' Window Procedure Handler 
'' 
function WndProc ( byval hWnd as HWND, _ 
                   byval uMsg as UINT, _ 
                   byval wParam as WPARAM, _ 
                   byval lParam as LPARAM ) as integer 

	function = 0 

  	select case ( uMsg ) 
	case WM_CREATE 

       	dim tvis as TVINSERTSTRUCT 

        dim i     as long, _ 
            hico  as HICON, _ 
            hPrev as HTREEITEM, _ 
            tlib  as long 

        dim as string ico, text

        GetClientRect( hWnd, @rc )

        htv = CreateWindowEx( WS_EX_CLIENTEDGE, WC_TREEVIEW, "",_ 
                              WS_CHILD or WS_VISIBLE or TVS_HASLINES _ 
                  			  or TVS_LINESATROOT or TVS_HASBUTTONS,_ 
                  			  0, 18, 160, rc.bottom-20,_ 
                  			  hWnd, 0, hInstance, 0 ) 

        TreeView_SetBkColor( htv, &hfff0e1 )

        for i = 3 to 5 
            ico = STR( i ) 
            hico = ExtractIcon( 0, "Shell32.DLL", i ) 
            ImageList_ReplaceIcon( ilist, -1, hico ) 
            DestroyIcon( hico ) 
        next i 

        TreeView_SetImageList( htv, ilist, TVSIL_NORMAL )
  
        clear tvis, 0, len(tvis)
        tvis.Item.Mask = TVIF_TEXT or TVIF_IMAGE or TVIF_SELECTEDIMAGE 

        '-- Root: tv.additem -> tv.item(0) 
        text                    	= "FreeBasic" 
        tvis.item.pszText          	= strptr(text) 
        tvis.item.cchTextMax       	= len(text) 
        tvis.item.iImage         	= 0 
        tvis.item.iSelectedImage 	= 1 
        tvis.hInsertAfter        	= 0 
        tvis.hParent             	= TVI_ROOT 
        hPrev                   	= TreeView_InsertItem( htv, @tvis )

        '-- tv.additem -> tv.item(1) | tv.children=0 
        text            	  		= "Inc" 
        tvis.item.pszText   		= strptr(text) 
        tvis.item.cchTextMax		= len(text) 
        tvis.hParent        		= hPrev 
        hPrev            	  		= TreeView_InsertItem( htv, @tvis )

        '-- tv.additem -> tv.item(2) | tv.children=1 
        text            			= "Win" 
        tvis.item.pszText   		= strptr(text) 
        tvis.item.cchTextMax		= len(text) 
        tvis.hParent      			= hPrev 
        hPrev            			= TreeView_InsertItem( htv, @tvis )

        '-- tv.additem -> tv.item(3) | tv.children=2 
        text            = "Gui" 
        tvis.item.pszText   		= strptr(text) 
        tvis.item.cchTextMax		= len(text) 
        tvis.hParent      			= hPrev 
        hPrev            			= TreeView_InsertItem( htv, @tvis )

        '-- tv.additem -> tv.item(4) | tv.children=0 
        text            			= "Assembler" 
        tvis.item.pszText   		= strptr(text) 
        tvis.item.cchTextMax		= len(text) 
        tvis.hParent      			= TVI_ROOT 
        hPrev            			= TreeView_InsertItem( htv, @tvis )

        '-- tv.additem -> tv.item(5) | tv.children=0 
        text            			= "Tutorials" 
        tvis.item.pszText   		= strptr(text) 
        tvis.item.cchTextMax		= len(text) 
        hPrev            			= TreeView_InsertItem( htv, @tvis )

        '-- tv.additem -> tv.item(6) | tv.children=0 
        text            			= "Object Oriented" 
        tvis.item.pszText   		= strptr(text) 
        tvis.item.cchTextMax		= len(text) 
        hPrev            			= TreeView_InsertItem( htv, @tvis )
      
	case WM_SIZE 
        GetClientRect( hWnd, @rc )
        if ( htv <> 0 ) then 
        	MoveWindow( htv, 0, 18, 160, rc.bottom - rc.top - 20, 1 ) 
        end if
      
	case WM_KEYDOWN 
		if( lobyte( wParam ) = 27 ) then 
          PostMessage( hWnd, WM_CLOSE, 0, 0 )
        end if 
      
	case WM_DESTROY 
        ImageList_Destroy( ilist ) 
        PostQuitMessage( 0 )
        exit function 
	end select 
    
  	function = DefWindowProc( hWnd, uMsg, wParam, lParam )    

end function 


	'' 
  	'' Main Program Exclusive Entry 
  	'' 
  	dim wMsg as MSG 
  	dim wcls as WNDCLASS      
  	dim hWnd as HWND
        
  	dim appName as string 
  	appName = "WinTreeView" 
    
    with wcls 
		.style         = CS_HREDRAW or CS_VREDRAW 
        .lpfnWndProc   = @WndProc 
        .cbClsExtra    = 0 
        .cbWndExtra    = 0 
        .hInstance     = hInstance 
        .hIcon         = LoadIcon( null, IDI_APPLICATION ) 
        .hCursor       = LoadCursor( null, IDC_ARROW ) 
        .hbrBackground = cast( HGDIOBJ, 16 ) ' btnface color 
        .lpszMenuName  = null 
        .lpszClassName = strptr( appName ) 
    end with 
      
	if ( RegisterClass( @wcls ) = false ) then 
		MessageBox( null, "Failed to register wcls!",  appName, MB_ICONERROR )
		end 1 
	end if 
    
    hWnd = CreateWindowEx( 0, appName, "Treeview Demo", _ 
                 		   WS_OVERLAPPEDWINDOW or WS_VISIBLE, _ 
                 		   100, 100, 420, 240, _ 
                 		   null, null, hInstance, null ) 
                          
	'' 
    '' messages loop 
    '' 
	do until( GetMessage( @wMsg, null, 0, 0 ) = FALSE ) 
		TranslateMessage( @wMsg )
        DispatchMessage( @wMsg )
	loop 
        
    end
