' Copyright (C) 1999 DJ Delorie, see COPYING.DJ for details
' Copyright (C) 1995 DJ Delorie, see COPYING.DJ for details
#ifndef __dj_include_dpmi_h_
#define __dj_include_dpmi_h_

extern __dpmi_error alias "__dpmi_error" as unsigned short

type __dpmi_raddr
	offset16	as ushort
	segment		as ushort
end type

type __dpmi_paddr
	offset32	as uinteger
	selector	as ushort
end type

type __dpmi_meminfo
	handle		as uinteger			' 0, 2
	size		as uinteger	' or count	' 4, 6
	address		as uinteger			' 8, 10
end type

type __dpmi_regs_d
	edi	as uinteger
	esi	as uinteger
	ebp	as uinteger
	res	as uinteger
	ebx	as uinteger
	edx	as uinteger
	ecx	as uinteger
	eax	as uinteger
end type

type __dpmi_regs_x
	di	as ushort
	di_hi	as ushort
	si	as ushort
	si_hi	as ushort
	bp	as ushort
	bp_hi	as ushort
	res	as ushort
	res_hi	as ushort
	bx	as ushort
	bx_hi	as ushort
	dx	as ushort
	dx_hi	as ushort
	cx	as ushort
	cx_hi	as ushort
	ax	as ushort
	ax_hi	as ushort
	flags	as ushort
	es	as ushort
	ds	as ushort
	fs	as ushort
	gs	as ushort
	ip	as ushort
	cs	as ushort
	sp	as ushort
	ss	as ushort
end type
type __dpmi_regs_h
	edi(3)	as ubyte
	esi(3)	as ubyte
	ebp(3)	as ubyte
	res(3)	as ubyte
	bl	as ubyte
	bh	as ubyte
	ebx_b2	as ubyte
	ebx_b3	as ubyte
	dl	as ubyte
	dh	as ubyte
	edx_b2	as ubyte
	edx_b3	as ubyte
	cl	as ubyte
	ch	as ubyte
	ecx_b2	as ubyte
	ecx_b3	as ubyte
	al	as ubyte
	ah	as ubyte
	eax_b2	as ubyte
	eax_b3	as ubyte
end type

union __dpmi_regs
	d as __dpmi_regs_d
	x as __dpmi_regs_x
	h as __dpmi_regs_h
end union

type __dpmi_version_ret
	major		as ubyte
	minor		as ubyte
	flags		as ushort
	cpu		as ubyte
	master_pic	as ubyte
	slave_pic	as ubyte
end type

type __dpmi_free_mem_info
	largest_available_free_block_in_bytes		as uinteger
	maximum_unlocked_page_allocation_in_pages	as uinteger
	maximum_locked_page_allocation_in_pages		as uinteger
	linear_address_space_size_in_pages		as uinteger
	total_number_of_unlocked_pages			as uinteger
	total_number_of_free_pages			as uinteger
	total_number_of_physical_pages			as uinteger
	free_linear_address_space_in_pages		as uinteger
	size_of_paging_file_partition_in_pages		as uinteger
	reserved(0 to 2)				as uinteger
end type

type __dpmi_memory_info
	total_allocated_bytes_of_physical_memory_host	as uinteger
	total_allocated_bytes_of_virtual_memory_host	as uinteger
	total_available_bytes_of_virtual_memory_host	as uinteger
	total_allocated_bytes_of_virtual_memory_vcpu	as uinteger
	total_available_bytes_of_virtual_memory_vcpu	as uinteger
	total_allocated_bytes_of_virtual_memory_client	as uinteger
	total_available_bytes_of_virtual_memory_client	as uinteger
	total_locked_bytes_of_memory_client		as uinteger
	max_locked_bytes_of_memory_client		as uinteger
	highest_linear_address_available_to_client	as uinteger
	size_in_bytes_of_largest_free_memory_block	as uinteger
	size_of_minimum_allocation_unit_in_bytes	as uinteger
	size_of_allocation_alignment_unit_in_bytes	as uinteger
	reserved(0 to 18)				as uinteger
end type

type __dpmi_callback_info
	data16(0 to 1)	as uinteger
	code16(0 to 1)	as uinteger
	ip		as ushort
	reserved	as ushort
	data32(0 to 1)	as uinteger
	code32(0 to 1)	as uinteger
	eip		as uinteger
