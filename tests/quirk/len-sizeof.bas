#include "fbcu.bi"

sub lenString cdecl()
	dim as string s = "123"
	dim as string ptr p = @s

	'' len() on string expressions should be strlen() and not sizeof(string)
	CU_ASSERT(len(s) = 3)

	CU_ASSERT(len(s + s) = 6)
	CU_ASSERT(len(s & s) = 6)
	CU_ASSERT(len(*p) = 3)
	CU_ASSERT(len(p[0]) = 3)

	CU_ASSERT(len("123") = 3)

	''CU_ASSERT(len(string(3, "a")) = 3) '' Conflicts with len(string). TODO: could be allowed by checking for '('
	CU_ASSERT(len((string(3, "a"))) = 3) '' This works, with extra parentheses which can't be used around types
end sub

namespace ns
	type T
		as integer a, b, c, d
	end type
	dim shared as integer a
end namespace

sub sizeofExpression cdecl()
	type a
		as integer a, b, c, d
	end type
	type b as a
	type p as a
	type x as a

	dim as integer a, b
	dim as integer ptr p = @a
	dim as integer x(0 to 0)
	dim as a aa
	dim as a ptr pa = @aa

	'' This tests len/sizeof's type/expression disambiguation, it needs to
	'' do a lookahead and check for following operators.

	CU_ASSERT(   len(a + b) = 4)
	CU_ASSERT(sizeof(a + b) = 4)

	CU_ASSERT(   len(a - b) = 4)
	CU_ASSERT(sizeof(a - b) = 4)

	''CU_ASSERT(   len(a * b) = 4) '' This is treated as type to support len(string * N)
	''CU_ASSERT(sizeof(a * b) = 4)

	CU_ASSERT(   len(a / b) = 8) '' (returns a double)
	CU_ASSERT(sizeof(a / b) = 8)

	CU_ASSERT(   len(a \ b) = 4)
	CU_ASSERT(sizeof(a \ b) = 4)

	CU_ASSERT(   len(a ^ b) = 8) '' (returns a double)
	CU_ASSERT(sizeof(a ^ b) = 8)

	CU_ASSERT(   len(a mod b) = 4)
	CU_ASSERT(sizeof(a mod b) = 4)

	CU_ASSERT(   len(not a) = 4)
	CU_ASSERT(sizeof(not a) = 4)

	CU_ASSERT(   len(-a) = 4)
	CU_ASSERT(sizeof(-a) = 4)

	CU_ASSERT(   len(a shl b) = 4)
	CU_ASSERT(sizeof(a shl b) = 4)

	CU_ASSERT(   len(a shr b) = 4)
	CU_ASSERT(sizeof(a shr b) = 4)

	CU_ASSERT(   len(a and b) = 4)
	CU_ASSERT(sizeof(a and b) = 4)

	CU_ASSERT(   len(a eqv b) = 4)
	CU_ASSERT(sizeof(a eqv b) = 4)

	CU_ASSERT(   len(a imp b) = 4)
	CU_ASSERT(sizeof(a imp b) = 4)

	CU_ASSERT(   len(a or b) = 4)
	CU_ASSERT(sizeof(a or b) = 4)

	CU_ASSERT(   len(a xor b) = 4)
	CU_ASSERT(sizeof(a xor b) = 4)

	CU_ASSERT(   len(a = b) = 4)
	CU_ASSERT(sizeof(a = b) = 4)

	CU_ASSERT(   len(a <> b) = 4)
	CU_ASSERT(sizeof(a <> b) = 4)

	CU_ASSERT(   len(a < b) = 4)
	CU_ASSERT(sizeof(a < b) = 4)

	CU_ASSERT(   len(a <= b) = 4)
	CU_ASSERT(sizeof(a <= b) = 4)

	CU_ASSERT(   len(a >= b) = 4)
	CU_ASSERT(sizeof(a >= b) = 4)

	CU_ASSERT(   len(a > b) = 4)
	CU_ASSERT(sizeof(a > b) = 4)

	CU_ASSERT(   len(a andalso b) = 4)
	CU_ASSERT(sizeof(a andalso b) = 4)

	CU_ASSERT(   len(a orelse b) = 4)
	CU_ASSERT(sizeof(a orelse b) = 4)

	''CU_ASSERT(   len(x(0)) = 4) '' TODO: allow by checking for '('
	''CU_ASSERT(sizeof(x(0)) = 4)

	CU_ASSERT(   len(p[0]) = 4)
	CU_ASSERT(sizeof(p[0]) = 4)

	CU_ASSERT(   len(aa.a) = 4) '' Plain field access
	CU_ASSERT(sizeof(aa.a) = 4)

	CU_ASSERT(   len(pa->a) = 4)
	CU_ASSERT(sizeof(pa->a) = 4)

	CU_ASSERT(   len(ns.a) = 4) '' Variable from namespace
	CU_ASSERT(sizeof(ns.a) = 4)

	/'
	'' Treated as len(bb) because bb is a type, even though there is a
	'' '.' coming, to allow accessing namespaced types
	type as a bb
	dim as bb bb
	CU_ASSERT(   len(bb.a) = 4)
	CU_ASSERT(sizeof(bb.a) = 4)
	'/
