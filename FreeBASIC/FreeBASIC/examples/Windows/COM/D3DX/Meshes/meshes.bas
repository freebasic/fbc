

''-----------------------------------------------------------------------------
'' File: Meshes.cpp
''
'' Desc: For advanced geometry, most apps will prefer to load pre-authored
''       meshes from a file. Fortunately, when using meshes, D3DX does most of
''       the work for this, parsing a geometry file and creating vertx buffers
''       (and index buffers) for us. This tutorial shows how to use a D3DXMESH
''       object, including loading it from a file and rendering it. One thing
''       D3DX does not handle for us is the materials and textures for a mesh,
''       so note that we have to handle those manually.
''
''       Note: one advanced (but nice) feature that we don't show here is that
''       when cloning a mesh we can specify the FVF. So, regardless of how the
''       mesh was authored, we can add/remove normals, add more texture
''       coordinate sets (for multi-texturing), etc.
''
'' Copyright (c) 2000-2001 Microsoft Corporation. All rights reserved.
''-----------------------------------------------------------------------------

#include once "win/d3dx9.bi"
#include once "win/mmsystem.bi"

''-----------------------------------------------------------------------------
'' Global variables
''-----------------------------------------------------------------------------
dim shared as LPDIRECT3D9           g_pD3D           = NULL '' Used to create the D3DDevice
dim shared as LPDIRECT3DDEVICE9     g_pd3dDevice     = NULL '' Our rendering device

dim shared as LPD3DXMESH            g_pMesh          = NULL '' Our mesh object in sysmem
dim shared as D3DMATERIAL9			g_pMeshMaterials() 		'' Materials for our mesh
dim shared as LPDIRECT3DTEXTURE9	g_pMeshTextures() 		'' Textures for our mesh
dim shared as DWORD                 g_dwNumMaterials = 0    '' Number of mesh materials

''-----------------------------------------------------------------------------
'' Name: InitD3D()
'' Desc: Initializes Direct3D
''-----------------------------------------------------------------------------
function InitD3D( byval hWnd as HWND ) as HRESULT 
    
    '' Create the D3D object.
    g_pD3D = Direct3DCreate9( D3D_SDK_VERSION )
    if( g_pD3D = NULL ) then
        return E_FAIL
    end if

    '' Get the current desktop display mode, so we can set up a back
    '' buffer of the same format
    dim as D3DDISPLAYMODE d3ddm
    if( FAILED( IDirect3D9_GetAdapterDisplayMode( g_pD3D, D3DADAPTER_DEFAULT, @d3ddm ) ) ) then
        return E_FAIL
    end if

    '' Set up the structure used to create the D3DDevice. Since we are now
    '' using more complex geometry, we will create a device with a zbuffer.
    dim as D3DPRESENT_PARAMETERS d3dpp 
    with d3dpp
    	.Windowed = TRUE
    	.SwapEffect = D3DSWAPEFFECT_DISCARD
    	.BackBufferFormat = d3ddm.Format
    	.EnableAutoDepthStencil = TRUE
    	.AutoDepthStencilFormat = D3DFMT_D16
    end with

    '' Create the D3DDevice
    if( FAILED( IDirect3D9_CreateDevice( g_pD3D, D3DADAPTER_DEFAULT, D3DDEVTYPE_HAL, hWnd, _
                                      		  D3DCREATE_SOFTWARE_VERTEXPROCESSING, _
                                      		  @d3dpp, @g_pd3dDevice ) ) ) then
        return E_FAIL
    end if

    '' Turn on the zbuffer
    IDirect3DDevice9_SetRenderState( g_pd3dDevice, D3DRS_ZENABLE, TRUE )

    '' Turn on ambient lighting 
    IDirect3DDevice9_SetRenderState( g_pd3dDevice, D3DRS_AMBIENT, &hffffffff )

    return S_OK
    
end function

