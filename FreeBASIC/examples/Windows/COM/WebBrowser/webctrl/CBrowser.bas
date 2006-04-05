''
'' CBrowser - the browser "class"
''

option explicit

#include once "Common.bi
#include once "CBrowser.bi"

type CBrowser_
	as CClientSite ptr	client
	as HWND 			hwnd
	as integer			ismozilla
	as IOleObject ptr	browserclass
	as IWebBrowser2 ptr browser
end type


'' constructor
function CBrowser_New _
	( _
		byval _this as CBrowser ptr, _
		byval hwnd as HWND, _
		byval ismozilla as integer _
	) as CBrowser ptr

	if( _this = NULL ) then
		_this = cast( CBrowser ptr, allocate( len( CBrowser ) ) )
		if( _this = NULL ) then
			return NULL
		end if
	end if

	_this->client = CClientSite_New( NULL, hwnd )
	_this->hwnd = hwnd
	_this->ismozilla = ismozilla
	_this->browserclass = NULL
	_this->browser = NULL
	
	function = _this

end function

'' destructor
sub CBrowser_Delete _
	( _
		byval _this as CBrowser ptr, _
		byval isstatic as integer _
	)

	CBrowser_Remove( _this )
	
	CClientSite_Delete( _this->client, FALSE )
	
	if( isstatic = FALSE ) then
		if( _this <> NULL ) then
			deallocate( _this )
		end if
	end if

end sub

''::::
function CBrowser_Insert _
	( _
		byval _this as CBrowser ptr _
	) as BOOL

	static as CLSID CLSID_MozillaBrowser = ( &h1339B54C, &h3453, &h11D2, { &h93, &hB9, &h00, &h00, &h00, &h00, &h00, &h00 } )

	dim as LPCLASSFACTORY classFactory = NULL
	dim as RECT rect
	
	function = FALSE
	
	if( CoGetClassObject( iif( _this->ismozilla, @CLSID_MozillaBrowser, @CLSID_WebBrowser ), _
						  CLSCTX_INPROC_SERVER or CLSCTX_INPROC_HANDLER, _
						  NULL, _
						  @IID_IClassFactory, _
						  cast( PVOID ptr, @classFactory ) ) <> S_OK ) then
	
		exit function
	end if

	if( classFactory->lpVtbl->CreateInstance( classFactory, _
											  0, _
											  @IID_IOleObject, _
											  cast( PVOID ptr, @_this->browserclass ) ) <> S_OK ) then
		
		_this->browserclass = NULL		
	end if
		
	classFactory->lpVtbl->Release( classFactory )
	
	if( _this->browserclass = NULL ) then
		exit function
	end if
	
	if( CClientSite_SetObject( _this->client, _this->browserclass ) = FALSE ) then
		CBrowser_Remove( _this )
		exit function
	end if
	
	_this->browserclass->lpVtbl->SetHostNames( _this->browserclass, "fb_webctrl", NULL )

	GetClientRect( _this->hwnd, @rect )
		
	if( _this->browserclass->lpVtbl->DoVerb( _this->browserclass, _
											 OLEIVERB_INPLACEACTIVATE, _
											 NULL, _
											 @_this->client->interface, _
											 0, _
											 _this->hwnd, _
											 @rect ) <> S_OK ) then
		exit function
	end if
	
	if( _this->browserclass->lpVtbl->QueryInterface( _this->browserclass, _
												  	 @IID_IWebBrowser2, _
													 cast( PVOID ptr, @_this->browser ) ) <> S_OK ) then
		exit function
	end if
			
	if( _this->ismozilla = FALSE ) then
		_this->browser->lpVtbl->put_Left( _this->browser, rect.left )
		_this->browser->lpVtbl->put_Top( _this->browser, rect.top )
		_this->browser->lpVtbl->put_Width( _this->browser, rect.right )
		_this->browser->lpVtbl->put_Height( _this->browser, rect.bottom )
	end if
		
	function = TRUE

end function

