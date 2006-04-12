#ifndef _movctrl_bi_
#define _movctrl_bi_ 1

#inclib "movctrl"
#inclib "strmiids"

type movctrl as movctrl_

declare function 	movctrl_Create 			( byval parent as HWND, _
											  byval x as integer, _
											  byval y as integer, _
											  byval width_ as integer, _
											  byval height as integer ) as movctrl ptr

declare function 	movctrl_Destroy			( byval _this as movctrl ptr ) as BOOL

declare function 	movctrl_Load 			( byval _this as movctrl ptr, _
											  byval filename as wstring ptr ) as BOOL

declare function 	movctrl_Play 			( byval _this as movctrl ptr ) as BOOL

declare function 	movctrl_Pause 			( byval _this as movctrl ptr ) as BOOL

declare function 	movctrl_Stop 			( byval _this as movctrl ptr ) as BOOL

declare function 	movctrl_Move 			( byval _this as movctrl ptr, _
											  byval x as integer, _
											  byval y as integer, _
											  byval width_ as integer, _
											  byval height as integer ) as BOOL

#endif