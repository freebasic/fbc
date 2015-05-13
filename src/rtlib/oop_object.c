/* Object class methods */

#include "fb.h"

	FB_RTTI __fb_ZTS6Object = { NULL, "6OBJECT", NULL };
	static FB_BASEVT Object_VT = { NULL, &__fb_ZTS6Object };

/* constructor fb_Object$( ) */
void _ZN10fb_Object$C1Ev( FB_OBJECT *this_ )
{
	this_->pVT = (FB_BASEVT *)(((unsigned char *)&Object_VT) + sizeof( FB_BASEVT ));
}
