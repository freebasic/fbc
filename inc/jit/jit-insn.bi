''
''
'' jit-insn -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __jit_insn_bi__
#define __jit_insn_bi__

#include "jit/jit-common.bi"

type jit_intrinsic_descr_t
	return_type as jit_type_t
	ptr_result_type as jit_type_t
	arg1_type as jit_type_t
	arg2_type as jit_type_t
end type

type jit_insn_iter_t
	block as jit_block_t
	posn as integer
end type

#define JIT_CALL_NOTHROW (1 shl 0)
#define JIT_CALL_NORETURN (1 shl 1)
#define JIT_CALL_TAIL (1 shl 2)

declare function jit_insn_get_opcode cdecl alias "jit_insn_get_opcode" (byval insn as jit_insn_t) as integer
declare function jit_insn_get_dest cdecl alias "jit_insn_get_dest" (byval insn as jit_insn_t) as jit_value_t
declare function jit_insn_get_value1 cdecl alias "jit_insn_get_value1" (byval insn as jit_insn_t) as jit_value_t
declare function jit_insn_get_value2 cdecl alias "jit_insn_get_value2" (byval insn as jit_insn_t) as jit_value_t
declare function jit_insn_get_label cdecl alias "jit_insn_get_label" (byval insn as jit_insn_t) as jit_label_t
declare function jit_insn_get_function cdecl alias "jit_insn_get_function" (byval insn as jit_insn_t) as jit_function_t
declare function jit_insn_get_native cdecl alias "jit_insn_get_native" (byval insn as jit_insn_t) as any ptr
declare function jit_insn_get_name cdecl alias "jit_insn_get_name" (byval insn as jit_insn_t) as zstring ptr
declare function jit_insn_get_signature cdecl alias "jit_insn_get_signature" (byval insn as jit_insn_t) as jit_type_t
declare function jit_insn_dest_is_value cdecl alias "jit_insn_dest_is_value" (byval insn as jit_insn_t) as integer
declare function jit_insn_label cdecl alias "jit_insn_label" (byval func as jit_function_t, byval label as jit_label_t ptr) as integer
declare function jit_insn_new_block cdecl alias "jit_insn_new_block" (byval func as jit_function_t) as integer
declare function jit_insn_load cdecl alias "jit_insn_load" (byval func as jit_function_t, byval value as jit_value_t) as jit_value_t
declare function jit_insn_dup cdecl alias "jit_insn_dup" (byval func as jit_function_t, byval value as jit_value_t) as jit_value_t
declare function jit_insn_load_small cdecl alias "jit_insn_load_small" (byval func as jit_function_t, byval value as jit_value_t) as jit_value_t
declare function jit_insn_store cdecl alias "jit_insn_store" (byval func as jit_function_t, byval dest as jit_value_t, byval value as jit_value_t) as integer
declare function jit_insn_load_relative cdecl alias "jit_insn_load_relative" (byval func as jit_function_t, byval value as jit_value_t, byval offset as jit_nint, byval type as jit_type_t) as jit_value_t
declare function jit_insn_store_relative cdecl alias "jit_insn_store_relative" (byval func as jit_function_t, byval dest as jit_value_t, byval offset as jit_nint, byval value as jit_value_t) as integer
declare function jit_insn_add_relative cdecl alias "jit_insn_add_relative" (byval func as jit_function_t, byval value as jit_value_t, byval offset as jit_nint) as jit_value_t
declare function jit_insn_load_elem cdecl alias "jit_insn_load_elem" (byval func as jit_function_t, byval base_addr as jit_value_t, byval index as jit_value_t, byval elem_type as jit_type_t) as jit_value_t
declare function jit_insn_load_elem_address cdecl alias "jit_insn_load_elem_address" (byval func as jit_function_t, byval base_addr as jit_value_t, byval index as jit_value_t, byval elem_type as jit_type_t) as jit_value_t
declare function jit_insn_store_elem cdecl alias "jit_insn_store_elem" (byval func as jit_function_t, byval base_addr as jit_value_t, byval index as jit_value_t, byval value as jit_value_t) as integer
declare function jit_insn_check_null cdecl alias "jit_insn_check_null" (byval func as jit_function_t, byval value as jit_value_t) as integer
declare function jit_insn_add cdecl alias "jit_insn_add" (byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_add_ovf cdecl alias "jit_insn_add_ovf" (byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_sub cdecl alias "jit_insn_sub" (byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_sub_ovf cdecl alias "jit_insn_sub_ovf" (byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_mul cdecl alias "jit_insn_mul" (byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_mul_ovf cdecl alias "jit_insn_mul_ovf" (byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_div cdecl alias "jit_insn_div" (byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_rem cdecl alias "jit_insn_rem" (byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_rem_ieee cdecl alias "jit_insn_rem_ieee" (byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_neg cdecl alias "jit_insn_neg" (byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_and cdecl alias "jit_insn_and" (byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_or cdecl alias "jit_insn_or" (byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_xor cdecl alias "jit_insn_xor" (byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_not cdecl alias "jit_insn_not" (byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_shl cdecl alias "jit_insn_shl" (byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_shr cdecl alias "jit_insn_shr" (byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_ushr cdecl alias "jit_insn_ushr" (byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_sshr cdecl alias "jit_insn_sshr" (byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_eq cdecl alias "jit_insn_eq" (byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_ne cdecl alias "jit_insn_ne" (byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_lt cdecl alias "jit_insn_lt" (byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_le cdecl alias "jit_insn_le" (byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_gt cdecl alias "jit_insn_gt" (byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_ge cdecl alias "jit_insn_ge" (byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_cmpl cdecl alias "jit_insn_cmpl" (byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_cmpg cdecl alias "jit_insn_cmpg" (byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_to_bool cdecl alias "jit_insn_to_bool" (byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_to_not_bool cdecl alias "jit_insn_to_not_bool" (byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_acos cdecl alias "jit_insn_acos" (byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_asin cdecl alias "jit_insn_asin" (byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_atan cdecl alias "jit_insn_atan" (byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_atan2 cdecl alias "jit_insn_atan2" (byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_ceil cdecl alias "jit_insn_ceil" (byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_cos cdecl alias "jit_insn_cos" (byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_cosh cdecl alias "jit_insn_cosh" (byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_exp cdecl alias "jit_insn_exp" (byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_floor cdecl alias "jit_insn_floor" (byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_log cdecl alias "jit_insn_log" (byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_log10 cdecl alias "jit_insn_log10" (byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_pow cdecl alias "jit_insn_pow" (byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_rint cdecl alias "jit_insn_rint" (byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_round cdecl alias "jit_insn_round" (byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_sin cdecl alias "jit_insn_sin" (byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_sinh cdecl alias "jit_insn_sinh" (byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_sqrt cdecl alias "jit_insn_sqrt" (byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_tan cdecl alias "jit_insn_tan" (byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_tanh cdecl alias "jit_insn_tanh" (byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_is_nan cdecl alias "jit_insn_is_nan" (byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_is_finite cdecl alias "jit_insn_is_finite" (byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_is_inf cdecl alias "jit_insn_is_inf" (byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_abs cdecl alias "jit_insn_abs" (byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_min cdecl alias "jit_insn_min" (byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_max cdecl alias "jit_insn_max" (byval func as jit_function_t, byval value1 as jit_value_t, byval value2 as jit_value_t) as jit_value_t
declare function jit_insn_sign cdecl alias "jit_insn_sign" (byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_branch cdecl alias "jit_insn_branch" (byval func as jit_function_t, byval label as jit_label_t ptr) as integer
declare function jit_insn_branch_if cdecl alias "jit_insn_branch_if" (byval func as jit_function_t, byval value as jit_value_t, byval label as jit_label_t ptr) as integer
declare function jit_insn_branch_if_not cdecl alias "jit_insn_branch_if_not" (byval func as jit_function_t, byval value as jit_value_t, byval label as jit_label_t ptr) as integer
declare function jit_insn_jump_table cdecl alias "jit_insn_jump_table" (byval func as jit_function_t, byval value as jit_value_t, byval labels as jit_label_t ptr, byval num_labels as uinteger) as integer
declare function jit_insn_address_of cdecl alias "jit_insn_address_of" (byval func as jit_function_t, byval value1 as jit_value_t) as jit_value_t
declare function jit_insn_address_of_label cdecl alias "jit_insn_address_of_label" (byval func as jit_function_t, byval label as jit_label_t ptr) as jit_value_t
declare function jit_insn_convert cdecl alias "jit_insn_convert" (byval func as jit_function_t, byval value as jit_value_t, byval type as jit_type_t, byval overflow_check as integer) as jit_value_t
declare function jit_insn_call cdecl alias "jit_insn_call" (byval func as jit_function_t, byval name as zstring ptr, byval jit_func as jit_function_t, byval signature as jit_type_t, byval args as jit_value_t ptr, byval num_args as uinteger, byval flags as integer) as jit_value_t
declare function jit_insn_call_indirect cdecl alias "jit_insn_call_indirect" (byval func as jit_function_t, byval value as jit_value_t, byval signature as jit_type_t, byval args as jit_value_t ptr, byval num_args as uinteger, byval flags as integer) as jit_value_t
declare function jit_insn_call_indirect_vtable cdecl alias "jit_insn_call_indirect_vtable" (byval func as jit_function_t, byval value as jit_value_t, byval signature as jit_type_t, byval args as jit_value_t ptr, byval num_args as uinteger, byval flags as integer) as jit_value_t
declare function jit_insn_call_native cdecl alias "jit_insn_call_native" (byval func as jit_function_t, byval name as zstring ptr, byval native_func as any ptr, byval signature as jit_type_t, byval args as jit_value_t ptr, byval num_args as uinteger, byval flags as integer) as jit_value_t
declare function jit_insn_call_intrinsic cdecl alias "jit_insn_call_intrinsic" (byval func as jit_function_t, byval name as zstring ptr, byval intrinsic_func as any ptr, byval descriptor as jit_intrinsic_descr_t ptr, byval arg1 as jit_value_t, byval arg2 as jit_value_t) as jit_value_t
declare function jit_insn_incoming_reg cdecl alias "jit_insn_incoming_reg" (byval func as jit_function_t, byval value as jit_value_t, byval reg as integer) as integer
declare function jit_insn_incoming_frame_posn cdecl alias "jit_insn_incoming_frame_posn" (byval func as jit_function_t, byval value as jit_value_t, byval frame_offset as jit_nint) as integer
declare function jit_insn_outgoing_reg cdecl alias "jit_insn_outgoing_reg" (byval func as jit_function_t, byval value as jit_value_t, byval reg as integer) as integer
declare function jit_insn_outgoing_frame_posn cdecl alias "jit_insn_outgoing_frame_posn" (byval func as jit_function_t, byval value as jit_value_t, byval frame_offset as jit_nint) as integer
declare function jit_insn_return_reg cdecl alias "jit_insn_return_reg" (byval func as jit_function_t, byval value as jit_value_t, byval reg as integer) as integer
declare function jit_insn_setup_for_nested cdecl alias "jit_insn_setup_for_nested" (byval func as jit_function_t, byval nested_level as integer, byval reg as integer) as integer
declare function jit_insn_flush_struct cdecl alias "jit_insn_flush_struct" (byval func as jit_function_t, byval value as jit_value_t) as integer
declare function jit_insn_import cdecl alias "jit_insn_import" (byval func as jit_function_t, byval value as jit_value_t) as jit_value_t
declare function jit_insn_push cdecl alias "jit_insn_push" (byval func as jit_function_t, byval value as jit_value_t) as integer
declare function jit_insn_push_ptr cdecl alias "jit_insn_push_ptr" (byval func as jit_function_t, byval value as jit_value_t, byval type as jit_type_t) as integer
declare function jit_insn_set_param cdecl alias "jit_insn_set_param" (byval func as jit_function_t, byval value as jit_value_t, byval offset as jit_nint) as integer
declare function jit_insn_set_param_ptr cdecl alias "jit_insn_set_param_ptr" (byval func as jit_function_t, byval value as jit_value_t, byval type as jit_type_t, byval offset as jit_nint) as integer
declare function jit_insn_push_return_area_ptr cdecl alias "jit_insn_push_return_area_ptr" (byval func as jit_function_t) as integer
declare function jit_insn_pop_stack cdecl alias "jit_insn_pop_stack" (byval func as jit_function_t, byval num_items as jit_nint) as integer
declare function jit_insn_defer_pop_stack cdecl alias "jit_insn_defer_pop_stack" (byval func as jit_function_t, byval num_items as jit_nint) as integer
declare function jit_insn_flush_defer_pop cdecl alias "jit_insn_flush_defer_pop" (byval func as jit_function_t, byval num_items as jit_nint) as integer
declare function jit_insn_return cdecl alias "jit_insn_return" (byval func as jit_function_t, byval value as jit_value_t) as integer
declare function jit_insn_return_ptr cdecl alias "jit_insn_return_ptr" (byval func as jit_function_t, byval value as jit_value_t, byval type as jit_type_t) as integer
declare function jit_insn_default_return cdecl alias "jit_insn_default_return" (byval func as jit_function_t) as integer
declare function jit_insn_throw cdecl alias "jit_insn_throw" (byval func as jit_function_t, byval value as jit_value_t) as integer
declare function jit_insn_get_call_stack cdecl alias "jit_insn_get_call_stack" (byval func as jit_function_t) as jit_value_t
declare function jit_insn_thrown_exception cdecl alias "jit_insn_thrown_exception" (byval func as jit_function_t) as jit_value_t
declare function jit_insn_uses_catcher cdecl alias "jit_insn_uses_catcher" (byval func as jit_function_t) as integer
declare function jit_insn_start_catcher cdecl alias "jit_insn_start_catcher" (byval func as jit_function_t) as jit_value_t
declare function jit_insn_branch_if_pc_not_in_range cdecl alias "jit_insn_branch_if_pc_not_in_range" (byval func as jit_function_t, byval start_label as jit_label_t, byval end_label as jit_label_t, byval label as jit_label_t ptr) as integer
declare function jit_insn_rethrow_unhandled cdecl alias "jit_insn_rethrow_unhandled" (byval func as jit_function_t) as integer
declare function jit_insn_start_finally cdecl alias "jit_insn_start_finally" (byval func as jit_function_t, byval finally_label as jit_label_t ptr) as integer
declare function jit_insn_return_from_finally cdecl alias "jit_insn_return_from_finally" (byval func as jit_function_t) as integer
declare function jit_insn_call_finally cdecl alias "jit_insn_call_finally" (byval func as jit_function_t, byval finally_label as jit_label_t ptr) as integer
declare function jit_insn_start_filter cdecl alias "jit_insn_start_filter" (byval func as jit_function_t, byval label as jit_label_t ptr, byval type as jit_type_t) as jit_value_t
declare function jit_insn_return_from_filter cdecl alias "jit_insn_return_from_filter" (byval func as jit_function_t, byval value as jit_value_t) as integer
declare function jit_insn_call_filter cdecl alias "jit_insn_call_filter" (byval func as jit_function_t, byval label as jit_label_t ptr, byval value as jit_value_t, byval type as jit_type_t) as jit_value_t
declare function jit_insn_memcpy cdecl alias "jit_insn_memcpy" (byval func as jit_function_t, byval dest as jit_value_t, byval src as jit_value_t, byval size as jit_value_t) as integer
declare function jit_insn_memmove cdecl alias "jit_insn_memmove" (byval func as jit_function_t, byval dest as jit_value_t, byval src as jit_value_t, byval size as jit_value_t) as integer
declare function jit_insn_memset cdecl alias "jit_insn_memset" (byval func as jit_function_t, byval dest as jit_value_t, byval value as jit_value_t, byval size as jit_value_t) as integer
declare function jit_insn_alloca cdecl alias "jit_insn_alloca" (byval func as jit_function_t, byval size as jit_value_t) as jit_value_t
declare function jit_insn_move_blocks_to_end cdecl alias "jit_insn_move_blocks_to_end" (byval func as jit_function_t, byval from_label as jit_label_t, byval to_label as jit_label_t) as integer
declare function jit_insn_move_blocks_to_start cdecl alias "jit_insn_move_blocks_to_start" (byval func as jit_function_t, byval from_label as jit_label_t, byval to_label as jit_label_t) as integer
declare function jit_insn_mark_offset cdecl alias "jit_insn_mark_offset" (byval func as jit_function_t, byval offset as jit_int) as integer
declare function jit_insn_mark_breakpoint cdecl alias "jit_insn_mark_breakpoint" (byval func as jit_function_t, byval data1 as jit_nint, byval data2 as jit_nint) as integer
declare function jit_insn_mark_breakpoint_variable cdecl alias "jit_insn_mark_breakpoint_variable" (byval func as jit_function_t, byval data1 as jit_value_t, byval data2 as jit_value_t) as integer
declare sub jit_insn_iter_init cdecl alias "jit_insn_iter_init" (byval iter as jit_insn_iter_t ptr, byval block as jit_block_t)
declare sub jit_insn_iter_init_last cdecl alias "jit_insn_iter_init_last" (byval iter as jit_insn_iter_t ptr, byval block as jit_block_t)
declare function jit_insn_iter_next cdecl alias "jit_insn_iter_next" (byval iter as jit_insn_iter_t ptr) as jit_insn_t
declare function jit_insn_iter_previous cdecl alias "jit_insn_iter_previous" (byval iter as jit_insn_iter_t ptr) as jit_insn_t

#endif
