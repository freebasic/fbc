''
''
'' cst_cg -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_cg_bi__
#define __cst_cg_bi__

type cst_cg_db_struct
	name as zstring ptr
	types as byte ptr ptr
	num_types as integer
	sample_rate as integer
	f0_mean as single
	f0_stddev as single
	f0_trees as cst_cart ptr ptr
	param_trees0 as cst_cart ptr ptr
	param_trees1 as cst_cart ptr ptr
	param_trees2 as cst_cart ptr ptr
	num_channels0 as integer
	num_frames0 as integer
	model_vectors0 as ushort ptr ptr
	num_channels1 as integer
	num_frames1 as integer
	model_vectors1 as ushort ptr ptr
	num_channels2 as integer
	num_frames2 as integer
	model_vectors2 as ushort ptr ptr
	model_min as single ptr
	model_range as single ptr
	frame_advance as single
	dur_stats as dur_stat ptr ptr
	dur_cart as cst_cart ptr
	phone_states as byte ptr ptr ptr
	do_mlpg as integer
	dynwin as single ptr
	dynwinsize as integer
	mlsa_alpha as single
	mlsa_beta as single
	multimodel as integer
	mixed_excitation as integer
	ME_num as integer
	ME_order as integer
	me_h as double ptr ptr
	gain as single
end type

type cst_cg_db as cst_cg_db_struct

declare function mlpg cdecl alias "mlpg" (byval param_track as cst_track ptr, byval cg_db as cst_cg_db ptr) as cst_track ptr

#endif
