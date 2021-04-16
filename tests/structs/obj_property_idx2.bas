#include "fbcunit.bi"

SUITE( fbc_tests.structs.obj_property_idx2 )

	type foo
		dim as string baa
		declare property bar(index as string)
		declare property bar() as string
	end type

	type foo2
		dim as foo ptr baa
		declare property bar(index as string) as foo ptr
	end type

	type foo3
		dim as foo2 ptr baa
		declare property bar(index as string) as foo2 ptr
	end type

	property foo3.bar(index as string) as foo2 ptr
		return this.baa
	end property

	property foo2.bar(index as string) as foo ptr
		return this.baa
	end property

	property foo.bar() as string
		return this.baa
	end property

	property foo.bar(index as string)
		this.baa = index
	end property

	TEST( all )
		var f = new foo
		var f2 = new foo2
		var f3 = new foo3
		
		f2->baa = f
		f3->baa = f2
		f3->bar("foo")->bar("bar")->bar = "hi"
		
		CU_ASSERT_EQUAL( f3->bar("foo")->bar("bar")->bar, "hi" )

		'' clean-up otherwise considered a memory leak
		delete f3
		delete f2
		delete f
	END_TEST
	
END_SUITE
