'' See:
''   extern-class.bi
''   extern-class.bas
''   extern-class-test.bas

namespace extern_class

	type T1
		as integer i
		declare constructor( byval as integer )
	end type

	type T2
		as integer i
		declare constructor( )
	end type

	extern as T1 global1
	extern as T1 fixarray1(0 to 1)

	extern as T2 global2
	extern as T2 fixarray2(0 to 1)

end namespace


