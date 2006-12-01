#ifndef _movctrl_bi_
#define _movctrl_bi_ 1

#inclib "movctrl"
#inclib "strmiids"

type movctrl_ctx_ as movctrl_ctx

type movctrl
	declare constructor	( byval parent as HWND, _
						  byval x as integer, _
						  byval y as integer, _
						  byval width_ as integer, _
						  byval height as integer )
	
	declare destructor (  )
	
	declare function load ( byval filename as wstring ptr ) as BOOL
	
	declare function play (  ) as BOOL
	
	declare function pause (  ) as BOOL
	
	declare function stop (  ) as BOOL
	
	declare function move ( byval x as integer, _
							byval y as integer, _
							byval width_ as integer, _
							byval height as integer ) as BOOL

	ctx as movctrl_ctx_ ptr
end type

#endif