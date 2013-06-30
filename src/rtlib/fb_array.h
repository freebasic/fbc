typedef struct _FBARRAYDIM {
	fbint       elements;
	fbint       lbound;
	fbint       ubound;
} FBARRAYDIM;

typedef struct _FBARRAY {
	void           *data;        /* ptr + diff, must be at ofs 0! */
	void           *ptr;
	fbint       size;
	fbint       element_len;
	fbint       dimensions;
	FBARRAYDIM      dimTB[1];    /* dimtb[dimensions] */
} FBARRAY;

/*!!!REMOVEME!!!*/
typedef struct _FB_ARRAY_TMPDESC {
    FB_LISTELEM     elem;
    FBARRAY         array;
    FBARRAYDIM      dimTB[FB_MAXDIMENSIONS-1];
} FB_ARRAY_TMPDESC;
/*!!!REMOVEME!!!*/

typedef void (*FB_DEFCTOR) ( const void *this_ );
typedef void (*FB_DTORMULT) ( FBARRAY *array, FB_DEFCTOR dtor, fbint base_idx );


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

FBCALL void *fb_ArrayBoundChk
	(
		fbint idx,
		fbint lbound,
		fbint ubound,
		fbint linenum,
		const char *fname
	);

FBCALL void *fb_ArraySngBoundChk
	(
		fbint idx,
		fbint ubound,
		fbint linenum,
		const char *fname
	);

       void       fb_hArrayCtorObj     ( FBARRAY *array, FB_DEFCTOR ctor, fbint base_idx );
       void       fb_hArrayDtorObj     ( FBARRAY *array, FB_DEFCTOR dtor, fbint base_idx );
       void       fb_hArrayDtorStr     ( FBARRAY *array, FB_DEFCTOR dtor, fbint base_idx );
FBCALL void       fb_ArrayDestructObj  ( FBARRAY *array, FB_DEFCTOR dtor );
FBCALL void       fb_ArrayDestructStr  ( FBARRAY *array );
FBCALL fbint  fb_ArrayClear        ( FBARRAY *array, fbint isvarlen );
FBCALL fbint  fb_ArrayClearObj     ( FBARRAY *array, FB_DEFCTOR ctor, FB_DEFCTOR dtor, fbint dofill );
FBCALL fbint  fb_ArrayErase        ( FBARRAY *array, fbint isvarlen );
FBCALL fbint  fb_ArrayEraseObj     ( FBARRAY *array, FB_DEFCTOR dtor );
FBCALL void       fb_ArrayStrErase     ( FBARRAY *array );
       fbint  fb_ArrayRedim        ( FBARRAY *array, fbint element_len, fbint preserve, fbint dimensions, ... );
       fbint  fb_ArrayRedimEx      ( FBARRAY *array, fbint element_len, fbint doclear, fbint isvarlen, fbint dimensions, ... );
       fbint  fb_ArrayRedimObj     ( FBARRAY *array, fbint element_len, FB_DEFCTOR ctor, FB_DEFCTOR dtor, fbint dimensions, ... );
       fbint  fb_ArrayRedimPresv   ( FBARRAY *array, fbint element_len, fbint preserve, fbint dimensions, ... );
       fbint  fb_ArrayRedimPresvEx ( FBARRAY *array, fbint element_len, fbint doclear, fbint isvarlen, fbint dimensions, ... );
       fbint  fb_ArrayRedimPresvObj( FBARRAY *array, fbint element_len, FB_DEFCTOR ctor, FB_DEFCTOR dtor, fbint dimensions, ... );
FBCALL void       fb_ArrayResetDesc    ( FBARRAY *array );
FBCALL fbint  fb_ArrayLBound       ( FBARRAY *array, fbint dimension );
FBCALL fbint  fb_ArrayUBound       ( FBARRAY *array, fbint dimension );
       fbint  fb_hArrayCalcElements( fbint dimensions, const fbint *lboundTB, const fbint *uboundTB );
       fbint  fb_hArrayCalcDiff    ( fbint dimensions, const fbint *lboundTB, const fbint *uboundTB );

fbint fb_hArrayAlloc
	(
		FBARRAY *array,
		fbint element_len,
		fbint doclear,
		FB_DEFCTOR ctor,
		fbint dimensions,
		va_list ap
	);

fbint fb_hArrayRealloc
	(
		FBARRAY *array,
		fbint element_len,
		fbint doclear,
		FB_DEFCTOR ctor,
		FB_DTORMULT dtor_mult,
		FB_DEFCTOR dtor,
		fbint dimensions,
		va_list ap
	);