end type

type __dpmi_shminfo
	size_requested	as uinteger
	size		as uinteger
	handle		as uinteger
	address		as uinteger
	name_offset	as uinteger
	name_selector	as ushort
	reserved1	as ushort
	reserved2	as uinteger
end type


' Unless otherwise noted, all functions return -1 on error, setting __dpmi_error to the DPMI error code

declare sub		__dpmi_yield cdecl alias "__dpmi_yield"										( )													' INT 0x2F AX=1680

declare function	__dpmi_allocate_ldt_descriptors cdecl alias "__dpmi_allocate_ldt_descriptors" 					( byval _count as integer ) as integer									' DPMI 0.9 AX=0000
declare function	__dpmi_free_ldt_descriptor cdecl alias "__dpmi_free_ldt_descriptor"						( byval _descriptor as integer ) as integer								' DPMI 0.9 AX=0001
declare function	__dpmi_segment_to_descriptor cdecl alias "__dpmi_segment_to_descriptor"						( byval _segment as integer ) as integer								' DPMI 0.9 AX=0002
declare function	__dpmi_get_selector_increment_value cdecl alias "__dpmi_get_selector_increment_value"				( ) as integer												' DPMI 0.9 AX=0003
declare function	__dpmi_get_segment_base_address cdecl alias "__dpmi_get_segment_base_address"					( byval _selector as integer, byval _addr as uinteger ptr ) as integer					' DPMI 0.9 AX=0006
declare function	__dpmi_set_segment_base_address cdecl alias "__dpmi_set_segment_base_address"					( byval _selector as integer, byval _address as uinteger ) as integer					' DPMI 0.9 AX=0007
declare function	__dpmi_get_segment_limit cdecl alias "__dpmi_get_segment_limit"							( byval _selector as integer ) as uinteger								' LSL instruction
declare function	__dpmi_set_segment_limit cdecl alias "__dpmi_set_segment_limit"							( byval _selector as integer, byval _limit as uinteger ) as integer					' DPMI 0.9 AX=0008
declare function	__dpmi_get_descriptor_access_rights cdecl alias "__dpmi_get_descriptor_access_rights"				( byval _selector as integer ) as integer								' LAR instruction
declare function	__dpmi_set_descriptor_access_rights cdecl alias "__dpmi_set_descriptor_access_rights"				( byval _selector as integer, byval _right as integer ) as integer					' DPMI 0.9 AX=0009
declare function	__dpmi_create_alias_descriptor cdecl alias "__dpmi_create_alias_descriptor"					( byval _selector as integer ) as integer								' DPMI 0.9 AX=000a
declare function	__dpmi_get_descriptor cdecl alias "__dpmi_get_descriptor"							( byval _selector as integer, byval _buffer as any ptr ) as integer					' DPMI 0.9 AX=000b
declare function	__dpmi_set_descriptor cdecl alias "__dpmi_set_descriptor"							( byval _selector as integer, byval _buffer as any ptr ) as integer					' DPMI 0.9 AX=000c
declare function	__dpmi_allocate_specific_ldt_descriptor cdecl alias "__dpmi_allocate_specific_ldt_descriptor"			( byval _selector as integer ) as integer								' DPMI 0.9 AX=000d

declare function	__dpmi_get_multiple_descriptors cdecl alias "__dpmi_get_multiple_descriptors"					( byval _count as integer, byval _buffer as any ptr ) as integer					' DPMI 1.0 AX=000e
declare function	__dpmi_set_multiple_descriptors cdecl alias "__dpmi_set_multiple_descriptors"					( byval _count as integer, byval _buffer as any ptr ) as integer					' DPMI 1.0 AX=000f

declare function	__dpmi_allocate_dos_memory cdecl alias "__dpmi_allocate_dos_memory"						( byval _paras as integer, byval _ret_sel_or_max as integer ptr) as integer				' DPMI 0.9 AX=0100
declare function	__dpmi_free_dos_memory cdecl alias "__dpmi_free_dos_memory"							( byval _selector as integer ) as integer								' DPMI 0.9 AX=0101
declare function	__dpmi_resize_dos_memory cdecl alias "__dpmi_resize_dos_memory"							( byval _selector as integer, byval _newpara as integer, byval _ret_max as integer ptr ) as integer	' DPMI 0.9 AX=0102

