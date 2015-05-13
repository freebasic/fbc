# include "fbcu.bi"

namespace fbc_tests.structs.padding

	type S8 field=8
		as ubyte b0
		as ushort a0
		as ubyte b1
		as function( ) as uinteger a1
		as uinteger a2
		as uinteger b3
		as double a3
		as ubyte b4
	end type
	
	type S4 field=4
		as ubyte b0
		as ushort a0
		as ubyte b1
		as function( ) as uinteger a1
		as uinteger a2
		as uinteger b3
		as double a3
		as ubyte b4
	end type
	
	type S2 field=2
		as ubyte b0
		as ushort a0
		as ubyte b1
		as function( ) as uinteger a1
		as uinteger a2
		as uinteger b3
		as double a3
		as ubyte b4
	end type
	
	type S1 field=1
		as ubyte b0
		as ushort a0
		as ubyte b1
		as function( ) as uinteger a1
		as uinteger a2
		as uinteger b3
		as double a3
		as ubyte b4
	end type
	
	type S
		as ubyte b0
		as ushort a0
		as ubyte b1
		as function( ) as uinteger a1
		as uinteger a2
		as uinteger b3
		as double a3
		as ubyte b4
	end type

sub test_size1 cdecl ()

	const UNPADLEN = sizeof(ubyte) + sizeof(ushort) + sizeof(ubyte) + sizeof(any ptr) + sizeof(uinteger) * 2 + sizeof(double) + sizeof(ubyte)	
	
	CU_ASSERT_EQUAL( sizeof(S1), UNPADLEN )
	CU_ASSERT_EQUAL( sizeof(S2), UNPADLEN + 3 )
	CU_ASSERT_EQUAL( sizeof(S4), UNPADLEN + 7 )
	#ifdef __FB_WIN32__
		CU_ASSERT_EQUAL( sizeof(S8), UNPADLEN + 15 )
		CU_ASSERT_EQUAL( sizeof(S) , UNPADLEN + 15 )
	#else
		CU_ASSERT_EQUAL( sizeof(S8), UNPADLEN + 7 )
		CU_ASSERT_EQUAL( sizeof(S) , UNPADLEN + 7 )
	#endif
end sub

sub test_size2 cdecl ()
	type _S1 field=1
		as ubyte b1
		as ushort s1
		as ushort s2
	end type

	type _S2 field=2
		as ubyte b1
		as ushort s1
		as ushort s2
	end type

	type _S
		as ubyte b1
		as ushort s1
		as ushort s2
	end type
	
	const UNPADLEN = sizeof(ubyte) + sizeof(ushort) * 2
	
	CU_ASSERT_EQUAL( sizeof(_S1), UNPADLEN )
	CU_ASSERT_EQUAL( sizeof(_S2), UNPADLEN + 1 )
	CU_ASSERT_EQUAL( sizeof(_S), UNPADLEN + 1 )

end sub

