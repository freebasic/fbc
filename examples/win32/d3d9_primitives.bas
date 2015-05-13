''------------------------------------------------------------------------------
''           Name: dx9_primitive_types.cpp
''         Author: Kevin Harris
''  Last Modified: 06/06/05
''    Description: This sample demonstrates how to properly use all the 
''                 primitive types available under Direct3D.
''
''                 The primitive types are:
''
''                 D3DPT_POINTLIST
''                 D3DPT_LINELIST
''                 D3DPT_LINESTRIP
''                 D3DPT_TRIANGLELIST
''                 D3DPT_TRIANGLESTRIP
''                 D3DPT_TRIANGLEFAN
''
''   Control Keys: F1 - Switch the primitive type to be rendered.
''                 F2 - Toggle wire-frame mode.
''------------------------------------------------------------------------------


#include once "windows.bi"
#include once "win/mmsystem.bi"
#include once "win/d3d9.bi"
#include once "win/d3dx9.bi"
#include once "crt.bi"

''-----------------------------------------------------------------------------
'' GLOBALS
''-----------------------------------------------------------------------------
dim shared as HWND              g_hWnd       = NULL
dim shared as LPDIRECT3D9       g_pD3D       = NULL
dim shared as LPDIRECT3DDEVICE9 g_pd3dDevice = NULL

dim shared as LPDIRECT3DVERTEXBUFFER9 g_pPointList_VB     = NULL
dim shared as LPDIRECT3DVERTEXBUFFER9 g_pLineStrip_VB     = NULL
dim shared as LPDIRECT3DVERTEXBUFFER9 g_pLineList_VB      = NULL
dim shared as LPDIRECT3DVERTEXBUFFER9 g_pTriangleList_VB  = NULL
dim shared as LPDIRECT3DVERTEXBUFFER9 g_pTriangleStrip_VB = NULL
dim shared as LPDIRECT3DVERTEXBUFFER9 g_pTriangleFan_VB   = NULL

#define D3DFVF_MY_VERTEX ( D3DFVF_XYZ or D3DFVF_DIFFUSE )

type Vertex
	as single x, y, z '' Position of vertex in 3D space
    as DWORD color    '' Color of vertex
end type

dim shared as integer g_bRenderInWireFrame = false
dim shared as D3DPRIMITIVETYPE g_currentPrimitive = D3DPT_TRIANGLEFAN

''
'' We'll store the vertex data in simple arrays until we're ready to load 
'' them into actual Direct3D Vertex Buffers. Seeing the vertices laid out 
'' like this should make it easier to understand how vertices need to be 
'' passed to be considered valid for each primitive type.
''

dim shared as Vertex g_pointList(0 to 5-1) => _
{_
    ( 0.0f, 0.0f, 0.0f,  D3DCOLOR_COLORVALUE( 1.0, 0.0, 0.0, 1.0 ) ),_
    ( 0.5f, 0.0f, 0.0f,  D3DCOLOR_COLORVALUE( 0.0, 1.0, 0.0, 1.0 ) ),_
    (-0.5f, 0.0f, 0.0f,  D3DCOLOR_COLORVALUE( 0.0, 0.0, 1.0, 1.0 ) ),_
	( 0.0f,-0.5f, 0.0f,  D3DCOLOR_COLORVALUE( 1.0, 1.0, 0.0, 1.0 ) ),_
    ( 0.0f, 0.5f, 0.0f,  D3DCOLOR_COLORVALUE( 0.0, 1.0, 1.0, 1.0 ) )_
}

dim shared as Vertex g_lineList(0 to 6-1) => _
{_
    (-1.0f,  0.0f, 0.0f, D3DCOLOR_COLORVALUE( 1.0, 0.0, 0.0, 1.0 ) ),_ '' Line #1
    ( 0.0f,  1.0f, 0.0f, D3DCOLOR_COLORVALUE( 1.0, 0.0, 0.0, 1.0 ) ),_
    ( 0.5f,  1.0f, 0.0f, D3DCOLOR_COLORVALUE( 0.0, 1.0, 0.0, 1.0 ) ),_ '' Line #2
    ( 0.5f, -1.0f, 0.0f, D3DCOLOR_COLORVALUE( 0.0, 1.0, 0.0, 1.0 ) ),_
    ( 1.0f, -0.5f, 0.0f, D3DCOLOR_COLORVALUE( 0.0, 0.0, 1.0, 1.0 ) ),_ '' Line #3
    (-1.0f, -0.5f, 0.0f, D3DCOLOR_COLORVALUE( 0.0, 0.0, 1.0, 1.0 ) )_
}

