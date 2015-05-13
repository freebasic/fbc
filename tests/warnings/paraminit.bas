type PodUdt
	as integer a, b
end type

type DefCtorUdt
	i as integer
	declare constructor()
end type

constructor DefCtorUdt()
end constructor

type CtorUdt
	i as integer
	declare constructor(as integer)
end type

constructor CtorUdt(i as integer)
end constructor

type ParentUdt1 extends object
	i as integer
	declare constructor(as integer)
end type

constructor ParentUdt1(i as integer)
end constructor

type ParentUdt2 extends object
	i as integer
	declare constructor(as integer)
end type

constructor ParentUdt2(i as integer)
end constructor

dim shared as integer a, b, c
dim shared podudtx as PodUdt
dim shared as integer array1(0 to 2), array2(0 to 2)

sub f1()
end sub

function f2(a as integer = 0) as integer
	function = 1
end function

function f3(a as integer) as integer
	function = 1
end function

function f4() as integer
	function = 1
end function

sub f5()
end sub

function f6() as integer
	function = 1
end function

#print "no warning:"
declare	sub test01(n as integer ptr = @a)
	sub test01(n as integer ptr = @a) : end sub

#print "no warning:"
declare	sub test02(n as any ptr = @f1)
	sub test02(n as any ptr = @f1) : end sub

#print "no warning:"
declare	sub test03(n as PodUdt = type(1, 2))
	sub test03(n as PodUdt = type(1, 2)) : end sub

#print "no warning:"
declare	sub test04(n as integer = a + b)
	sub test04(n as integer = a + b) : end sub

#print "no warning:"
declare	sub test05(n as integer = a + 1)
	sub test05(n as integer = a + 1) : end sub

#print "no warning:"
declare	sub test06(n as integer = f2())
	sub test06(n as integer = f2(0))
	end sub

#print "no warning:"
declare	sub test07(n as integer = f2(0))
	sub test07(n as integer = f2()) : end sub

#print "no warning:"
declare	sub test08(n as integer = f3(0))
	sub test08(n as integer = f3(0)) : end sub

#print "no warning:"
declare	sub test09(n as integer = f4())
	sub test09(n as integer = f4()) : end sub

#print "no warning:"
declare	sub test10(n as integer = f3(1))
	sub test10(n as integer = f3(1)) : end sub

#print "no warning:"
declare	sub test11(n as integer = 1)
	sub test11(n as integer = 1) : end sub

#print "no warning:"
declare	sub test12(x as CtorUdt = CtorUdt(0))
	sub test12(x as CtorUdt = CtorUdt(0)) : end sub

#print "no warning:"
declare	sub test13(i as integer = podudtx.a)
	sub test13(i as integer = podudtx.a) : end sub

#print "no warning:"
declare	sub test14(n as integer = array1(1))
	sub test14(n as integer = array1(1)) : end sub

#print "no warning:"
declare	sub test15(n as integer = iif(a, b, c))
	sub test15(n as integer = iif(a, b, c)) : end sub

#print "no warning:"
declare	sub test16(n as integer ptr = new integer)
	sub test16(n as integer ptr = new integer) : end sub

#print "no warning:"
declare	sub test17(n as DefCtorUdt ptr = new DefCtorUdt)
	sub test17(n as DefCtorUdt ptr = new DefCtorUdt) : end sub

#print "no warning:"
declare	sub test18(n as integer ptr = new integer[10])
	sub test18(n as integer ptr = new integer[10]) : end sub

#print "no warning:"
declare	sub test19(n as DefCtorUdt ptr = new DefCtorUdt[10])
	sub test19(n as DefCtorUdt ptr = new DefCtorUdt[10]) : end sub

#print "no warning:"
declare	sub test20(n as string = "a")
	sub test20(n as string = "a") : end sub

#print "no warning:"
declare	sub test21(n as integer = not a)
	sub test21(n as integer = not a) : end sub

#print "no warning:"
declare	sub test22(n as integer = a)
	sub test22(n as integer = a) : end sub

#print "mismatch addrof var:"
declare	sub test23(n as integer ptr = @a)
	sub test23(n as integer ptr = @b) : end sub

#print "mismatch addrof proc:"
declare	sub test24(n as any ptr = @f1)
	sub test24(n as any ptr = @f5) : end sub

#print "mismatch anon type:"
declare	sub test25(n as PodUdt = type(1, 2))
	sub test25(n as PodUdt = type(1, 3)) : end sub

#print "mismatch anon type:"
declare	sub test26(n as PodUdt = type(1, 2))
	sub test26(n as PodUdt = type(2, 2)) : end sub

#print "mismatch bop:"
declare	sub test27(n as integer = a + b)
	sub test27(n as integer = a - b) : end sub

#print "mismatch const:"
declare	sub test28(n as integer = a + 1)
	sub test28(n as integer = a + 2) : end sub

#print "mismatch call:"
declare	sub test29(n as integer = f4())
	sub test29(n as integer = f6()) : end sub

#print "mismatch arg:"
declare	sub test30(n as integer = f2())
	sub test30(n as integer = f2(1)) : end sub

#print "mismatch arg:"
declare	sub test31(n as integer = f3(1))
	sub test31(n as integer = f3(2)) : end sub

#print "mismatch const:"
declare	sub test32(n as integer = 1)
	sub test32(n as integer = 2) : end sub

#print "mismatch ctorcall:"
declare	sub test33(x as object = ParentUdt1(0))
	sub test33(x as object = ParentUdt2(0)) : end sub

#print "mismatch field:"
declare	sub test34(i as integer = podudtx.a)
	sub test34(i as integer = podudtx.b) : end sub

#print "mismatch array:"
declare	sub test35(n as integer = array1(0))
	sub test35(n as integer = array2(0)) : end sub

#print "mismatch idx:"
declare	sub test36(n as integer = array1(1))
	sub test36(n as integer = array1(2)) : end sub

#print "mismatch iif:"
declare	sub test37(n as integer = iif(a, b, c))
	sub test37(n as integer = iif(c, b, a)) : end sub

#print "mismatch const:"
declare	sub test38(n as integer ptr = new integer(1))
	sub test38(n as integer ptr = new integer(2)) : end sub

#print "mismatch const:"
declare	sub test39(n as CtorUdt ptr = new CtorUdt(1))
	sub test39(n as CtorUdt ptr = new CtorUdt(2)) : end sub

#print "mismatch const:"
declare	sub test40(n as integer ptr = new integer[10])
	sub test40(n as integer ptr = new integer[20]) : end sub

#print "mismatch const:"
declare	sub test41(n as DefCtorUdt ptr = new DefCtorUdt[10])
	sub test41(n as DefCtorUdt ptr = new DefCtorUdt[20]) : end sub

#print "mismatch string:"
declare	sub test42(n as string = "a")
	sub test42(n as string = "b") : end sub

#print "mismatch string:"
declare	sub test43(n as string = "a")
	sub test43(n as string = "aa") : end sub

#print "mismatch string:"
declare	sub test44(n as string = "aa")
	sub test44(n as string = "a") : end sub

#print "mismatch uop:"
declare	sub test45(n as integer = not a)
	sub test45(n as integer = -a) : end sub

#print "mismatch var:"
declare	sub test46(n as integer = a)
	sub test46(n as integer = b) : end sub