sub testDefaultNoPadding cdecl()
	#macro make(T)
		'' Simple:

		type A_##T
			as T x
		end type

		CU_ASSERT(sizeof(A_##T) = sizeof(T))

		type B_##T
			as T x
			as T y
		end type

		CU_ASSERT(sizeof(B_##T) = sizeof(T) * 2)
		CU_ASSERT(offsetof(B_##T, y) = sizeof(T))

		'' Nested UDTs:

		type C_##T
			as A_##T a
			as T x
		end type

		CU_ASSERT(sizeof(C_##T) = sizeof(T) * 2)
		CU_ASSERT(offsetof(C_##T, x) = sizeof(T))

		type D_##T
			as T x
			as A_##T a
		end type

		CU_ASSERT(sizeof(D_##T) = sizeof(T) * 2)
		CU_ASSERT(offsetof(D_##T, a) = sizeof(T))

		type E_##T
			as T x
			as A_##T a
			as T y
		end type

		CU_ASSERT(sizeof(E_##T) = sizeof(T) * 3)
		CU_ASSERT(offsetof(E_##T, a) = sizeof(T))
		CU_ASSERT(offsetof(E_##T, y) = sizeof(T) * 2)
	#endmacro

	make(byte)
	make(short)
	make(integer)
	make(single)
	make(longint)
	make(double)
end sub

sub testDefaultPad2 cdecl()
	'' Simple:

	type A
		as byte b
		as short s
	end type
	CU_ASSERT(sizeof(A) = 4)
	CU_ASSERT(offsetof(A, s) = 2)

	type B
		as short s
		as byte b
	end type
	CU_ASSERT(sizeof(B) = 4)
	CU_ASSERT(offsetof(B, b) = 2)

	'' ---
	'' Now with nested UDT.
	'' As with gcc, the UDT tail padding should be calculated /in/ into
	'' the alignment of the following field. This /must/ be done to ensure
	'' sizeof(Parent.field-as-Child) = sizeof(Child), otherwise
	''    memset(@Parent.field-as-Child, FOO, sizeof(Child))
	'' would overwrite following fields.

	type C
		as A a
		as byte b
	end type
	CU_ASSERT(sizeof(C) = 6)
	CU_ASSERT(offsetof(C, b) = 4)

	type D
		as B b___
		as byte b
	end type
	CU_ASSERT(sizeof(D) = 6)
	CU_ASSERT(offsetof(D, b) = 4)

	type E
		as A a
		as short s
	end type
	CU_ASSERT(sizeof(E) = 6)
	CU_ASSERT(offsetof(E, s) = 4)

	type F
		as B b___
		as short s
	end type
	CU_ASSERT(sizeof(F) = 6)
	CU_ASSERT(offsetof(F, s) = 4)

	'' ---
	'' Now the same but with the UDT field at the end

	type G
		as byte b
		as A a
	end type
	CU_ASSERT(sizeof(G) = 6)
	CU_ASSERT(offsetof(G, a) = 2)

	type H
		as byte b
		as B b___
	end type
	CU_ASSERT(sizeof(H) = 6)
	CU_ASSERT(offsetof(H, b___) = 2)

	type I
		as short s
		as A a
	end type
	CU_ASSERT(sizeof(I) = 6)
	CU_ASSERT(offsetof(I, a) = 2)

	type J
		as short s
		as B b___
	end type
	CU_ASSERT(sizeof(J) = 6)
	CU_ASSERT(offsetof(J, b___) = 2)
end sub

sub testDefaultPad4 cdecl()
	'' Simple:

	type A
		as short s
		as integer i
	end type
	CU_ASSERT(sizeof(A) = 8)
	CU_ASSERT(offsetof(A, i) = 4)

	type B
		as integer i
		as short s
	end type
	CU_ASSERT(sizeof(B) = 8)
	CU_ASSERT(offsetof(B, s) = 4)

	type C1
		as short s1
		as short s2
		as integer i
	end type
	CU_ASSERT(sizeof(C1) = 8)
	CU_ASSERT(offsetof(C1, s2) = 2)
	CU_ASSERT(offsetof(C1, i) = 4)

	type C2
		as integer i
		as short s1
		as short s2
	end type
	CU_ASSERT(sizeof(C2) = 8)
	CU_ASSERT(offsetof(C2, s1) = 4)
	CU_ASSERT(offsetof(C2, s2) = 6)

	type C3
		as short s1
		as integer i
		as short s2
	end type
	CU_ASSERT(sizeof(C3) = 12)
	CU_ASSERT(offsetof(C3, i) = 4)
	CU_ASSERT(offsetof(C3, s2) = 8)

	'' ---
	'' Now with nested UDT:

	type E1
		as A a
		as short s
	end type
	CU_ASSERT(sizeof(E1) = 12)
	CU_ASSERT(offsetof(E1, s) = 8)

	type E2
		as A a
		as integer i
	end type
	CU_ASSERT(sizeof(E2) = 12)
	CU_ASSERT(offsetof(E2, i) = 8)

	type E3
		as A a
		as short s1
		as short s2
	end type
	CU_ASSERT(sizeof(E3) = 12)
	CU_ASSERT(offsetof(E3, s1) = 8)
	CU_ASSERT(offsetof(E3, s2) = 10)

	type E4
		as A a
		as short s
		as integer i
	end type
	CU_ASSERT(sizeof(E4) = 16)
	CU_ASSERT(offsetof(E4, s) = 8)
	CU_ASSERT(offsetof(E4, i) = 12)

	type E5
		as A a
		as integer i
		as short s
	end type
	CU_ASSERT(sizeof(E5) = 16)
	CU_ASSERT(offsetof(E5, i) = 8)
	CU_ASSERT(offsetof(E5, s) = 12)

	type E6
		as A a
		as short s1
		as short s2
		as integer i
	end type
	CU_ASSERT(sizeof(E6) = 16)
	CU_ASSERT(offsetof(E6, s1) = 8)
	CU_ASSERT(offsetof(E6, s2) = 10)
	CU_ASSERT(offsetof(E6, i) = 12)

	type E7
		as A a
		as integer i
		as short s1
		as short s2
	end type
	CU_ASSERT(sizeof(E7) = 16)
	CU_ASSERT(offsetof(E7, i) = 8)
	CU_ASSERT(offsetof(E7, s1) = 12)
	CU_ASSERT(offsetof(E7, s2) = 14)

	type E8
		as A a
		as short s1
		as integer i
		as short s2
	end type
	CU_ASSERT(sizeof(E8) = 20)
	CU_ASSERT(offsetof(E8, s1) = 8)
	CU_ASSERT(offsetof(E8, i) = 12)
	CU_ASSERT(offsetof(E8, s2) = 16)

	'' ---
	'' Now the same, but with the UDT at the end

	type F1
		as short s
		as A a
	end type
	CU_ASSERT(sizeof(F1) = 12)
	CU_ASSERT(offsetof(F1, a) = 4)

	type F2
		as integer i
		as A a
	end type
	CU_ASSERT(sizeof(F2) = 12)
	CU_ASSERT(offsetof(F2, a) = 4)

	type F3
		as short s1
		as short s2
		as A a
	end type
	CU_ASSERT(sizeof(F3) = 12)
	CU_ASSERT(offsetof(F3, s2) = 2)
	CU_ASSERT(offsetof(F3, a) = 4)

	type F4
		as short s
		as integer i
		as A a
	end type
	CU_ASSERT(sizeof(F4) = 16)
	CU_ASSERT(offsetof(F4, i) = 4)
	CU_ASSERT(offsetof(F4, a) = 8)

	type F5
		as integer i
		as short s
		as A a
	end type
	CU_ASSERT(sizeof(F5) = 16)
	CU_ASSERT(offsetof(F5, s) = 4)
	CU_ASSERT(offsetof(F5, a) = 8)

	type F6
		as short s1
		as short s2
		as integer i
		as A a
	end type
	CU_ASSERT(sizeof(F6) = 16)
	CU_ASSERT(offsetof(F6, s2) = 2)
	CU_ASSERT(offsetof(F6, i) = 4)
	CU_ASSERT(offsetof(F6, a) = 8)

	type F7
		as integer i
		as short s1
		as short s2
		as A a
	end type
	CU_ASSERT(sizeof(F7) = 16)
	CU_ASSERT(offsetof(F7, s1) = 4)
	CU_ASSERT(offsetof(F7, s2) = 6)
	CU_ASSERT(offsetof(F7, a) = 8)

	type F8
		as short s1
		as integer i
		as short s2
		as A a
	end type
	CU_ASSERT(sizeof(F8) = 20)
	CU_ASSERT(offsetof(F8, i) = 4)
	CU_ASSERT(offsetof(F8, s2) = 8)
	CU_ASSERT(offsetof(F8, a) = 12)

	'' ---
	'' Now the same (both UDT at the begin and at the end), but with B
	'' instead of A (B has tail padding, A doesn't)

	'' B at the beginning

	type G1
		as B b
		as short s
	end type
	CU_ASSERT(sizeof(G1) = 12)
	CU_ASSERT(offsetof(G1, s) = 8)

	type G2
		as B b
		as integer i
	end type
	CU_ASSERT(sizeof(G2) = 12)
	CU_ASSERT(offsetof(G2, i) = 8)

	type G3
		as B b
		as short s1
		as short s2
	end type
	CU_ASSERT(sizeof(G3) = 12)
	CU_ASSERT(offsetof(G3, s1) = 8)
	CU_ASSERT(offsetof(G3, s2) = 10)

	type G4
		as B b
		as short s
		as integer i
	end type
	CU_ASSERT(sizeof(G4) = 16)
	CU_ASSERT(offsetof(G4, s) = 8)
	CU_ASSERT(offsetof(G4, i) = 12)

	type G5
		as B b
		as integer i
		as short s
	end type
	CU_ASSERT(sizeof(E5) = 16)
	CU_ASSERT(offsetof(E5, i) = 8)
	CU_ASSERT(offsetof(E5, s) = 12)

	type G6
		as B b
		as short s1
		as short s2
		as integer i
	end type
	CU_ASSERT(sizeof(G6) = 16)
	CU_ASSERT(offsetof(G6, s1) = 8)
	CU_ASSERT(offsetof(G6, s2) = 10)
	CU_ASSERT(offsetof(G6, i) = 12)

	type G7
		as B b
		as integer i
		as short s1
		as short s2
	end type
	CU_ASSERT(sizeof(G7) = 16)
	CU_ASSERT(offsetof(G7, i) = 8)
	CU_ASSERT(offsetof(G7, s1) = 12)
	CU_ASSERT(offsetof(G7, s2) = 14)

	type G8
		as B b
		as short s1
		as integer i
		as short s2
	end type
	CU_ASSERT(sizeof(G8) = 20)
	CU_ASSERT(offsetof(G8, s1) = 8)
	CU_ASSERT(offsetof(G8, i) = 12)
	CU_ASSERT(offsetof(G8, s2) = 16)

	'' ---
	'' B at the end

	type H1
		as short s
		as B b
	end type
	CU_ASSERT(sizeof(H1) = 12)
	CU_ASSERT(offsetof(H1, b) = 4)

	type H2
		as integer i
		as B b
	end type
	CU_ASSERT(sizeof(H2) = 12)
	CU_ASSERT(offsetof(H2, b) = 4)

	type H3
		as short s1
		as short s2
		as B b
	end type
	CU_ASSERT(sizeof(H3) = 12)
	CU_ASSERT(offsetof(H3, s2) = 2)
	CU_ASSERT(offsetof(H3, b) = 4)

	type H4
		as short s
		as integer i
		as B b
	end type
	CU_ASSERT(sizeof(H4) = 16)
	CU_ASSERT(offsetof(H4, i) = 4)
	CU_ASSERT(offsetof(H4, b) = 8)

	type H5
		as integer i
		as short s
		as B b
	end type
	CU_ASSERT(sizeof(H5) = 16)
	CU_ASSERT(offsetof(H5, s) = 4)
	CU_ASSERT(offsetof(H5, b) = 8)

	type H6
		as short s1
		as short s2
		as integer i
		as B b
	end type
	CU_ASSERT(sizeof(H6) = 16)
	CU_ASSERT(offsetof(H6, s2) = 2)
	CU_ASSERT(offsetof(H6, i) = 4)
	CU_ASSERT(offsetof(H6, b) = 8)

	type H7
		as integer i
		as short s1
		as short s2
		as B b
	end type
	CU_ASSERT(sizeof(H7) = 16)
	CU_ASSERT(offsetof(H7, s1) = 4)
	CU_ASSERT(offsetof(H7, s2) = 6)
	CU_ASSERT(offsetof(H7, b) = 8)

	type H8
		as short s1
		as integer i
		as short s2
		as B b
	end type
	CU_ASSERT(sizeof(H8) = 20)
	CU_ASSERT(offsetof(H8, i) = 4)
	CU_ASSERT(offsetof(H8, s2) = 8)
	CU_ASSERT(offsetof(H8, b) = 12)
end sub

sub testDefaultPad8 cdecl()

	'' On Win32/MinGW, doubles/longints are aligned to 8.
	'' On Linux and others, doubles/longints are aligned to 4.
	'' (This often results in tighter packing, and only few cases are
	'' the same as on MinGW)

	type A1
		as integer i
		as longint l
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(A1) = 16)
		CU_ASSERT(offsetof(A1, l) = 8)
	#else
		CU_ASSERT(sizeof(A1) = 12)
		CU_ASSERT(offsetof(A1, l) = 4)
	#endif

	type A2
		as longint l
		as integer i
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(A2) = 16)
	#else
		CU_ASSERT(sizeof(A2) = 12)
	#endif
	CU_ASSERT(offsetof(A2, i) = 8)

	type A3
		as integer i1
		as integer i2
		as longint l
	end type
	CU_ASSERT(sizeof(A3) = 16)
	CU_ASSERT(offsetof(A3, i2) = 4)
	CU_ASSERT(offsetof(A3, l) = 8)

	type A4
		as longint l
		as integer i1
		as integer i2
	end type
	CU_ASSERT(sizeof(A4) = 16)
	CU_ASSERT(offsetof(A4, i1) = 8)
	CU_ASSERT(offsetof(A4, i2) = 12)

	type A5
		as integer i1
		as longint l
		as integer i2
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(A5) = 24)
		CU_ASSERT(offsetof(A5, l) = 8)
		CU_ASSERT(offsetof(A5, i2) = 16)
	#else
		CU_ASSERT(sizeof(A5) = 16)
		CU_ASSERT(offsetof(A5, l) = 4)
		CU_ASSERT(offsetof(A5, i2) = 12)
	#endif

	'' ---
	'' Now with A1 at the beginning

	type B1
		as A1 a
		as integer i
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(B1) = 24)
		CU_ASSERT(offsetof(B1, i) = 16)
	#else
		CU_ASSERT(sizeof(B1) = 16)
		CU_ASSERT(offsetof(B1, i) = 12)
	#endif

	type B2
		as A1 a
		as integer i1
		as integer i2
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(B2) = 24)
		CU_ASSERT(offsetof(B2, i1) = 16)
		CU_ASSERT(offsetof(B2, i2) = 20)
	#else
		CU_ASSERT(sizeof(B2) = 20)
		CU_ASSERT(offsetof(B2, i1) = 12)
		CU_ASSERT(offsetof(B2, i2) = 16)
	#endif

	type B3
		as A1 a
		as longint l
		as integer i
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(B3) = 32)
		CU_ASSERT(offsetof(B3, l) = 16)
		CU_ASSERT(offsetof(B3, i) = 24)
	#else
		CU_ASSERT(sizeof(B3) = 24)
		CU_ASSERT(offsetof(B3, l) = 12)
		CU_ASSERT(offsetof(B3, i) = 20)
	#endif

	type B4
		as A1 a
		as integer i
		as longint l
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(B4) = 32)
		CU_ASSERT(offsetof(B4, i) = 16)
		CU_ASSERT(offsetof(B4, l) = 24)
	#else
		CU_ASSERT(sizeof(B4) = 24)
		CU_ASSERT(offsetof(B4, i) = 12)
		CU_ASSERT(offsetof(B4, l) = 16)
	#endif

	type B5
		as A1 a
		as integer i1
		as integer i2
		as longint l
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(B5) = 32)
		CU_ASSERT(offsetof(B5, i1) = 16)
		CU_ASSERT(offsetof(B5, i2) = 20)
		CU_ASSERT(offsetof(B5, l) = 24)
	#else
		CU_ASSERT(sizeof(B5) = 28)
		CU_ASSERT(offsetof(B5, i1) = 12)
		CU_ASSERT(offsetof(B5, i2) = 16)
		CU_ASSERT(offsetof(B5, l) = 20)
	#endif

	type B6
		as A1 a
		as longint l
		as integer i1
		as integer i2
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(B6) = 32)
		CU_ASSERT(offsetof(B6, l) = 16)
		CU_ASSERT(offsetof(B6, i1) = 24)
		CU_ASSERT(offsetof(B6, i2) = 28)
	#else
		CU_ASSERT(sizeof(B6) = 28)
		CU_ASSERT(offsetof(B6, l) = 12)
		CU_ASSERT(offsetof(B6, i1) = 20)
		CU_ASSERT(offsetof(B6, i2) = 24)
	#endif

	type B7
		as A1 a
		as integer i1
		as longint l
		as integer i2
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(B7) = 40)
		CU_ASSERT(offsetof(B7, i1) = 16)
		CU_ASSERT(offsetof(B7, l) = 24)
		CU_ASSERT(offsetof(B7, i2) = 32)
	#else
		CU_ASSERT(sizeof(B7) = 28)
		CU_ASSERT(offsetof(B7, i1) = 12)
		CU_ASSERT(offsetof(B7, l) = 16)
		CU_ASSERT(offsetof(B7, i2) = 24)
	#endif

	'' ---
	'' With A1 at the end

	type C1
		as integer i
		as A1 a
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(C1) = 24)
		CU_ASSERT(offsetof(C1, a) = 8)
	#else
		CU_ASSERT(sizeof(C1) = 16)
		CU_ASSERT(offsetof(C1, a) = 4)
	#endif

	type C2
		as integer i1
		as integer i2
		as A1 a
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(C2) = 24)
	#else
		CU_ASSERT(sizeof(C2) = 20)
	#endif
	CU_ASSERT(offsetof(C2, i2) = 4)
	CU_ASSERT(offsetof(C2, a) = 8)

	type C3
		as longint l
		as integer i
		as A1 a
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(C3) = 32)
		CU_ASSERT(offsetof(C3, i) = 8)
		CU_ASSERT(offsetof(C3, a) = 16)
	#else
		CU_ASSERT(sizeof(C3) = 24)
		CU_ASSERT(offsetof(C3, i) = 8)
		CU_ASSERT(offsetof(C3, a) = 12)
	#endif

	type C4
		as integer i
		as longint l
		as A1 a
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(C4) = 32)
		CU_ASSERT(offsetof(C4, l) = 8)
		CU_ASSERT(offsetof(C4, a) = 16)
	#else
		CU_ASSERT(sizeof(C4) = 24)
		CU_ASSERT(offsetof(C4, l) = 4)
		CU_ASSERT(offsetof(C4, a) = 12)
	#endif

	type C5
		as integer i1
		as integer i2
		as longint l
		as A1 a
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(C5) = 32)
	#else
		CU_ASSERT(sizeof(C5) = 28)
	#endif
	CU_ASSERT(offsetof(C5, i2) = 4)
	CU_ASSERT(offsetof(C5, l) = 8)
	CU_ASSERT(offsetof(C5, a) = 16)

	type C6
		as longint l
		as integer i1
		as integer i2
		as A1 a
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(C6) = 32)
	#else
		CU_ASSERT(sizeof(C6) = 28)
	#endif
	CU_ASSERT(offsetof(C6, i1) = 8)
	CU_ASSERT(offsetof(C6, i2) = 12)
	CU_ASSERT(offsetof(C6, a) = 16)

	type C7
		as integer i1
		as longint l
		as integer i2
		as A1 a
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(C7) = 40)
		CU_ASSERT(offsetof(C7, l) = 8)
		CU_ASSERT(offsetof(C7, i2) = 16)
		CU_ASSERT(offsetof(C7, a) = 24)
	#else
		CU_ASSERT(sizeof(C7) = 28)
		CU_ASSERT(offsetof(C7, l) = 4)
		CU_ASSERT(offsetof(C7, i2) = 12)
		CU_ASSERT(offsetof(C7, a) = 16)
	#endif

	'' ---
	'' Now with A2 at the beginning

	type D1
		as A2 a
		as integer i
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(D1) = 24)
		CU_ASSERT(offsetof(D1, i) = 16)
	#else
		CU_ASSERT(sizeof(D1) = 16)
		CU_ASSERT(offsetof(D1, i) = 12)
	#endif

	type D2
		as A2 a
		as integer i1
		as integer i2
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(D2) = 24)
		CU_ASSERT(offsetof(D2, i1) = 16)
		CU_ASSERT(offsetof(D2, i2) = 20)
	#else
		CU_ASSERT(sizeof(D2) = 20)
		CU_ASSERT(offsetof(D2, i1) = 12)
		CU_ASSERT(offsetof(D2, i2) = 16)
	#endif

	type D3
		as A2 a
		as longint l
		as integer i
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(D3) = 32)
		CU_ASSERT(offsetof(D3, l) = 16)
		CU_ASSERT(offsetof(D3, i) = 24)
	#else
		CU_ASSERT(sizeof(D3) = 24)
		CU_ASSERT(offsetof(D3, l) = 12)
		CU_ASSERT(offsetof(D3, i) = 20)
	#endif

	type D4
		as A2 a
		as integer i
		as longint l
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(D4) = 32)
		CU_ASSERT(offsetof(D4, i) = 16)
		CU_ASSERT(offsetof(D4, l) = 24)
	#else
		CU_ASSERT(sizeof(D4) = 24)
		CU_ASSERT(offsetof(D4, i) = 12)
		CU_ASSERT(offsetof(D4, l) = 16)
	#endif

	type D5
		as A2 a
		as integer i1
		as integer i2
		as longint l
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(D5) = 32)
		CU_ASSERT(offsetof(D5, i1) = 16)
		CU_ASSERT(offsetof(D5, i2) = 20)
		CU_ASSERT(offsetof(D5, l) = 24)
	#else
		CU_ASSERT(sizeof(D5) = 28)
		CU_ASSERT(offsetof(D5, i1) = 12)
		CU_ASSERT(offsetof(D5, i2) = 16)
		CU_ASSERT(offsetof(D5, l) = 20)
	#endif

	type D6
		as A2 a
		as longint l
		as integer i1
		as integer i2
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(D6) = 32)
		CU_ASSERT(offsetof(D6, l) = 16)
		CU_ASSERT(offsetof(D6, i1) = 24)
		CU_ASSERT(offsetof(D6, i2) = 28)
	#else
		CU_ASSERT(sizeof(D6) = 28)
		CU_ASSERT(offsetof(D6, l) = 12)
		CU_ASSERT(offsetof(D6, i1) = 20)
		CU_ASSERT(offsetof(D6, i2) = 24)
	#endif

	type D7
		as A2 a
		as integer i1
		as longint l
		as integer i2
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(D7) = 40)
		CU_ASSERT(offsetof(D7, i1) = 16)
		CU_ASSERT(offsetof(D7, l) = 24)
		CU_ASSERT(offsetof(D7, i2) = 32)
	#else
		CU_ASSERT(sizeof(D7) = 28)
		CU_ASSERT(offsetof(D7, i1) = 12)
		CU_ASSERT(offsetof(D7, l) = 16)
		CU_ASSERT(offsetof(D7, i2) = 24)
	#endif

	'' ---
	'' With A2 at the end

	type E1
		as integer i
		as A2 a
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(E1) = 24)
		CU_ASSERT(offsetof(E1, a) = 8)
	#else
		CU_ASSERT(sizeof(E1) = 16)
		CU_ASSERT(offsetof(E1, a) = 4)
	#endif

	type E2
		as integer i1
		as integer i2
		as A2 a
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(E2) = 24)
	#else
		CU_ASSERT(sizeof(E2) = 20)
	#endif
	CU_ASSERT(offsetof(E2, i2) = 4)
	CU_ASSERT(offsetof(E2, a) = 8)

	type E3
		as longint l
		as integer i
		as A2 a
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(E3) = 32)
		CU_ASSERT(offsetof(E3, i) = 8)
		CU_ASSERT(offsetof(E3, a) = 16)
	#else
		CU_ASSERT(sizeof(E3) = 24)
		CU_ASSERT(offsetof(E3, i) = 8)
		CU_ASSERT(offsetof(E3, a) = 12)
	#endif

	type E4
		as integer i
		as longint l
		as A2 a
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(E4) = 32)
		CU_ASSERT(offsetof(E4, l) = 8)
		CU_ASSERT(offsetof(E4, a) = 16)
	#else
		CU_ASSERT(sizeof(E4) = 24)
		CU_ASSERT(offsetof(E4, l) = 4)
		CU_ASSERT(offsetof(E4, a) = 12)
	#endif

	type E5
		as integer i1
		as integer i2
		as longint l
		as A2 a
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(E5) = 32)
	#else
		CU_ASSERT(sizeof(E5) = 28)
	#endif
	CU_ASSERT(offsetof(E5, i2) = 4)
	CU_ASSERT(offsetof(E5, l) = 8)
	CU_ASSERT(offsetof(E5, a) = 16)

	type E6
		as longint l
		as integer i1
		as integer i2
		as A2 a
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(E6) = 32)
	#else
		CU_ASSERT(sizeof(E6) = 28)
	#endif
	CU_ASSERT(offsetof(E6, i1) = 8)
	CU_ASSERT(offsetof(E6, i2) = 12)
	CU_ASSERT(offsetof(E6, a) = 16)

	type E7
		as integer i1
		as longint l
		as integer i2
		as A2 a
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(E7) = 40)
		CU_ASSERT(offsetof(E7, l) = 8)
		CU_ASSERT(offsetof(E7, i2) = 16)
		CU_ASSERT(offsetof(E7, a) = 24)
	#else
		CU_ASSERT(sizeof(E7) = 28)
		CU_ASSERT(offsetof(E7, l) = 4)
		CU_ASSERT(offsetof(E7, i2) = 12)
		CU_ASSERT(offsetof(E7, a) = 16)
	#endif