declare function	__dpmi_get_real_mode_interrupt_vector cdecl alias "__dpmi_get_real_mode_interrupt_vector"			( byval _vector as integer, byval _address as __dpmi_raddr ptr ) as integer				' DPMI 0.9 AX=0200
declare function	__dpmi_set_real_mode_interrupt_vector cdecl alias "__dpmi_set_real_mode_interrupt_vector"			( byval _vector as integer, byval _address as __dpmi_raddr ptr ) as integer				' DPMI 0.9 AX=0201
declare function	__dpmi_get_processor_exception_handler_vector cdecl alias "__dpmi_get_processor_exception_handler_vector"	( byval _vector as integer, byval _address as __dpmi_paddr ptr ) as integer				' DPMI 0.9 AX=0202
declare function	__dpmi_set_processor_exception_handler_vector cdecl alias "__dpmi_set_processor_exception_handler_vector"	( byval _vector as integer, byval _address as __dpmi_paddr ptr ) as integer				' DPMI 0.9 AX=0203
declare function	__dpmi_get_protected_mode_interrupt_vector cdecl alias "__dpmi_get_protected_mode_interrupt_vector"		( byval _vector as integer, byval _address as __dpmi_paddr ptr ) as integer				' DPMI 0.9 AX=0204
declare function	__dpmi_set_protected_mode_interrupt_vector cdecl alias "__dpmi_set_protected_mode_interrupt_vector"		( byval _vector as integer, byval _address as __dpmi_paddr ptr ) as integer				' DPMI 0.9 AX=0205

declare function	__dpmi_get_extended_exception_handler_vector_pm cdecl alias "__dpmi_get_extended_exception_handler_vector_pm"	( byval _vector as integer, byval _address as __dpmi_paddr ptr ) as integer				' DPMI 1.0 AX=0210
declare function	__dpmi_get_extended_exception_handler_vector_rm cdecl alias "__dpmi_get_extended_exception_handler_vector_rm"	( byval _vector as integer, byval _address as __dpmi_paddr ptr ) as integer				' DPMI 1.0 AX=0211
declare function	__dpmi_set_extended_exception_handler_vector_pm cdecl alias "__dpmi_set_extended_exception_handler_vector_pm"	( byval _vector as integer, byval _address as __dpmi_paddr ptr ) as integer				' DPMI 1.0 AX=0212
declare function	__dpmi_set_extended_exception_handler_vector_rm cdecl alias "__dpmi_set_extended_exception_handler_vector_rm"	( byval _vector as integer, byval _address as __dpmi_paddr ptr ) as integer				' DPMI 1.0 AX=0213

declare function	__dpmi_simulate_real_mode_interrupt cdecl alias "__dpmi_simulate_real_mode_interrupt"				( byval _vector as integer, byval _regs as __dpmi_regs ptr ) as integer					' DPMI 0.9 AX=0300
declare function	__dpmi_int cdecl alias "__dpmi_int"										( byval _vector as integer, byval _regs as __dpmi_regs ptr ) as integer	' like above, but sets ss sp fl	' DPMI 0.9 AX=0300
extern __dpmi_int_ss alias "__dpmi_int_ss" as short ' default to zero
extern __dpmi_int_sp alias "__dpmi_int_sp" as short
extern __dpmi_int_flags alias "__dpmi_int_flags" as short
declare function	__dpmi_simulate_real_mode_procedure_retf cdecl alias "__dpmi_simulate_real_mode_procedure_retf"			( byval _regs as __dpmi_regs ptr ) as integer								' DPMI 0.9 AX=0301
declare function	__dpmi_simulate_real_mode_procedure_retf_stack cdecl alias "__dpmi_simulate_real_mode_procedure_retf_stack"	( byval _regs as __dpmi_regs ptr, byval st_words_cpy as integer, byval st_dat as any ptr ) as integer	' DPMI 0.9 AX=0301
declare function	__dpmi_simulate_real_mode_procedure_iret cdecl alias "__dpmi_simulate_real_mode_procedure_iret"			( byval _regs as __dpmi_regs ptr ) as integer								' DPMI 0.9 AX=0302
declare function	__dpmi_allocate_real_mode_callback cdecl alias "__dpmi_allocate_real_mode_callback"				( byval _handler as sub( ), byval _regs as __dpmi_regs ptr, byval _ret as __dpmi_raddr ptr ) as integer	' DPMI 0.9 AX=0303
declare function	__dpmi_free_real_mode_callback cdecl alias "__dpmi_free_real_mode_callback"					( byval _addr as __dpmi_raddr ptr ) as integer								' DPMI 0.9 AX=0304
declare function	__dpmi_get_state_save_restore_addr cdecl alias "__dpmi_get_state_save_restore_addr"				( byval _rm as __dpmi_raddr ptr, byval _pm as __dpmi_paddr ptr ) as integer				' DPMI 0.9 AX=0305
declare function	__dpmi_get_raw_mode_switch_addr cdecl alias "__dpmi_get_raw_mode_switch_addr"					( byval _rm as __dpmi_raddr ptr, byval _pm as __dpmi_paddr ptr ) as integer				' DPMI 0.9 AX=0306