''-----------------------------------------------------------------------------
'' Name: InitGeometry()
'' Desc: Load the mesh and build the material and texture arrays
''-----------------------------------------------------------------------------
function InitGeometry() as HRESULT 
    dim as LPD3DXBUFFER pD3DXMtrlBuffer

    '' Load the mesh from the specified file
    if( FAILED( D3DXLoadMeshFromX( "tiger.x", D3DXMESH_SYSTEMMEM, _
                                   g_pd3dDevice, NULL, _
                                   @pD3DXMtrlBuffer, NULL, @g_dwNumMaterials, _
                                   @g_pMesh ) ) ) then
        return E_FAIL
    end if

    '' We need to extract the material properties and texture names from the 
    '' pD3DXMtrlBuffer
    dim as D3DXMATERIAL ptr d3dxMaterials
    d3dxMaterials = cast( D3DXMATERIAL ptr, pD3DXMtrlBuffer->lpVtbl->GetBufferPointer( pD3DXMtrlBuffer ) )
    
    redim g_pMeshMaterials(0 to g_dwNumMaterials-1)
    redim g_pMeshTextures(0 to g_dwNumMaterials-1)

    dim as DWORD i
    for i = 0 to g_dwNumMaterials-1
        '' Copy the material
        g_pMeshMaterials(i) = d3dxMaterials[i].MatD3D

        '' Set the ambient color for the material (D3DX does not do this)
        g_pMeshMaterials(i).Ambient = g_pMeshMaterials(i).Diffuse
     
        '' Create the texture
        if( FAILED( D3DXCreateTextureFromFile( g_pd3dDevice, _
                                               d3dxMaterials[i].pTextureFilename, _
                                               @g_pMeshTextures(i) ) ) ) then
            g_pMeshTextures(i) = NULL
        end if
    next

    '' Done with the material buffer
    pD3DXMtrlBuffer->lpVtbl->Release( pD3DXMtrlBuffer )

    return S_OK
    
end function

''-----------------------------------------------------------------------------
'' Name: Cleanup()
'' Desc: Releases all previously initialized objects
''-----------------------------------------------------------------------------
sub Cleanup()
    
    erase g_pMeshMaterials

    if( g_dwNumMaterials > 0 ) then
        dim as DWORD i
        for i = 0 to g_dwNumMaterials-1
            if( g_pMeshTextures(i) ) then
                g_pMeshTextures(i)->lpVtbl->Release( g_pMeshTextures(i) )
            end if
        next
        
        erase g_pMeshTextures
    end if
    
    if( g_pMesh <> NULL ) then
        g_pMesh->lpVtbl->Release( g_pMesh )
    end if
    
    if( g_pd3dDevice <> NULL ) then
        IDirect3DDevice9_Release( g_pd3dDevice )
    end if

    if( g_pD3D <> NULL ) then
        IDirect3D9_Release( g_pD3D )
    end if

end sub

''-----------------------------------------------------------------------------
'' Name: SetupMatrices()
'' Desc: Sets up the world, view, and projection transform matrices.
''-----------------------------------------------------------------------------
sub SetupMatrices()
    
    '' For our world matrix, we will just leave it as the identity
    dim as D3DXMATRIX matWorld
    D3DXMatrixRotationY( @matWorld, timeGetTime() / 1000.0 )
    IDirect3DDevice9_SetTransform( g_pd3dDevice, D3DTS_WORLD, @matWorld )

    '' Set up our view matrix. A view matrix can be defined given an eye point,
    '' a point to lookat, and a direction for which way is up. Here, we set the
    '' eye five units back along the z-axis and up three units, look at the 
    '' origin, and define "up" to be in the y-direction.
    dim as D3DXMATRIX matView
    D3DXMatrixLookAtLH( @matView, @type<D3DVECTOR>( 0.0, 2.0,-2.0 ), _ 
                                  @type<D3DVECTOR>( 0.0, 0.0, 0.0 ), _
                                  @type<D3DVECTOR>( 0.0, 1.0, 0.0 ) )
    IDirect3DDevice9_SetTransform( g_pd3dDevice, D3DTS_VIEW, @matView )

    '' For the projection matrix, we set up a perspective transform (which
    '' transforms geometry from 3D view space to 2D viewport space, with
    '' a perspective divide making objects smaller in the distance). To build
    '' a perpsective transform, we need the field of view (1/4 pi is common),
    '' the aspect ratio, and the near and far clipping planes (which define at
    '' what distances geometry should be no longer be rendered).
    dim as D3DXMATRIX matProj
    D3DXMatrixPerspectiveFovLH( @matProj, D3DX_PI/4, 1.0, 1.0, 100.0 )
    IDirect3DDevice9_SetTransform( g_pd3dDevice, D3DTS_PROJECTION, @matProj )
    
