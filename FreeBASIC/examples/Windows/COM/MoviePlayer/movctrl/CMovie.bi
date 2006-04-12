#ifndef _CMovie_bi_
#define _CMovie_bi_ 1

#inclib "cmovie"

type CMovie as CMovie_

declare function 	CMovie_New 				( byval _this as CMovie ptr, _
										  	  byval hwnd as HWND ) as CMovie ptr

declare sub 		CMovie_Delete 			( byval _this as CMovie ptr, _
										  	  byval isstatic as integer )

declare function 	CMovie_Insert 			( byval _this as CMovie ptr ) as BOOL

declare function 	CMovie_Remove 			( byval _this as CMovie ptr ) as BOOL

declare function 	CMovie_Resize 			( byval _this as CMovie ptr, _
										  	  byval width_ as DWORD, _
										  	  byval height as DWORD ) as BOOL

declare function 	CMovie_Load 			( byval _this as CMovie ptr, _
											  byval filename as wstring ptr ) as BOOL

declare function 	CMovie_Play 			( byval _this as CMovie ptr ) as BOOL

declare function 	CMovie_Pause 			( byval _this as CMovie ptr ) as BOOL

declare function 	CMovie_Stop 			( byval _this as CMovie ptr ) as BOOL

#endif