declare function	__dpmi_get_version cdecl alias "__dpmi_get_version"								( byval _ret as __dpmi_version_ret ptr ) as integer							' DPMI 0.9 AX=0400

declare function	__dpmi_get_capabilities cdecl alias "__dpmi_get_capabilities"							( byval _flags as integer ptr, byval vendor_info as zstring ptr ) as integer					' DPMI 1.0 AX=0401

declare function	__dpmi_get_free_memory_information cdecl alias "__dpmi_get_free_memory_information"				( byval _info as __dpmi_free_mem_info ptr ) as integer							' DPMI 0.9 AX=0500
declare function	__dpmi_allocate_memory cdecl alias "__dpmi_allocate_memory"							( byval _info as __dpmi_meminfo ptr ) as integer							' DPMI 0.9 AX=0501
declare function	__dpmi_free_memory cdecl alias "__dpmi_free_memory"								( byval _handle as uinteger ) as integer								' DPMI 0.9 AX=0502
declare function	__dpmi_resize_memory cdecl alias "__dpmi_resize_memory"								( byval _info as __dpmi_meminfo ptr ) as integer							' DPMI 0.9 AX=0503

declare function	__dpmi_allocate_linear_memory cdecl alias "__dpmi_allocate_linear_memory"					( byval _info as __dpmi_meminfo ptr, byval _commit as integer ) as integer				' DPMI 1.0 AX=0504
declare function	__dpmi_resize_linear_memory cdecl alias "__dpmi_resize_linear_memory"						( byval _info as __dpmi_meminfo ptr, byval _commit as integer ) as integer				' DPMI 1.0 AX=0505
declare function	__dpmi_get_page_attributes cdecl alias "__dpmi_get_page_attributes"						( byval _info as __dpmi_meminfo ptr, byval _buffer as short ptr ) as integer				' DPMI 1.0 AX=0506
declare function	__dpmi_set_page_attributes cdecl alias "__dpmi_set_page_attributes"						( byval _info as __dpmi_meminfo ptr, byval _buffer as short ptr ) as integer				' DPMI 1.0 AX=0507
declare function	__dpmi_map_device_in_memory_block cdecl alias "__dpmi_map_device_in_memory_block"				( byval _info as __dpmi_meminfo ptr, byval _physaddr as uinteger ) as integer				' DPMI 1.0 AX=0508
declare function	__dpmi_map_conventional_memory_in_memory_block cdecl alias "__dpmi_map_conventional_memory_in_memory_block"	( byval _info as __dpmi_meminfo ptr, byval _physaddr as uinteger ) as integer				' DPMI 1.0 AX=0509
declare function	__dpmi_get_memory_block_size_and_base cdecl alias "__dpmi_get_memory_block_size_and_base"			( byval _info as __dpmi_meminfo ptr ) as integer							' DPMI 1.0 AX=050a
declare function	__dpmi_get_memory_information cdecl alias "__dpmi_get_memory_information"					( byval _buffer as __dpmi_memory_info ptr ) as integer							' DPMI 1.0 AX=050b

