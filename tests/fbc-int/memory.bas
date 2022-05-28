#include "fbcunit.bi"
#include "fbc-int/memory.bi"

'' tests for low level memory function

SUITE( fbc_tests.fbc_int.memory )

	const BUFF_SIZE = 20

	#macro check( b1, b2, count )
		scope
			var same = 0
			for i as integer = 0 to count-1
				if( b1[i] = b2[i] ) then
					same += 1
				end if
			next
			if( same = count ) then
				CU_PASS( )
			else
				CU_FAIL( )
			end if
		end scope
	#endmacro

	TEST( clear_ )
		dim p1 as ubyte ptr = fbc.callocate( BUFF_SIZE )
		dim p2 as ubyte ptr = fbc.callocate( BUFF_SIZE )

		'' check both are same on calloc
		check( p1, p2, BUFF_SIZE )

		'' explicitly check if set to all zeroes
		for i as integer = 0 to BUFF_SIZE-1
			p1[i] = 0
		next
		check( p1, p2, BUFF_SIZE )

		'' use loop & clear to set other value
		fbc.clear( p1, 1, BUFF_SIZE )
		for i as integer = 0 to BUFF_SIZE-1
			p2[i] = 1
		next
		check( p1, p2, BUFF_SIZE )

		fbc.deallocate( p2 )
		fbc.deallocate( p1 )
	END_TEST

	TEST( allocs )
		dim p1 as ubyte ptr = fbc.callocate( BUFF_SIZE )
		dim p2 as ubyte ptr = fbc.allocate( BUFF_SIZE )
		dim p3 as ubyte ptr = fbc.reallocate( 0, BUFF_SIZE )
		dim p4 as ubyte ptr = fbc.callocate( BUFF_SIZE )

		'' load data in to first buffer
		*cast(zstring ptr, p1) = "hello world"

		'' copy/move first buffer to other buffers
		fbc.memcopy( p2, p1, BUFF_SIZE )
		fbc.memmove( p3, p1, BUFF_SIZE )

		check( p1, p2, BUFF_SIZE )
		check( p1, p3, BUFF_SIZE )

		'' clear all the buffers
		fbc.clear( p1, 0, BUFF_SIZE )
		fbc.clear( p2, 0, BUFF_SIZE )
		fbc.clear( p3, 0, BUFF_SIZE )

		'' compare with zero'd buffer
		check( p4, p1, BUFF_SIZE )
		check( p4, p2, BUFF_SIZE )
		check( p4, p3, BUFF_SIZE )

		fbc.deallocate( p4 )
		fbc.deallocate( p3 )
		fbc.deallocate( p2 )
		fbc.deallocate( p1 )
	END_TEST

	TEST( memmove_ )

		#macro init_buffer( p )
			for i as integer = 0 to BUFF_SIZE-1
				p[i] = i
			next
		#endmacro

		#macro move_to_idx( p, idx, count )
			for i as integer = count-1 to 0 step -1
				p[idx+i] = p[i]
			next
		#endmacro

		#macro move_from_idx( p, idx, count )
			for i as integer = 0 to count-1
				p[i] = p[idx+i]
			next
		#endmacro

		const index = BUFF_SIZE \ 4
		const bytes = BUFF_SIZE \ 2

		dim p1 as ubyte ptr = fbc.callocate( BUFF_SIZE )
		dim p2 as ubyte ptr = fbc.callocate( BUFF_SIZE )

		init_buffer( p1 )
		init_buffer( p2 )

		'' move to higher overlapping location
		fbc.memmove( p1 + index, p1, bytes )
		move_to_idx( p2, index, bytes )
		check( p1, p2, BUFF_SIZE )

		init_buffer( p1 )
		init_buffer( p2 )

		'' move to lower overlapping location
		fbc.memmove( p1, p1 + index, bytes )
		move_from_idx( p2, index, bytes )
		check( p1, p2, BUFF_SIZE )

		fbc.deallocate( p1 )
		fbc.deallocate( p2 )

	END_TEST

	TEST( copyclear_ )

		#macro init_buffer( p, b )
			for i as integer = 0 to BUFF_SIZE-1
				p[i] = b + i
			next
		#endmacro

		#macro chk_cc( dstlen, srclen, srcbytes, zerobytes, dstbytes )

			scope
				dim src as ubyte ptr = fbc.callocate( BUFF_SIZE )
				dim dst as ubyte ptr = fbc.callocate( BUFF_SIZE )

				CU_ASSERT_EQUAL( BUFF_SIZE, srcbytes+zerobytes+dstbytes )

				init_buffer( src, &h20 )
				init_buffer( dst, &h40 )

				fbc.copyclear( dst, dstlen, src, srclen )

				var same_src = 0
				var same_zero = 0
				var same_dst = 0

				'' check bytes copied from source to dest
				for i as integer = 0 to srcbytes-1
					if( dst[i] = src[i] ) then
						same_src += 1
					end if
				next
				CU_ASSERT_EQUAL( same_src, srcbytes )

				'' check zero bytes set
				for i as integer = 0 to zerobytes-1
					if( dst[i+srcbytes] = 0 ) then
						same_zero += 1
					end if
				next
				CU_ASSERT_EQUAL( same_zero, zerobytes )

				'' check dest bytes not touched due dstlen given smaller than actual buffer
				for i as integer = 0 to dstbytes-1
					if( dst[i+srcbytes+zerobytes] = (&h40+srcbytes+zerobytes+i) ) then
						same_dst += 1
					end if
				next
				CU_ASSERT_EQUAL( same_dst, dstbytes )

				fbc.deallocate( src )
				fbc.deallocate( dst )

			end scope

		#endmacro

		const bytes = BUFF_SIZE \ 2

		'' copy various lengths from source to destination
		'' check that the resulting destination buffer
		'' has expected contents
		''
		''      dst-len    src-len    srcbytes   zerobytes  dstbytes
		''
		chk_cc( BUFF_SIZE, BUFF_SIZE, BUFF_SIZE, 0        , 0         )
		chk_cc( BUFF_SIZE, bytes    , bytes    , bytes    , 0         )
		chk_cc( BUFF_SIZE, 0        , 0        , BUFF_SIZE, 0         )
		chk_cc( bytes    , BUFF_SIZE, bytes    , 0        , bytes     )
		chk_cc( bytes    , bytes    , bytes    , 0        , bytes     )
		chk_cc( bytes    , 0        , 0        , bytes    , bytes     )
		chk_cc( 0        , BUFF_SIZE, 0        , 0        , BUFF_SIZE )
		chk_cc( 0        , bytes    , 0        , 0        , BUFF_SIZE )
		chk_cc( 0        , 0        , 0        , 0        , BUFF_SIZE )

	END_TEST

	TEST( using_fbc )

		'' essentially, a compile test only
		using fbc

		dim p1 as ubyte ptr = callocate( BUFF_SIZE )
		dim p2 as ubyte ptr = allocate( BUFF_SIZE )
		dim p3 as ubyte ptr = reallocate( 0, BUFF_SIZE )
		dim p4 as ubyte ptr = callocate( BUFF_SIZE )

		deallocate( p4 )
		deallocate( p3 )
		deallocate( p2 )
		deallocate( p1 )

		CU_PASS()

	END_TEST

