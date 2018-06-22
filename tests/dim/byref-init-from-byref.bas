# include "fbcunit.bi"


'' INTEGER: shared refer to same shared

dim shared       as integer I01
dim shared byref as integer I02 = I01
dim shared byref as integer I03 = I01
dim shared byref as integer I04 = I01

'' INTEGER: shared refer to shared chain

dim shared       as integer I11
dim shared byref as integer I12 = I11
dim shared byref as integer I13 = I12
dim shared byref as integer I14 = I13

'' INTEGER: static shared refer to same static shared

static shared       as integer I21
static shared byref as integer I22 = I21
static shared byref as integer I23 = I21
static shared byref as integer I24 = I21

'' INTEGER: static shared refer to static shared chain

static shared       as integer I31
static shared byref as integer I32 = I31
static shared byref as integer I33 = I32
static shared byref as integer I34 = I33


'' INTEGER: shared & static shared mixed

dim    shared       as integer I41
static shared byref as integer I42 = I41
dim    shared byref as integer I43 = I41
static shared byref as integer I44 = I41

dim    shared       as integer I51
static shared byref as integer I52 = I51
dim    shared byref as integer I53 = I52
static shared byref as integer I54 = I53


'' INTEGER: static shared & shared mixed

static shared       as integer I61
dim    shared byref as integer I62 = I61
static shared byref as integer I63 = I61
dim    shared byref as integer I64 = I61

static shared       as integer I71
dim    shared byref as integer I72 = I71
static shared byref as integer I73 = I72
dim    shared byref as integer I74 = I73


''
type T
	__ as integer
end type

'' Simple UDT: shared refer to same shared

dim shared       as T T01
dim shared byref as T T02 = T01
dim shared byref as T T03 = T01
dim shared byref as T T04 = T01

'' Simple UDT: shared refer to shared chain

dim shared       as T T11
dim shared byref as T T12 = T11
dim shared byref as T T13 = T12
dim shared byref as T T14 = T13

'' Simple UDT: static shared refer to same static shared

static shared       as T T21
static shared byref as T T22 = T21
static shared byref as T T23 = T21
static shared byref as T T24 = T21

'' Simple UDT: static shared refer to static shared chain

static shared       as T T31
static shared byref as T T32 = T31
static shared byref as T T33 = T32
static shared byref as T T34 = T33


'' Simple UDT: shared & static shared mixed

dim    shared       as T T41
static shared byref as T T42 = T41
dim    shared byref as T T43 = T41
static shared byref as T T44 = T41

dim    shared       as T T51
static shared byref as T T52 = T51
dim    shared byref as T T53 = T52
static shared byref as T T54 = T53

'' Simple UDT: static shared & shared mixed

static shared       as T T61
dim    shared byref as T T62 = T61
static shared byref as T T63 = T61
dim    shared byref as T T64 = T61

dim    shared       as T T71
static shared byref as T T72 = T71
dim    shared byref as T T73 = T72
static shared byref as T T74 = T73


'' UDT2 with static byref fields

type T1
	dim as integer F
end type

type T2
	dim as integer F
	static byref as T1 R1
	static byref as T1 R2
	static byref as T1 R3
	static byref as T1 R4
end type

dim shared T1_Initializer as T1

dim byref as T1 T2.R1 = T1_Initializer
dim byref as T1 T2.R2 = T2.R1
dim byref as T1 T2.R3 = T2.R2
dim byref as T1 T2.R4 = T2.R3

dim shared byref as T1 RT1 = T2.R1
dim shared byref as T1 RT2 = T2.R2
dim shared byref as T1 RT3 = T2.R3
dim shared byref as T1 RT4 = T2.R4

static shared byref as T1 SRT1 = RT1
static shared byref as T1 SRT2 = RT2
static shared byref as T1 SRT3 = RT3
static shared byref as T1 SRT4 = RT4