declare function	__dpmi_lock_linear_region cdecl alias "__dpmi_lock_linear_region"						( byval _info as __dpmi_meminfo ptr ) as integer							' DPMI 0.9 AX=0600
declare function	__dpmi_unlock_linear_region cdecl alias "__dpmi_unlock_linear_region"						( byval _info as __dpmi_meminfo ptr ) as integer							' DPMI 0.9 AX=0601
declare function	__dpmi_mark_real_mode_region_as_pageable cdecl alias "__dpmi_mark_real_mode_region_as_pageable"			( byval _info as __dpmi_meminfo ptr ) as integer							' DPMI 0.9 AX=0602
declare function	__dpmi_relock_real_mode_region cdecl alias "__dpmi_relock_real_mode_region"					( byval _info as __dpmi_meminfo ptr ) as integer							' DPMI 0.9 AX=0603
declare function	__dpmi_get_page_size cdecl alias "__dpmi_get_page_size"								( byval _size as uinteger ptr ) as integer								' DPMI 0.9 AX=0604

declare function	__dpmi_mark_page_as_demand_paging_candidate cdecl alias "__dpmi_mark_page_as_demand_paging_candidate"		( byval _info as __dpmi_meminfo ptr ) as integer							' DPMI 0.9 AX=0702
declare function	__dpmi_discard_page_contents cdecl alias "__dpmi_discard_page_contents"						( byval _info as __dpmi_meminfo ptr ) as integer							' DPMI 0.9 AX=0703

declare function	__dpmi_physical_address_mapping cdecl alias "__dpmi_physical_address_mapping"					( byval _info as __dpmi_meminfo ptr ) as integer							' DPMI 0.9 AX=0800
declare function	__dpmi_free_physical_address_mapping cdecl alias "__dpmi_free_physical_address_mapping"				( byval _info as __dpmi_meminfo ptr ) as integer							' DPMI 0.9 AX=0801

' These next four functions return the old state
declare function	__dpmi_get_and_disable_virtual_interrupt_state cdecl alias "__dpmi_get_and_disable_virtual_interrupt_state"	( ) as integer												' DPMI 0.9 AX=0900
declare function	__dpmi_get_and_enable_virtual_interrupt_state cdecl alias "__dpmi_get_and_enable_virtual_interrupt_state"	( ) as integer												' DPMI 0.9 AX=0901
declare function	__dpmi_get_and_set_virtual_interrupt_state cdecl alias "__dpmi_get_and_set_virtual_interrupt_state"		( byval _old_state as integer ) as integer								' DPMI 0.9 AH=09
declare function	__dpmi_get_virtual_interrupt_state cdecl alias "__dpmi_get_virtual_interrupt_state"				( ) as integer												' DPMI 0.9 AX=0902

declare function	__dpmi_get_vendor_specific_api_entry_point cdecl alias "__dpmi_get_vendor_specific_api_entry_point"		( byval _id as zstring ptr, byval _api as __dpmi_paddr ptr ) as integer					' DPMI 0.9 AX=0a00

declare function	__dpmi_set_debug_watchpoint cdecl alias "__dpmi_set_debug_watchpoint"						( byval _info as __dpmi_meminfo ptr, byval _type as integer ) as integer				' DPMI 0.9 AX=0b00
declare function	__dpmi_clear_debug_watchpoint cdecl alias "__dpmi_clear_debug_watchpoint"					( byval _handle as uinteger ) as integer								' DPMI 0.9 AX=0b01
declare function	__dpmi_get_state_of_debug_watchpoint cdecl alias "__dpmi_get_state_of_debug_watchpoint"				( byval _handle as uinteger, byval _status as integer ptr ) as integer					' DPMI 0.9 AX=0b02
declare function	__dpmi_reset_debug_watchpoint cdecl alias "__dpmi_reset_debug_watchpoint"					( byval _handle as uinteger ) as integer								' DPMI 0.9 AX=0b03

declare function	__dpmi_install_resident_service_provider_callback cdecl alias "__dpmi_install_resident_service_provider_callback" ( byval _info as __dpmi_callback_info ptr ) as integer						' DPMI 1.0 AX=0c00
declare function	__dpmi_terminate_and_stay_resident cdecl alias "__dpmi_terminate_and_stay_resident"				( byval return_code as integer, byval paragraphs_to_keep as integer ) as integer			' DPMI 1.0 AX=0c01

