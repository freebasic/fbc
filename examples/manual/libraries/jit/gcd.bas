'' examples/manual/libraries/jit/gcd.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'libjit'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ExtLibJit
'' --------

'' GCD calculation example

#include "jit.bi"

' initialize libjit
Dim context As jit_context_t = jit_context_create()
jit_context_build_start(context)

' define function gcd(x as uinteger, y as uinteger) as uinteger
Dim params(0 To 1) As jit_type_t = {jit_type_uint, jit_type_uint}
Dim signature As jit_type_t = jit_type_create_signature( _  
	jit_abi_cdecl,  _ ' C-style function
	jit_type_uint,  _ ' Return type
	@params(0),     _ ' Parameter array
	2,              _ ' Number of components
	1               _ ' Count references?
)
Dim gcd As jit_function_t = jit_function_create(context, signature)

' build function
' check x = y
Dim As jit_value_t x, y, x_eq_y
x = jit_value_get_param(gcd, 0)
y = jit_value_get_param(gcd, 1)
x_eq_y = jit_insn_eq(gcd, x, y)

' if x = y, return x
Dim label_x_ne_y As jit_label_t = jit_label_undefined
jit_insn_branch_if_not(gcd, x_eq_y, @label_x_ne_y)
jit_insn_return(gcd, x)

' else if...
jit_insn_label(gcd, @label_x_ne_y)

' check x < y
Dim As jit_value_t x_lt_y
Dim label_x_gte_y As jit_label_t = jit_label_undefined
x_lt_y = jit_insn_lt(gcd, x, y)
jit_insn_branch_if_not(gcd, x_lt_y, @label_x_gte_y)

' if x < y, return gcd(x, y-x)
Dim As jit_value_t gcd_args(0 To 2), gcd_result
gcd_args(0) = x
gcd_args(1) = jit_insn_sub(gcd, y, x)
gcd_result = jit_insn_call( _
	gcd,          _ ' where we are calling from
	"gcd",        _ ' function name
	gcd,          _ ' function reference
	0,            _ ' signature = auto
	@gcd_args(0), _ ' arguments
	2,            _ ' argument count
	0             _ ' flags = nothing special
)
jit_insn_return(gcd, gcd_result)

' else...
jit_insn_label(gcd, @label_x_gte_y)

' return gcd(x-y, y)
gcd_args(0) = jit_insn_sub(gcd, x, y)
gcd_args(1) = y
gcd_result = jit_insn_call( _
	gcd,          _ ' where we are calling from
	"gcd",        _ ' function name
	gcd,          _ ' function reference
	0,            _ ' signature = auto
	@gcd_args(0), _ ' arguments
	2,            _ ' argument count
	0             _ ' flags = nothing special
)
jit_insn_return(gcd, gcd_result)

' compile function
jit_function_compile(gcd)
jit_context_build_end(context)

' call function
Dim As jit_uint a=21, b=14, result
Dim As jit_uint Ptr args(0 To 1) = {@a, @b}
jit_function_apply(gcd, @args(0), @result)
Print Using "gcd(&, &) = &"; a; b; result

' clean up libjit
jit_context_destroy(context)
