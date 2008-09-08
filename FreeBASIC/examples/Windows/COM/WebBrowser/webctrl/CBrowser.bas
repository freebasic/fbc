''
'' CBrowser - the browser "class"
''

#include once "Common.bi"
#include once "CBrowser.bi"

type CBrowserCtx
	as CClientSite ptr	client
	as HWND 			hwnd
	as integer			ismozilla
	as IOleObject ptr	browserclass
	as IWebBrowser2 ptr browser
end type

''::::
constructor CBrowser _
	( _
		byval hwnd as HWND, _
		byval ismozilla as integer _
	) 

	ctx = new CBrowserCtx
	
	ctx->client = CClientSite_New( NULL, hwnd )
	ctx->hwnd = hwnd
	ctx->ismozilla = ismozilla
	ctx->browserclass = NULL
	ctx->browser = NULL
	
end constructor

''::::
destructor CBrowser _
	( _
		_
	)

	remove( )
	
	CClientSite_Delete( ctx->client, FALSE )
	
	delete ctx

end destructor

''::::
function CBrowser.insert _
	( _
		_
	) as BOOL

	static as CLSID CLSID_MozillaBrowser = _
		( _
			&h1339B54C, &h3453, &h11D2, { &h93, &hB9, &h00, &h00, &h00, &h00, &h00, &h00 } _
		)

	dim as LPCLASSFACTORY classFactory = NULL
	dim as RECT rect
	
	function = FALSE
	
	if( CoGetClassObject( iif( ctx->ismozilla, @CLSID_MozillaBrowser, @CLSID_WebBrowser ), _
						  CLSCTX_INPROC_SERVER or CLSCTX_INPROC_HANDLER, _
						  NULL, _
						  @IID_IClassFactory, _
						  cast( PVOID ptr, @classFactory ) ) <> S_OK ) then
	
		exit function
	end if

	if( classFactory->lpVtbl->CreateInstance( classFactory, _
											  0, _
											  @IID_IOleObject, _
											  cast( PVOID ptr, @ctx->browserclass ) ) <> S_OK ) then
		
		ctx->browserclass = NULL		
	end if
		
	classFactory->lpVtbl->Release( classFactory )
	
	if( ctx->browserclass = NULL ) then
		exit function
	end if
	
	if( CClientSite_SetObject( ctx->client, ctx->browserclass ) = FALSE ) then
		remove( )
		exit function
	end if
	
	ctx->browserclass->lpVtbl->SetHostNames( ctx->browserclass, "fb_webctrl", NULL )

	GetClientRect( ctx->hwnd, @rect )
		
	if( ctx->browserclass->lpVtbl->DoVerb( ctx->browserclass, _
											 OLEIVERB_INPLACEACTIVATE, _
											 NULL, _
											 @ctx->client->interface, _
											 0, _
											 ctx->hwnd, _
											 @rect ) <> S_OK ) then
		exit function
	end if
	
	if( ctx->browserclass->lpVtbl->QueryInterface( ctx->browserclass, _
												  	 @IID_IWebBrowser2, _
													 cast( PVOID ptr, @ctx->browser ) ) <> S_OK ) then
		exit function
	end if
			
	if( ctx->ismozilla = FALSE ) then
		ctx->browser->lpVtbl->put_Left( ctx->browser, rect.left )
		ctx->browser->lpVtbl->put_Top( ctx->browser, rect.top )
		ctx->browser->lpVtbl->put_Width( ctx->browser, rect.right )
		ctx->browser->lpVtbl->put_Height( ctx->browser, rect.bottom )
	end if
		
	function = TRUE

end function

''::::
function CBrowser.remove _
	( _
		_
	) as BOOL

	function = FALSE
	
	if( ctx->browserclass = NULL ) then
		return TRUE
	end if

	if( ctx->browser <> NULL ) then
		ctx->browser->lpVtbl->Release( ctx->browser )
		ctx->browser = NULL
	end if

	ctx->browserclass->lpVtbl->Close( ctx->browserclass, OLECLOSE_NOSAVE )
	ctx->browserclass->lpVtbl->Release( ctx->browserclass )
	
	ctx->browserclass = NULL
	
	function = TRUE

end function

#define HIMETRIC_PER_INCH 2540
#define MAP_PIX_TO_LOGHIM( x, ppli) ( (HIMETRIC_PER_INCH * (x) + ((ppli) shr 1)) \ (ppli) )

''::::
private sub hPixelToMetric _
	( _
		byval src as SIZEL ptr, _
		byval dst as SIZEL ptr _
	)

	dim as integer x, y

	dim as HDC hDCScreen = GetDC( NULL )
	x = GetDeviceCaps( hDCScreen, LOGPIXELSX )
	y = GetDeviceCaps( hDCScreen, LOGPIXELSY )
	ReleaseDC( NULL, hDCScreen )

	dst->cx = MAP_PIX_TO_LOGHIM( src->cx, x )
	dst->cy = MAP_PIX_TO_LOGHIM( src->cy, y )
	
end sub