END_SUITE

'' redefinition of allocate/deallocate
''
'' internally, fbc uses global allocate/deallocate
'' to implement NEW, NEW[], DELETE, DELETE[]
''
'' inc/fbc-int/memory.bi has
''   #undef allocate
''   #undef deallocate
''
'' and then adds the declarations back in, however
'' we can test that they can be overridden by
'' providing our own global allocate/deallocate
'' and calling the fbc.allocate/fbc.deallocate
'' instead.

#undef allocate
#undef deallocate

dim shared as integer allocate_count, deallocate_count

'' provide our own global replacement. calling convention
'' does not need to match, although the number of arguments
'' and types need to be compatible.

function allocate( byval size as const uinteger ) as any ptr
	allocate_count += 1
	return fbc.allocate( size )
end function

sub deallocate( byval p as const any ptr )
	deallocate_count += 1
	fbc.deallocate( p )
end sub

SUITE( fbc_tests.fbc_int.memory )

	TEST( new_delete1 )

		allocate_count = 0
		deallocate_count = 0

		scope
			var p = new integer
			CU_ASSERT( allocate_count = 1 )
			CU_ASSERT( deallocate_count = 0 )

			delete p
			CU_ASSERT( allocate_count = 1 )
			CU_ASSERT( deallocate_count = 1 )

		end scope

		scope
			var p = new integer[10]
			CU_ASSERT( allocate_count = 2 )
			CU_ASSERT( deallocate_count = 1 )

			delete p
			CU_ASSERT( allocate_count = 2 )
			CU_ASSERT( deallocate_count = 2 )

		end scope

		CU_ASSERT( allocate_count = 2 )
		CU_ASSERT( deallocate_count = 2 )

	END_TEST

	TEST( new_delete2 )

		'' even though we are importing fbc
		'' namespace, we expect that we still
		'' get our global level allocate/deallocate
		'' for new/delete operation

		using fbc

		allocate_count = 0
		deallocate_count = 0

		scope
			var p = new integer
			CU_ASSERT( allocate_count = 1 )
			CU_ASSERT( deallocate_count = 0 )

			delete p
			CU_ASSERT( allocate_count = 1 )
			CU_ASSERT( deallocate_count = 1 )

		end scope

		scope
			var p = new integer[10]
			CU_ASSERT( allocate_count = 2 )
			CU_ASSERT( deallocate_count = 1 )

			delete p
			CU_ASSERT( allocate_count = 2 )
			CU_ASSERT( deallocate_count = 2 )

		end scope

		CU_ASSERT( allocate_count = 2 )
		CU_ASSERT( deallocate_count = 2 )


#if ENABLE_CHECK_BUGS

		'' after 'using fbc', when calling
		'' allocate/deallocate directly,
		'' we should get the one declared
		'' in the fbc namespace and not
		'' the global one, however, this
		'' this appears to be a bug since
		'' the global definition seems
		'' to overshadow the one we declare

		scope
			var p = allocate( 10 )
			deallocate( p )
		end scope

		CU_ASSERT( allocate_count = 2 )
		CU_ASSERT( deallocate_count = 2 )

#endif

	END_TEST

END_SUITE
