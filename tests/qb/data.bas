' TEST_MODE : COMPILE_AND_RUN_OK

#define ASSERT(e) if (e) = 0 then fb_Assert(__FILE__, __LINE__, __FUNCTION__, #e)

const EPSILON_DBL = 2.2204460492503131e-016

	Dim i As Integer
	Dim v As Double
	
	Data  .25, .025, .0025
	data 0.25, 0.025, 0.0025
	
	dim c as double 
	c = .25
	For i = 1 To 3
	    Read v
	    assert( (v - c) < EPSILON_DBL )
	    c *= 0.1
	next i
	
	c = .25
	For i = 1 To 3
	    Read v
	    assert( (v - c) < EPSILON_DBL )
	    c *= 0.1
	next i
