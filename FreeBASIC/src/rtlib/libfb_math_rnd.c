/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2007 The FreeBASIC development team.
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
 */

/*
 * math_rnd.c -- rnd# function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include <stdlib.h>
#include "fb.h"

#define RND_CRT			1
#define RND_SIMPLE		2
#define RND_MTWIST		3
#define RND_QB			4

#define RND_FUNC		RND_CRT


#if RND_FUNC == RND_CRT

/* C runtime library rand() based implementation */

/*:::::*/
FBCALL double fb_Rnd ( int n )
{
	static double last_num;

	if( n == 0 )
		return last_num;

    /* return between 0 and 1 (but never 1) */
	last_num = (double)rand( ) * (1.0 / ((double)RAND_MAX+1.0));

	return last_num;
}


/*:::::*/
FBCALL void fb_Randomize ( double seed )
{

	if( seed == -1.0 )
		seed = fb_Timer( );

	srand( (int)seed );

	rand( );

}



#elif RND_FUNC == RND_SIMPLE

/* Simple implementation, patch provided by yetifoot. */

static uint32_t idum = 0;

/*:::::*/
FBCALL double fb_Rnd ( int n )
{
	static double last_num;
	
	if( n == 0 )
		return last_num;

	/* return between 0 and 1 (but never 1) */
	/* Constants from 'Numerical recipes in C' chapter 7.1 */
	idum = (1664525 * idum + 1013904223);
	last_num = (double)idum / (double)4294967296ULL;
	
	return last_num;
}


/*:::::*/
FBCALL void fb_Randomize ( double seed )
{
	if( seed == -1.0 )
		seed = fb_Timer( );

	idum = (uint32_t)seed;
}



#elif RND_FUNC == RND_MTWIST

/* Marsenne Twister pseudorandom number generator, using */
/* algorithm MT19937 as described in the Wikipedia. */

#define INITIAL_SEED	0xABADCAFE
#define MAX_STATE		624
#define PERIOD			397

static uint32_t state[MAX_STATE], *p = NULL;

/*:::::*/
FBCALL double fb_Rnd ( int n )
{
	uint32_t i, v, xor_mask[2] = { 0, 0x9908B0DF };
	static double last_num;
	
	if (n == 0)
		return last_num;
	
	if (!p) {
		/* initialize state starting with an initial seed */
		fb_Randomize( INITIAL_SEED );
	}
	
	if (p >= state + MAX_STATE) {
		/* generate another array of 624 numbers */
		for (i = 0; i < MAX_STATE - PERIOD; i++) {
			v = (state[i] & 0x80000000) | (state[i + 1] & 0x7FFFFFFF);
			state[i] = state[i + PERIOD] ^ (v >> 1) ^ xor_mask[v & 0x1];
		}
		for (; i < MAX_STATE - 1; i++) {
			v = (state[i] & 0x80000000) | (state[i + 1] & 0x7FFFFFFF);
			state[i] = state[i + PERIOD - MAX_STATE] ^ (v >> 1) ^ xor_mask[v & 0x1];
		}
		v = (state[MAX_STATE - 1] & 0x80000000) | (state[0] & 0x7FFFFFFF);
		state[MAX_STATE - 1] = state[PERIOD - 1] ^ (v >> 1) ^ xor_mask[v & 0x1];
		p = state;
	}
	
	v = *p++;

	v ^= (v >> 11);
	v ^= ((v << 7) & 0x9D2C5680);
	v ^= ((v << 15) & 0xEFC60000);
	v ^= (v >> 18);
	
	last_num = (double)v / (double)4294967296ULL;
	
	return last_num;
}


/*:::::*/
FBCALL void fb_Randomize ( double seed )
{
	int i;
	
	if (seed == -1.0)
		seed = fb_Timer();
	
	state[0] = (uint32_t)seed;
	for (i = 1; i < MAX_STATE; i++)
		state[i] = (state[i - 1] * 1664525) + 1013904223;
	p = state + MAX_STATE;
}



#elif RND_FUNC == RND_QB

/* QB-compatible implementation, by counting_pine. */
/* Missing manual user input of random seed if RANDOMIZE without params is called */

static uint32_t seed = 327680;

/*:::::*/
FBCALL double fb_Rnd ( int n )
{
	if (n) {
		if (n < 0)
			seed = (n & 0xFFFFFF) + ((unsigned int)n >> 24);
		seed = ((seed * 16598013) + 12820163) & 0xFFFFFF;
	}
	return (double)seed / (double)0x1000000;
}


/*:::::*/
FBCALL void fb_Randomize ( double s )
{
	if (seed == -1.0)
		seed = fb_Timer();
	seed = ((uint32_t *)&s)[1];
	seed ^= (seed >> 16);
	seed = ((seed & 0xFFFF) << 8) | (seed & 0xFF);
}



#else
	#error RND function implementation not defined!
#endif
