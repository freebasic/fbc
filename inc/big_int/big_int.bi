''
''
'' big_int -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __bigint_big_int_bi__
#define __bigint_big_int_bi__

#inclib "big_int"

#include once "big_int/memory_manager.bi"

#define BIG_INT_DIGIT_SIZE 32

type big_int_word as uinteger
type big_int_dword as ulongint

enum sign_type
	PLUS
	MINUS
end enum


enum bin_op_type
	OP_ADD
	OP_SUB
	OP_MUL
	OP_DIV
	OP_MOD
	OP_CMP
	OP_POW
	OP_GCD
	OP_OR
	OP_XOR
	OP_AND
	OP_ANDNOT
end enum


type big_int
	num as big_int_word ptr
	sign as sign_type
	len as integer
	len_allocated as integer
end type

#endif
