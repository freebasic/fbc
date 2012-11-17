# include "fbcu.bi"

namespace fbc_tests.structs.union_init

sub test1 cdecl( )
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
end sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

sub toplevel1 cdecl( )
	union UDT
		a as integer
	end union

	dim as UDT x = ( 1 )
	CU_ASSERT( x.a = 1 )
end sub

sub toplevel2 cdecl( )
	union UDT
		a as integer
		b as integer
	end union

	dim as UDT x = ( 1 )
	CU_ASSERT( x.a = 1 )
	CU_ASSERT( x.b = 1 )
end sub

sub toplevel3 cdecl( )
	union UDT
		type
			a as integer
		end type
	end union

	dim as UDT x = ( 1 )
	CU_ASSERT( x.a = 1 )
end sub

sub toplevel4 cdecl( )
	union UDT
		a as integer
		type
			b as integer
		end type
	end union

	dim as UDT x = ( 1 )
	CU_ASSERT( x.a = 1 )
	CU_ASSERT( x.b = 1 )
end sub

sub toplevel5 cdecl( )
	union UDT
		type
			a as integer
		end type
		b as integer
	end union

	dim as UDT x = ( 1 )
	CU_ASSERT( x.a = 1 )
	CU_ASSERT( x.b = 1 )
end sub

sub toplevel6 cdecl( )
	union UDT
		type
			a as integer
			b as integer
		end type
	end union

	dim as UDT x = ( 1, 2 )
	CU_ASSERT( x.a = 1 )
	CU_ASSERT( x.b = 2 )
end sub

sub toplevel7 cdecl( )
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
end sub

sub toplevel8 cdecl( )
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
end sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

sub nested11 cdecl( )
	type UDT
		union
			a as integer
		end union
	end type

	dim as UDT x = ( 1 )
	CU_ASSERT( x.a = 1 )
end sub

sub nested12 cdecl( )
	type UDT
		a as integer
		union
			b as integer
		end union
	end type

	dim as UDT x = ( 1, 2 )
	CU_ASSERT( x.a = 1 )
	CU_ASSERT( x.b = 2 )
end sub

sub nested13 cdecl( )
	type UDT
		union
			a as integer
		end union
		b as integer
	end type

	dim as UDT x = ( 1, 2 )
	CU_ASSERT( x.a = 1 )
	CU_ASSERT( x.b = 2 )
end sub

sub nested14 cdecl( )
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
end sub

sub nested15 cdecl( )
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
end sub

sub nested16 cdecl( )
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
end sub

sub nested17 cdecl( )
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
end sub

sub nested21 cdecl( )
	type UDT
		union
			a as integer
			b as integer
		end union
	end type

	dim as UDT x = ( 1 )
	CU_ASSERT( x.a = 1 )
	CU_ASSERT( x.b = 1 )
end sub

sub nested22 cdecl( )
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
end sub

sub nested23 cdecl( )
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
end sub

sub nested24 cdecl( )
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
end sub

sub nested25 cdecl( )
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
end sub

sub nested26 cdecl( )
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
end sub

sub nested27 cdecl( )
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
end sub

sub nested31 cdecl( )
	type UDT
		union
			type
				a as integer
			end type
		end union
	end type

	dim as UDT x = ( 1 )
	CU_ASSERT( x.a = 1 )
end sub

sub nested32 cdecl( )
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
end sub

sub nested33 cdecl( )
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
end sub

sub nested34 cdecl( )
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
end sub

sub nested35 cdecl( )
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
end sub

sub nested36 cdecl( )
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
end sub

sub nested37 cdecl( )
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
end sub

sub nested41 cdecl( )
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
end sub

sub nested42 cdecl( )
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
end sub

sub nested43 cdecl( )
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
end sub

sub nested44 cdecl( )
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
end sub

sub nested45 cdecl( )
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
end sub

sub nested46 cdecl( )
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
end sub

sub nested47 cdecl( )
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
end sub

sub nested51 cdecl( )
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
end sub

sub nested52 cdecl( )
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
end sub

sub nested53 cdecl( )
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
end sub

sub nested54 cdecl( )
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
end sub

sub nested55 cdecl( )
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
end sub

sub nested56 cdecl( )
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
end sub

sub nested57 cdecl( )
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
end sub

sub nested61 cdecl( )
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
end sub

sub nested62 cdecl( )
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
end sub

sub nested63 cdecl( )
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
end sub

