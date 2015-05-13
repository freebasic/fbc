''
''
'' cst_clunits -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_clunits_bi__
#define __cst_clunits_bi__

type cst_clunit_struct
	type as ushort
	phone as ushort
	start as integer
	end as integer
	prev as integer
	next as integer
end type

type cst_clunit as cst_clunit_struct

type cst_clunit_type_struct
	name as zstring ptr
	start as integer
	count as integer
end type

type cst_clunit_type as cst_clunit_type_struct

type cst_clunit_db_struct
	name as zstring ptr
	types as cst_clunit_type ptr
	trees as cst_cart ptr ptr
	units as cst_clunit ptr
	num_types as integer
	num_units as integer
	sts as cst_sts_list ptr
	mcep as cst_sts_list ptr
	join_weights as integer ptr
	optimal_coupling as integer
	extend_selections as integer
	f0_weight as integer
	unit_name_func as function cdecl(byval as cst_item ptr) as byte ptr
end type

type cst_clunit_db as cst_clunit_db_struct

declare function clunits_ldom_phone_word cdecl alias "clunits_ldom_phone_word" (byval s as cst_item ptr) as zstring ptr
declare function clunit_get_unit_index cdecl alias "clunit_get_unit_index" (byval cludb as cst_clunit_db ptr, byval unit_type as zstring ptr, byval instance as integer) as integer
declare function clunit_get_unit_index_name cdecl alias "clunit_get_unit_index_name" (byval cludb as cst_clunit_db ptr, byval name as zstring ptr) as integer

#endif
