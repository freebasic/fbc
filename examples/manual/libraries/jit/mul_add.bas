'' examples/manual/libraries/jit/mul_add.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'libjit'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ExtLibJit
'' --------

'' Simple mul/add example

#include "jit.bi"

' initialize libjit
Dim context As jit_context_t = jit_context_create()
jit_context_build_start(context)

' define function mul_add(x, y, z)
Dim params(0 To 2) As jit_type_t = {jit_type_int, jit_type_int, jit_type_int}
Dim signature As jit_type_t = jit_type_create_signature( _  
	jit_abi_cdecl,  _ ' C-style function
	jit_type_int,   _ ' Return type
	@params(0),     _ ' Parameter array
	3,              _ ' Number of components
	1               _ ' Count references?
)
Dim mul_add As jit_function_t = jit_function_create(context, signature)

' build function (result = (x*y)+z)
Dim As jit_value_t x, y, z, temp1, temp2
x = jit_value_get_param(mul_add, 0)
y = jit_value_get_param(mul_add, 1)
temp1 = jit_insn_mul(mul_add, x, y)
z = jit_value_get_param(mul_add, 2)
temp2 = jit_insn_add(mul_add, temp1, z)
jit_insn_return(mul_add, temp2)

' compile function function
jit_function_compile(mul_add)
jit_context_build_end(context)

' call function
Dim As Integer a=3, b=5, c=2, result
Dim args(0 To 2) As Integer Ptr = {@a, @b, @c}
jit_function_apply(mul_add, @args(0), @result)
Print Using "mul__add(&, &, &) = &"; a; b; c; result

' clean up libjit
jit_context_destroy(context)