dim shared as Vertex g_lineStrip(0 to 6-1) => _
{_
    ( 0.5f, 0.5f, 0.0f, D3DCOLOR_COLORVALUE( 1.0, 0.0, 0.0, 1.0 ) ),_
    ( 1.0f, 0.0f, 0.0f, D3DCOLOR_COLORVALUE( 0.0, 1.0, 0.0, 1.0 ) ),_
    ( 0.0f,-1.0f, 0.0f, D3DCOLOR_COLORVALUE( 0.0, 0.0, 1.0, 1.0 ) ),_
    (-1.0f, 0.0f, 0.0f, D3DCOLOR_COLORVALUE( 1.0, 1.0, 0.0, 1.0 ) ),_
    ( 0.0f, 0.0f, 0.0f, D3DCOLOR_COLORVALUE( 0.0, 1.0, 1.0, 1.0 ) ),_
    ( 0.0f, 1.0f, 0.0f, D3DCOLOR_COLORVALUE( 1.0, 0.0, 0.0, 1.0 ) )_
}

dim shared as Vertex g_triangleList(0 to 6-1) => _
{_
    (-1.0f, 0.0f, 0.0f,  D3DCOLOR_COLORVALUE( 1.0, 0.0, 0.0, 1.0 ) ),_ '' Triangle #1
    ( 0.0f, 1.0f, 0.0f,  D3DCOLOR_COLORVALUE( 0.0, 1.0, 0.0, 1.0 ) ),_
    ( 1.0f, 0.0f, 0.0f,  D3DCOLOR_COLORVALUE( 0.0, 0.0, 1.0, 1.0 ) ),_
    (-0.5f,-1.0f, 0.0f,  D3DCOLOR_COLORVALUE( 1.0, 1.0, 0.0, 1.0 ) ),_ '' Triangle #2
    ( 0.0f,-0.5f, 0.0f,  D3DCOLOR_COLORVALUE( 0.0, 1.0, 1.0, 1.0 ) ),_
    ( 0.5f,-1.0f, 0.0f,  D3DCOLOR_COLORVALUE( 1.0, 0.0, 0.0, 1.0 ) )_
}

dim shared as Vertex g_triangleStrip(0 to 8-1) => _ 
{_
    (-2.0f, 0.0f, 0.0f,  D3DCOLOR_COLORVALUE( 1.0, 0.0, 0.0, 1.0 ) ),_
    (-1.0f, 1.0f, 0.0f,  D3DCOLOR_COLORVALUE( 0.0, 1.0, 0.0, 1.0 ) ),_
    (-1.0f, 0.0f, 0.0f,  D3DCOLOR_COLORVALUE( 0.0, 0.0, 1.0, 1.0 ) ),_
    ( 0.0f, 1.0f, 0.0f,  D3DCOLOR_COLORVALUE( 1.0, 1.0, 0.0, 1.0 ) ),_
    ( 0.0f, 0.0f, 0.0f,  D3DCOLOR_COLORVALUE( 0.0, 1.0, 1.0, 1.0 ) ),_
    ( 1.0f, 1.0f, 0.0f,  D3DCOLOR_COLORVALUE( 1.0, 0.0, 1.0, 1.0 ) ),_
    ( 1.0f, 0.0f, 0.0f,  D3DCOLOR_COLORVALUE( 1.0, 0.0, 0.0, 1.0 ) ),_
	( 2.0f, 1.0f, 0.0f,  D3DCOLOR_COLORVALUE( 0.0, 1.0, 0.0, 1.0 ) )_
}

