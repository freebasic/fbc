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

#ifndef __FB_ARRAY_H__
#define __FB_ARRAY_H__

typedef struct _FBARRAYDIM {
    int             elements;
    int             lbound;
    int             ubound;
} FBARRAYDIM;

typedef struct _FBARRAY {
    void           *data;               /* ptr + diff, must be at ofs 0! */
    void           *ptr;
    int             size;
    int             element_len;
    int             dimensions;
    FBARRAYDIM      dimTB[1];           /* dimtb[dimensions] */
} FBARRAY;

/*!!!REMOVEME!!!*/
typedef struct _FB_ARRAY_TMPDESC {
    FB_LISTELEM     elem;

    FBARRAY         array;
    FBARRAYDIM      dimTB[FB_MAXDIMENSIONS-1];
} FB_ARRAY_TMPDESC;
/*!!!REMOVEME!!!*/

typedef void (*FB_DEFCTOR) ( const void *this_ );

typedef void (*FB_DTORMULT) ( FBARRAY *array, FB_DEFCTOR dtor, int base_idx );


#define FB_ARRAY_SETDESC(_array, _elen, _dims, _size, _diff)          \
    do {                                                              \
        _array->element_len = _elen;                                  \
        _array->dimensions  = _dims;                                  \
        _array->size        = _size;                                  \
                                                                      \
        if( _array->ptr != NULL )                                     \
            _array->data = ((unsigned char*) _array->ptr) + (_diff);  \
        else                                                          \
            _array->data = NULL;                                      \
    } while (0)

/* protos */

int fb_ArrayRedim 
	( 
		FBARRAY *array, 
		int element_len, 
		int preserve,
       	int dimensions, 
       	... 
	);

int fb_ArrayRedimEx
	( 
		FBARRAY *array, 
		int element_len, 
		int doclear, 
		int isvarlen, 
		int dimensions, 
		... 
	);
   
int fb_ArrayRedimObj
	( 
		FBARRAY *array, 
		int element_len, 
		FB_DEFCTOR ctor,
		FB_DEFCTOR dtor,
		int dimensions, 
		... 
	);

int fb_ArrayRedimPresv 
	( 
		FBARRAY *array, 
		int element_len, 
		int preserve,
       	int dimensions, 
       	... 
	);

int fb_ArrayRedimPresvEx
	( 
		FBARRAY *array, 
		int element_len, 
		int doclear, 
		int isvarlen, 
		int dimensions, 
		... 
	);
    
int fb_ArrayRedimPresvObj
	( 
		FBARRAY *array, 
		int element_len, 
		FB_DEFCTOR ctor,
		FB_DEFCTOR dtor,
		int dimensions, 
		... 
	);

FBCALL int fb_ArrayErase
	( 
		FBARRAY *array, 
		int isvarlen 
	);

FBCALL int fb_ArrayEraseObj
	( 
		FBARRAY *array, 
		FB_DEFCTOR dtor
	);

FBCALL void fb_ArrayStrErase    
	( 
		FBARRAY *array 
	);

FBCALL int fb_ArrayClear
	( 
		FBARRAY *array, 
		int isvarlen 
	);

FBCALL int fb_ArrayClearObj
	( 
		FBARRAY *array, 
		FB_DEFCTOR ctor, 
		FB_DEFCTOR dtor, 
		int dofill
	);

FBCALL void fb_ArrayResetDesc
	( 
		FBARRAY *array 
	);
	
FBCALL int fb_ArrayLBound      
	( 
		FBARRAY *array, 
		int dimension 
	);

FBCALL int fb_ArrayUBound      
	( 
		FBARRAY *array, 
		int dimension 
	);

int fb_hArrayCalcElements
	( 
		int dimensions, 
		const int *lboundTB,
       	const int *uboundTB 
	);

int fb_hArrayCalcDiff   
	( 
		int dimensions, 
		const int *lboundTB,
       	const int *uboundTB 
	);

int fb_hArrayAlloc
	( 
		FBARRAY *array, 
		int element_len, 
		int doclear, 
		FB_DEFCTOR ctor,
		int dimensions, 
		va_list ap 
	);

int fb_hArrayRealloc
	( 
		FBARRAY *array, 
		int element_len, 
		int doclear, 
		FB_DEFCTOR ctor,
		FB_DTORMULT dtor_mult,
		FB_DEFCTOR dtor,
		int dimensions, 
		va_list ap 
	);

void fb_hArrayDtorStr
	( 
		FBARRAY *array, 
		FB_DEFCTOR dtor,
		int base_idx
	);

void fb_hArrayDtorObj
	( 
		FBARRAY *array, 
		FB_DEFCTOR dtor,
		int base_idx
	);

void fb_hArrayCtorObj
	(
		FBARRAY *array,
		FB_DEFCTOR ctor,
		int base_idx
	);

#endif /* __FB_ARRAY_H__ */
