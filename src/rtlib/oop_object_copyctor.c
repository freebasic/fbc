#include "fb.h"

/* constructor fb_Object$( byref rhs as const fb_Object$ ) */
void _ZN10fb_Object$C1ERKS_( FB_OBJECT *this_, const FB_OBJECT *rhs )
{
	/* Just initialize the vptr properly (we cannot just copy it from the
	   rhs, because that may really be a different object type that just was
	   up-casted), nothing else to do. */
	_ZN10fb_Object$C1Ev( this_ );
}