SUITE( fbc_tests.dim_.byref_init_from_byref )

	#macro CheckAddrs( A1, A2, A3, A4 )
		CU_ASSERT( @A1 <> 0 and @A1 = @A2 and @A1 = @A3 and @A1 = @A4 )
	#endmacro

	'' -------- INTEGER ---------------

	TEST( integer_shared )
		CheckAddrs( I01, I02, I03, I04 )
		CheckAddrs( I11, I12, I13, I14 )
	END_TEST

	TEST( static_shared_integer )
		CheckAddrs( I21, I22, I23, I24 )
		CheckAddrs( I31, I32, I33, I34 )
	END_TEST

	TEST( integer_shared_and_static_shared )
		CheckAddrs( I41, I42, I43, I44 )
		CheckAddrs( I51, I52, I53, I54 )
	END_TEST

	TEST( integer_static_shared_and_shared )
		CheckAddrs( I61, I62, I63, I64 )
		CheckAddrs( I71, I72, I73, I74 )
	END_TEST

	TEST( integer_local_same )
		dim       as integer a
		dim byref as integer b = a
		dim byref as integer c = a
		dim byref as integer d = a
		CheckAddrs( a, b, c, d )
	END_TEST

	TEST( integer_local_chain )
		dim       as integer a
		dim byref as integer b = a
		dim byref as integer c = b
		dim byref as integer d = c
		CheckAddrs( a, b, c, d )
	END_TEST

	TEST( integer_local_to_shared )
		static byref as integer b = I11
		dim    byref as integer c = I14
		dim    byref as integer d = c
		CheckAddrs( I11, b, c, d )
	END_TEST

	TEST( integer_local_to_static_shared )
		static byref as integer b = I31
		dim    byref as integer c = I34
		dim    byref as integer d = c
		CheckAddrs( I31, b, c, d )
	END_TEST

	TEST( integer_static_local_to_shared )
		static byref as integer b = I51
		static byref as integer c = I54
		dim    byref as integer d = c
		CheckAddrs( I51, b, c, d )
	END_TEST

	TEST( integer_static_local_to_static_shared )
		static byref as integer b = I71
		static byref as integer c = I74
		dim    byref as integer d = c
		CheckAddrs( I71, b, c, d )
	END_TEST

	'' -------- UDT -------------------

	TEST( UDT_shared )
		CheckAddrs( T01, T02, T03, T04 )
		CheckAddrs( T11, T12, T13, T14 )
	END_TEST

	TEST( UDT_static_shared )
		CheckAddrs( T21, T22, T23, T24 )
		CheckAddrs( T31, T32, T33, T34 )
	END_TEST

	TEST( static_shared_and_static_shared )
		CheckAddrs( T41, T42, T43, T44 )
		CheckAddrs( T51, T52, T53, T54 )
	END_TEST

	TEST( UDT_static_shared_and_shared )
		CheckAddrs( T61, T62, T63, T64 )
		CheckAddrs( T71, T72, T73, T74 )
	END_TEST

	TEST( UDT_local_same )
		dim       as T a
		dim byref as T b = a
		dim byref as T c = a
		dim byref as T d = a
		CheckAddrs( a, b, c, d )
	END_TEST

	TEST( UDT_local_chain )
		dim       as T a
		dim byref as T b = a
		dim byref as T c = b
		dim byref as T d = c
		CheckAddrs( a, b, c, d )
	END_TEST

	TEST( UDT_local_to_shared )
		static byref as T b = T11
		dim    byref as T c = T14
		dim    byref as T d = c
		CheckAddrs( T11, b, c, d )
	END_TEST

	TEST( UDT_local_to_static_shared )
		static byref as T b = T31
		dim    byref as T c = T34
		dim    byref as T d = c
		CheckAddrs( T31, b, c, d )
	END_TEST

	TEST( UDT_static_local_to_shared )
		static byref as T b = T51
		static byref as T c = T54
		dim    byref as T d = c
		CheckAddrs( T51, b, c, d )
	END_TEST

	TEST( UDT_static_local_to_static_shared )
		static byref as T b = T71
		static byref as T c = T74
		dim    byref as T d = c
		CheckAddrs( T71, b, c, d )
	END_TEST

	'' -------- UDT2 -------------------

	TEST( UDT2_static_members )
		CheckAddrs( T2.R1, T2.R2, T2.R3, T2.R4 )
	END_TEST

	TEST( UDT2_shared )
		CheckAddrs( RT1, RT2, RT3, RT4 )
	END_TEST

	TEST( UDT2_static_to_shared )
		CheckAddrs( SRT1, SRT2, SRT3, SRT4 )
	END_TEST

	TEST( UDT2_check_all )
		static byref as T1 a = T2.R1
		static byref as T1 b = RT1
		dim    byref as T1 c = SRT1
		dim    byref as T1 d = c
		CheckAddrs( T2.R1, RT1, SRT1, a )
		CheckAddrs( T2.R2, RT2, SRT2, b )
		CheckAddrs( T2.R3, RT3, SRT3, c )
		CheckAddrs( T2.R4, RT4, SRT4, d )
	END_TEST

	TEST( UDT2_local_to_shared )
		static byref as T1 b = RT1
		dim    byref as T1 c = RT4
		dim    byref as T1 d = c
		CheckAddrs( RT1, b, c, d )
	END_TEST

	TEST( UDT2_local_to_static_shared )
		static byref as T1 b = SRT1
		dim    byref as T1 c = SRT4
		dim    byref as T1 d = c
		CheckAddrs( SRT1, b, c, d )
	END_TEST

	TEST( UDT2_static_local_to_shared )
		static byref as T1 b = RT1
		static byref as T1 c = RT4
		dim    byref as T1 d = c
		CheckAddrs( RT1, b, c, d )
	END_TEST

	TEST( UDT2_static_local_to_static_shared )
		static byref as T1 b = SRT1
		static byref as T1 c = SRT4
		dim    byref as T1 d = c
		CheckAddrs( SRT1, b, c, d )
	END_TEST

END_SUITE