sub nested64 cdecl( )
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
end sub

sub nested65 cdecl( )
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
end sub

sub nested66 cdecl( )
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
end sub

sub nested67 cdecl( )
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
end sub

sub nested71 cdecl( )
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
end sub

sub nested72 cdecl( )
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
end sub

sub nested73 cdecl( )
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
end sub

sub nested74 cdecl( )
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
end sub

sub nested75 cdecl( )
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
end sub

sub nested76 cdecl( )
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
end sub

sub nested77 cdecl( )
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
end sub

sub nested81 cdecl( )
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
end sub

sub nested82 cdecl( )
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
end sub

sub nested83 cdecl( )
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
end sub

sub nested84 cdecl( )
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
end sub

sub nested85 cdecl( )
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
end sub

sub nested86 cdecl( )
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
end sub

sub nested87 cdecl( )
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
end sub

sub nested91 cdecl( )
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
end sub

sub nested92 cdecl( )
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
end sub

sub nested93 cdecl( )
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
end sub

sub nested94 cdecl( )
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
end sub

sub nested95 cdecl( )
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
end sub

sub nested96 cdecl( )
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
end sub

sub nested97 cdecl( )
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
end sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

sub field11 cdecl( )
	union UDT1
		a as integer
	end union

	type UDT2
		a as UDT1
	end type

	dim as UDT2 x = ( 1 )
	CU_ASSERT( x.a.a = 1 )
end sub

sub field12 cdecl( )
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
end sub

sub field13 cdecl( )
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
end sub

sub field14 cdecl( )
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
end sub

sub field15 cdecl( )
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
end sub

sub field21 cdecl( )
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
end sub

sub field22 cdecl( )
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
end sub

sub field23 cdecl( )
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
end sub

sub field24 cdecl( )
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
end sub

sub field25 cdecl( )
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
end sub

sub field31 cdecl( )
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
end sub

sub field32 cdecl( )
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
end sub

sub field33 cdecl( )
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
end sub

sub field34 cdecl( )
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
end sub

sub field35 cdecl( )
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
end sub

sub field41 cdecl( )
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
end sub

sub field42 cdecl( )
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
end sub

sub field43 cdecl( )
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
end sub

sub field44 cdecl( )
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
end sub

sub field45 cdecl( )
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
end sub

sub field51 cdecl( )
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
end sub

sub field52 cdecl( )
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
end sub

sub field53 cdecl( )
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
end sub

sub field54 cdecl( )
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
end sub

sub field55 cdecl( )
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
end sub

sub field61 cdecl( )
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
end sub

sub field62 cdecl( )
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
end sub

sub field63 cdecl( )
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
end sub

sub field64 cdecl( )
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
end sub

sub field65 cdecl( )
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
end sub

sub field71 cdecl( )
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
end sub

sub field72 cdecl( )
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
end sub

sub field73 cdecl( )
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
end sub

sub field74 cdecl( )
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
end sub

sub field75 cdecl( )
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
end sub

sub field81 cdecl( )
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
end sub

sub field82 cdecl( )
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
end sub

sub field83 cdecl( )
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
end sub

sub field84 cdecl( )
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
end sub

sub field85 cdecl( )
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
end sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

sub derived11 cdecl( )
	union UDT1
		a as integer
	end union

	type UDT2 extends UDT1
	end type

	dim as UDT2 x = ( 1 )
	CU_ASSERT( x.a = 1 )
end sub

sub derived12 cdecl( )
	union UDT1
		a as integer
	end union

	type UDT2 extends UDT1
		b as integer
	end type

	dim as UDT2 x = ( 1, 2 )
	CU_ASSERT( x.a = 1 )
	CU_ASSERT( x.b = 2 )
end sub

sub derived13 cdecl( )
	union UDT1
		a as integer
	end union

	type UDT2 extends UDT1
		b as UDT1
	end type

	dim as UDT2 x = ( 1, 2 )
	CU_ASSERT( x.a = 1 )
	CU_ASSERT( x.b.a = 2 )
end sub

sub derived21 cdecl( )
	union UDT1
		a as integer
		b as integer
	end union

	type UDT2 extends UDT1
	end type

	dim as UDT2 x = ( 1 )
	CU_ASSERT( x.a = 1 )
	CU_ASSERT( x.b = 1 )
end sub

sub derived22 cdecl( )
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
end sub

