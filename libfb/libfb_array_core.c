/*
 * array_core.c -- dynamic arrays core
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include "fb.h"

/*:::::*/
int fb_hArrayCalcElements
	( 
		int dimensions, 
		const int *lboundTB, 
		const int *uboundTB 
	)
{
	int i;
	int elements;

    elements = (uboundTB[0] - lboundTB[0]) + 1;
    for( i = 1; i < dimensions; i++ )
    	elements *= (uboundTB[i] - lboundTB[i]) + 1;

    return elements;
}

/*:::::*/
int fb_hArrayCalcDiff
	( 
		int dimensions, 
		const int *lboundTB, 
		const int *uboundTB 
	)
{
	int i;
	int elements;
	int diff = 0;

	if( dimensions <= 0 )
		return 0;

    for( i = 0; i < dimensions-1; i++ )
    {
    	elements = (uboundTB[i+1] - lboundTB[i+1]) + 1;
    	diff = (diff + lboundTB[i]) * elements;
    }

	diff += lboundTB[dimensions-1];

	return -diff;
}

