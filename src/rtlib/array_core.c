/* dynamic arrays core */

#include "fb.h"

fbint fb_hArrayCalcElements
	(
		fbint dimensions,
		const fbint *lboundTB,
		const fbint *uboundTB
	)
{
	fbint i, elements;

    elements = (uboundTB[0] - lboundTB[0]) + 1;
    for( i = 1; i < dimensions; i++ )
    	elements *= (uboundTB[i] - lboundTB[i]) + 1;

    return elements;
}

fbint fb_hArrayCalcDiff
	(
		fbint dimensions,
		const fbint *lboundTB,
		const fbint *uboundTB
	)
{
	fbint i, elements, diff = 0;

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