sub derived23 cdecl( )
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
end sub

sub derived31 cdecl( )
	union UDT1
		type
			a as integer
		end type
	end union

	type UDT2 extends UDT1
	end type

	dim as UDT2 x = ( 1 )
	CU_ASSERT( x.a = 1 )
end sub

sub derived32 cdecl( )
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
end sub

sub derived33 cdecl( )
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
end sub

sub derived41 cdecl( )
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
end sub

sub derived42 cdecl( )
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
end sub

sub derived43 cdecl( )
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
end sub

sub derived51 cdecl( )
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
end sub

sub derived52 cdecl( )
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
end sub

sub derived53 cdecl( )
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
end sub

sub derived61 cdecl( )
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
end sub

sub derived62 cdecl( )
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
end sub

sub derived63 cdecl( )
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
end sub

sub derived71 cdecl( )
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
end sub

sub derived72 cdecl( )
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
end sub

sub derived73 cdecl( )
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
end sub

sub derived81 cdecl( )
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
end sub

sub derived82 cdecl( )
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
end sub

sub derived83 cdecl( )
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
end sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

private sub testGenGccAnonUnion cdecl( )
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
end sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

private sub ctor( ) constructor
	fbcu.add_suite( "tests/structs/union-init" )
	fbcu.add_test( "test1", @test1 )
	fbcu.add_test( "toplevel1", @toplevel1 )
	fbcu.add_test( "toplevel2", @toplevel2 )
	fbcu.add_test( "toplevel3", @toplevel3 )
	fbcu.add_test( "toplevel4", @toplevel4 )
	fbcu.add_test( "toplevel5", @toplevel5 )
	fbcu.add_test( "toplevel6", @toplevel6 )
	fbcu.add_test( "toplevel7", @toplevel7 )
	fbcu.add_test( "toplevel8", @toplevel8 )
	fbcu.add_test( "nested11", @nested11 )
	fbcu.add_test( "nested12", @nested12 )
	fbcu.add_test( "nested13", @nested13 )
	fbcu.add_test( "nested14", @nested14 )
	fbcu.add_test( "nested15", @nested15 )
	fbcu.add_test( "nested16", @nested16 )
	fbcu.add_test( "nested17", @nested17 )
	fbcu.add_test( "nested21", @nested21 )
	fbcu.add_test( "nested22", @nested22 )
	fbcu.add_test( "nested23", @nested23 )
	fbcu.add_test( "nested24", @nested24 )
	fbcu.add_test( "nested25", @nested25 )
	fbcu.add_test( "nested26", @nested26 )
	fbcu.add_test( "nested27", @nested27 )
	fbcu.add_test( "nested31", @nested31 )
	fbcu.add_test( "nested32", @nested32 )
	fbcu.add_test( "nested33", @nested33 )
	fbcu.add_test( "nested34", @nested34 )
	fbcu.add_test( "nested35", @nested35 )
	fbcu.add_test( "nested36", @nested36 )
	fbcu.add_test( "nested37", @nested37 )
	fbcu.add_test( "nested41", @nested41 )
	fbcu.add_test( "nested42", @nested42 )
	fbcu.add_test( "nested43", @nested43 )
	fbcu.add_test( "nested44", @nested44 )
	fbcu.add_test( "nested45", @nested45 )
	fbcu.add_test( "nested46", @nested46 )
	fbcu.add_test( "nested47", @nested47 )
	fbcu.add_test( "nested51", @nested51 )
	fbcu.add_test( "nested52", @nested52 )
	fbcu.add_test( "nested53", @nested53 )
	fbcu.add_test( "nested54", @nested54 )
	fbcu.add_test( "nested55", @nested55 )
	fbcu.add_test( "nested56", @nested56 )
	fbcu.add_test( "nested57", @nested57 )
	fbcu.add_test( "nested61", @nested61 )
	fbcu.add_test( "nested62", @nested62 )
	fbcu.add_test( "nested63", @nested63 )
	fbcu.add_test( "nested64", @nested64 )
	fbcu.add_test( "nested65", @nested65 )
	fbcu.add_test( "nested66", @nested66 )
	fbcu.add_test( "nested67", @nested67 )
	fbcu.add_test( "nested71", @nested71 )
	fbcu.add_test( "nested72", @nested72 )
	fbcu.add_test( "nested73", @nested73 )
	fbcu.add_test( "nested74", @nested74 )
	fbcu.add_test( "nested75", @nested75 )
	fbcu.add_test( "nested76", @nested76 )
	fbcu.add_test( "nested77", @nested77 )
	fbcu.add_test( "nested81", @nested81 )
	fbcu.add_test( "nested82", @nested82 )
	fbcu.add_test( "nested83", @nested83 )
	fbcu.add_test( "nested84", @nested84 )
	fbcu.add_test( "nested85", @nested85 )
	fbcu.add_test( "nested86", @nested86 )
	fbcu.add_test( "nested87", @nested87 )
	fbcu.add_test( "nested91", @nested91 )
	fbcu.add_test( "nested92", @nested92 )
	fbcu.add_test( "nested93", @nested93 )
	fbcu.add_test( "nested94", @nested94 )
	fbcu.add_test( "nested95", @nested95 )
	fbcu.add_test( "nested96", @nested96 )
	fbcu.add_test( "nested97", @nested97 )
	fbcu.add_test( "field11", @field11 )
	fbcu.add_test( "field12", @field12 )
	fbcu.add_test( "field13", @field13 )
	fbcu.add_test( "field14", @field14 )
	fbcu.add_test( "field15", @field15 )
	fbcu.add_test( "field21", @field21 )
	fbcu.add_test( "field22", @field22 )
	fbcu.add_test( "field23", @field23 )
	fbcu.add_test( "field24", @field24 )
	fbcu.add_test( "field25", @field25 )
	fbcu.add_test( "field31", @field31 )
	fbcu.add_test( "field32", @field32 )
	fbcu.add_test( "field33", @field33 )
	fbcu.add_test( "field34", @field34 )
	fbcu.add_test( "field35", @field35 )
	fbcu.add_test( "field41", @field41 )
	fbcu.add_test( "field42", @field42 )
	fbcu.add_test( "field43", @field43 )
	fbcu.add_test( "field44", @field44 )
	fbcu.add_test( "field45", @field45 )
	fbcu.add_test( "field51", @field51 )
	fbcu.add_test( "field52", @field52 )
	fbcu.add_test( "field53", @field53 )
	fbcu.add_test( "field54", @field54 )
	fbcu.add_test( "field55", @field55 )
	fbcu.add_test( "field61", @field61 )
	fbcu.add_test( "field62", @field62 )
	fbcu.add_test( "field63", @field63 )
	fbcu.add_test( "field64", @field64 )
	fbcu.add_test( "field65", @field65 )
	fbcu.add_test( "field71", @field71 )
	fbcu.add_test( "field72", @field72 )
	fbcu.add_test( "field73", @field73 )
	fbcu.add_test( "field74", @field74 )
	fbcu.add_test( "field75", @field75 )
	fbcu.add_test( "field81", @field81 )
	fbcu.add_test( "field82", @field82 )
	fbcu.add_test( "field83", @field83 )
	fbcu.add_test( "field84", @field84 )
	fbcu.add_test( "field85", @field85 )
	fbcu.add_test( "derived11", @derived11 )
	fbcu.add_test( "derived12", @derived12 )
	fbcu.add_test( "derived13", @derived13 )
	fbcu.add_test( "derived21", @derived21 )
	fbcu.add_test( "derived22", @derived22 )
	fbcu.add_test( "derived23", @derived23 )
	fbcu.add_test( "derived31", @derived31 )
	fbcu.add_test( "derived32", @derived32 )
	fbcu.add_test( "derived33", @derived33 )
	fbcu.add_test( "derived41", @derived41 )
	fbcu.add_test( "derived42", @derived42 )
	fbcu.add_test( "derived43", @derived43 )
	fbcu.add_test( "derived51", @derived51 )
	fbcu.add_test( "derived52", @derived52 )
	fbcu.add_test( "derived53", @derived53 )
	fbcu.add_test( "derived61", @derived61 )
	fbcu.add_test( "derived62", @derived62 )
	fbcu.add_test( "derived63", @derived63 )
	fbcu.add_test( "derived71", @derived71 )
	fbcu.add_test( "derived72", @derived72 )
	fbcu.add_test( "derived73", @derived73 )
	fbcu.add_test( "derived81", @derived81 )
	fbcu.add_test( "derived82", @derived82 )
	fbcu.add_test( "derived83", @derived83 )
	fbcu.add_test( "-gen gcc anonymous union", @testGenGccAnonUnion )
end sub

end namespace
