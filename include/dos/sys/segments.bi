' Copyright (C) 1999 DJ Delorie, see COPYING.DJ for details
' Copyright (C) 1998 DJ Delorie, see COPYING.DJ for details
' Copyright (C) 1995 DJ Delorie, see COPYING.DJ for details
#ifndef __dj_include_sys_segments_h_
#define __dj_include_sys_segments_h_

private function _my_cs ( ) as integer
	asm
		mov [FUNCTION], cs
	end asm
end function

private function _my_ds ( ) as integer
	asm
		mov [FUNCTION], ds
	end asm
end function

private function _my_ss ( ) as integer
	asm
		mov [FUNCTION], ss
	end asm
end function

#endif ' !__dj_include_sys_segment_h_