''::::
function CBrowser.resize _
	( _
		byval width_ as DWORD, _
		byval height as DWORD _
	) as BOOL

	function = FALSE

	if( ctx->browserclass = NULL ) then
		exit function
	end if
	
	dim as SIZEL pxSize, hmSize = ( width_, height )
	hPixelToMetric( @pxSize, @hmSize )
	ctx->browserclass->lpVtbl->SetExtent( ctx->browserclass, _
											DVASPECT_CONTENT, _
											@hmSize )
	
	dim as RECT rect = (0, 0, width_, height )
	ctx->client->site.inplaceobj->lpVtbl->SetObjectRects( ctx->client->site.inplaceobj, _
															@rect, _
															@rect )

	if( ctx->ismozilla = FALSE ) then
		ctx->browser->lpVtbl->put_Width( ctx->browser, width_ )
		ctx->browser->lpVtbl->put_Height( ctx->browser, height )
	end if
	
	function = TRUE

end function

''::::
function CBrowser.setFocus _
	( _
		_
	) as BOOL

	dim as RECT rect

	function = FALSE
	
	if( ctx->browserclass = NULL ) then
		exit function
	end if

	GetClientRect( ctx->hwnd, @rect )
	
	ctx->browserclass->lpVtbl->DoVerb( ctx->browserclass, _
										 OLEIVERB_UIACTIVATE, _
										 NULL, _
										 @ctx->client->interface, _
										 0, _
										 ctx->hwnd, _
										 @rect )

	function = TRUE

end function

''::::
function CBrowser.navigate _
	( _
		byval url as wstring ptr, _
		byval target as wstring ptr _
	) as BOOL

	dim as VARIANT vURL, vTarget

	function = FALSE
	
	if( ctx->browserclass = NULL ) then
		exit function
	end if
	
	if( url <> NULL ) then
		VariantInit( @vURL )
		vURL.vt = VT_BSTR
		vURL.bstrVal = SysAllocString( url )
	end if
	
	if( target <> NULL ) then
		VariantInit( @vTarget )
		vTarget.vt = VT_BSTR
		vTarget.bstrVal = SysAllocString( target )
	end if
	
	if( vURL.bstrVal <> NULL ) then
		function = (ctx->browser->lpVtbl->Navigate2( ctx->browser, _
												 	   iif( url <> NULL, @vURL, NULL ), _
												 	   NULL, _
												 	   iif( target <> NULL, @vTarget, NULL ), _
												 	   NULL, _
												 	   NULL ) = S_OK )
	end if

	if( target <> NULL ) then
		VariantClear( @vTarget )
	end if
	if( url <> NULL ) then
		VariantClear( @vURL )
	end if

end function

''::::
function CBrowser.render _
	( _
		byval text as wstring ptr _
	) as BOOL

	dim as IDispatch ptr doc
	dim as IHTMLDocument2 ptr htmldoc2
	dim as BOOL res

	function = FALSE
	
	if( ctx->browserclass = NULL ) then
		exit function
	end if
	
	res = TRUE

	if( ctx->browser->lpVtbl->get_Document( ctx->browser, @doc ) <> S_OK ) then
		return FALSE
	end if
		
	if( doc = NULL ) then
		navigate( "about:blank", NULL )
			
		if( ctx->browser->lpVtbl->get_Document( ctx->browser, @doc ) <> S_OK ) then
			return FALSE
		end if
	end if

	if( doc <> NULL ) then
		if( doc->lpVtbl->QueryInterface( doc, _
										 @IID_IHTMLDocument2, _
										 cast( PVOID ptr, @htmldoc2 ) ) = S_OK ) then
		
			dim as SAFEARRAY ptr arraydesc
			dim as VARIANT ptr arraydata

			arraydesc = SafeArrayCreate( VT_VARIANT, 1, @type<SAFEARRAYBOUND>(1, 0) )
			if( arraydesc <> NULL ) then

				if( SafeArrayAccessData( arraydesc, cast( PVOID ptr, @arraydata ) ) = S_OK ) then
					arraydata[0].vt = VT_BSTR
					arraydata[0].bstrVal = SysAllocString( text )
					
					htmlDoc2->lpVtbl->write( htmlDoc2, arraydesc )
					htmlDoc2->lpVtbl->close( htmlDoc2 )
				
					SafeArrayUnaccessData( arraydesc )
				
				else
					res = FALSE
				end if
			
				SafeArrayDestroy( arraydesc )

			else
				res = FALSE
			end if
			
			htmldoc2->lpVtbl->Release( htmldoc2 )
		
		else
			res = FALSE
		end if
		
		doc->lpVtbl->Release( doc )
	
	else
		res = FALSE
	end if
	
	function = res
	
end function

''::::
function CBrowser.goBack _
	( _
		_
	) as BOOL

	function = FALSE
	
	if( ctx->browserclass = NULL ) then
		exit function
	end if
	
	function = ctx->browser->lpVtbl->GoBack( ctx->browser ) = S_OK
	
end function

''::::
function CBrowser.goForward _
	( _
		_
	) as BOOL

	function = FALSE
	
	if( ctx->browserclass = NULL ) then
		exit function
	end if
	
	function = ctx->browser->lpVtbl->GoForward( ctx->browser ) = S_OK
	
end function

''::::
function CBrowser.refresh _
	( _
		_
	) as BOOL

	function = FALSE
	
	if( ctx->browserclass = NULL ) then
		exit function
	end if
	
	function = ctx->browser->lpVtbl->Refresh( ctx->browser ) = S_OK
	
end function

''::::
function CBrowser.stop _
	( _
		_
	) as BOOL

	function = FALSE
	
	if( ctx->browserclass = NULL ) then
		exit function
	end if
	
	function = ctx->browser->lpVtbl->Stop( ctx->browser ) = S_OK
	
end function
