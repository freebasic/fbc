' Copyright (C) 1998 DJ Delorie, see COPYING.DJ for details
' Copyright (C) 1995 DJ Delorie, see COPYING.DJ for details
#ifndef __dj_include_go32_h_
#define __dj_include_go32_h_

#include "dos/sys/version.bi"
#include "dos/sys/djtypes.bi"

type __Go32_Info_Block
	size_of_this_structure_in_bytes as uinteger
	linear_address_of_primary_screen as uinteger
	linear_address_of_secondary_screen as uinteger
	linear_address_of_transfer_buffer as uinteger
	size_of_transfer_buffer as uinteger ' >= 4k
	pid as uinteger
	master_interrupt_controller_base as ubyte
	slave_interrupt_controller_base as ubyte
	selector_for_linear_memory as ushort
	linear_address_of_stub_info_structure as uinteger
	linear_address_of_original_psp as uinteger
	run_mode as ushort
	run_mode_info as ushort
end type

extern _go32_info_block alias "_go32_info_block" as __Go32_Info_Block

#define _GO32_RUN_MODE_UNDEF	0
#define _GO32_RUN_MODE_RAW	1
#define _GO32_RUN_MODE_XMS	2
#define _GO32_RUN_MODE_VCPI	3
#define _GO32_RUN_MODE_DPMI	4

#include "dos/sys/movedata.bi"
#include "dos/sys/segments.bi"

#define _go32_my_cs _my_cs
#define _go32_my_ds _my_ds
#define _go32_my_ss _my_ss
#define _go32_conventional_mem_selector _go32_info_block.selector_for_linear_memory
#define _dos_ds _go32_info_block.selector_for_linear_memory

#define __tb _go32_info_block.linear_address_of_transfer_buffer

' returns number of times hit since last call. (zero first time)
declare function	_go32_was_ctrl_break_hit cdecl alias "_go32_was_ctrl_break_hit" ( ) as uinteger
declare sub		_go32_want_ctrl_break cdecl alias "_go32_want_ctrl_break" ( byval yes as integer ) ' auto-yes if call above function

#endif ' !__dj_include_go32_h_
