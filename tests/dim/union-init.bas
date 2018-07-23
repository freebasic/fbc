# include "fbcunit.bi"

SUITE( fbc_tests.dim_.union_init )

	TEST( basicUnion )
		type UDT
			as integer a
			union
				as integer i
				as double d
			end union
			as integer c
		end type

		dim as UDT x = ( 1, 2, 3 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.i = 2 )
		CU_ASSERT( abs(x.d - 9.881312916824931e-324) < .0001 )
		CU_ASSERT( x.c = 3 )
	END_TEST

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	TEST( toplevel1 )
		union UDT
			a as integer
		end union

		dim as UDT x = ( 1 )
		CU_ASSERT( x.a = 1 )
	END_TEST

	TEST( toplevel2 )
		union UDT
			a as integer
			b as integer
		end union

		dim as UDT x = ( 1 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
	END_TEST

	TEST( toplevel3 )
		union UDT
			type
				a as integer
			end type
		end union

		dim as UDT x = ( 1 )
		CU_ASSERT( x.a = 1 )
	END_TEST

	TEST( toplevel4 )
		union UDT
			a as integer
			type
				b as integer
			end type
		end union

		dim as UDT x = ( 1 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
	END_TEST

	TEST( toplevel5 )
		union UDT
			type
				a as integer
			end type
			b as integer
		end union

		dim as UDT x = ( 1 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
	END_TEST

	TEST( toplevel6 )
		union UDT
			type
				a as integer
				b as integer
			end type
		end union

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
	END_TEST

	TEST( toplevel7 )
		union UDT
			a as integer
			type
				b as integer
				c as integer
			end type
		end union

		dim as UDT x = ( 1 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
		CU_ASSERT( x.c = 0 )
	END_TEST

	TEST( toplevel8 )
		union UDT
			type
				a as integer
				b as integer
			end type
			c as integer
		end union

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 1 )
	END_TEST

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	TEST( nested11 )
		type UDT
			union
				a as integer
			end union
		end type

		dim as UDT x = ( 1 )
		CU_ASSERT( x.a = 1 )
	END_TEST

	TEST( nested12 )
		type UDT
			a as integer
			union
				b as integer
			end union
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
	END_TEST

	TEST( nested13 )
		type UDT
			union
				a as integer
			end union
			b as integer
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
	END_TEST

	TEST( nested14 )
		type UDT
			a as integer
			union
				b as integer
			end union
			c as integer
		end type

		dim as UDT x = ( 1, 2, 3 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 3 )
	END_TEST

	TEST( nested15 )
		type UDT
			union
				a as integer
			end union
			union
				b as integer
			end union
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
	END_TEST

	TEST( nested16 )
		type UDT
			union
				type
					a as integer
				end type
			end union
			union
				b as integer
			end union
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
	END_TEST

	TEST( nested17 )
		type UDT
			union
				a as integer
			end union
			union
				type
					b as integer
				end type
			end union
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
	END_TEST

	TEST( nested21 )
		type UDT
			union
				a as integer
				b as integer
			end union
		end type

		dim as UDT x = ( 1 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
	END_TEST

	TEST( nested22 )
		type UDT
			a as integer
			union
				b as integer
				c as integer
			end union
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 2 )
	END_TEST

	TEST( nested23 )
		type UDT
			union
				a as integer
				b as integer
			end union
			c as integer
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
		CU_ASSERT( x.c = 2 )
	END_TEST

	TEST( nested24 )
		type UDT
			a as integer
			union
				b as integer
				c as integer
			end union
			d as integer
		end type

		dim as UDT x = ( 1, 2, 3 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 2 )
		CU_ASSERT( x.d = 3 )
	END_TEST

	TEST( nested25 )
		type UDT
			union
				a as integer
				b as integer
			end union
			union
				c as integer
				d as integer
			end union
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
		CU_ASSERT( x.c = 2 )
		CU_ASSERT( x.d = 2 )
	END_TEST

	TEST( nested26 )
		type UDT
			union
				type
					a as integer
					b as integer
				end type
			end union
			union
				c as integer
				d as integer
			end union
		end type

		dim as UDT x = ( 1, 2, 3 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 3 )
		CU_ASSERT( x.d = 3 )
	END_TEST

	TEST( nested27 )
		type UDT
			union
				a as integer
				b as integer
			end union
			union
				type
					c as integer
					d as integer
				end type
			end union
		end type

		dim as UDT x = ( 1, 2, 3 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
		CU_ASSERT( x.c = 2 )
		CU_ASSERT( x.d = 3 )
	END_TEST

	TEST( nested31 )
		type UDT
			union
				type
					a as integer
				end type
			end union
		end type

		dim as UDT x = ( 1 )
		CU_ASSERT( x.a = 1 )
	END_TEST

	TEST( nested32 )
		type UDT
			a as integer
			union
				type
					b as integer
				end type
			end union
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
	END_TEST

	TEST( nested33 )
		type UDT
			union
				type
					a as integer
				end type
			end union
			b as integer
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
	END_TEST

	TEST( nested34 )
		type UDT
			a as integer
			union
				type
					b as integer
				end type
			end union
			c as integer
		end type

		dim as UDT x = ( 1, 2, 3 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 3 )
	END_TEST

	TEST( nested35 )
		type UDT
			union
				type
					a as integer
				end type
			end union
			union
				type
					b as integer
				end type
			end union
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
	END_TEST

	TEST( nested36 )
		type UDT
			union
				type
					union
						type
							a as integer
						end type
					end union
				end type
			end union
			union
				type
					b as integer
				end type
			end union
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
	END_TEST

	TEST( nested37 )
		type UDT
			union
				type
					a as integer
				end type
			end union
			union
				type
					union
						type
							b as integer
						end type
					end union
				end type
			end union
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
	END_TEST

	TEST( nested41 )
		type UDT
			union
				a as integer
				type
					b as integer
				end type
			end union
		end type

		dim as UDT x = ( 1 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
	END_TEST

	TEST( nested42 )
		type UDT
			a as integer
			union
				b as integer
				type
					c as integer
				end type
			end union
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 2 )
	END_TEST

	TEST( nested43 )
		type UDT
			union
				a as integer
				type
					b as integer
				end type
			end union
			c as integer
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
		CU_ASSERT( x.c = 2 )
	END_TEST

	TEST( nested44 )
		type UDT
			a as integer
			union
				b as integer
				type
					c as integer
				end type
			end union
			d as integer
		end type

		dim as UDT x = ( 1, 2, 3 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 2 )
		CU_ASSERT( x.d = 3 )
	END_TEST

	TEST( nested45 )
		type UDT
			union
				a as integer
				type
					b as integer
				end type
			end union
			union
				c as integer
				type
					d as integer
				end type
			end union
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
		CU_ASSERT( x.c = 2 )
		CU_ASSERT( x.d = 2 )
	END_TEST

	TEST( nested46 )
		type UDT
			union
				type
					union
						a as integer
						type
							b as integer
						end type
					end union
				end type
			end union
			union
				c as integer
				type
					d as integer
				end type
			end union
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
		CU_ASSERT( x.c = 2 )
		CU_ASSERT( x.d = 2 )
	END_TEST

	TEST( nested47 )
		type UDT
			union
				a as integer
				type
					b as integer
				end type
			end union
			union
				type
					union
						c as integer
						type
							d as integer
						end type
					end union
				end type
			end union
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
		CU_ASSERT( x.c = 2 )
		CU_ASSERT( x.d = 2 )
	END_TEST

	TEST( nested51 )
		type UDT
			union
				type
					a as integer
				end type
				b as integer
			end union
		end type

		dim as UDT x = ( 1 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
	END_TEST

	TEST( nested52 )
		type UDT
			a as integer
			union
				type
					b as integer
				end type
				c as integer
			end union
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 2 )
	END_TEST

	TEST( nested53 )
		type UDT
			union
				type
					a as integer
				end type
				b as integer
			end union
			c as integer
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
		CU_ASSERT( x.c = 2 )
	END_TEST

	TEST( nested54 )
		type UDT
			a as integer
			union
				type
					b as integer
				end type
				c as integer
			end union
			d as integer
		end type

		dim as UDT x = ( 1, 2, 3 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 2 )
		CU_ASSERT( x.d = 3 )
	END_TEST

	TEST( nested55 )
		type UDT
			union
				type
					a as integer
				end type
				b as integer
			end union
			union
				type
					c as integer
				end type
				d as integer
			end union
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
		CU_ASSERT( x.c = 2 )
		CU_ASSERT( x.d = 2 )
	END_TEST

	TEST( nested56 )
		type UDT
			union
				type
					union
						type
							a as integer
						end type
						b as integer
					end union
				end type
			end union
			union
				type
					c as integer
				end type
				d as integer
			end union
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
		CU_ASSERT( x.c = 2 )
		CU_ASSERT( x.d = 2 )
	END_TEST

	TEST( nested57 )
		type UDT
			union
				type
					a as integer
				end type
				b as integer
			end union
			union
				type
					union
						type
							c as integer
						end type
						d as integer
					end union
				end type
			end union
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
		CU_ASSERT( x.c = 2 )
		CU_ASSERT( x.d = 2 )
	END_TEST

	TEST( nested61 )
		type UDT
			union
				type
					a as integer
					b as integer
				end type
			end union
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
	END_TEST

	TEST( nested62 )
		type UDT
			a as integer
			union
				type
					b as integer
					c as integer
				end type
			end union
		end type

		dim as UDT x = ( 1, 2, 3 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 3 )
	END_TEST

	TEST( nested63 )
		type UDT
			union
				type
					a as integer
					b as integer
				end type
			end union
			c as integer
		end type

		dim as UDT x = ( 1, 2, 3 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 3 )
	END_TEST

	TEST( nested64 )
		type UDT
			a as integer
			union
				type
					b as integer
					c as integer
				end type
			end union
			d as integer
		end type

		dim as UDT x = ( 1, 2, 3, 4 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 3 )
		CU_ASSERT( x.d = 4 )
	END_TEST

	TEST( nested65 )
		type UDT
			union
				type
					a as integer
					b as integer
				end type
			end union
			union
				type
					c as integer
					d as integer
				end type
			end union
		end type

		dim as UDT x = ( 1, 2, 3, 4 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 3 )
		CU_ASSERT( x.d = 4 )
	END_TEST

	TEST( nested66 )
		type UDT
			union
				type
					union
						type
							a as integer
							b as integer
						end type
					end union
				end type
			end union
			union
				type
					c as integer
					d as integer
				end type
			end union
		end type

		dim as UDT x = ( 1, 2, 3, 4 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 3 )
		CU_ASSERT( x.d = 4 )
	END_TEST

	TEST( nested67 )
		type UDT
			union
				type
					a as integer
					b as integer
				end type
			end union
			union
				type
					union
						type
							c as integer
							d as integer
						end type
					end union
				end type
			end union
		end type

		dim as UDT x = ( 1, 2, 3, 4 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 3 )
		CU_ASSERT( x.d = 4 )
	END_TEST

	TEST( nested71 )
		type UDT
			union
				a as integer
				type
					b as integer
					c as integer
				end type
			end union
		end type

		dim as UDT x = ( 1 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
		CU_ASSERT( x.c = 0 )
	END_TEST

	TEST( nested72 )
		type UDT
			a as integer
			union
				b as integer
				type
					c as integer
					d as integer
				end type
			end union
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 2 )
		CU_ASSERT( x.d = 0 )
	END_TEST

	TEST( nested73 )
		type UDT
			union
				a as integer
				type
					b as integer
					c as integer
				end type
			end union
			d as integer
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
		CU_ASSERT( x.c = 0 )
		CU_ASSERT( x.d = 2 )
	END_TEST

	TEST( nested74 )
		type UDT
			a as integer
			union
				b as integer
				type
					c as integer
					d as integer
				end type
			end union
			e as integer
		end type

		dim as UDT x = ( 1, 2, 3 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 2 )
		CU_ASSERT( x.d = 0 )
		CU_ASSERT( x.e = 3 )
	END_TEST

	TEST( nested75 )
		type UDT
			union
				a as integer
				type
					b as integer
					c as integer
				end type
			end union
			union
				d as integer
				type
					e as integer
					f as integer
				end type
			end union
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
		CU_ASSERT( x.c = 0 )
		CU_ASSERT( x.d = 2 )
		CU_ASSERT( x.e = 2 )
		CU_ASSERT( x.f = 0 )
	END_TEST

	TEST( nested76 )
		type UDT
			union
				type
					union
						a as integer
						type
							b as integer
							c as integer
						end type
					end union
				end type
			end union
			union
				d as integer
				type
					e as integer
					f as integer
				end type
			end union
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
		CU_ASSERT( x.c = 0 )
		CU_ASSERT( x.d = 2 )
		CU_ASSERT( x.e = 2 )
		CU_ASSERT( x.f = 0 )
	END_TEST

	TEST( nested77 )
		type UDT
			union
				a as integer
				type
					b as integer
					c as integer
				end type
			end union
			union
				type
					union
						d as integer
						type
							e as integer
							f as integer
						end type
					end union
				end type
			end union
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
		CU_ASSERT( x.c = 0 )
		CU_ASSERT( x.d = 2 )
		CU_ASSERT( x.e = 2 )
		CU_ASSERT( x.f = 0 )
	END_TEST

	TEST( nested81 )
		type UDT
			union
				type
					a as integer
					b as integer
				end type
				c as integer
			end union
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 1 )
	END_TEST

	TEST( nested82 )
		type UDT
			a as integer
			union
				type
					b as integer
					c as integer
				end type
				d as integer
			end union
		end type

		dim as UDT x = ( 1, 2, 3 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 3 )
		CU_ASSERT( x.d = 2 )
	END_TEST

	TEST( nested83 )
		type UDT
			union
				type
					a as integer
					b as integer
				end type
				c as integer
			end union
			d as integer
		end type

		dim as UDT x = ( 1, 2, 3 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 1 )
		CU_ASSERT( x.d = 3 )
	END_TEST

	TEST( nested84 )
		type UDT
			a as integer
			union
				type
					b as integer
					c as integer
				end type
				d as integer
			end union
			e as integer
		end type

		dim as UDT x = ( 1, 2, 3, 4 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 3 )
		CU_ASSERT( x.d = 2 )
		CU_ASSERT( x.e = 4 )
	END_TEST

	TEST( nested85 )
		type UDT
			union
				type
					a as integer
					b as integer
				end type
				c as integer
			end union
			union
				type
					d as integer
					e as integer
				end type
				f as integer
			end union
		end type

		dim as UDT x = ( 1, 2, 3, 4 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 1 )
		CU_ASSERT( x.d = 3 )
		CU_ASSERT( x.e = 4 )
		CU_ASSERT( x.f = 3 )
	END_TEST

	TEST( nested86 )
		type UDT
			union
				type
					union
						type
							a as integer
							b as integer
						end type
						c as integer
					end union
				end type
			end union
			union
				type
					d as integer
					e as integer
				end type
				f as integer
			end union
		end type

		dim as UDT x = ( 1, 2, 3, 4 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 1 )
		CU_ASSERT( x.d = 3 )
		CU_ASSERT( x.e = 4 )
		CU_ASSERT( x.f = 3 )
	END_TEST

	TEST( nested87 )
		type UDT
			union
				type
					a as integer
					b as integer
				end type
				c as integer
			end union
			union
				type
					union
						type
							d as integer
							e as integer
						end type
						f as integer
					end union
				end type
			end union
		end type

		dim as UDT x = ( 1, 2, 3, 4 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 1 )
		CU_ASSERT( x.d = 3 )
		CU_ASSERT( x.e = 4 )
		CU_ASSERT( x.f = 3 )
	END_TEST

	TEST( nested91 )
		type UDT
			union
				type
					a as integer
					b as integer
				end type
				type
					c as integer
					d as integer
				end type
			end union
		end type

		dim as UDT x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 1 )
		CU_ASSERT( x.d = 2 )
	END_TEST

	TEST( nested92 )
		type UDT
			a as integer
			union
				type
					b as integer
					c as integer
				end type
				type
					d as integer
					e as integer
				end type
			end union
		end type

		dim as UDT x = ( 1, 2, 3 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 3 )
		CU_ASSERT( x.d = 2 )
		CU_ASSERT( x.e = 3 )
	END_TEST

	TEST( nested93 )
		type UDT
			union
				type
					a as integer
					b as integer
				end type
				type
					c as integer
					d as integer
				end type
			end union
			e as integer
		end type

		dim as UDT x = ( 1, 2, 3 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 1 )
		CU_ASSERT( x.d = 2 )
		CU_ASSERT( x.e = 3 )
	END_TEST

	TEST( nested94 )
		type UDT
			a as integer
			union
				type
					b as integer
					c as integer
				end type
				type
					d as integer
					e as integer
				end type
			end union
			f as integer
		end type

		dim as UDT x = ( 1, 2, 3, 4 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 3 )
		CU_ASSERT( x.d = 2 )
		CU_ASSERT( x.e = 3 )
		CU_ASSERT( x.f = 4 )
	END_TEST

	TEST( nested95 )
		type UDT
			union
				type
					a as integer
					b as integer
				end type
				type
					c as integer
					d as integer
				end type
			end union
			union
				type
					e as integer
					f as integer
				end type
				type
					g as integer
					h as integer
				end type
			end union
		end type

		dim as UDT x = ( 1, 2, 3, 4 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 1 )
		CU_ASSERT( x.d = 2 )
		CU_ASSERT( x.e = 3 )
		CU_ASSERT( x.f = 4 )
		CU_ASSERT( x.g = 3 )
		CU_ASSERT( x.h = 4 )
	END_TEST

	TEST( nested96 )
		type UDT
			union
				type
					union
						type
							a as integer
							b as integer
						end type
						type
							c as integer
							d as integer
						end type
					end union
				end type
			end union
			union
				type
					e as integer
					f as integer
				end type
				type
					g as integer
					h as integer
				end type
			end union
		end type

		dim as UDT x = ( 1, 2, 3, 4 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 1 )
		CU_ASSERT( x.d = 2 )
		CU_ASSERT( x.e = 3 )
		CU_ASSERT( x.f = 4 )
		CU_ASSERT( x.g = 3 )
		CU_ASSERT( x.h = 4 )
	END_TEST

	TEST( nested97 )
		type UDT
			union
				type
					a as integer
					b as integer
				end type
				type
					c as integer
					d as integer
				end type
			end union
			union
				type
					union
						type
							e as integer
							f as integer
						end type
						type
							g as integer
							h as integer
						end type
					end union
				end type
			end union
		end type

		dim as UDT x = ( 1, 2, 3, 4 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 1 )
		CU_ASSERT( x.d = 2 )
		CU_ASSERT( x.e = 3 )
		CU_ASSERT( x.f = 4 )
		CU_ASSERT( x.g = 3 )
		CU_ASSERT( x.h = 4 )
	END_TEST

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	TEST( field11 )
		union UDT1
			a as integer
		end union

		type UDT2
			a as UDT1
		end type

		dim as UDT2 x = ( 1 )
		CU_ASSERT( x.a.a = 1 )
	END_TEST

	TEST( field12 )
		union UDT1
			a as integer
		end union

		type UDT2
			a as integer
			b as UDT1
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b.a = 2 )
	END_TEST

	TEST( field13 )
		union UDT1
			a as integer
		end union

		type UDT2
			a as UDT1
			b as integer
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a.a = 1 )
		CU_ASSERT( x.b = 2 )
	END_TEST

	TEST( field14 )
		union UDT1
			a as integer
		end union

		type UDT2
			a as integer
			b as UDT1
			c as integer
		end type

		dim as UDT2 x = ( 1, 2, 3 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b.a = 2 )
		CU_ASSERT( x.c = 3 )
	END_TEST

	TEST( field15 )
		union UDT1
			a as integer
		end union

		type UDT2
			a as UDT1
			b as UDT1
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a.a = 1 )
		CU_ASSERT( x.b.a = 2 )
	END_TEST

	TEST( field21 )
		union UDT1
			a as integer
			b as integer
		end union

		type UDT2
			a as UDT1
		end type

		dim as UDT2 x = ( 1 )
		CU_ASSERT( x.a.a = 1 )
		CU_ASSERT( x.a.b = 1 )
	END_TEST

	TEST( field22 )
		union UDT1
			a as integer
			b as integer
		end union

		type UDT2
			a as integer
			b as UDT1
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b.a = 2 )
		CU_ASSERT( x.b.b = 2 )
	END_TEST

	TEST( field23 )
		union UDT1
			a as integer
			b as integer
		end union

		type UDT2
			a as UDT1
			b as integer
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a.a = 1 )
		CU_ASSERT( x.a.b = 1 )
		CU_ASSERT( x.b = 2 )
	END_TEST

	TEST( field24 )
		union UDT1
			a as integer
			b as integer
		end union

		type UDT2
			a as integer
			b as UDT1
			c as integer
		end type

		dim as UDT2 x = ( 1, 2, 3 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b.a = 2 )
		CU_ASSERT( x.b.b = 2 )
		CU_ASSERT( x.c = 3 )
	END_TEST

	TEST( field25 )
		union UDT1
			a as integer
			b as integer
		end union

		type UDT2
			a as UDT1
			b as UDT1
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a.a = 1 )
		CU_ASSERT( x.a.b = 1 )
		CU_ASSERT( x.b.a = 2 )
		CU_ASSERT( x.b.b = 2 )
	END_TEST

	TEST( field31 )
		union UDT1
			type
				a as integer
			end type
		end union

		type UDT2
			a as UDT1
		end type

		dim as UDT2 x = ( 1 )
		CU_ASSERT( x.a.a = 1 )
	END_TEST

	TEST( field32 )
		union UDT1
			type
				a as integer
			end type
		end union

		type UDT2
			a as integer
			b as UDT1
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b.a = 2 )
	END_TEST

	TEST( field33 )
		union UDT1
			type
				a as integer
			end type
		end union

		type UDT2
			a as UDT1
			b as integer
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a.a = 1 )
		CU_ASSERT( x.b = 2 )
	END_TEST

	TEST( field34 )
		union UDT1
			type
				a as integer
			end type
		end union

		type UDT2
			a as integer
			b as UDT1
			c as integer
		end type

		dim as UDT2 x = ( 1, 2, 3 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b.a = 2 )
		CU_ASSERT( x.c = 3 )
	END_TEST

	TEST( field35 )
		union UDT1
			type
				a as integer
			end type
		end union

		type UDT2
			a as UDT1
			b as UDT1
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a.a = 1 )
		CU_ASSERT( x.b.a = 2 )
	END_TEST

	TEST( field41 )
		union UDT1
			a as integer
			type
				b as integer
			end type
		end union

		type UDT2
			a as UDT1
		end type

		dim as UDT2 x = ( 1 )
		CU_ASSERT( x.a.a = 1 )
		CU_ASSERT( x.a.b = 1 )
	END_TEST

	TEST( field42 )
		union UDT1
			a as integer
			type
				b as integer
			end type
		end union

		type UDT2
			a as integer
			b as UDT1
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b.a = 2 )
		CU_ASSERT( x.b.b = 2 )
	END_TEST

	TEST( field43 )
		union UDT1
			a as integer
			type
				b as integer
			end type
		end union

		type UDT2
			a as UDT1
			b as integer
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a.a = 1 )
		CU_ASSERT( x.a.b = 1 )
		CU_ASSERT( x.b = 2 )
	END_TEST

	TEST( field44 )
		union UDT1
			a as integer
			type
				b as integer
			end type
		end union

		type UDT2
			a as integer
			b as UDT1
			c as integer
		end type

		dim as UDT2 x = ( 1, 2, 3 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b.a = 2 )
		CU_ASSERT( x.b.b = 2 )
		CU_ASSERT( x.c = 3 )
	END_TEST

	TEST( field45 )
		union UDT1
			a as integer
			type
				b as integer
			end type
		end union

		type UDT2
			a as UDT1
			b as UDT1
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a.a = 1 )
		CU_ASSERT( x.b.a = 2 )
	END_TEST

	TEST( field51 )
		union UDT1
			type
				a as integer
			end type
			b as integer
		end union

		type UDT2
			a as UDT1
		end type

		dim as UDT2 x = ( 1 )
		CU_ASSERT( x.a.a = 1 )
		CU_ASSERT( x.a.b = 1 )
	END_TEST

	TEST( field52 )
		union UDT1
			type
				a as integer
			end type
			b as integer
		end union

		type UDT2
			a as integer
			b as UDT1
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b.a = 2 )
	END_TEST

	TEST( field53 )
		union UDT1
			type
				a as integer
			end type
			b as integer
		end union

		type UDT2
			a as UDT1
			b as integer
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a.a = 1 )
		CU_ASSERT( x.b = 2 )
	END_TEST

	TEST( field54 )
		union UDT1
			type
				a as integer
			end type
			b as integer
		end union

		type UDT2
			a as integer
			b as UDT1
			c as integer
		end type

		dim as UDT2 x = ( 1, 2, 3 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b.a = 2 )
		CU_ASSERT( x.c = 3 )
	END_TEST

	TEST( field55 )
		union UDT1
			type
				a as integer
			end type
			b as integer
		end union

		type UDT2
			a as UDT1
			b as UDT1
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a.a = 1 )
		CU_ASSERT( x.b.a = 2 )
	END_TEST

	TEST( field61 )
		union UDT1
			type
				a as integer
				b as integer
			end type
		end union

		type UDT2
			a as UDT1
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a.a = 1 )
		CU_ASSERT( x.a.b = 2 )
	END_TEST

	TEST( field62 )
		union UDT1
			type
				a as integer
				b as integer
			end type
		end union

		type UDT2
			a as integer
			b as UDT1
		end type

		dim as UDT2 x = ( 1, 2, 3 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b.a = 2 )
		CU_ASSERT( x.b.b = 3 )
	END_TEST

	TEST( field63 )
		union UDT1
			type
				a as integer
				b as integer
			end type
		end union

		type UDT2
			a as UDT1
			b as integer
		end type

		dim as UDT2 x = ( 1, 2, 3 )
		CU_ASSERT( x.a.a = 1 )
		CU_ASSERT( x.a.b = 2 )
		CU_ASSERT( x.b = 3 )
	END_TEST

	TEST( field64 )
		union UDT1
			type
				a as integer
				b as integer
			end type
		end union

		type UDT2
			a as integer
			b as UDT1
			c as integer
		end type

		dim as UDT2 x = ( 1, 2, 3, 4 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b.a = 2 )
		CU_ASSERT( x.b.b = 3 )
		CU_ASSERT( x.c = 4 )
	END_TEST

	TEST( field65 )
		union UDT1
			type
				a as integer
				b as integer
			end type
		end union

		type UDT2
			a as UDT1
			b as UDT1
		end type

		dim as UDT2 x = ( 1, 2, 3, 4 )
		CU_ASSERT( x.a.a = 1 )
		CU_ASSERT( x.a.b = 2 )
		CU_ASSERT( x.b.a = 3 )
		CU_ASSERT( x.b.b = 4 )
	END_TEST

	TEST( field71 )
		union UDT1
			a as integer
			type
				b as integer
				c as integer
			end type
		end union

		type UDT2
			a as UDT1
		end type

		dim as UDT2 x = ( 1 )
		CU_ASSERT( x.a.a = 1 )
		CU_ASSERT( x.a.b = 1 )
		CU_ASSERT( x.a.c = 0 )
	END_TEST

	TEST( field72 )
		union UDT1
			a as integer
			type
				b as integer
				c as integer
			end type
		end union

		type UDT2
			a as integer
			b as UDT1
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b.a = 2 )
		CU_ASSERT( x.b.b = 2 )
		CU_ASSERT( x.b.c = 0 )
	END_TEST

	TEST( field73 )
		union UDT1
			a as integer
			type
				b as integer
				c as integer
			end type
		end union

		type UDT2
			a as UDT1
			b as integer
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a.a = 1 )
		CU_ASSERT( x.a.b = 1 )
		CU_ASSERT( x.a.c = 0 )
		CU_ASSERT( x.b = 2 )
	END_TEST

	TEST( field74 )
		union UDT1
			a as integer
			type
				b as integer
				c as integer
			end type
		end union

		type UDT2
			a as integer
			b as UDT1
			c as integer
		end type

		dim as UDT2 x = ( 1, 2, 3 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b.a = 2 )
		CU_ASSERT( x.b.b = 2 )
		CU_ASSERT( x.b.c = 0 )
		CU_ASSERT( x.c = 3 )
	END_TEST

	TEST( field75 )
		union UDT1
			a as integer
			type
				b as integer
				c as integer
			end type
		end union

		type UDT2
			a as UDT1
			b as UDT1
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a.a = 1 )
		CU_ASSERT( x.a.b = 1 )
		CU_ASSERT( x.a.c = 0 )
		CU_ASSERT( x.b.a = 2 )
		CU_ASSERT( x.b.b = 2 )
		CU_ASSERT( x.b.c = 0 )
	END_TEST

	TEST( field81 )
		union UDT1
			type
				a as integer
				b as integer
			end type
			c as integer
		end union

		type UDT2
			a as UDT1
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a.a = 1 )
		CU_ASSERT( x.a.b = 2 )
		CU_ASSERT( x.a.c = 1 )
	END_TEST

	TEST( field82 )
		union UDT1
			type
				a as integer
				b as integer
			end type
			c as integer
		end union

		type UDT2
			a as integer
			b as UDT1
		end type

		dim as UDT2 x = ( 1, 2, 3 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b.a = 2 )
		CU_ASSERT( x.b.b = 3 )
		CU_ASSERT( x.b.c = 2 )
	END_TEST

	TEST( field83 )
		union UDT1
			type
				a as integer
				b as integer
			end type
			c as integer
		end union

		type UDT2
			a as UDT1
			b as integer
		end type

		dim as UDT2 x = ( 1, 2, 3 )
		CU_ASSERT( x.a.a = 1 )
		CU_ASSERT( x.a.b = 2 )
		CU_ASSERT( x.a.c = 1 )
		CU_ASSERT( x.b = 3 )
	END_TEST

	TEST( field84 )
		union UDT1
			type
				a as integer
				b as integer
			end type
			c as integer
		end union

		type UDT2
			a as integer
			b as UDT1
			c as integer
		end type

		dim as UDT2 x = ( 1, 2, 3, 4 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b.a = 2 )
		CU_ASSERT( x.b.b = 3 )
		CU_ASSERT( x.b.c = 2 )
		CU_ASSERT( x.c = 4 )
	END_TEST

	TEST( field85 )
		union UDT1
			type
				a as integer
				b as integer
			end type
			c as integer
		end union

		type UDT2
			a as UDT1
			b as UDT1
		end type

		dim as UDT2 x = ( 1, 2, 3, 4 )
		CU_ASSERT( x.a.a = 1 )
		CU_ASSERT( x.a.b = 2 )
		CU_ASSERT( x.a.c = 1 )
		CU_ASSERT( x.b.a = 3 )
		CU_ASSERT( x.b.b = 4 )
		CU_ASSERT( x.b.c = 3 )
	END_TEST

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	TEST( derived11 )
		union UDT1
			a as integer
		end union

		type UDT2 extends UDT1
		end type

		dim as UDT2 x = ( 1 )
		CU_ASSERT( x.a = 1 )
	END_TEST

	TEST( derived12 )
		union UDT1
			a as integer
		end union

		type UDT2 extends UDT1
			b as integer
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
	END_TEST

	TEST( derived13 )
		union UDT1
			a as integer
		end union

		type UDT2 extends UDT1
			b as UDT1
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b.a = 2 )
	END_TEST

	TEST( derived21 )
		union UDT1
			a as integer
			b as integer
		end union

		type UDT2 extends UDT1
		end type

		dim as UDT2 x = ( 1 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
	END_TEST

	TEST( derived22 )
		union UDT1
			a as integer
			b as integer
		end union

		type UDT2 extends UDT1
			c as integer
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
		CU_ASSERT( x.c = 2 )
	END_TEST

	TEST( derived23 )
		union UDT1
			a as integer
			b as integer
		end union

		type UDT2 extends UDT1
			c as UDT1
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
		CU_ASSERT( x.c.a = 2 )
		CU_ASSERT( x.c.b = 2 )
	END_TEST

	TEST( derived31 )
		union UDT1
			type
				a as integer
			end type
		end union

		type UDT2 extends UDT1
		end type

		dim as UDT2 x = ( 1 )
		CU_ASSERT( x.a = 1 )
	END_TEST

	TEST( derived32 )
		union UDT1
			type
				a as integer
			end type
		end union

		type UDT2 extends UDT1
			b as integer
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
	END_TEST

	TEST( derived33 )
		union UDT1
			type
				a as integer
			end type
		end union

		type UDT2 extends UDT1
			b as UDT1
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b.a = 2 )
	END_TEST

	TEST( derived41 )
		union UDT1
			a as integer
			type
				b as integer
			end type
		end union

		type UDT2 extends UDT1
		end type

		dim as UDT2 x = ( 1 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
	END_TEST

	TEST( derived42 )
		union UDT1
			a as integer
			type
				b as integer
			end type
		end union

		type UDT2 extends UDT1
			c as integer
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
		CU_ASSERT( x.c = 2 )
	END_TEST

	TEST( derived43 )
		union UDT1
			a as integer
			type
				b as integer
			end type
		end union

		type UDT2 extends UDT1
			c as UDT1
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
		CU_ASSERT( x.c.a = 2 )
		CU_ASSERT( x.c.b = 2 )
	END_TEST

	TEST( derived51 )
		union UDT1
			type
				a as integer
			end type
			b as integer
		end union

		type UDT2 extends UDT1
		end type

		dim as UDT2 x = ( 1 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
	END_TEST

	TEST( derived52 )
		union UDT1
			type
				a as integer
			end type
			b as integer
		end union

		type UDT2 extends UDT1
			c as integer
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
		CU_ASSERT( x.c = 2 )
	END_TEST

	TEST( derived53 )
		union UDT1
			type
				a as integer
			end type
			b as integer
		end union

		type UDT2 extends UDT1
			c as UDT1
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
		CU_ASSERT( x.c.a = 2 )
		CU_ASSERT( x.c.b = 2 )
	END_TEST

	TEST( derived61 )
		union UDT1
			type
				a as integer
				b as integer
			end type
		end union

		type UDT2 extends UDT1
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
	END_TEST

	TEST( derived62 )
		union UDT1
			type
				a as integer
				b as integer
			end type
		end union

		type UDT2 extends UDT1
			c as integer
		end type

		dim as UDT2 x = ( 1, 2, 3 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 3 )
	END_TEST

	TEST( derived63 )
		union UDT1
			type
				a as integer
				b as integer
			end type
		end union

		type UDT2 extends UDT1
			c as UDT1
		end type

		dim as UDT2 x = ( 1, 2, 3, 4 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c.a = 3 )
		CU_ASSERT( x.c.b = 4 )
	END_TEST

	TEST( derived71 )
		union UDT1
			a as integer
			type
				b as integer
				c as integer
			end type
		end union

		type UDT2 extends UDT1
		end type

		dim as UDT2 x = ( 1 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
		CU_ASSERT( x.c = 0 )
	END_TEST

	TEST( derived72 )
		union UDT1
			a as integer
			type
				b as integer
				c as integer
			end type
		end union

		type UDT2 extends UDT1
			d as integer
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
		CU_ASSERT( x.c = 0 )
		CU_ASSERT( x.d = 2 )
	END_TEST

	TEST( derived73 )
		union UDT1
			a as integer
			type
				b as integer
				c as integer
			end type
		end union

		type UDT2 extends UDT1
			d as UDT1
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 1 )
		CU_ASSERT( x.c = 0 )
		CU_ASSERT( x.d.a = 2 )
		CU_ASSERT( x.d.b = 2 )
		CU_ASSERT( x.d.c = 0 )
	END_TEST

	TEST( derived81 )
		union UDT1
			type
				a as integer
				b as integer
			end type
			c as integer
		end union

		type UDT2 extends UDT1
		end type

		dim as UDT2 x = ( 1, 2 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 1 )
	END_TEST

	TEST( derived82 )
		union UDT1
			type
				a as integer
				b as integer
			end type
			c as integer
		end union

		type UDT2 extends UDT1
			d as integer
		end type

		dim as UDT2 x = ( 1, 2, 3 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 1 )
		CU_ASSERT( x.d = 3 )
	END_TEST

	TEST( derived83 )
		union UDT1
			type
				a as integer
				b as integer
			end type
			c as integer
		end union

		type UDT2 extends UDT1
			d as UDT1
		end type

		dim as UDT2 x = ( 1, 2, 3, 4 )
		CU_ASSERT( x.a = 1 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 1 )
		CU_ASSERT( x.d.a = 3 )
		CU_ASSERT( x.d.b = 4 )
		CU_ASSERT( x.d.c = 3 )
	END_TEST

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	TEST( genGccAnonUnion )
		'' -gen gcc regression test: it should properly emit the nested
		'' anonymous type, to ensure the variable on stack will be 12 bytes
		'' (a union of 4 and 12), not just 4 bytes (a union of 4*4).

		union UDT
			a as integer
			type
				b as integer
				c as integer
				d as integer
			end type
		end union

		dim a as integer = 111
		dim x as UDT
		dim b as integer = 222

		CU_ASSERT( a = 111 )
		CU_ASSERT( x.a = 0 )
		CU_ASSERT( x.b = 0 )
		CU_ASSERT( x.c = 0 )
		CU_ASSERT( x.d = 0 )
		CU_ASSERT( b = 222 )

		'' this should not trash other variables on the stack
		x.a = 1
		x.b = 2
		x.c = 3
		x.d = 4

		CU_ASSERT( a = 111 )
		CU_ASSERT( x.a = 2 )
		CU_ASSERT( x.b = 2 )
		CU_ASSERT( x.c = 3 )
		CU_ASSERT( x.d = 4 )
		CU_ASSERT( b = 222 )
	END_TEST

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

END_SUITE
