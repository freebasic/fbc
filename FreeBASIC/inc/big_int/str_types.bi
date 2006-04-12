''
''
'' str_types -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __bigint_str_types_bi__
#define __bigint_str_types_bi__

type big_int_str
	str as zstring ptr
	len as integer
	len_allocated as integer
end type

#endif