end sub

''-----------------------------------------------------------------------------
'' Name: Render()
'' Desc: Draws the scene
''-----------------------------------------------------------------------------
sub Render()

    '' Clear the backbuffer and the zbuffer
    IDirect3DDevice9_Clear( g_pd3dDevice, 0, NULL, D3DCLEAR_TARGET or D3DCLEAR_ZBUFFER, _
                         	D3DCOLOR_XRGB( 0, 0, 255 ), 1.0, 0 )
    
    '' Begin the scene
    IDirect3DDevice9_BeginScene( g_pd3dDevice )

    '' Setup the world, view, and projection matrices
    SetupMatrices()

    '' Meshes are divided into subsets, one for each material. Render them in
    '' a loop
    dim as DWORD i
    for i = 0 to g_dwNumMaterials-1
        '' Set the material and texture for this subset
        IDirect3DDevice9_SetMaterial( g_pd3dDevice, @g_pMeshMaterials(i) )
        IDirect3DDevice9_SetTexture( g_pd3dDevice, 0, cast( PVOID, g_pMeshTextures(i) ) )
        
        '' Draw the mesh subset
        g_pMesh->lpVtbl->DrawSubset( g_pMesh, i )
    next

    '' End the scene
    IDirect3DDevice9_EndScene( g_pd3dDevice )
    
    '' Present the backbuffer contents to the display
    IDirect3DDevice9_Present( g_pd3dDevice, NULL, NULL, NULL, NULL )

end sub

''-----------------------------------------------------------------------------
'' Name: MsgProc()
'' Desc: The window's message handler
''-----------------------------------------------------------------------------
function MsgProc( byval hWnd as HWND, byval msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM ) as LRESULT

    select case msg
	case WM_DESTROY
    	PostQuitMessage( 0 )
        return 0
    end select

    return DefWindowProc( hWnd, msg, wParam, lParam )
    
end function

''-----------------------------------------------------------------------------
'' Name: WinMain()
'' Desc: The application's entry point
''-----------------------------------------------------------------------------

    '' Register the window class
    dim as WNDCLASSEX wc = ( len(WNDCLASSEX), CS_CLASSDC, @MsgProc, 0, 0,  _
                      		 GetModuleHandle(NULL), NULL, NULL, NULL, NULL, _
                      		 @"D3D Tutorial", NULL )
    RegisterClassEx( @wc )

    '' Create the application's window
    dim as HWND hWnd = CreateWindow( "D3D Tutorial", "D3D Tutorial 06: Meshes", _
                              		 WS_OVERLAPPEDWINDOW, 100, 100, 300, 300, _
                              		 GetDesktopWindow(), NULL, wc.hInstance, NULL )

    '' Initialize Direct3D
    if( SUCCEEDED( InitD3D( hWnd ) ) ) then

        '' Create the scene geometry
        if( SUCCEEDED( InitGeometry() ) ) then

            '' Show the window
            ShowWindow( hWnd, SW_SHOWDEFAULT )
            UpdateWindow( hWnd )

            '' Enter the message loop
            dim as MSG msg 

            do while( msg.message <> WM_QUIT )

                if( PeekMessage( @msg, NULL, 0, 0, PM_REMOVE ) ) then
                    TranslateMessage( @msg )
                    DispatchMessage( @msg )
                else
                    Render()
                end if
            loop
        end if
    end if

    '' Clean up everything and exit the app
    Cleanup()
    UnregisterClass( "D3D Tutorial", wc.hInstance )
	end 0