end sub

private sub sizeofType cdecl()
	type a
		as integer a, b, c, d
	end type
	dim as integer a

	type T as a

	CU_ASSERT(   len(integer) = 4)
	CU_ASSERT(sizeof(integer) = 4)
	CU_ASSERT(   len(integer ptr) = sizeof(any ptr))
	CU_ASSERT(   len(string) = sizeof(string))
	CU_ASSERT(   len(T) = 16)
	CU_ASSERT(sizeof(T) = 16)
	CU_ASSERT(   len(a) = 16)
	CU_ASSERT(sizeof(a) = 16)
	CU_ASSERT(   len(ns.T) = 16)
	CU_ASSERT(sizeof(ns.T) = 16)
	CU_ASSERT(   len(string * 5) = 5 + 1) '' + the implicit null terminator
	CU_ASSERT(sizeof(string * 5) = 5 + 1)
	CU_ASSERT(   len(zstring * 5) = 5)
	CU_ASSERT(sizeof(zstring * 5) = 5)
	CU_ASSERT(   len(wstring * 5) = 5 * sizeof(wstring))
	CU_ASSERT(sizeof(wstring * 5) = 5 * sizeof(wstring))
end sub

private sub sizeofTypeVsLenString cdecl()
	'' len() does not prefer string over type if both have the same name.
	'' (Perhaps one day this should be changed for -lang fb at least,
	'' since we do have sizeof())

	type s1
		as integer a, b, c, d
	end type
	dim as string s1 = "123"
	CU_ASSERT(   len(s1) = 16)
	CU_ASSERT(sizeof(s1) = 16)
	CU_ASSERT(   len(s1 + s1) = 6)

	'' ---

	dim as string s2 = "123"
	type s2
		as integer a, b, c, d
	end type
	CU_ASSERT(   len(s2) = 16)
	CU_ASSERT(sizeof(s2) = 16)
	CU_ASSERT(   len(s2 + s2) = 6)

	'' ---

	dim as string s3 = "123"
	scope
		type s3
			as integer a, b, c, d
		end type
		CU_ASSERT(   len(s3) = 16)
		CU_ASSERT(sizeof(s3) = 16)
		CU_ASSERT(   len(s3 + s3) = 6)
	end scope

	'' ---

	type s4
		as integer a, b, c, d
	end type
	scope
		dim as string s4 = "123"
		CU_ASSERT(   len(s4) = 16)
		CU_ASSERT(sizeof(s4) = 16)
		CU_ASSERT(   len(s4 + s4) = 6)
	end scope
end sub

private sub ctor() constructor
	fbcu.add_suite("fbc_tests.quirk.len_sizeof")
	fbcu.add_test("len(string)", @lenString)
	fbcu.add_test("sizeof(expression)", @sizeofExpression)
	fbcu.add_test("sizeof(type)", @sizeofType)
	fbcu.add_test("sizeof(type) vs. len(string)", @sizeofTypeVsLenString)
end sub
