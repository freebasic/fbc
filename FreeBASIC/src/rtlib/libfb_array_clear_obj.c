/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2010 The FreeBASIC development team.
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
 * array_clear_obj.c -- ERASE function for static arrays of objects
 *
 * chng: jan/2005 written [v1ctor]
 *
 */

#include <stdlib.h>
#include "fb.h"

/*:::::*/
FBCALL int fb_ArrayClearObj
	( 
		FBARRAY *array, 
		FB_DEFCTOR ctor, 
		FB_DEFCTOR dtor, 
		int dofill
	)
{
    /* not an error, see fb_ArrayEraseObj() */
    if( array->ptr == NULL )
    	return fb_ErrorSetNum( FB_RTERROR_OK );
    
    /* call dtors */
    if( dtor )
    	fb_hArrayDtorObj( array, dtor, 0 );
	
	if( dofill != FB_FALSE )
	{
		/* clear stills needed, the default dtor will just call other dtors
	   	   and free dynamic data, the non-dynamic fields would still the same */ 
		memset( array->ptr, 0, array->size );
		
		/* call ctors */
		if( ctor )
			fb_hArrayCtorObj( array, ctor, 0 );
			
	}

   	return fb_ErrorSetNum( FB_RTERROR_OK );
}