''::::
function CBrowser_Remove _
	( _
		byval _this as CBrowser ptr _
	) as BOOL

	function = FALSE
	
	if( _this->browserclass = NULL ) then
		return TRUE
	end if

	if( _this->browser <> NULL ) then
		_this->browser->lpVtbl->Release( _this->browser )
		_this->browser = NULL
	end if

	_this->browserclass->lpVtbl->Close( _this->browserclass, OLECLOSE_NOSAVE )
	_this->browserclass->lpVtbl->Release( _this->browserclass )
	
	_this->browserclass = NULL
	
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
function CBrowser_Resize _
	( _
		byval _this as CBrowser ptr, _
		byval width_ as DWORD, _
		byval height as DWORD _
	) as BOOL

	function = FALSE

	if( _this->browserclass = NULL ) then
		exit function
	end if
	
	dim as SIZEL pxSize, hmSize = ( width_, height )
	hPixelToMetric( @pxSize, @hmSize )
	_this->browserclass->lpVtbl->SetExtent( _this->browserclass, _
											DVASPECT_CONTENT, _
											@hmSize )
	
	dim as RECT rect = (0, 0, width_, height )
	_this->client->site.inplaceobj->lpVtbl->SetObjectRects( _this->client->site.inplaceobj, _
															@rect, _
															@rect )

	if( _this->ismozilla = FALSE ) then
		_this->browser->lpVtbl->put_Width( _this->browser, width_ )
		_this->browser->lpVtbl->put_Height( _this->browser, height )
	end if
	
	function = TRUE

end function

''::::
function CBrowser_SetFocus _
	( _
		byval _this as CBrowser ptr _
	) as BOOL

	dim as RECT rect

	function = FALSE
	
	if( _this->browserclass = NULL ) then
		exit function
	end if

	GetClientRect( _this->hwnd, @rect )
	
	_this->browserclass->lpVtbl->DoVerb( _this->browserclass, _
										 OLEIVERB_UIACTIVATE, _
										 NULL, _
										 @_this->client->interface, _
										 0, _
										 _this->hwnd, _
										 @rect )

	function = TRUE

end function

''::::
function CBrowser_Navigate _
	( _
		byval _this as CBrowser ptr, _
		byval url as wstring ptr, _
		byval target as wstring ptr _
	) as BOOL

	dim as VARIANT vURL, vTarget

	function = FALSE
	
	if( _this->browserclass = NULL ) then
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
		function = (_this->browser->lpVtbl->Navigate2( _this->browser, _
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
function CBrowser_Render _
	( _
		byval _this as CBrowser ptr, _
		byval text as wstring ptr _
	) as BOOL

	dim as IDispatch ptr doc
	dim as IHTMLDocument2 ptr htmldoc2
	dim as BOOL res

	function = FALSE
	
	if( _this->browserclass = NULL ) then
		exit function
	end if
	
	res = TRUE

	if( _this->browser->lpVtbl->get_Document( _this->browser, @doc ) <> S_OK ) then
		return FALSE
	end if
		
	if( doc = NULL ) then
		CBrowser_Navigate( _this, "about:blank", NULL )
			
		if( _this->browser->lpVtbl->get_Document( _this->browser, @doc ) <> S_OK ) then
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
function CBrowser_GoBack _
	( _
		byval _this as CBrowser ptr _
	) as BOOL

	function = FALSE
	
	if( _this->browserclass = NULL ) then
		exit function
	end if
	
	function = _this->browser->lpVtbl->GoBack( _this->browser ) = S_OK
	
end function

''::::
function CBrowser_GoForward _
	( _
		byval _this as CBrowser ptr _
	) as BOOL

	function = FALSE
	
	if( _this->browserclass = NULL ) then
		exit function
	end if
	
	function = _this->browser->lpVtbl->GoForward( _this->browser ) = S_OK
	
end function

''::::
function CBrowser_Refresh _
	( _
		byval _this as CBrowser ptr _
	) as BOOL

	function = FALSE
	
	if( _this->browserclass = NULL ) then
		exit function
	end if
	
	function = _this->browser->lpVtbl->Refresh( _this->browser ) = S_OK
	
end function

''::::
function CBrowser_Stop _
	( _
		byval _this as CBrowser ptr _
	) as BOOL

	function = FALSE
	
	if( _this->browserclass = NULL ) then
		exit function
	end if
	
	function = _this->browser->lpVtbl->Stop( _this->browser ) = S_OK
	
end function
