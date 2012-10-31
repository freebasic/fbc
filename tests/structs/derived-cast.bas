# include "fbcu.bi"

namespace fbc_tests.structs.derived_cast

type T1
	as integer a
	as string s
	declare constructor()
end type

type T2 extends T1
	as integer b
	as string s
	declare constructor()
end type

type T3 extends T2
	as integer c
	as string s
	declare constructor()
end type

constructor T1()
	this.a = 111
	this.s = "one"
end constructor

constructor T2()
	this.b = 222
	this.s = "two"
end constructor

constructor T3()
	this.c = 333
	this.s = "three"
end constructor

#macro checkVarT1(x1)
	CU_ASSERT(x1.a = 111)
	CU_ASSERT(x1.s = "one")
#endmacro

#macro checkVarT2(x2)
	CU_ASSERT(x2.a = 111)
	CU_ASSERT(x2.b = 222)
	CU_ASSERT(x2.s = "two")

	'' Up-casting
	CU_ASSERT(cast(T1, x2).a = 111)
	CU_ASSERT(cast(T1, x2).s = "one")

	CU_ASSERT(cast(T1, *@x2).a = 111)
	CU_ASSERT(cast(T1, *@x2).s = "one")

	CU_ASSERT(cptr(T1 ptr, @x2)->a = 111)
	CU_ASSERT(cptr(T1 ptr, @x2)->s = "one")

	'' Repeated up-casting
	checkVarT1(cast(T1, x2))
#endmacro

#macro checkVarT3(x3)
	CU_ASSERT(x3.a = 111)
	CU_ASSERT(x3.b = 222)
	CU_ASSERT(x3.c = 333)
	CU_ASSERT(x3.s = "three")

	'' Up-casting
	CU_ASSERT(cast(T2, x3).a = 111)
	CU_ASSERT(cast(T2, x3).b = 222)
	CU_ASSERT(cast(T2, x3).s = "two")
	CU_ASSERT(cast(T1, x3).a = 111)
	CU_ASSERT(cast(T1, x3).s = "one")

	CU_ASSERT(cast(T2, *@x3).a = 111)
	CU_ASSERT(cast(T2, *@x3).b = 222)
	CU_ASSERT(cast(T2, *@x3).s = "two")
	CU_ASSERT(cast(T1, *@x3).a = 111)
	CU_ASSERT(cast(T1, *@x3).s = "one")

	CU_ASSERT(cptr(T2 ptr, @x3)->a = 111)
	CU_ASSERT(cptr(T2 ptr, @x3)->b = 222)
	CU_ASSERT(cptr(T2 ptr, @x3)->s = "two")
	CU_ASSERT(cptr(T1 ptr, @x3)->a = 111)
	CU_ASSERT(cptr(T1 ptr, @x3)->s = "one")

	'' Repeated up-casting
	checkVarT2(cast(T2, x3))
#endmacro

#macro makeCheckParam(N)
	private sub checkByvalT##N(byval x##N as T##N)
		checkVarT##N(x##N)
	end sub

	private sub checkByrefT##N(byref x##N as T##N)
		checkVarT##N(x##N)
	end sub

	private sub checkPtrT##N(byval x##N as T##N ptr)
		checkVarT##N((*x##N))
	end sub
#endmacro

makeCheckParam(1)
makeCheckParam(2)
makeCheckParam(3)

dim shared as T3 x3_global

sub test cdecl()
	static as T3 x3_static
	dim as T3 x3_local

	'' Up-casting
	checkVarT3(x3_local)
	checkVarT3(x3_static)
	checkVarT3(x3_global)

	'' Implicit argument-to-parameter casting
	checkByvalT1(x3_local)
	checkByvalT2(x3_local)
	checkByvalT3(x3_local)

	checkByrefT1(x3_local)
	checkByrefT2(x3_local)
	checkByrefT3(x3_local)

	'' Implicit pointer casting too
	checkPtrT1(@x3_local)
	checkPtrT2(@x3_local)
	checkPtrT3(@x3_local)
end sub

type Byte1
	dim b1 as byte
end type

type Byte2 extends Byte1
end type

private sub testDerivedLvalueCast cdecl( )
	'' crash regression test
	'' As long as lvalue casting like this is allowed,
	'' this should not crash the compiler.
	dim i2 as Byte2
	cast(Byte1, i2) = type<Byte1>(2)
end sub

private sub ctor() constructor
	fbcu.add_suite("tests/structs/derived_cast")
	fbcu.add_test("upcasting derived UDT vars", @test)
	fbcu.add_test("derived lvalue cast + anon assign", @testDerivedLvalueCast)
end sub

end namespace
