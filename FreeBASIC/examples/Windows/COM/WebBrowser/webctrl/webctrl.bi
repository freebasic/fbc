#ifndef _webctrl_bi_
#define _webctrl_bi_ 1

#inclib "webctrl"

type webctrl as webctrl_

enum WEBCTRL_FLAGS
	WEBCTRL_IE			= &h00000
	WEBCTRL_MOZILLA		= &h00001
end enum

declare function 	webctrl_Create 			( byval parent as HWND, _
											  byval x as integer, _
											  byval y as integer, _
											  byval width_ as integer, _
											  byval height as integer, _
											  byval flags as WEBCTRL_FLAGS = 0 ) as webctrl ptr

declare function 	webctrl_Navigate 		( byval _this as webctrl ptr, _
											  byval url as wstring ptr, _
											  byval target as wstring ptr = NULL ) as BOOL

declare function 	webctrl_Render 			( byval _this as webctrl ptr, _
											  byval text as wstring ptr ) as BOOL

declare function 	webctrl_Move 			( byval _this as webctrl ptr, _
											  byval x as integer, _
											  byval y as integer, _
											  byval width_ as integer, _
											  byval height as integer ) as BOOL

declare function 	webctrl_GoBack			( byval _this as webctrl ptr ) as BOOL

declare function 	webctrl_GoForward		( byval _this as webctrl ptr ) as BOOL

declare function 	webctrl_Refresh			( byval _this as webctrl ptr ) as BOOL

declare function 	webctrl_Stop 			( byval _this as webctrl ptr ) as BOOL

#endif