declare function	__dpmi_allocate_shared_memory cdecl alias "__dpmi_allocate_shared_memory"					( byval _info as __dpmi_shminfo ptr ) as integer							' DPMI 1.0 AX=0d00
declare function	__dpmi_free_shared_memory cdecl alias "__dpmi_free_shared_memory"						( byval _handle as uinteger ) as integer								' DPMI 1.0 AX=0d01
declare function	__dpmi_serialize_on_shared_memory cdecl alias "__dpmi_serialize_on_shared_memory"				( byval _handle as uinteger, byval _flags as integer ) as integer					' DPMI 1.0 AX=0d02
declare function	__dpmi_free_serialization_on_shared_memory cdecl alias "__dpmi_free_serialization_on_shared_memory"		( byval _handle as uinteger, byval _flags as integer ) as integer					' DPMI 1.0 AX=0d03

declare function	__dpmi_get_coprocessor_status cdecl alias "__dpmi_get_coprocessor_status"					( ) as integer												' DPMI 1.0 AX=0e00
declare function	__dpmi_set_coprocessor_emulation cdecl alias "__dpmi_set_coprocessor_emulation"					( byval _flags as integer ) as integer									' DPMI 1.0 AX=0e01


' - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
' Backwards compatibility stuff						       

#define _go32_dpmi_registers            __dpmi_regs

type _go32_dpmi_meminfo
	available_memory		as uinteger
	available_pages			as uinteger
	available_lockable_pages	as uinteger
	linear_space			as uinteger
	unlocked_pages			as uinteger
	available_physical_pages	as uinteger
	total_physical_pages		as uinteger
	free_linear_space		as uinteger
	max_pages_in_paging_file	as uinteger
	reserved(0 to 2)		as uinteger
end type

#define _go32_dpmi_get_free_memory_information(x) __dpmi_get_free_memory_information((x))

#define _go32_dpmi_simulate_int		__dpmi_simulate_real_mode_interrupt
#define _go32_dpmi_simulate_fcall	__dpmi_simulate_real_mode_procedure_retf
#define _go32_dpmi_simulate_fcall_iret	__dpmi_simulate_real_mode_procedure_iret

type _go32_dpmi_seginfo
	size		as uinteger
	pm_offset	as uinteger
	pm_selector	as uinteger
	rm_offset	as uinteger
	rm_segment	as uinteger
end type

' returns zero if success, else dpmi error and info->size is max size
declare function	_go32_dpmi_allocate_dos_memory cdecl alias "_go32_dpmi_allocate_dos_memory"	( byval info as _go32_dpmi_seginfo ptr ) as integer
	' set size to bytes/16, call, use rm_segment.  Do not
	'   change anthing but size until the memory is freed.
	'   If error, max size is returned in size as bytes/16.

declare function	_go32_dpmi_free_dos_memory cdecl alias "_go32_dpmi_free_dos_memory"		( byval info as _go32_dpmi_seginfo ptr ) as integer
	' set new size to bytes/16, call.  If error, max size
	'   is returned in size as bytes/16

declare function	_go32_dpmi_resize_dos_memory cdecl alias "_go32_dpmi_resize_dos_memory"		( byval info as _go32_dpmi_seginfo ptr ) as integer
	' uses pm_selector to free memory

' These both use the rm_segment:rm_offset fields only
declare function	_go32_dpmi_get_real_mode_interrupt_vector cdecl alias "_go32_dpmi_get_real_mode_interrupt_vector"	( byval vector as integer, byval info as _go32_dpmi_seginfo ptr ) as integer
declare function	_go32_dpmi_set_real_mode_interrupt_vector cdecl alias "_go32_dpmi_set_real_mode_interrupt_vector"	( byval vector as integer, byval info as _go32_dpmi_seginfo ptr ) as integer

' These do NOT wrap the function in pm_offset in an iret handler.
'   You must provide an assembler interface yourself, or alloc one below.
'   You may NOT longjmp out of an interrupt handler.
declare function	_go32_dpmi_get_protected_mode_interrupt_vector cdecl alias "_go32_dpmi_get_protected_mode_interrupt_vector"	( byval vector as integer, byval info as _go32_dpmi_seginfo ptr ) as integer
	' puts vector in pm_selector:pm_offset.
