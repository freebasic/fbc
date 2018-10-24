#include "fbcunit.bi"

SUITE( fbc_tests.structs.padding )

	'' On 32bit Win32/MinGW, doubles/longints are aligned to 8, but on
	'' 32bit Linux and others, doubles/longints are aligned to 4.
	'' (This often results in tighter packing, and only few cases are
	'' the same as on MinGW)
	''
	'' On 64bit, doubles/longints are aligned to 8 everywhere.
	#if defined( __FB_64BIT__ ) or defined( __FB_WIN32__ ) or defined( __FB_ARM__ )
		#define QWORD_ALIGN 8
	#else
		#define QWORD_ALIGN 4
	#endif

	TEST( size1 )
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

		#ifdef __FB_64BIT__
			CU_ASSERT( sizeof( S ) = _
				sizeof(ubyte)		+ _ '' 1
				1			+ _ '' 2
				sizeof(ushort)		+ _ '' 4
				sizeof(ubyte)		+ _ '' 5
				3			+ _ '' 8
				sizeof(any ptr)		+ _ '' 16
				sizeof(uinteger)	+ _ '' 24
				sizeof(uinteger)	+ _ '' 32
				sizeof(double)		+ _ '' 40
				sizeof(ubyte)		+ _ '' 41
				7			)   '' 48
		#elseif QWORD_ALIGN = 8
			CU_ASSERT( sizeof( S ) = _
				sizeof(ubyte)		+ _ '' 1
				1			+ _ '' 2
				sizeof(ushort)		+ _ '' 4
				sizeof(ubyte)		+ _ '' 5
				3			+ _ '' 8
				sizeof(any ptr)		+ _ '' 12
				sizeof(uinteger)	+ _ '' 16
				sizeof(uinteger)	+ _ '' 20
				4			+ _ '' 24
				sizeof(double)		+ _ '' 32
				sizeof(ubyte)		+ _ '' 33
				7			)   '' 40
		#else
			CU_ASSERT( sizeof( S ) = _
				sizeof(ubyte)		+ _ '' 1
				1			+ _ '' 2
				sizeof(ushort)		+ _ '' 4
				sizeof(ubyte)		+ _ '' 5
				3			+ _ '' 8
				sizeof(any ptr)		+ _ '' 12
				sizeof(uinteger)	+ _ '' 16
				sizeof(uinteger)	+ _ '' 20
				sizeof(double)		+ _ '' 28
				sizeof(ubyte)		+ _ '' 29
				3			)   '' 32
		#endif

		type S8 field = 8
			as ubyte b0
			as ushort a0
			as ubyte b1
			as function( ) as uinteger a1
			as uinteger a2
			as uinteger b3
			as double a3
			as ubyte b4
		end type

		'' FIELD only lowers alignment, never increases it, so FIELD=8 does
		'' nothing, because everything already has alignment <= 8.
		CU_ASSERT( sizeof( S8 ) = sizeof( S ) )

		type S4 field = 4
			as ubyte b0
			as ushort a0
			as ubyte b1
			as function( ) as uinteger a1
			as uinteger a2
			as uinteger b3
			as double a3
			as ubyte b4
		end type

		#ifdef __FB_64BIT__
			CU_ASSERT( sizeof( S4 ) = _
				sizeof(ubyte)		+ _ '' 1
				1			+ _ '' 2
				sizeof(ushort)		+ _ '' 4
				sizeof(ubyte)		+ _ '' 5
				3			+ _ '' 8
				sizeof(any ptr)		+ _ '' 16
				sizeof(uinteger)	+ _ '' 24
				sizeof(uinteger)	+ _ '' 32
				sizeof(double)		+ _ '' 40
				sizeof(ubyte)		+ _ '' 41
				3			)   '' 44
		#else
			'' FIELD=4 makes the padding equal across 32bit platforms
			'' (win32/arm 8-byte alignments are lowered to 4; linux & co stay
			'' unchanged as there are no alignments > 4)
			CU_ASSERT( sizeof( S4 ) = _
				sizeof(ubyte)		+ _ '' 1
				1			+ _ '' 2
				sizeof(ushort)		+ _ '' 4
				sizeof(ubyte)		+ _ '' 5
				3			+ _ '' 8
				sizeof(any ptr)		+ _ '' 12
				sizeof(uinteger)	+ _ '' 16
				sizeof(uinteger)	+ _ '' 20
				sizeof(double)		+ _ '' 28
				sizeof(ubyte)		+ _ '' 29
				3			)   '' 32
		#endif

		type S2 field = 2
			as ubyte b0
			as ushort a0
			as ubyte b1
			as function( ) as uinteger a1
			as uinteger a2
			as uinteger b3
			as double a3
			as ubyte b4
		end type

		#ifdef __FB_64BIT__
			CU_ASSERT( sizeof( S2 ) = _
				sizeof(ubyte)		+ _ '' 1
				1			+ _ '' 2
				sizeof(ushort)		+ _ '' 4
				sizeof(ubyte)		+ _ '' 5
				1			+ _ '' 6
				sizeof(any ptr)		+ _ '' 14
				sizeof(uinteger)	+ _ '' 22
				sizeof(uinteger)	+ _ '' 30
				sizeof(double)		+ _ '' 38
				sizeof(ubyte)		+ _ '' 39
				1			)   '' 40
		#else
			CU_ASSERT( sizeof( S2 ) = _
				sizeof(ubyte)		+ _ '' 1
				1			+ _ '' 2
				sizeof(ushort)		+ _ '' 4
				sizeof(ubyte)		+ _ '' 5
				1			+ _ '' 6
				sizeof(any ptr)		+ _ '' 10
				sizeof(uinteger)	+ _ '' 14
				sizeof(uinteger)	+ _ '' 18
				sizeof(double)		+ _ '' 26
				sizeof(ubyte)		+ _ '' 27
				1			)   '' 28
		#endif

		type S1 field = 1
			as ubyte b0
			as ushort a0
			as ubyte b1
			as function( ) as uinteger a1
			as uinteger a2
			as uinteger b3
			as double a3
			as ubyte b4
		end type

		#ifdef __FB_64BIT__
			CU_ASSERT( sizeof( S1 ) = _
				sizeof(ubyte)		+ _ '' 1
				sizeof(ushort)		+ _ '' 3
				sizeof(ubyte)		+ _ '' 4
				sizeof(any ptr)		+ _ '' 12
				sizeof(uinteger)	+ _ '' 20
				sizeof(uinteger)	+ _ '' 28
				sizeof(double)		+ _ '' 36
				sizeof(ubyte)		)   '' 37
		#else
			CU_ASSERT( sizeof( S1 ) = _
				sizeof(ubyte)		+ _ '' 1
				sizeof(ushort)		+ _ '' 3
				sizeof(ubyte)		+ _ '' 4
				sizeof(any ptr)		+ _ '' 8
				sizeof(uinteger)	+ _ '' 12
				sizeof(uinteger)	+ _ '' 16
				sizeof(double)		+ _ '' 24
				sizeof(ubyte)		)   '' 25
		#endif
	END_TEST

	TEST( size2 )
		type S1 field = 1
			as ubyte b1
			as ushort s1
			as ushort s2
		end type

		type S2 field = 2
			as ubyte b1
			as ushort s1
			as ushort s2
		end type

		type S
			as ubyte b1
			as ushort s1
			as ushort s2
		end type

		const UNPADLEN = sizeof(ubyte) + sizeof(ushort) * 2

		CU_ASSERT( sizeof(S1) = UNPADLEN )
		CU_ASSERT( sizeof(S2) = UNPADLEN + 1 )
		CU_ASSERT( sizeof(S)  = UNPADLEN + 1 )
	END_TEST

	'' no padding by default
	TEST( defaultNoPadding )
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
		make(long)
		make(integer)
		make(single)
		make(longint)
		make(double)
	END_TEST

	'' default mod 2 padding
	TEST( defaultPad2 )
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
	END_TEST

	'' default mod 4 padding
	TEST( defaultPad4 )
		'' Simple:

		type A
			as short s
			as integer i
		end type
		CU_ASSERT(sizeof(A) = sizeof(integer) * 2)
		CU_ASSERT(offsetof(A, i) = sizeof(integer))

		type B
			as integer i
			as short s
		end type
		CU_ASSERT(sizeof(B) = sizeof(integer) * 2)
		CU_ASSERT(offsetof(B, s) = sizeof(integer))

		type C1
			as short s1
			as short s2
			as integer i
		end type
		CU_ASSERT(sizeof(C1) = sizeof(integer) * 2)
		CU_ASSERT(offsetof(C1, s2) = sizeof(short))
		CU_ASSERT(offsetof(C1, i) = sizeof(integer))

		type C2
			as integer i
			as short s1
			as short s2
		end type
		CU_ASSERT(sizeof(C2) = sizeof(integer) * 2)
		CU_ASSERT(offsetof(C2, s1) = sizeof(integer))
		CU_ASSERT(offsetof(C2, s2) = sizeof(integer) + sizeof(short))

		type C3
			as short s1
			as integer i
			as short s2
		end type
		CU_ASSERT(sizeof(C3) = sizeof(integer) * 3)
		CU_ASSERT(offsetof(C3, i) = sizeof(integer))
		CU_ASSERT(offsetof(C3, s2) = sizeof(integer) * 2)

		'' ---
		'' Now with nested UDT:

		type E1
			as A a
			as short s
		end type
		CU_ASSERT(sizeof(E1) = sizeof(integer) * 3)
		CU_ASSERT(offsetof(E1, s) = sizeof(integer) * 2)

		type E2
			as A a
			as integer i
		end type
		CU_ASSERT(sizeof(E2) = sizeof(integer) * 3)
		CU_ASSERT(offsetof(E2, i) = sizeof(integer) * 2)

		type E3
			as A a
			as short s1
			as short s2
		end type
		CU_ASSERT(sizeof(E3) = sizeof(integer) * 3)
		CU_ASSERT(offsetof(E3, s1) = sizeof(integer) * 2)
		CU_ASSERT(offsetof(E3, s2) = sizeof(integer) * 2 + 2)

		type E4
			as A a
			as short s
			as integer i
		end type
		CU_ASSERT(sizeof(E4) = sizeof(integer) * 4)
		CU_ASSERT(offsetof(E4, s) = sizeof(integer) * 2)
		CU_ASSERT(offsetof(E4, i) = sizeof(integer) * 3)

		type E5
			as A a
			as integer i
			as short s
		end type
		CU_ASSERT(sizeof(E5) = sizeof(integer) * 4)
		CU_ASSERT(offsetof(E5, i) = sizeof(integer) * 2)
		CU_ASSERT(offsetof(E5, s) = sizeof(integer) * 3)

		type E6
			as A a
			as short s1
			as short s2
			as integer i
		end type
		CU_ASSERT(sizeof(E6) = sizeof(integer) * 4)
		CU_ASSERT(offsetof(E6, s1) = sizeof(integer) * 2)
		CU_ASSERT(offsetof(E6, s2) = sizeof(integer) * 2 + 2)
		CU_ASSERT(offsetof(E6, i) = sizeof(integer) * 3)

		type E7
			as A a
			as integer i
			as short s1
			as short s2
		end type
		CU_ASSERT(sizeof(E7) = sizeof(integer) * 4)
		CU_ASSERT(offsetof(E7, i) = sizeof(integer) * 2)
		CU_ASSERT(offsetof(E7, s1) = sizeof(integer) * 3)
		CU_ASSERT(offsetof(E7, s2) = sizeof(integer) * 3 + 2)

		type E8
			as A a
			as short s1
			as integer i
			as short s2
		end type
		CU_ASSERT(sizeof(E8) = sizeof(integer) * 5)
		CU_ASSERT(offsetof(E8, s1) = sizeof(integer) * 2)
		CU_ASSERT(offsetof(E8, i) = sizeof(integer) * 3)
		CU_ASSERT(offsetof(E8, s2) = sizeof(integer) * 4)

		'' ---
		'' Now the same, but with the UDT at the end

		type F1
			as short s
			as A a
		end type
		CU_ASSERT(sizeof(F1) = sizeof(integer) * 3)
		CU_ASSERT(offsetof(F1, a) = sizeof(integer))

		type F2
			as integer i
			as A a
		end type
		CU_ASSERT(sizeof(F2) = sizeof(integer) * 3)
		CU_ASSERT(offsetof(F2, a) = sizeof(integer))

		type F3
			as short s1
			as short s2
			as A a
		end type
		CU_ASSERT(sizeof(F3) = sizeof(integer) * 3)
		CU_ASSERT(offsetof(F3, s2) = 2)
		CU_ASSERT(offsetof(F3, a) = sizeof(integer))

		type F4
			as short s
			as integer i
			as A a
		end type
		CU_ASSERT(sizeof(F4) = sizeof(integer) * 4)
		CU_ASSERT(offsetof(F4, i) = sizeof(integer))
		CU_ASSERT(offsetof(F4, a) = sizeof(integer) * 2)

		type F5
			as integer i
			as short s
			as A a
		end type
		CU_ASSERT(sizeof(F5) = sizeof(integer) * 4)
		CU_ASSERT(offsetof(F5, s) = sizeof(integer))
		CU_ASSERT(offsetof(F5, a) = sizeof(integer) * 2)

		type F6
			as short s1
			as short s2
			as integer i
			as A a
		end type
		CU_ASSERT(sizeof(F6) = sizeof(integer) * 4)
		CU_ASSERT(offsetof(F6, s2) = 2)
		CU_ASSERT(offsetof(F6, i) = sizeof(integer))
		CU_ASSERT(offsetof(F6, a) = sizeof(integer) * 2)

		type F7
			as integer i
			as short s1
			as short s2
			as A a
		end type
		CU_ASSERT(sizeof(F7) = sizeof(integer) * 4)
		CU_ASSERT(offsetof(F7, s1) = sizeof(integer))
		CU_ASSERT(offsetof(F7, s2) = sizeof(integer) + 2)
		CU_ASSERT(offsetof(F7, a) = sizeof(integer) * 2)

		type F8
			as short s1
			as integer i
			as short s2
			as A a
		end type
		CU_ASSERT(sizeof(F8) = sizeof(integer) * 5)
		CU_ASSERT(offsetof(F8, i) = sizeof(integer))
		CU_ASSERT(offsetof(F8, s2) = sizeof(integer) * 2)
		CU_ASSERT(offsetof(F8, a) = sizeof(integer) * 3)

		'' ---
		'' Now the same (both UDT at the begin and at the end), but with B
		'' instead of A (B has tail padding, A doesn't)

		'' B at the beginning

		type G1
			as B b
			as short s
		end type
		CU_ASSERT(sizeof(G1) = sizeof(integer) * 3)
		CU_ASSERT(offsetof(G1, s) = sizeof(integer) * 2)

		type G2
			as B b
			as integer i
		end type
		CU_ASSERT(sizeof(G2) = sizeof(integer) * 3)
		CU_ASSERT(offsetof(G2, i) = sizeof(integer) * 2)

		type G3
			as B b
			as short s1
			as short s2
		end type
		CU_ASSERT(sizeof(G3) = sizeof(integer) * 3)
		CU_ASSERT(offsetof(G3, s1) = sizeof(integer) * 2)
		CU_ASSERT(offsetof(G3, s2) = sizeof(integer) * 2 + 2)

		type G4
			as B b
			as short s
			as integer i
		end type
		CU_ASSERT(sizeof(G4) = sizeof(integer) * 4)
		CU_ASSERT(offsetof(G4, s) = sizeof(integer) * 2)
		CU_ASSERT(offsetof(G4, i) = sizeof(integer) * 3)

		type G5
			as B b
			as integer i
			as short s
		end type
		CU_ASSERT(sizeof(E5) = sizeof(integer) * 4)
		CU_ASSERT(offsetof(E5, i) = sizeof(integer) * 2)
		CU_ASSERT(offsetof(E5, s) = sizeof(integer) * 3)

		type G6
			as B b
			as short s1
			as short s2
			as integer i
		end type
		CU_ASSERT(sizeof(G6) = sizeof(integer) * 4)
		CU_ASSERT(offsetof(G6, s1) = sizeof(integer) * 2)
		CU_ASSERT(offsetof(G6, s2) = sizeof(integer) * 2 + 2)
		CU_ASSERT(offsetof(G6, i) = sizeof(integer) * 3)

		type G7
			as B b
			as integer i
			as short s1
			as short s2
		end type
		CU_ASSERT(sizeof(G7) = sizeof(integer) * 4)
		CU_ASSERT(offsetof(G7, i) = sizeof(integer) * 2)
		CU_ASSERT(offsetof(G7, s1) = sizeof(integer) * 3)
		CU_ASSERT(offsetof(G7, s2) = sizeof(integer) * 3 + 2)

		type G8
			as B b
			as short s1
			as integer i
			as short s2
		end type
		CU_ASSERT(sizeof(G8) = sizeof(integer) * 5)
		CU_ASSERT(offsetof(G8, s1) = sizeof(integer) * 2)
		CU_ASSERT(offsetof(G8, i) = sizeof(integer) * 3)
		CU_ASSERT(offsetof(G8, s2) = sizeof(integer) * 4)

		'' ---
		'' B at the end

		type H1
			as short s
			as B b
		end type
		CU_ASSERT(sizeof(H1) = sizeof(integer) * 3)
		CU_ASSERT(offsetof(H1, b) = sizeof(integer))

		type H2
			as integer i
			as B b
		end type
		CU_ASSERT(sizeof(H2) = sizeof(integer) * 3)
		CU_ASSERT(offsetof(H2, b) = sizeof(integer))

		type H3
			as short s1
			as short s2
			as B b
		end type
		CU_ASSERT(sizeof(H3) = sizeof(integer) * 3)
		CU_ASSERT(offsetof(H3, s2) = 2)
		CU_ASSERT(offsetof(H3, b) = sizeof(integer))

		type H4
			as short s
			as integer i
			as B b
		end type
		CU_ASSERT(sizeof(H4) = sizeof(integer) * 4)
		CU_ASSERT(offsetof(H4, i) = sizeof(integer))
		CU_ASSERT(offsetof(H4, b) = sizeof(integer) * 2)

		type H5
			as integer i
			as short s
			as B b
		end type
		CU_ASSERT(sizeof(H5) = sizeof(integer) * 4)
		CU_ASSERT(offsetof(H5, s) = sizeof(integer))
		CU_ASSERT(offsetof(H5, b) = sizeof(integer) * 2)

		type H6
			as short s1
			as short s2
			as integer i
			as B b
		end type
		CU_ASSERT(sizeof(H6) = sizeof(integer) * 4)
		CU_ASSERT(offsetof(H6, s2) = 2)
		CU_ASSERT(offsetof(H6, i) = sizeof(integer))
		CU_ASSERT(offsetof(H6, b) = sizeof(integer) * 2)

		type H7
			as integer i
			as short s1
			as short s2
			as B b
		end type
		CU_ASSERT(sizeof(H7) = sizeof(integer) * 4)
		CU_ASSERT(offsetof(H7, s1) = sizeof(integer))
		CU_ASSERT(offsetof(H7, s2) = sizeof(integer) + 2)
		CU_ASSERT(offsetof(H7, b) = sizeof(integer) * 2)

		type H8
			as short s1
			as integer i
			as short s2
			as B b
		end type
		CU_ASSERT(sizeof(H8) = sizeof(integer) * 5)
		CU_ASSERT(offsetof(H8, i) = sizeof(integer))
		CU_ASSERT(offsetof(H8, s2) = sizeof(integer) * 2)
		CU_ASSERT(offsetof(H8, b) = sizeof(integer) * 3)
	END_TEST

	'' default mod 8 padding
	TEST( defaultPad8 )
		type A1
			as long a
			as longint b
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(A1) = 16)
			CU_ASSERT(offsetof(A1, b) = 8)
		#else
			CU_ASSERT(sizeof(A1) = 12)
			CU_ASSERT(offsetof(A1, b) = 4)
		#endif

		type A2
			as longint a
			as long b
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(A2) = 16)
		#else
			CU_ASSERT(sizeof(A2) = 12)
		#endif
		CU_ASSERT(offsetof(A2, b) = 8)

		type A3
			as long a
			as long b
			as longint c
		end type
		CU_ASSERT(sizeof(A3) = 16)
		CU_ASSERT(offsetof(A3, b) = 4)
		CU_ASSERT(offsetof(A3, c) = 8)

		type A4
			as longint a
			as long b
			as long c
		end type
		CU_ASSERT(sizeof(A4) = 16)
		CU_ASSERT(offsetof(A4, b) = 8)
		CU_ASSERT(offsetof(A4, c) = 12)

		type A5
			as long a
			as longint b
			as long c
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(A5) = 24)
			CU_ASSERT(offsetof(A5, b) = 8)
			CU_ASSERT(offsetof(A5, c) = 16)
		#else
			CU_ASSERT(sizeof(A5) = 16)
			CU_ASSERT(offsetof(A5, b) = 4)
			CU_ASSERT(offsetof(A5, c) = 12)
		#endif

		'' ---
		'' Now with A1 at the beginning

		type B1
			as A1 a
			as long b
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(B1) = 24)
			CU_ASSERT(offsetof(B1, b) = 16)
		#else
			CU_ASSERT(sizeof(B1) = 16)
			CU_ASSERT(offsetof(B1, b) = 12)
		#endif

		type B2
			as A1 a
			as long b
			as long c
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(B2) = 24)
			CU_ASSERT(offsetof(B2, b) = 16)
			CU_ASSERT(offsetof(B2, c) = 20)
		#else
			CU_ASSERT(sizeof(B2) = 20)
			CU_ASSERT(offsetof(B2, b) = 12)
			CU_ASSERT(offsetof(B2, c) = 16)
		#endif

		type B3
			as A1 a
			as longint b
			as long c
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(B3) = 32)
			CU_ASSERT(offsetof(B3, b) = 16)
			CU_ASSERT(offsetof(B3, c) = 24)
		#else
			CU_ASSERT(sizeof(B3) = 24)
			CU_ASSERT(offsetof(B3, b) = 12)
			CU_ASSERT(offsetof(B3, c) = 20)
		#endif

		type B4
			as A1 a
			as long b
			as longint c
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(B4) = 32)
			CU_ASSERT(offsetof(B4, b) = 16)
			CU_ASSERT(offsetof(B4, c) = 24)
		#else
			CU_ASSERT(sizeof(B4) = 24)
			CU_ASSERT(offsetof(B4, b) = 12)
			CU_ASSERT(offsetof(B4, c) = 16)
		#endif

		type B5
			as A1 a
			as long b
			as long c
			as longint d
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(B5) = 32)
			CU_ASSERT(offsetof(B5, b) = 16)
			CU_ASSERT(offsetof(B5, c) = 20)
			CU_ASSERT(offsetof(B5, d) = 24)
		#else
			CU_ASSERT(sizeof(B5) = 28)
			CU_ASSERT(offsetof(B5, b) = 12)
			CU_ASSERT(offsetof(B5, c) = 16)
			CU_ASSERT(offsetof(B5, d) = 20)
		#endif

		type B6
			as A1 a
			as longint b
			as long c
			as long d
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(B6) = 32)
			CU_ASSERT(offsetof(B6, b) = 16)
			CU_ASSERT(offsetof(B6, c) = 24)
			CU_ASSERT(offsetof(B6, d) = 28)
		#else
			CU_ASSERT(sizeof(B6) = 28)
			CU_ASSERT(offsetof(B6, b) = 12)
			CU_ASSERT(offsetof(B6, c) = 20)
			CU_ASSERT(offsetof(B6, d) = 24)
		#endif

		type B7
			as A1 a
			as long b
			as longint c
			as long d
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(B7) = 40)
			CU_ASSERT(offsetof(B7, b) = 16)
			CU_ASSERT(offsetof(B7, c) = 24)
			CU_ASSERT(offsetof(B7, d) = 32)
		#else
			CU_ASSERT(sizeof(B7) = 28)
			CU_ASSERT(offsetof(B7, b) = 12)
			CU_ASSERT(offsetof(B7, c) = 16)
			CU_ASSERT(offsetof(B7, d) = 24)
		#endif

		'' ---
		'' With A1 at the end

		type C1
			as long a
			as A1 b
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(C1) = 24)
			CU_ASSERT(offsetof(C1, b) = 8)
		#else
			CU_ASSERT(sizeof(C1) = 16)
			CU_ASSERT(offsetof(C1, b) = 4)
		#endif

		type C2
			as long a
			as long b
			as A1 c
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(C2) = 24)
		#else
			CU_ASSERT(sizeof(C2) = 20)
		#endif
		CU_ASSERT(offsetof(C2, b) = 4)
		CU_ASSERT(offsetof(C2, c) = 8)

		type C3
			as longint a
			as long b
			as A1 c
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(C3) = 32)
			CU_ASSERT(offsetof(C3, b) = 8)
			CU_ASSERT(offsetof(C3, c) = 16)
		#else
			CU_ASSERT(sizeof(C3) = 24)
			CU_ASSERT(offsetof(C3, b) = 8)
			CU_ASSERT(offsetof(C3, c) = 12)
		#endif

		type C4
			as long a
			as longint b
			as A1 c
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(C4) = 32)
			CU_ASSERT(offsetof(C4, b) = 8)
			CU_ASSERT(offsetof(C4, c) = 16)
		#else
			CU_ASSERT(sizeof(C4) = 24)
			CU_ASSERT(offsetof(C4, b) = 4)
			CU_ASSERT(offsetof(C4, c) = 12)
		#endif

		type C5
			as long a
			as long b
			as longint c
			as A1 d
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(C5) = 32)
		#else
			CU_ASSERT(sizeof(C5) = 28)
		#endif
		CU_ASSERT(offsetof(C5, b) = 4)
		CU_ASSERT(offsetof(C5, c) = 8)
		CU_ASSERT(offsetof(C5, d) = 16)

		type C6
			as longint a
			as long b
			as long c
			as A1 d
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(C6) = 32)
		#else
			CU_ASSERT(sizeof(C6) = 28)
		#endif
		CU_ASSERT(offsetof(C6, b) = 8)
		CU_ASSERT(offsetof(C6, c) = 12)
		CU_ASSERT(offsetof(C6, d) = 16)

		type C7
			as long a
			as longint b
			as long c
			as A1 d
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(C7) = 40)
			CU_ASSERT(offsetof(C7, b) = 8)
			CU_ASSERT(offsetof(C7, c) = 16)
			CU_ASSERT(offsetof(C7, d) = 24)
		#else
			CU_ASSERT(sizeof(C7) = 28)
			CU_ASSERT(offsetof(C7, b) = 4)
			CU_ASSERT(offsetof(C7, c) = 12)
			CU_ASSERT(offsetof(C7, d) = 16)
		#endif

		'' ---
		'' Now with A2 at the beginning

		type D1
			as A2 a
			as long b
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(D1) = 24)
			CU_ASSERT(offsetof(D1, b) = 16)
		#else
			CU_ASSERT(sizeof(D1) = 16)
			CU_ASSERT(offsetof(D1, b) = 12)
		#endif

		type D2
			as A2 a
			as long b
			as long c
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(D2) = 24)
			CU_ASSERT(offsetof(D2, b) = 16)
			CU_ASSERT(offsetof(D2, c) = 20)
		#else
			CU_ASSERT(sizeof(D2) = 20)
			CU_ASSERT(offsetof(D2, b) = 12)
			CU_ASSERT(offsetof(D2, c) = 16)
		#endif

		type D3
			as A2 a
			as longint b
			as long c
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(D3) = 32)
			CU_ASSERT(offsetof(D3, b) = 16)
			CU_ASSERT(offsetof(D3, c) = 24)
		#else
			CU_ASSERT(sizeof(D3) = 24)
			CU_ASSERT(offsetof(D3, b) = 12)
			CU_ASSERT(offsetof(D3, c) = 20)
		#endif

		type D4
			as A2 a
			as long b
			as longint c
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(D4) = 32)
			CU_ASSERT(offsetof(D4, b) = 16)
			CU_ASSERT(offsetof(D4, c) = 24)
		#else
			CU_ASSERT(sizeof(D4) = 24)
			CU_ASSERT(offsetof(D4, b) = 12)
			CU_ASSERT(offsetof(D4, c) = 16)
		#endif

		type D5
			as A2 a
			as long b
			as long c
			as longint d
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(D5) = 32)
			CU_ASSERT(offsetof(D5, b) = 16)
			CU_ASSERT(offsetof(D5, c) = 20)
			CU_ASSERT(offsetof(D5, d) = 24)
		#else
			CU_ASSERT(sizeof(D5) = 28)
			CU_ASSERT(offsetof(D5, b) = 12)
			CU_ASSERT(offsetof(D5, c) = 16)
			CU_ASSERT(offsetof(D5, d) = 20)
		#endif

		type D6
			as A2 a
			as longint b
			as long c
			as long d
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(D6) = 32)
			CU_ASSERT(offsetof(D6, b) = 16)
			CU_ASSERT(offsetof(D6, c) = 24)
			CU_ASSERT(offsetof(D6, d) = 28)
		#else
			CU_ASSERT(sizeof(D6) = 28)
			CU_ASSERT(offsetof(D6, b) = 12)
			CU_ASSERT(offsetof(D6, c) = 20)
			CU_ASSERT(offsetof(D6, d) = 24)
		#endif

		type D7
			as A2 a
			as long b
			as longint c
			as long d
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(D7) = 40)
			CU_ASSERT(offsetof(D7, b) = 16)
			CU_ASSERT(offsetof(D7, c) = 24)
			CU_ASSERT(offsetof(D7, d) = 32)
		#else
			CU_ASSERT(sizeof(D7) = 28)
			CU_ASSERT(offsetof(D7, b) = 12)
			CU_ASSERT(offsetof(D7, c) = 16)
			CU_ASSERT(offsetof(D7, d) = 24)
		#endif

		'' ---
		'' With A2 at the end

		type E1
			as long a
			as A2 b
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(E1) = 24)
			CU_ASSERT(offsetof(E1, b) = 8)
		#else
			CU_ASSERT(sizeof(E1) = 16)
			CU_ASSERT(offsetof(E1, b) = 4)
		#endif

		type E2
			as long a
			as long b
			as A2 c
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(E2) = 24)
		#else
			CU_ASSERT(sizeof(E2) = 20)
		#endif
		CU_ASSERT(offsetof(E2, b) = 4)
		CU_ASSERT(offsetof(E2, c) = 8)

		type E3
			as longint a
			as long b
			as A2 c
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(E3) = 32)
			CU_ASSERT(offsetof(E3, b) = 8)
			CU_ASSERT(offsetof(E3, c) = 16)
		#else
			CU_ASSERT(sizeof(E3) = 24)
			CU_ASSERT(offsetof(E3, b) = 8)
			CU_ASSERT(offsetof(E3, c) = 12)
		#endif

		type E4
			as long a
			as longint b
			as A2 c
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(E4) = 32)
			CU_ASSERT(offsetof(E4, b) = 8)
			CU_ASSERT(offsetof(E4, c) = 16)
		#else
			CU_ASSERT(sizeof(E4) = 24)
			CU_ASSERT(offsetof(E4, b) = 4)
			CU_ASSERT(offsetof(E4, c) = 12)
		#endif

		type E5
			as long a
			as long b
			as longint c
			as A2 d
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(E5) = 32)
		#else
			CU_ASSERT(sizeof(E5) = 28)
		#endif
		CU_ASSERT(offsetof(E5, b) = 4)
		CU_ASSERT(offsetof(E5, c) = 8)
		CU_ASSERT(offsetof(E5, d) = 16)

		type E6
			as longint a
			as long b
			as long c
			as A2 d
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(E6) = 32)
		#else
			CU_ASSERT(sizeof(E6) = 28)
		#endif
		CU_ASSERT(offsetof(E6, b) = 8)
		CU_ASSERT(offsetof(E6, c) = 12)
		CU_ASSERT(offsetof(E6, d) = 16)

		type E7
			as long a
			as longint b
			as long c
			as A2 d
		end type
		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(E7) = 40)
			CU_ASSERT(offsetof(E7, b) = 8)
			CU_ASSERT(offsetof(E7, c) = 16)
			CU_ASSERT(offsetof(E7, d) = 24)
		#else
			CU_ASSERT(sizeof(E7) = 28)
			CU_ASSERT(offsetof(E7, b) = 4)
			CU_ASSERT(offsetof(E7, c) = 12)
			CU_ASSERT(offsetof(E7, d) = 16)
		#endif

	END_TEST

	'' bug #2828675 regression test
	TEST( bug2828675 )
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

		type TestType
			a as double
			b as Nested
			c as Nested
			d as ubyte ptr
			e as integer
			f as integer
		end type

		#if defined( __FB_64BIT__ )
			CU_ASSERT(sizeof(Nested) = 80)
			CU_ASSERT(sizeof(TestType) = 192)
		#elseif QWORD_ALIGN = 8
			CU_ASSERT(sizeof(Nested) = 72)
			CU_ASSERT(sizeof(TestType) = 168)
		#else
			CU_ASSERT(sizeof(Nested) = 68)
			CU_ASSERT(sizeof(TestType) = 156)
		#endif

		type A
			as double d
			as integer i
		end type

		type B
			as A a
			as integer i
		end type

		#if QWORD_ALIGN = 8
			CU_ASSERT(sizeof(A) = 16)
			CU_ASSERT(sizeof(B) = 24)
			CU_ASSERT(offsetof(B, i) = 16)
		#else
			CU_ASSERT(sizeof(A) = 12)
			CU_ASSERT(sizeof(B) = 16)
			CU_ASSERT(offsetof(B, i) = 12)
		#endif
	END_TEST

	'' -gen gcc field alignment
	TEST( gccAlign )
		'' -gen gcc regression test
		type UDT1 field = 1
			a	as ushort
			b	as ulong
		end type

		static x1 as UDT1 = ( &h1122u, &hAABBCCDDu )

		CU_ASSERT( x1.a = &h1122u )
		CU_ASSERT( x1.b = &hAABBCCDDu )

		type UDT2 field = 2
			a	as ushort
			b	as ulong
		end type

		static x2 as UDT2 = ( &h1122u, &hAABBCCDDu )

		CU_ASSERT( x2.a = &h1122u )
		CU_ASSERT( x2.b = &hAABBCCDDu )

		type UDT4 field = 4
			a	as ushort
			b	as ulong
		end type

		static x4 as UDT4 = ( &h1122u, &hAABBCCDDu )

		CU_ASSERT( x4.a = &h1122u )
		CU_ASSERT( x4.b = &hAABBCCDDu )

		type BigUDT1 field = 1
			a as ubyte
			b as ushort
			c as ulong
			d as ulongint
			e as zstring * 5
			f(0 to 2) as ubyte
			g(0 to 2) as ushort
			h(0 to 2) as ulong
			i(0 to 2) as ulongint
		end type

		static bigx1 as BigUDT1 = _
		( _
			&h12u, _
			&h1122u, _
			&h11223344u, _
			&h1122334455667788ull, _
			"1122", _
			{ &h11u, &h22u, &h33u }, _
			{ &h1122u, &h2233u, &h3344u }, _
			{ &h11112222u, &h22223333u, &h33334444u }, _
			{ &h1111222211112222ull, &h2222333322223333ull, &h3333444433334444ull } _
		)

		CU_ASSERT( bigx1.a = &h12u )
		CU_ASSERT( bigx1.b = &h1122u )
		CU_ASSERT( bigx1.c = &h11223344u )
		CU_ASSERT( bigx1.d = &h1122334455667788ull )
		CU_ASSERT( bigx1.e = "1122" )
		CU_ASSERT( bigx1.f(0) = &h11u )
		CU_ASSERT( bigx1.f(1) = &h22u )
		CU_ASSERT( bigx1.f(2) = &h33u )
		CU_ASSERT( bigx1.g(0) = &h1122u )
		CU_ASSERT( bigx1.g(1) = &h2233u )
		CU_ASSERT( bigx1.g(2) = &h3344u )
		CU_ASSERT( bigx1.h(0) = &h11112222u )
		CU_ASSERT( bigx1.h(1) = &h22223333u )
		CU_ASSERT( bigx1.h(2) = &h33334444u )
		CU_ASSERT( bigx1.i(0) = &h1111222211112222ull )
		CU_ASSERT( bigx1.i(1) = &h2222333322223333ull )
		CU_ASSERT( bigx1.i(2) = &h3333444433334444ull )

		type BigUDT2 field = 2
			a as ubyte
			b as ushort
			c as ulong
			d as ulongint
			e as zstring * 5
			f(0 to 2) as ubyte
			g(0 to 2) as ushort
			h(0 to 2) as ulong
			i(0 to 2) as ulongint
		end type

		static bigx2 as BigUDT2 = _
		( _
			&h12u, _
			&h1122u, _
			&h11223344u, _
			&h1122334455667788ull, _
			"1122", _
			{ &h11u, &h22u, &h33u }, _
			{ &h1122u, &h2233u, &h3344u }, _
			{ &h11112222u, &h22223333u, &h33334444u }, _
			{ &h1111222211112222ull, &h2222333322223333ull, &h3333444433334444ull } _
		)

		CU_ASSERT( bigx2.a = &h12u )
		CU_ASSERT( bigx2.b = &h1122u )
		CU_ASSERT( bigx2.c = &h11223344u )
		CU_ASSERT( bigx2.d = &h1122334455667788ull )
		CU_ASSERT( bigx2.e = "1122" )
		CU_ASSERT( bigx2.f(0) = &h11u )
		CU_ASSERT( bigx2.f(1) = &h22u )
		CU_ASSERT( bigx2.f(2) = &h33u )
		CU_ASSERT( bigx2.g(0) = &h1122u )
		CU_ASSERT( bigx2.g(1) = &h2233u )
		CU_ASSERT( bigx2.g(2) = &h3344u )
		CU_ASSERT( bigx2.h(0) = &h11112222u )
		CU_ASSERT( bigx2.h(1) = &h22223333u )
		CU_ASSERT( bigx2.h(2) = &h33334444u )
		CU_ASSERT( bigx2.i(0) = &h1111222211112222ull )
		CU_ASSERT( bigx2.i(1) = &h2222333322223333ull )
		CU_ASSERT( bigx2.i(2) = &h3333444433334444ull )

		type BigUDT4 field = 4
			a as ubyte
			b as ushort
			c as ulong
			d as ulongint
			e as zstring * 5
			f(0 to 2) as ubyte
			g(0 to 2) as ushort
			h(0 to 2) as ulong
			i(0 to 2) as ulongint
		end type

		static bigx4 as BigUDT4 = _
		( _
			&h12u, _
			&h1122u, _
			&h11223344u, _
			&h1122334455667788ull, _
			"1122", _
			{ &h11u, &h22u, &h33u }, _
			{ &h1122u, &h2233u, &h3344u }, _
			{ &h11112222u, &h22223333u, &h33334444u }, _
			{ &h1111222211112222ull, &h2222333322223333ull, &h3333444433334444ull } _
		)

		CU_ASSERT( bigx4.a = &h12u )
		CU_ASSERT( bigx4.b = &h1122u )
		CU_ASSERT( bigx4.c = &h11223344u )
		CU_ASSERT( bigx4.d = &h1122334455667788ull )
		CU_ASSERT( bigx4.e = "1122" )
		CU_ASSERT( bigx4.f(0) = &h11u )
		CU_ASSERT( bigx4.f(1) = &h22u )
		CU_ASSERT( bigx4.f(2) = &h33u )
		CU_ASSERT( bigx4.g(0) = &h1122u )
		CU_ASSERT( bigx4.g(1) = &h2233u )
		CU_ASSERT( bigx4.g(2) = &h3344u )
		CU_ASSERT( bigx4.h(0) = &h11112222u )
		CU_ASSERT( bigx4.h(1) = &h22223333u )
		CU_ASSERT( bigx4.h(2) = &h33334444u )
		CU_ASSERT( bigx4.i(0) = &h1111222211112222ull )
		CU_ASSERT( bigx4.i(1) = &h2222333322223333ull )
		CU_ASSERT( bigx4.i(2) = &h3333444433334444ull )
	END_TEST

	TEST( genGccUdtFieldInPackedUdt )
		'' Regression test for -gen gcc's struct emitting

		type UDT1  '' non-packed UDT
			i as integer
		end type
		#assert sizeof( UDT1 ) = sizeof( integer )

		type UDT2 field = 1  '' packed UDT
			x1 as UDT1   '' UDT field, whose UDT is itself not packed
			b as byte
		end type
		#assert sizeof( UDT2 ) = sizeof( integer ) + 1

		dim x2 as UDT2 = ((11), 22)
		CU_ASSERT( x2.x1.i = 11 )
		CU_ASSERT( x2.b = 22 )
	END_TEST
	
	TEST( genGccUdtPackedFieldInUdt )
		'' Regression test for -gen gcc's struct emitting
		
		type UDT1 field=1 '' packed UDT
			a as byte     '' 1 byte
			b as short    '' 2 bytes
		end type
		#assert sizeof( UDT1 ) = sizeof( byte ) + sizeof ( short )
		#assert sizeof( UDT1 ) = 3

		type UDT2 field=2  '' packed UDT
			x1 as UDT1   '' UDT field, which is packed with field=1
		end type
		#assert sizeof( UDT2 ) = 4
		#assert offsetof(UDT2, x1.b) = 1

		dim x2 as UDT2 = ((11,22))
		CU_ASSERT( x2.x1.a = 11 )
		CU_ASSERT( x2.x1.b = 22 )
	END_TEST
	
END_SUITE
