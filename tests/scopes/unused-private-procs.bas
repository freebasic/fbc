' TEST_MODE : COMPILE_AND_RUN_OK

''
'' C backend regression test
''
'' Local vars (including temp vars) should not be emitted in any way when the
'' surrounding proc is ignored which can happen with unused PRIVATE procs.
''
'' Both unused PRIVATEs have a scoped local var called "i" which both were
'' falsely emitted by the C backend, without any surrounding proc bodies,
'' causing them to end up in global scope and conflicting due to the differing
'' types, causing gcc to show an error.
''
'' "Unfortunately" the C backend today emits each var with a unique name,
'' so this breakage isn't easily visible anymore. I.e. it doesn't trigger
'' compile-time gcc errors anymore, and since such vars will be emitted
'' without initializer, gcc will treat them as COMMONs, thus there won't even
'' be duplicate definitions at link-time.
''

dim shared s as string
dim shared c as integer

private sub f1( )
	scope
		dim i as zstring ptr
		dim j as zstring ptr = @"1"
		select case( s )
		case "foo"
			s = "bar"
		end select
		print iif( c, 1, 2 )
	end scope
end sub

private sub f2( )
	scope
		dim i as integer
		dim j as integer = 1
		select case( s )
		case "foo"
			s = "bar"
		end select
		print iif( c, 1, 2 )
	end scope
end sub

''
'' Similar case for STATIC vars, with and without dtors
''

type UDT3
	dummy as integer
	declare destructor( )
end type

destructor UDT3( )
end destructor

private sub f3( )
	static i as integer
	static x3 as UDT3
	scope
		static x3 as UDT3
		scope
			static x3 as UDT3
			scope
				static i as double
				static x3 as double
			end scope
		end scope
		static y3 as UDT3
	end scope
	static y3 as UDT3
end sub
