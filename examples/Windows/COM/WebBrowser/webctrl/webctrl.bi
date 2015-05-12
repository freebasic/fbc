#ifndef _webctrl_bi_
#define _webctrl_bi_ 1

#inclib "webctrl"

type webctrl_ctx_ as webctrl_ctx

enum WEBCTRL_FLAGS
	WEBCTRL_IE			= &h00000
	WEBCTRL_MOZILLA		= &h00001
end enum

type webctrl
	
	declare constructor _
		( _
			byval parent as HWND, _
			byval x as integer, _
			byval y as integer, _
			byval width_ as integer, _
			byval height as integer, _
			byval flags as WEBCTRL_FLAGS = 0 _
		)
												  
	declare destructor ( )
	
	declare function navigate _
		( _
			byval url as wstring ptr, _
			byval target as wstring ptr = NULL _
		) as BOOL
	
	declare function render _ 
		( _
			byval text as wstring ptr _
		) as BOOL
	
	declare function move _
		( _
			byval x as integer, _
			byval y as integer, _
			byval width_ as integer, _
			byval height as integer _
		) as BOOL
	
	declare function goBack	(  ) as BOOL
	
	declare function goForward (  ) as BOOL
	
	declare function refresh (  ) as BOOL
	
	declare function stop (  ) as BOOL

/'private:'/
	ctx as webctrl_ctx_ ptr
end type

#endif