declare function	_go32_dpmi_set_protected_mode_interrupt_vector cdecl alias "_go32_dpmi_set_protected_mode_interrupt_vector"	( byval vector as integer, byval info as _go32_dpmi_seginfo ptr ) as integer
	' sets vector from pm_offset and pm_selector

'/********** HELPER FUNCTIONS **********/

declare function	_go32_dpmi_chain_protected_mode_interrupt_vector cdecl alias "_go32_dpmi_chain_protected_mode_interrupt_vector"	( byval vector as integer, byval info as _go32_dpmi_seginfo ptr ) as integer
	' sets up wrapper that calls function in pm_offset, chaining to old
	'   handler when it returns

' These generate assember IRET-style wrappers for functions and set up stack
declare function	_go32_dpmi_allocate_iret_wrapper cdecl alias "_go32_dpmi_allocate_iret_wrapper"	( byval info as _go32_dpmi_seginfo ptr ) as integer
	' Put function ptr in pm_offset, call, returns wrapper entry in pm_offset.
declare function	_go32_dpmi_free_iret_wrapper cdecl alias "_go32_dpmi_free_iret_wrapper"		( byval info as _go32_dpmi_seginfo ptr ) as integer
	' assumes pm_offset points to wrapper, frees it

' RMCB functions, automatically restructure the real-mode stack for the 
'   proper return type and set up correct PM stack.  The callback
'   (info->pm_offset) is called as (*pmcb)(_go32_dpmi_registers *regs);
declare function	_go32_dpmi_allocate_real_mode_callback_retf cdecl alias "_go32_dpmi_allocate_real_mode_callback_retf"	( byval info as _go32_dpmi_seginfo ptr, byval regs as _go32_dpmi_registers ptr ) as integer
	' points callback at pm_offset, returns seg:ofs of callback addr
	'   in rm_segment:rm_offset.  Do not change any fields until freed.
	'   Interface is added to simulate far return
declare function	_go32_dpmi_allocate_real_mode_callback_iret cdecl alias "_go32_dpmi_allocate_real_mode_callback_iret"	( byval info as _go32_dpmi_seginfo ptr, byval regs as _go32_dpmi_registers ptr ) as integer
	' same, but simulates iret
declare function	_go32_dpmi_free_real_mode_callback cdecl alias "_go32_dpmi_free_real_mode_callback"			(byval info as _go32_dpmi_seginfo ptr) as integer
	' frees callback

' The following two variables may be used to change the default stack size
'   for interrupts and rmcb wrappers to a user defined size from the default
'   of 32Kbytes.  Each RMCB and chain/iret wrapper gets it's own stack.

extern _go32_interrupt_stack_size alias "_go32_interrupt_stack_size"	as uinteger
extern _go32_rmcb_stack_size alias "_go32_rmcb_stack_size"		as uinteger

' Convenience functions, the return value is *bytes*
declare function	_go32_dpmi_remaining_physical_memory cdecl alias "_go32_dpmi_remaining_physical_memory"	( ) as uinteger
declare function	_go32_dpmi_remaining_virtual_memory cdecl alias "_go32_dpmi_remaining_virtual_memory"	( ) as uinteger

' locks memory from a specified offset within the code/data selector
declare function	_go32_dpmi_lock_code cdecl alias "_go32_dpmi_lock_code"	( byval _lockaddr as any ptr, byval _locksize as uinteger ) as integer
declare function	_go32_dpmi_lock_data cdecl alias "_go32_dpmi_lock_data" ( byval _lockaddr as any ptr, byval _locksize as uinteger ) as integer

declare function	__djgpp_set_page_attributes cdecl alias "__djgpp_set_page_attributes"	( byval our_addr as any ptr, byval num_bytes as uinteger, byval attributes as ushort ) as integer
declare function	__djgpp_map_physical_memory cdecl alias "__djgpp_map_physical_memory"	( byval our_addr as any ptr, byval num_bytes as uinteger, byval phys_addr as uinteger ) as integer

#endif ' !__dj_include_dpmi_h_
