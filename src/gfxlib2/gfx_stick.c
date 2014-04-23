/* QB compatible STICK(n) and STRIG(n) functions */

#include "fb_gfx.h"

/* save state for x,y,buttons for A,B sticks */
static int stick_posn[4] = { 0, 0, 0, 0 };
static int stick_btns[2] = { 0, 0 };

FBCALL int fb_GfxStickQB( int n )
{
	int result;

	/*
		if n == 0 then 
			read and save x,y positions for stick A and B.
			return A.x
		if n == 1,2,3
			return the last read position for A.y, B.x, B.y
	*/

	FB_GRAPHICS_LOCK( );

	if( n >= 0 && n <= 3 )
	{
		if( n == 0 )
		{
			int i;
			for( i=0; i<2; i++ )
			{
				float x, y, a;
				ssize_t buttons;
				int ret = fb_GfxGetJoystick( i, &buttons, &x, &y, &a, &a, &a, &a, &a, &a );
				if( ret == FB_RTERROR_OK )
				{
					stick_posn[i*2] = (int)(x * 100 + 101);
					stick_posn[i*2+1] = (int)(y * 100 + 101);
					stick_btns[i] = buttons;
				}
				else
				{
					stick_posn[i*2] = 0;
					stick_posn[i*2+1] = 0;
					stick_btns[i] = 0;
				}
			}
		}

		result = stick_posn[n];
	} else {
		result = 0;
		fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

	FB_GRAPHICS_UNLOCK( );
	return result;
}

FBCALL int fb_GfxStrigQB( int n )
{
	int result;

	/* 
		n	result ( -1 == TRUE, 0 == FALSE )
		0	A button 1 pressed since last STICK(0)
		1	A button 1 is pressed
		2	B button 1 pressed since last STICK(0)
		3	B button 1 is pressed
		4	A button 2 pressed since last STICK(0)
		5	A button 2 is pressed
		6	B button 2 pressed since last STICK(0)
		7	B button 2 is pressed
	*/

	FB_GRAPHICS_LOCK( );

	if( (n >= 0) && (n <= 7) )
	{
		int i = (n>>1)&1;
		int bmask = (n>>2)+1;

		if( n & 1 )
		{
			float a;
			ssize_t buttons;
			if( FB_RTERROR_OK == fb_GfxGetJoystick( i, &buttons, &a, &a, &a, &a, &a, &a, &a, &a ))
			{
				stick_btns[i] |= buttons;
				result = ( buttons & bmask) ? -1 : 0;
			} else {
				result = 0;
				fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
			}
		} else {
			result = ( stick_btns[i] & bmask) ? -1 : 0;
		}
	} else {
		result = 0;
		fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

	FB_GRAPHICS_UNLOCK( );
	return result;
}