dim shared as Vertex g_triangleFan(0 to 6-1) => _
{_
    ( 0.0f,-1.0f, 0.0f,  D3DCOLOR_COLORVALUE( 1.0, 0.0, 0.0, 1.0 ) ),_
    (-1.0f, 0.0f, 0.0f,  D3DCOLOR_COLORVALUE( 0.0, 1.0, 0.0, 1.0 ) ),_
    (-0.5f, 0.5f, 0.0f,  D3DCOLOR_COLORVALUE( 0.0, 0.0, 1.0, 1.0 ) ),_
    ( 0.0f, 1.0f, 0.0f,  D3DCOLOR_COLORVALUE( 1.0, 1.0, 0.0, 1.0 ) ),_
    ( 0.5f, 0.5f, 0.0f,  D3DCOLOR_COLORVALUE( 0.0, 1.0, 1.0, 1.0 ) ),_
    ( 1.0f, 0.0f, 0.0f,  D3DCOLOR_COLORVALUE( 1.0, 0.0, 1.0, 1.0 ) )_
}

''-----------------------------------------------------------------------------
'' PROTOTYPES
''-----------------------------------------------------------------------------
declare function WindowProc( byval hWnd as HWND, byval msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM ) as LRESULT
declare sub init()
declare sub shutDown()
declare sub render()

''-----------------------------------------------------------------------------
'' Name: WinMain()
'' Desc: The application's entry point
''-----------------------------------------------------------------------------
function WinMain(byval hInstance as HINSTANCE, _
				 byval hPrevInstance as HINSTANCE, _
				 byval lpCmdLine as zstring ptr, _
				 byval nCmdShow as integer _
				) as integer

	dim as WNDCLASSEX winClass 
	dim as MSG        uMsg

	with winClass
		.lpszClassName = @"MY_WINDOWS_CLASS"
		.cbSize        = len(WNDCLASSEX)
		.style         = CS_HREDRAW or CS_VREDRAW
		.lpfnWndProc   = @WindowProc
		.hInstance     = hInstance
		.hIcon	       = LoadIcon(hInstance, cast(LPCTSTR,IDI_APPLICATION))
    	.hIconSm	   = LoadIcon(hInstance, cast(LPCTSTR,IDI_APPLICATION))
		.hCursor       = LoadCursor(NULL, IDC_ARROW)
		.hbrBackground = cast(HBRUSH,GetStockObject(BLACK_BRUSH))
		.lpszMenuName  = NULL
		.cbClsExtra    = 0
		.cbWndExtra    = 0
	end with

	if( RegisterClassEx( @winClass ) = FALSE ) then
		return E_FAIL
	end if

	g_hWnd = CreateWindowEx( NULL, "MY_WINDOWS_CLASS", _
                             "Direct3D (DX9) - Primitive Types", _
						     WS_OVERLAPPEDWINDOW or WS_VISIBLE, _
					         0, 0, 640, 480, NULL, NULL, hInstance, NULL )

	if( g_hWnd = NULL ) then
		return E_FAIL
	end if

    ShowWindow( g_hWnd, nCmdShow )
    UpdateWindow( g_hWnd )

	init()

	do while( uMsg.message <> WM_QUIT )
		if( PeekMessage( @uMsg, NULL, 0, 0, PM_REMOVE ) ) then
			TranslateMessage( @uMsg )
			DispatchMessage( @uMsg )
        else
		    render()
		    sleep 10
		end if
	loop

	shutDown()

    UnregisterClass( "MY_WINDOWS_CLASS", winClass.hInstance )

	return uMsg.wParam
end function

