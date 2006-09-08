#ifndef _CBrowser_bi_
#define _CBrowser_bi_ 1

#inclib "CBrowser"

type CBrowser as CBrowser_

declare function 	CBrowser_New 			( byval _this as CBrowser ptr, _
											  byval hwnd as HWND, _
											  byval ismozilla as integer = FALSE ) as CBrowser ptr

declare sub 		CBrowser_Delete 		( byval _this as CBrowser ptr, _
											  byval isstatic as integer )

declare function 	CBrowser_Insert 		( byval _this as CBrowser ptr ) as BOOL

declare function 	CBrowser_Remove 		( byval _this as CBrowser ptr ) as BOOL

declare function 	CBrowser_Resize 		( byval _this as CBrowser ptr, _
											  byval width_ as DWORD, _
											  byval height as DWORD ) as BOOL

declare function 	CBrowser_SetFocus		( byval _this as CBrowser ptr ) as BOOL

declare function 	CBrowser_Navigate 		( byval _this as CBrowser ptr, _
											  byval url as wstring ptr, _
											  byval target as wstring ptr = NULL ) as BOOL

declare function 	CBrowser_Render 		( byval _this as CBrowser ptr, _
											  byval text as wstring ptr ) as BOOL

declare function 	CBrowser_GoBack			( byval _this as CBrowser ptr ) as BOOL

declare function 	CBrowser_GoForward		( byval _this as CBrowser ptr ) as BOOL

declare function 	CBrowser_Refresh		( byval _this as CBrowser ptr ) as BOOL

declare function 	CBrowser_Stop 			( byval _this as CBrowser ptr ) as BOOL

#endif