end sub

private sub bug2828675 cdecl()
	type Pointd
		x as double
		y as double
	end type

	type Pointi
		x as integer
		y as integer
	end type

	type Nested
		a as Pointd
		b as Pointd
		c as Pointd
		d as Pointi
		e as double
		f as byte
		g as byte
	end type

	type Test
		a as double
		b as Nested
		c as Nested
		d as ubyte ptr
		e as integer
		f as integer
	end type

	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(Nested) = 72)
		CU_ASSERT(sizeof(Test) = 168)
	#else
		CU_ASSERT(sizeof(Nested) = 68)
		CU_ASSERT(sizeof(Test) = 156)
	#endif

	type A
		as double d
		as integer i
	end type

	type B
		as A a
		as integer i
	end type

	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(A) = 16)
		CU_ASSERT(sizeof(B) = 24)
		CU_ASSERT(offsetof(B, i) = 16)
	#else
		CU_ASSERT(sizeof(A) = 12)
		CU_ASSERT(sizeof(B) = 16)
		CU_ASSERT(offsetof(B, i) = 12)
	#endif
end sub

private sub ctor () constructor

	fbcu.add_suite("tests/structs/padding")
	fbcu.add_test("size1", @test_size1)
	fbcu.add_test("size2", @test_size2)
	fbcu.add_test("no padding by default", @testDefaultNoPadding)
	fbcu.add_test("default mod 2 padding", @testDefaultPad2)
	fbcu.add_test("default mod 4 padding", @testDefaultPad4)
	fbcu.add_test("default mod 8 padding", @testDefaultPad8)
	fbcu.add_test("bug #2828675 regression test", @bug2828675)

end sub

end namespace
