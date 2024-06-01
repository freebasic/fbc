#include "fbcunit.bi"

SUITE( fbc_tests.pp.macro_arg_listexpand )

	const x0 = 1
	const x1 = 10
	const x2 = 100
	const x3 = 1000
	const x4 = 10000

	dim shared g_args_remain as integer
	dim shared g_next_args as integer
	dim shared g_args_step as integer
	dim shared g_total_args as integer
	dim shared g_total_calls as integer
	dim shared g_total_value as integer

	sub hResetCounts( byval stp as integer, byval args as integer )
		g_args_step = stp
		g_args_remain = args
		if( stp < 0 ) then
			g_next_args = args
		elseif( stp > 0 ) then
			if( g_args_remain >= stp ) then
				g_next_args = stp
			else
				g_next_args = g_args_remain
			end if
		else
			g_next_args = args
		end if
		g_total_calls = 0
		g_total_args = 0
		g_total_value = 0
	end sub

	sub hUpdateCounts( byval args as integer )
		g_total_calls += 1
		g_total_args += args
		if( g_args_step < 0 ) then
			if( g_args_remain >= -g_args_step ) then
				g_args_remain -= -g_args_step
			else
				g_args_remain = 0
			end if
			g_next_args -= -g_args_step
			if( g_next_args < 0 ) then
				g_next_args = 0
			end if
		elseif( g_args_step > 0 ) then
			if( g_args_remain >= g_args_step ) then
				g_args_remain -= g_args_step
			else
				g_args_remain = 0
			end if
			if( g_args_remain >= g_args_step ) then
				g_next_args = g_args_step
			else
				g_next_args = g_args_remain
			end if
		else
			g_next_args = 0
			g_args_remain = 0
		end if
		'' print "UPDATE:", "remain=" & g_args_remain, "NEXT=" & g_next_args
	end sub

	#macro M( args... )
		scope
			const n = __FB_ARG_COUNT__( args )
			#if( n >= 1 )
				g_total_value += __FB_ARG_EXTRACT__( 0, args )
			#endif
			#if( n >= 2 )
				g_total_value += __FB_ARG_EXTRACT__( 1, args )
			#endif
			#if( n >= 3 )
				g_total_value += __FB_ARG_EXTRACT__( 2, args )
			#endif
			#if( n >= 4 )
				g_total_value += __FB_ARG_EXTRACT__( 3, args )
			#endif
			#if( n >= 5 )
				g_total_value += __FB_ARG_EXTRACT__( 4, args )
			#endif
			CU_ASSERT( n = g_next_args )
			hUpdateCounts( n )
		end scope
	#endmacro

	'' Will error because there are no arguments in the list
	'' __FB_ARG_LISTEXPAND__( M, 0 )
	'' __FB_ARG_LISTEXPAND__( M, 1 )
	'' __FB_ARG_LISTEXPAND__( M, 2 )
	'' __FB_ARG_LISTEXPAND__( M, 3 )
	'' __FB_ARG_LISTEXPAND__( M, 4 )
	'' __FB_ARG_LISTEXPAND__( M, 5 )
	'' __FB_ARG_LISTEXPAND__( M, 6 )
	'' __FB_ARG_LISTEXPAND__( M, -1 )
	'' __FB_ARG_LISTEXPAND__( M, -2 )
	'' __FB_ARG_LISTEXPAND__( M, -3 )
	'' __FB_ARG_LISTEXPAND__( M, -4 )
	'' __FB_ARG_LISTEXPAND__( M, -5 )
	'' __FB_ARG_LISTEXPAND__( M, -6 )

	TEST( T_zero_1 )
		hResetCounts( 0, 1 )
		__FB_ARG_LISTEXPAND__( M, 0, x0 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 1 )
		CU_ASSERT( g_total_value = 1 )
	END_TEST
	TEST( T_zero_2 )
		hResetCounts( 0, 2 )
		__FB_ARG_LISTEXPAND__( M, 0, x0, x1 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 2 )
		CU_ASSERT( g_total_value = 1+10 )
	END_TEST
	TEST( T_zero_3 )
		hResetCounts( 0, 3 )
		__FB_ARG_LISTEXPAND__( M, 0, x0, x1, x2 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 3 )
		CU_ASSERT( g_total_value = 1+10+100 )
	END_TEST
	TEST( T_zero_4 )
		hResetCounts( 0, 4 )
		__FB_ARG_LISTEXPAND__( M, 0, x0, x1, x2, x3 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 4 )
		CU_ASSERT( g_total_value = 1+10+100+1000 )
	END_TEST
	TEST( T_zero_5 )
		hResetCounts( 0, 5 )
		__FB_ARG_LISTEXPAND__( M, 0, x0, x1, x2, x3, x4 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 5 )
		CU_ASSERT( g_total_value = 1+10+100+1000+10000 )
	END_TEST

	TEST( T_pos1_1 )
		hResetCounts( 1, 1 )
		__FB_ARG_LISTEXPAND__( M, 1, x0 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 1 )
		CU_ASSERT( g_total_value = 1 )
	END_TEST
	TEST( T_pos1_2 )
		hResetCounts( 1, 2 )
		__FB_ARG_LISTEXPAND__( M, 1, x0, x1 )
		CU_ASSERT( g_total_calls = 2 )
		CU_ASSERT( g_total_args = 2 )
		CU_ASSERT( g_total_value = 1+10 )
	END_TEST
	TEST( T_pos1_3 )
		hResetCounts( 1, 3 )
		__FB_ARG_LISTEXPAND__( M, 1, x0, x1, x2 )
		CU_ASSERT( g_total_calls = 3 )
		CU_ASSERT( g_total_args = 3 )
		CU_ASSERT( g_total_value = 1+10+100 )
	END_TEST
	TEST( T_pos1_4 )
		hResetCounts( 1, 4 )
		__FB_ARG_LISTEXPAND__( M, 1, x0, x1, x2, x3 )
		CU_ASSERT( g_total_calls = 4 )
		CU_ASSERT( g_total_args = 4 )
		CU_ASSERT( g_total_value = 1+10+100+1000 )
	END_TEST
	TEST( T_pos1_5 )
		hResetCounts( 1, 5 )
		__FB_ARG_LISTEXPAND__( M, 1, x0, x1, x2, x3, x4 )
		CU_ASSERT( g_total_calls = 5 )
		CU_ASSERT( g_total_args = 5 )
		CU_ASSERT( g_total_value = 1+10+100+1000+10000 )
	END_TEST

	TEST( T_pos2_1 )
		hResetCounts( 2, 1 )
		__FB_ARG_LISTEXPAND__( M, 2, x0 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 1 )
		CU_ASSERT( g_total_value = 1 )
	END_TEST
	TEST( T_pos2_2 )
		hResetCounts( 2, 2 )
		__FB_ARG_LISTEXPAND__( M, 2, x0, x1 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 2 )
		CU_ASSERT( g_total_value = 1+10 )
	END_TEST
	TEST( T_pos2_3 )
		hResetCounts( 2, 3 )
		__FB_ARG_LISTEXPAND__( M, 2, x0, x1, x2 )
		CU_ASSERT( g_total_calls = 2 )
		CU_ASSERT( g_total_args = 3 )
		CU_ASSERT( g_total_value = 1+10+100 )
	END_TEST
	TEST( T_pos2_4 )
		hResetCounts( 2, 4 )
		__FB_ARG_LISTEXPAND__( M, 2, x0, x1, x2, x3 )
		CU_ASSERT( g_total_calls = 2 )
		CU_ASSERT( g_total_args = 4 )
		CU_ASSERT( g_total_value = 1+10+100+1000 )
	END_TEST
	TEST( T_pos2_5 )
		hResetCounts( 2, 5 )
		__FB_ARG_LISTEXPAND__( M, 2, x0, x1, x2, x3, x4 )
		CU_ASSERT( g_total_calls = 3 )
		CU_ASSERT( g_total_args = 5 )
		CU_ASSERT( g_total_value = 1+10+100+1000+10000 )
	END_TEST

	TEST( T_pos3_1 )
		hResetCounts( 3, 1 )
		__FB_ARG_LISTEXPAND__( M, 3, x0 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 1 )
		CU_ASSERT( g_total_value = 1 )
	END_TEST
	TEST( T_pos3_2 )
		hResetCounts( 3, 2 )
		__FB_ARG_LISTEXPAND__( M, 3, x0, x1 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 2 )
		CU_ASSERT( g_total_value = 1+10 )
	END_TEST
	TEST( T_pos3_3 )
		hResetCounts( 3, 3 )
		__FB_ARG_LISTEXPAND__( M, 3, x0, x1, x2 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 3 )
		CU_ASSERT( g_total_value = 1+10+100 )
	END_TEST
	TEST( T_pos3_4 )
		hResetCounts( 3, 4 )
		__FB_ARG_LISTEXPAND__( M, 3, x0, x1, x2, x3 )
		CU_ASSERT( g_total_calls = 2 )
		CU_ASSERT( g_total_args = 4 )
		CU_ASSERT( g_total_value = 1+10+100+1000 )
	END_TEST
	TEST( T_pos3_5 )
		hResetCounts( 3, 5 )
		__FB_ARG_LISTEXPAND__( M, 3, x0, x1, x2, x3, x4 )
		CU_ASSERT( g_total_calls = 2 )
		CU_ASSERT( g_total_args = 5 )
		CU_ASSERT( g_total_value = 1+10+100+1000+10000 )
	END_TEST

	TEST( T_pos4_1 )
		hResetCounts( 4, 1 )
		__FB_ARG_LISTEXPAND__( M, 4, x0 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 1 )
		CU_ASSERT( g_total_value = 1 )
	END_TEST
	TEST( T_pos4_2 )
		hResetCounts( 4, 2 )
		__FB_ARG_LISTEXPAND__( M, 4, x0, x1 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 2 )
		CU_ASSERT( g_total_value = 1+10 )
	END_TEST
	TEST( T_pos4_3 )
		hResetCounts( 4, 3 )
		__FB_ARG_LISTEXPAND__( M, 4, x0, x1, x2 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 3 )
		CU_ASSERT( g_total_value = 1+10+100 )
	END_TEST
	TEST( T_pos4_4 )
		hResetCounts( 4, 4 )
		__FB_ARG_LISTEXPAND__( M, 4, x0, x1, x2, x3 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 4 )
		CU_ASSERT( g_total_value = 1+10+100+1000 )
	END_TEST
	TEST( T_pos4_5 )
		hResetCounts( 4, 5 )
		__FB_ARG_LISTEXPAND__( M, 4, x0, x1, x2, x3, x4 )
		CU_ASSERT( g_total_calls = 2 )
		CU_ASSERT( g_total_args = 5 )
		CU_ASSERT( g_total_value = 1+10+100+1000+10000 )
	END_TEST

	TEST( T_pos5_1 )
		hResetCounts( 5, 1 )
		__FB_ARG_LISTEXPAND__( M, 5, x0 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 1 )
		CU_ASSERT( g_total_value = 1 )
	END_TEST
	TEST( T_pos5_2 )
		hResetCounts( 5, 2 )
		__FB_ARG_LISTEXPAND__( M, 5, x0, x1 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 2 )
		CU_ASSERT( g_total_value = 1+10 )
	END_TEST
	TEST( T_pos5_3 )
		hResetCounts( 5, 3 )
		__FB_ARG_LISTEXPAND__( M, 5, x0, x1, x2 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 3 )
		CU_ASSERT( g_total_value = 1+10+100 )
	END_TEST
	TEST( T_pos5_4 )
		hResetCounts( 5, 4 )
		__FB_ARG_LISTEXPAND__( M, 5, x0, x1, x2, x3 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 4 )
		CU_ASSERT( g_total_value = 1+10+100+1000 )
	END_TEST
	TEST( T_pos5_5 )
		hResetCounts( 5, 5 )
		__FB_ARG_LISTEXPAND__( M, 5, x0, x1, x2, x3, x4 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 5 )
		CU_ASSERT( g_total_value = 1+10+100+1000+10000 )
	END_TEST

	TEST( T_pos6_1 )
		hResetCounts( 6, 1 )
		__FB_ARG_LISTEXPAND__( M, 6, x0 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 1 )
		CU_ASSERT( g_total_value = 1 )
	END_TEST
	TEST( T_pos6_2 )
		hResetCounts( 6, 2 )
		__FB_ARG_LISTEXPAND__( M, 6, x0, x1 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 2 )
		CU_ASSERT( g_total_value = 1+10 )
	END_TEST
	TEST( T_pos6_3 )
		hResetCounts( 6, 3 )
		__FB_ARG_LISTEXPAND__( M, 6, x0, x1, x2 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 3 )
		CU_ASSERT( g_total_value = 1+10+100 )
	END_TEST
	TEST( T_pos6_4 )
		hResetCounts( 6, 4 )
		__FB_ARG_LISTEXPAND__( M, 6, x0, x1, x2, x3 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 4 )
		CU_ASSERT( g_total_value = 1+10+100+1000 )
	END_TEST
	TEST( T_pos6_5 )
		hResetCounts( 6, 5 )
		__FB_ARG_LISTEXPAND__( M, 6, x0, x1, x2, x3, x4 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 5 )
		CU_ASSERT( g_total_value = 1+10+100+1000+10000 )
	END_TEST

	TEST( T_neg1_1 )
		hResetCounts( -1, 1 )
		__FB_ARG_LISTEXPAND__( M, -1, x0 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 1 )
		CU_ASSERT( g_total_value = 000001 )
	END_TEST
	TEST( T_neg1_2 )
		hResetCounts( -1, 2 )
		__FB_ARG_LISTEXPAND__( M, -1, x0, x1 )
		CU_ASSERT( g_total_calls = 2 )
		CU_ASSERT( g_total_args = 2+1 )
		CU_ASSERT( g_total_value = 00021 )
	END_TEST
	TEST( T_neg1_3 )
		hResetCounts( -1, 3 )
		__FB_ARG_LISTEXPAND__( M, -1, x0, x1, x2 )
		CU_ASSERT( g_total_calls = 3 )
		CU_ASSERT( g_total_args = 3+2+1 )
		CU_ASSERT( g_total_value = 00321 )
	END_TEST
	TEST( T_neg1_4 )
		hResetCounts( -1, 4 )
		__FB_ARG_LISTEXPAND__( M, -1, x0, x1, x2, x3 )
		CU_ASSERT( g_total_calls = 4 )
		CU_ASSERT( g_total_args = 4+3+2+1 )
		CU_ASSERT( g_total_value = 04321 )
	END_TEST
	TEST( T_neg1_5 )
		hResetCounts( -1, 5 )
		__FB_ARG_LISTEXPAND__( M, -1, x0, x1, x2, x3, x4 )
		CU_ASSERT( g_total_calls = 5 )
		CU_ASSERT( g_total_args = 5+4+3+2+1 )
		CU_ASSERT( g_total_value = 54321 )
	END_TEST

	TEST( T_neg2_1 )
		hResetCounts( -2, 1 )
		__FB_ARG_LISTEXPAND__( M, -2, x0 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 1 )
		CU_ASSERT( g_total_value = 00001 )
	END_TEST
	TEST( T_neg2_2 )
		hResetCounts( -2, 2 )
		__FB_ARG_LISTEXPAND__( M, -2, x0, x1 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 2 )
		CU_ASSERT( g_total_value = 00011 )
	END_TEST
	TEST( T_neg2_3 )
		hResetCounts( -2, 3 )
		__FB_ARG_LISTEXPAND__( M, -2, x0, x1, x2 )
		CU_ASSERT( g_total_calls = 2 )
		CU_ASSERT( g_total_args = 3+1 )
		CU_ASSERT( g_total_value = 00211 )
	END_TEST
	TEST( T_neg2_4 )
		hResetCounts( -2, 4 )
		__FB_ARG_LISTEXPAND__( M, -2, x0, x1, x2, x3 )
		CU_ASSERT( g_total_calls = 2 )
		CU_ASSERT( g_total_args = 4+2 )
		CU_ASSERT( g_total_value = 02211 )
	END_TEST
	TEST( T_neg2_5 )
		hResetCounts( -2, 5 )
		__FB_ARG_LISTEXPAND__( M, -2, x0, x1, x2, x3, x4 )
		CU_ASSERT( g_total_calls = 3 )
		CU_ASSERT( g_total_args = 5+3+1 )
		CU_ASSERT( g_total_value = 32211 )
	END_TEST

	TEST( T_neg3_1 )
		hResetCounts( -3, 1 )
		__FB_ARG_LISTEXPAND__( M, -3, x0 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 1 )
		CU_ASSERT( g_total_value = 00001 )
	END_TEST
	TEST( T_neg3_2 )
		hResetCounts( -3, 2 )
		__FB_ARG_LISTEXPAND__( M, -3, x0, x1 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 2 )
		CU_ASSERT( g_total_value = 00011 )
	END_TEST
	TEST( T_neg3_3 )
		hResetCounts( -3, 3 )
		__FB_ARG_LISTEXPAND__( M, -3, x0, x1, x2 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 3 )
		CU_ASSERT( g_total_value = 00111 )
	END_TEST
	TEST( T_neg3_4 )
		hResetCounts( -3, 4 )
		__FB_ARG_LISTEXPAND__( M, -3, x0, x1, x2, x3 )
		CU_ASSERT( g_total_calls = 2 )
		CU_ASSERT( g_total_args = 4+1 )
		CU_ASSERT( g_total_value = 02111 )
	END_TEST
	TEST( T_neg3_5 )
		hResetCounts( -3, 5 )
		__FB_ARG_LISTEXPAND__( M, -3, x0, x1, x2, x3, x4 )
		CU_ASSERT( g_total_calls = 2 )
		CU_ASSERT( g_total_args = 5+2 )
		CU_ASSERT( g_total_value = 22111 )
	END_TEST

	TEST( T_neg4_1 )
		hResetCounts( -4, 1 )
		__FB_ARG_LISTEXPAND__( M, -4, x0 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 1 )
		CU_ASSERT( g_total_value = 00001 )
	END_TEST
	TEST( T_neg4_2 )
		hResetCounts( -4, 2 )
		__FB_ARG_LISTEXPAND__( M, -4, x0, x1 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 2 )
		CU_ASSERT( g_total_value = 00011 )
	END_TEST
	TEST( T_neg4_3 )
		hResetCounts( -4, 3 )
		__FB_ARG_LISTEXPAND__( M, -4, x0, x1, x2 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 3 )
		CU_ASSERT( g_total_value = 00111 )
	END_TEST
	TEST( T_neg4_4 )
		hResetCounts( -4, 4 )
		__FB_ARG_LISTEXPAND__( M, -4, x0, x1, x2, x3 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 4 )
		CU_ASSERT( g_total_value = 01111 )
	END_TEST
	TEST( T_neg4_5 )
		hResetCounts( -4, 5 )
		__FB_ARG_LISTEXPAND__( M, -4, x0, x1, x2, x3, x4 )
		CU_ASSERT( g_total_calls = 2 )
		CU_ASSERT( g_total_args = 5+1 )
		CU_ASSERT( g_total_value = 21111 )
	END_TEST

	TEST( T_neg5_1 )
		hResetCounts( -5, 1 )
		__FB_ARG_LISTEXPAND__( M, -5, x0 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 1 )
		CU_ASSERT( g_total_value = 00001 )
	END_TEST
	TEST( T_neg5_2 )
		hResetCounts( -5, 2 )
		__FB_ARG_LISTEXPAND__( M, -5, x0, x1 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 2 )
		CU_ASSERT( g_total_value = 00011 )
	END_TEST
	TEST( T_neg5_3 )
		hResetCounts( -5, 3 )
		__FB_ARG_LISTEXPAND__( M, -5, x0, x1, x2 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 3 )
		CU_ASSERT( g_total_value = 00111 )
	END_TEST
	TEST( T_neg5_4 )
		hResetCounts( -5, 4 )
		__FB_ARG_LISTEXPAND__( M, -5, x0, x1, x2, x3 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 4 )
		CU_ASSERT( g_total_value = 01111 )
	END_TEST
	TEST( T_neg5_5 )
		hResetCounts( -5, 5 )
		__FB_ARG_LISTEXPAND__( M, -5, x0, x1, x2, x3, x4 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 5 )
		CU_ASSERT( g_total_value = 11111 )
	END_TEST

	TEST( T_neg6_1 )
		hResetCounts( -6, 1 )
		__FB_ARG_LISTEXPAND__( M, -6, x0 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 1 )
		CU_ASSERT( g_total_value = 00001 )
	END_TEST
	TEST( T_neg6_2 )
		hResetCounts( -6, 2 )
		__FB_ARG_LISTEXPAND__( M, -6, x0, x1 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 2 )
		CU_ASSERT( g_total_value = 00011 )
	END_TEST
	TEST( T_neg6_3 )
		hResetCounts( -6, 3 )
		__FB_ARG_LISTEXPAND__( M, -6, x0, x1, x2 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 3 )
		CU_ASSERT( g_total_value = 00111 )
	END_TEST
	TEST( T_neg6_4 )
		hResetCounts( -6, 4 )
		__FB_ARG_LISTEXPAND__( M, -6, x0, x1, x2, x3 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 4 )
		CU_ASSERT( g_total_value = 01111 )
	END_TEST
	TEST( T_neg6_5 )
		hResetCounts( -6, 5 )
		__FB_ARG_LISTEXPAND__( M, -6, x0, x1, x2, x3, x4 )
		CU_ASSERT( g_total_calls = 1 )
		CU_ASSERT( g_total_args = 5 )
		CU_ASSERT( g_total_value = 11111 )
	END_TEST

END_SUITE
