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