''-----------------------------------------------------------------------------
'' Name: WindowProc()
'' Desc: The window's message handler
''-----------------------------------------------------------------------------
function WindowProc( byval hWnd as HWND, _
					 byval msg as UINT, _
					 byval wParam as WPARAM, _
					 byval lParam as LPARAM _
				   ) as LRESULT

    select case ( msg )
        case WM_KEYDOWN
			select case( wParam )
				case VK_ESCAPE
					PostQuitMessage(0)

				case VK_F1
					if( g_currentPrimitive = D3DPT_POINTLIST ) then
						g_currentPrimitive = D3DPT_LINELIST
					elseif( g_currentPrimitive = D3DPT_LINELIST ) then
						g_currentPrimitive = D3DPT_LINESTRIP
					elseif( g_currentPrimitive = D3DPT_LINESTRIP ) then
						g_currentPrimitive = D3DPT_TRIANGLELIST
					elseif( g_currentPrimitive = D3DPT_TRIANGLELIST ) then
						g_currentPrimitive = D3DPT_TRIANGLESTRIP
					elseif( g_currentPrimitive = D3DPT_TRIANGLESTRIP ) then
						g_currentPrimitive = D3DPT_TRIANGLEFAN
					elseif( g_currentPrimitive = D3DPT_TRIANGLEFAN ) then
						g_currentPrimitive = D3DPT_POINTLIST
					end if

				case VK_F2
                    g_bRenderInWireFrame = not g_bRenderInWireFrame
                    if( g_bRenderInWireFrame ) then
                        IDirect3DDevice9_SetRenderState(g_pd3dDevice, D3DRS_FILLMODE, D3DFILL_WIREFRAME )
                    else
                        IDirect3DDevice9_SetRenderState(g_pd3dDevice, D3DRS_FILLMODE, D3DFILL_SOLID )
                    end if
			end select

		case WM_CLOSE
			PostQuitMessage(0)	
		
        case WM_DESTROY
            PostQuitMessage(0)

		case else
			return DefWindowProc( hWnd, msg, wParam, lParam )
	end select

	return 0
end function

''-----------------------------------------------------------------------------
'' Name: init()
'' Desc: Initializes Direct3D under DirectX 9.0
''-----------------------------------------------------------------------------
sub init( )
    g_pD3D = Direct3DCreate9( D3D_SDK_VERSION )

    dim as D3DDISPLAYMODE d3ddm

    IDirect3D9_GetAdapterDisplayMode( g_pD3D, D3DADAPTER_DEFAULT, @d3ddm )

    dim as D3DPRESENT_PARAMETERS d3dpp
    clear( d3dpp, 0, len(d3dpp) )

    d3dpp.Windowed               = TRUE
    d3dpp.SwapEffect             = D3DSWAPEFFECT_DISCARD
    d3dpp.BackBufferFormat       = d3ddm.Format
    d3dpp.EnableAutoDepthStencil = TRUE
    d3dpp.AutoDepthStencilFormat = D3DFMT_D16
    d3dpp.PresentationInterval   = D3DPRESENT_INTERVAL_IMMEDIATE

    IDirect3D9_CreateDevice( g_pD3D, D3DADAPTER_DEFAULT, D3DDEVTYPE_HAL, g_hWnd, _
                          	 D3DCREATE_SOFTWARE_VERTEXPROCESSING, _
                          	 @d3dpp, @g_pd3dDevice )

	IDirect3DDevice9_SetRenderState(g_pd3dDevice,D3DRS_LIGHTING, FALSE)
	IDirect3DDevice9_SetRenderState(g_pd3dDevice,D3DRS_CULLMODE, D3DCULL_NONE)

	dim as D3DXMATRIX mProjection
    D3DXMatrixPerspectiveFovLH( @mProjection, D3DXToRadian( 45.0f ), 1.0f, 1.0f, 100.0f )
    IDirect3DDevice9_SetTransform(g_pd3dDevice, D3DTS_PROJECTION, @mProjection )

	dim as Vertex ptr pVertices = NULL

	''
	'' Point List
	''

	IDirect3DDevice9_CreateVertexBuffer(g_pd3dDevice, 5*len(Vertex), 0, D3DFVF_MY_VERTEX, _
									    D3DPOOL_DEFAULT, @g_pPointList_VB,_
									    NULL )

	pVertices = NULL
	IDirect3DVertexBuffer9_Lock( g_pPointList_VB, 0, len(g_pointList)*5, cast( any ptr ptr, @pVertices ), 0 )
    memcpy( pVertices, @g_pointList(0), len(g_pointList)*5 )
    IDirect3DVertexBuffer9_Unlock(g_pPointList_VB)

	''
	'' Line List
	''

	IDirect3DDevice9_CreateVertexBuffer(g_pd3dDevice, 6*len(Vertex), 0, D3DFVF_MY_VERTEX,_
									    D3DPOOL_DEFAULT, @g_pLineList_VB,_
									    NULL )

	pVertices = NULL
	IDirect3DVertexBuffer9_Lock( g_pLineList_VB, 0, len(g_lineList)*6, cast( any ptr ptr, @pVertices ), 0 )
    memcpy( pVertices, @g_lineList(0), len(g_lineList)*6 )
    IDirect3DVertexBuffer9_Unlock(g_pLineList_VB)

	''
	'' Line Strip
	''

	IDirect3DDevice9_CreateVertexBuffer(g_pd3dDevice, 6*len(Vertex), 0, D3DFVF_MY_VERTEX,_
									    D3DPOOL_DEFAULT, @g_pLineStrip_VB,_
									    NULL )

	pVertices = NULL
	IDirect3DVertexBuffer9_Lock( g_pLineStrip_VB, 0, len(g_lineStrip)*6, cast( any ptr ptr, @pVertices ), 0 )
    memcpy( pVertices, @g_lineStrip(0), len(g_lineStrip)*6 )
    IDirect3DVertexBuffer9_Unlock(g_pLineStrip_VB)

	''
	'' Triangle List
	''

	IDirect3DDevice9_CreateVertexBuffer(g_pd3dDevice, 6*len(Vertex), 0, D3DFVF_MY_VERTEX,_
									    D3DPOOL_DEFAULT, @g_pTriangleList_VB,_
									    NULL )

	pVertices = NULL
	IDirect3DVertexBuffer9_Lock( g_pTriangleList_VB, 0, len(g_triangleList)*8, cast( any ptr ptr, @pVertices ), 0 )
    memcpy( pVertices, @g_triangleList(0), len(g_triangleList)*8 )
    IDirect3DVertexBuffer9_Unlock(g_pTriangleList_VB)

	''
	'' Triangle Strip
	''

	IDirect3DDevice9_CreateVertexBuffer(g_pd3dDevice, 8*len(Vertex), 0, D3DFVF_MY_VERTEX,_
									    D3DPOOL_DEFAULT, @g_pTriangleStrip_VB,_
									    NULL )

	pVertices = NULL
	IDirect3DVertexBuffer9_Lock( g_pTriangleStrip_VB, 0, len(g_triangleStrip)*6, cast( any ptr ptr, @pVertices ), 0 )
    memcpy( pVertices, @g_triangleStrip(0), len(g_triangleStrip)*6 )
    IDirect3DVertexBuffer9_Unlock(g_pTriangleStrip_VB)

	''
	'' Triangle Fan
	''

	IDirect3DDevice9_CreateVertexBuffer(g_pd3dDevice, 6*len(Vertex), 0, D3DFVF_MY_VERTEX,_
									    D3DPOOL_DEFAULT, @g_pTriangleFan_VB,_
									    NULL )

	pVertices = NULL
	IDirect3DVertexBuffer9_Lock( g_pTriangleFan_VB, 0, len(g_triangleFan)*6, cast( any ptr ptr, @pVertices ), 0 )
    memcpy( pVertices, @g_triangleFan(0), len(g_triangleFan)*6 )
    IDirect3DVertexBuffer9_Unlock(g_pTriangleFan_VB)
