#ifndef _CBrowser_bi_
#define _CBrowser_bi_ 1

type CBrowserCtx_ as CBrowserCtx

type CBrowser
	declare constructor _
		( _
			byval hwnd as HWND, _
			byval ismozilla as integer = FALSE _
		)
	
	declare destructor 	( )
	
	declare function insert ( ) as BOOL
	
	declare function remove ( ) as BOOL
	
	declare function resize _
		( _
			byval width_ as DWORD, _
			byval height as DWORD _
		) as BOOL
	
	declare function setFocus ( ) as BOOL
	
	declare function navigate _
		( _
			byval url as wstring ptr, _
			byval target as wstring ptr = NULL _
		) as BOOL
	
	declare function render _
		( _
			byval text as wstring ptr _
		) as BOOL
	
	declare function goBack	( ) as BOOL
	
	declare function goForward ( ) as BOOL
	
	declare function refresh ( ) as BOOL
	
	declare function stop ( ) as BOOL

private:
	ctx as CBrowserCtx_ ptr
end type

#endif