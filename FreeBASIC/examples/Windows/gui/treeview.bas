'-------------------------------------------------------------- 
'        TreeViewEx and ImageList Demo for FreeBasic. 
'                    by zydon@mesra.net 
'-------------------------------------------------------------- 

option explicit 
option private 

'$include once:'win\kernel32.bi' 
'$include once:'win\user32.bi' 
'$include once:'win\commctrl32.bi' 
'$include once:'win\shellapi.bi'

	dim shared hInstance as long 
	dim shared rc as RECT 
	dim shared htv as long 
	dim shared si1 as integer 
	dim shared six as integer 
	dim shared siy  as integer 
	dim shared iclr as integer 
	dim shared iccx as INITCOMMONCONTROLSEX 

    hInstance = GetModuleHandle( null ) 
    six  = GetSystemMetrics(SM_CXSMICON) 
    siy  = GetSystemMetrics(SM_CYSMICON) 
    iclr = ILC_COLOR8 or ILC_MASK 
    si1  = ImageList_Create(six,siy,iclr,1,1) 
    
    iccx.dwSize = len(INITCOMMONCONTROLSEX) 
    iccx.dwICC  = ICC_TREEVIEW_CLASSES or ICC_WIN95_CLASSES 

    InitCommonControlsEx(iccx) 


'' 
'' Window Procedure Handler 
'' 
function WndProc (byval hwnd as long, byval uMsg as long, byval wParam as long, byval lParam as long)  as integer 

	WndProc = 0 

  	select case ( uMsg ) 
	case WM_CREATE 

       	dim tvis as TVINSERTSTRUCT 

        dim i     as long,_ 
            hico  as long,_ 
            hPrev as long,_ 
            tlib  as long 

        dim ico$, text$ 


        GetClientRect hWnd, rc 

        htv = CreateWindowEx( WS_EX_CLIENTEDGE,WC_TREEVIEW, "",_ 
                              WS_CHILD or WS_VISIBLE or TVS_HASLINES _ 
                  			  or TVS_LINESATROOT or TVS_HASBUTTONS,_ 
                  			  0,18,160,rc.nbottom-20,_ 
                  			  hWnd,0,hInstance,0) 

        SendMessage(htv,TVM_SETBKCOLOR,0,&hfff0e1) 

        for i=3 to 5 
            ico$ = STR$(i) 
            hico = ExtractIcon(0,"Shell32.DLL",i) 
            ImageList_ReplaceIcon(si1,-1,hico) 
            DestroyIcon(hico) 
        next i 

        SendMessage(htv,TVM_SETIMAGELIST,TVSIL_NORMAL,byval si1) 
  
        clear tvis, 0, len(tvis)
        tvis.Item.Mask = TVIF_TEXT or TVIF_IMAGE or TVIF_SELECTEDIMAGE 

        '-- Root: tv.additem -> tv.item(0) 
        text$                   = "FreeBasic" 
        tvis.Item.Text          = strptr(text$) 
        tvis.Item.textmax       = len(text$) 
        tvis.Item.Image         = 0 
        tvis.Item.SelectedImage = 1 
        tvis.InsertAfter        = 0 
        tvis.parent             = TVI_ROOT 
        hPrev                   = SendMessage(htv,TVM_INSERTITEM,0,tvis) 

          '-- tv.additem -> tv.item(1) | tv.children=0 
          text$            = "Inc" 
          tvis.Item.Text   = strptr(text$) 
          tvis.Item.textmax= len(text$) 
          tvis.parent      = hPrev 
          hPrev            = SendMessage(htv,TVM_INSERTITEM,0,tvis) 

            '-- tv.additem -> tv.item(2) | tv.children=1 
            text$            = "Win" 
            tvis.Item.Text   = strptr(text$) 
            tvis.Item.textmax= len(text$) 
            tvis.parent      = hPrev 
            hPrev            = SendMessage(htv,TVM_INSERTITEM,0,tvis) 

              '-- tv.additem -> tv.item(3) | tv.children=2 
              text$            = "Gui" 
              tvis.Item.Text   = strptr(text$) 
              tvis.Item.textmax= len(text$) 
              tvis.parent      = hPrev 
              hPrev            = SendMessage(htv,TVM_INSERTITEM,0,tvis) 

        '-- tv.additem -> tv.item(4) | tv.children=0 
        text$            = "Assembler" 
        tvis.Item.Text   = strptr(text$) 
        tvis.Item.textmax= len(text$) 
        tvis.parent      = TVI_ROOT 
        hPrev            = SendMessage(htv,TVM_INSERTITEM,0,tvis) 

        '-- tv.additem -> tv.item(5) | tv.children=0 
        text$            = "Tutorials" 
        tvis.Item.Text   = strptr(text$) 
        tvis.Item.textmax= len(text$) 
        hPrev            = SendMessage(htv,TVM_INSERTITEM,0,tvis) 

        '-- tv.additem -> tv.item(6) | tv.children=0 
        text$            = "Object Oriented" 
        tvis.Item.Text   = strptr(text$) 
        tvis.Item.textmax= len(text$) 
        hPrev            = SendMessage(htv,TVM_INSERTITEM,0,tvis) 
      
	case WM_SIZE 
        GetClientRect hWnd, rc 
        if ( htv <> 0 ) then 
        	MoveWindow(htv,0,18,160,rc.nBottom-rc.nTop-20,1) 
        end if
      
	case WM_KEYDOWN 
		if( lobyte( wParam ) = 27 ) then 
          PostMessage hWnd, WM_CLOSE, 0, 0 
        end if 
      
	case WM_DESTROY 
        ImageList_Destroy(si1) 
        PostQuitMessage 0 
        exit function 
	end select 
    
  	WndProc = DefWindowProc( hWnd, uMsg, wParam, lParam )    

end function 


	'' 
  	'' Main Program Exclusive Entry 
  	'' 
  	dim wMsg as MSG 
  	dim wcls as WNDCLASS      
  	dim hWnd as unsigned long 
        
  	dim szAppName as string 
  	szAppName = "WinTreeView" 
    
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
    
    hWnd = CreateWindowEx( 0, szAppName, "Treeview Demo", _ 
                 		   WS_OVERLAPPEDWINDOW or WS_VISIBLE, _ 
                 		   100, 100, 420, 240, _ 
                 		   null, null, hInstance, null ) 
                          
	'' 
    '' messages loop 
    '' 
	do until( GetMessage( wMsg, null, 0, 0 ) = FALSE ) 
		TranslateMessage wMsg 
        DispatchMessage  wMsg 
	loop 
        
    end