end sub

''-----------------------------------------------------------------------------
'' Name: shutDown()
'' Desc: Release all Direct3D resources.
''-----------------------------------------------------------------------------
sub shutDown( )
	if( g_pPointList_VB <> NULL ) then
        IDirect3DVertexBuffer9_Release(g_pPointList_VB) 
    end if

	if( g_pLineList_VB <> NULL ) then
        IDirect3DVertexBuffer9_Release(g_pLineList_VB) 
    end if

	if( g_pLineStrip_VB <> NULL ) then
        IDirect3DVertexBuffer9_Release(g_pLineStrip_VB) 
    end if

    if( g_pTriangleList_VB <> NULL ) then
        IDirect3DVertexBuffer9_Release(g_pTriangleList_VB) 
    end if

	if( g_pTriangleStrip_VB <> NULL ) then
        IDirect3DVertexBuffer9_Release(g_pTriangleStrip_VB) 
    end if

	if( g_pTriangleFan_VB <> NULL ) then
        IDirect3DVertexBuffer9_Release(g_pTriangleFan_VB) 
    end if

    if( g_pd3dDevice <> NULL ) then
        IDirect3DDevice9_Release(g_pd3dDevice)
    end if

    if( g_pD3D <> NULL ) then
        IDirect3D9_Release( g_pD3D )
    end if
end sub

