''
''
'' str_types -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __str_types_bi__
#define __str_types_bi__

type big_int_str
	str as byte ptr
	len as integer
	len_allocated as integer
end type

#endif
