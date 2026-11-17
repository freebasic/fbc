#include "fbcunit.bi"

'' darwin: THREADCREATE without a stack size took PTHREAD_STACK_MIN of darwin
'' (8 KB on x86_64, 16 KB on arm64) as the stack size, so a thread with big
'' local variables crashed. It takes at least 8 MB now.

#if defined( __FB_DARWIN__ )

SUITE( fbc_tests.threads.darwin_stack )

	const BUFF_SIZE = 1024 * 1024

	dim shared as longint result

	private sub bigLocals( byval p as any ptr )
		'' 1 MB on the stack of the thread
		dim as ubyte buff(0 to BUFF_SIZE - 1)
		dim as longint sum = 0

		for i as integer = 0 to BUFF_SIZE - 1 step 4096
			buff(i) = (i \ 4096) and 255
		next
		for i as integer = 0 to BUFF_SIZE - 1 step 4096
			sum += buff(i)
		next

		result = sum
	end sub

	TEST( defaultStackSize )
		dim as longint expected = 0
		for i as integer = 0 to BUFF_SIZE - 1 step 4096
			expected += (i \ 4096) and 255
		next

		result = -1
		dim as any ptr t = threadcreate( @bigLocals )
		CU_ASSERT( t <> 0 )
		if( t ) then
			threadwait( t )
		end if
		CU_ASSERT_EQUAL( result, expected )
	END_TEST

END_SUITE

#endif