''-----------------------------------------------------------------------------
'' Name: render()
'' Desc: Render or draw our scene to the monitor.
''-----------------------------------------------------------------------------
sub render( )
    IDirect3DDevice9_Clear( g_pd3dDevice, 0, NULL, D3DCLEAR_TARGET or D3DCLEAR_ZBUFFER, _
                            D3DCOLOR_COLORVALUE(0.0f,0.0f,0.0f,1.0f), 1.0f, 0 )

	static as single zAngle = 0, zPos = 5, zInc = .1
	dim as D3DXMATRIX mWorld

	''
	'' begin drawing
	''
	IDirect3DDevice9_BeginScene(g_pd3dDevice)
    
    ''
    '' rotate
    ''
    D3DXMatrixRotationZ( @mWorld, zAngle )
    IDirect3DDevice9_SetTransform( g_pd3dDevice, D3DTS_WORLD, @mWorld )
    zAngle += .01

	''
	'' move
	''
	D3DXMatrixTranslation( @mWorld, 0, 0.0f, zPos )
    IDirect3DDevice9_MultiplyTransform( g_pd3dDevice, D3DTS_WORLD, @mWorld )
    zPos += zInc
    if( zPos < 2.5 or zPos > 10 ) then
    	zInc = -zInc
    end if
    
	''
	'' draw vertex buffer
	''
	select case ( g_currentPrimitive )
		case D3DPT_POINTLIST
			IDirect3DDevice9_SetStreamSource(g_pd3dDevice, 0, g_pPointList_VB, 0, len(Vertex) )
			IDirect3DDevice9_SetFVF(g_pd3dDevice, D3DFVF_MY_VERTEX )
			IDirect3DDevice9_DrawPrimitive(g_pd3dDevice, D3DPT_POINTLIST, 0, 5 )

		case D3DPT_LINELIST
			IDirect3DDevice9_SetStreamSource(g_pd3dDevice, 0, g_pLineList_VB, 0, len(Vertex) )
			IDirect3DDevice9_SetFVF(g_pd3dDevice, D3DFVF_MY_VERTEX )
			IDirect3DDevice9_DrawPrimitive(g_pd3dDevice, D3DPT_LINELIST, 0, 3)

		case D3DPT_LINESTRIP
			IDirect3DDevice9_SetStreamSource(g_pd3dDevice, 0, g_pLineStrip_VB, 0, len(Vertex) )
			IDirect3DDevice9_SetFVF(g_pd3dDevice, D3DFVF_MY_VERTEX )
			IDirect3DDevice9_DrawPrimitive(g_pd3dDevice, D3DPT_LINESTRIP, 0, 5)

		case D3DPT_TRIANGLELIST
			IDirect3DDevice9_SetStreamSource(g_pd3dDevice, 0, g_pTriangleList_VB, 0, len(Vertex) )
			IDirect3DDevice9_SetFVF(g_pd3dDevice, D3DFVF_MY_VERTEX )
			IDirect3DDevice9_DrawPrimitive(g_pd3dDevice, D3DPT_TRIANGLELIST, 0, 2 )

		case D3DPT_TRIANGLESTRIP
			IDirect3DDevice9_SetStreamSource(g_pd3dDevice, 0, g_pTriangleStrip_VB, 0, len(Vertex) )
			IDirect3DDevice9_SetFVF(g_pd3dDevice, D3DFVF_MY_VERTEX )
			IDirect3DDevice9_DrawPrimitive(g_pd3dDevice, D3DPT_TRIANGLESTRIP, 0, 6 )

		case D3DPT_TRIANGLEFAN
			IDirect3DDevice9_SetStreamSource(g_pd3dDevice, 0, g_pTriangleFan_VB, 0, len(Vertex) )
			IDirect3DDevice9_SetFVF(g_pd3dDevice, D3DFVF_MY_VERTEX )
			IDirect3DDevice9_DrawPrimitive(g_pd3dDevice, D3DPT_TRIANGLEFAN, 0, 4 )

	end select

	''
	'' end drawing
	''
	IDirect3DDevice9_EndScene(g_pd3dDevice)
    IDirect3DDevice9_Present(g_pd3dDevice, NULL, NULL, NULL, NULL )
    
end sub

	''
	''
	''
	end WinMain( GetModuleHandle( null ), null, Command( ), SW_NORMAL )
