''
''
'' cst_cart -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_cart_bi__
#define __cst_cart_bi__

#define CST_CART_OP_NONE 255
#define CST_CART_OP_LEAF 255
#define CST_CART_OP_IS 0
#define CST_CART_OP_IN 1
#define CST_CART_OP_LESS 2
#define CST_CART_OP_GREATER 3
#define CST_CART_OP_MATCHES 4
#define CST_CART_OP_EQUALS 5

type cst_cart_node_struct
	feat as ubyte
	op as ubyte
	no_node as ushort
	val as cst_val ptr
end type

type cst_cart_node as cst_cart_node_struct

type cst_cart_struct
	rule_table as cst_cart_node ptr
	feat_table as byte ptr ptr
end type

type cst_cart as cst_cart_struct

declare sub delete_cart cdecl alias "delete_cart" (byval c as cst_cart ptr)

#endif
