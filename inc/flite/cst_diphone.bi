''
''
'' cst_diphone -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_diphone_bi__
#define __cst_diphone_bi__

type cst_diphone_entry_struct
	name as zstring ptr
	start_pm as ushort
	pb_pm as ubyte
	end_pm as ubyte
end type

type cst_diphone_entry as cst_diphone_entry_struct

type cst_diphone_db_struct
	name as zstring ptr
	num_entries as integer
	diphones as cst_diphone_entry ptr
	sts as cst_sts_list ptr
end type

type cst_diphone_db as cst_diphone_db_struct

#endif
