/* dynamic arrays core */

#include "fb.h"

fbinteger fb_hArrayCalcElements
	(
		fbinteger dimensions,
		const fbinteger *lboundTB,
		const fbinteger *uboundTB
	)
{
	fbinteger i, elements;

    elements = (uboundTB[0] - lboundTB[0]) + 1;
    for( i = 1; i < dimensions; i++ )
    	elements *= (uboundTB[i] - lboundTB[i]) + 1;

    return elements;
}

fbinteger fb_hArrayCalcDiff
	(
		fbinteger dimensions,
		const fbinteger *lboundTB,
		const fbinteger *uboundTB
	)
{
	fbinteger i, elements, diff = 0;

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
