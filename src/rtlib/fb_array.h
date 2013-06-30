typedef struct _FBARRAYDIM {
	fbinteger       elements;
	fbinteger       lbound;
	fbinteger       ubound;
} FBARRAYDIM;

typedef struct _FBARRAY {
	void           *data;        /* ptr + diff, must be at ofs 0! */
	void           *ptr;
	fbinteger       size;
	fbinteger       element_len;
	fbinteger       dimensions;
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
typedef void (*FB_DTORMULT) ( FBARRAY *array, FB_DEFCTOR dtor, fbinteger base_idx );


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
		fbinteger idx,
		fbinteger lbound,
		fbinteger ubound,
		fbinteger linenum,
		const char *fname
	);

FBCALL void *fb_ArraySngBoundChk
	(
		fbinteger idx,
		fbinteger ubound,
		fbinteger linenum,
		const char *fname
	);

       void       fb_hArrayCtorObj     ( FBARRAY *array, FB_DEFCTOR ctor, fbinteger base_idx );
       void       fb_hArrayDtorObj     ( FBARRAY *array, FB_DEFCTOR dtor, fbinteger base_idx );
       void       fb_hArrayDtorStr     ( FBARRAY *array, FB_DEFCTOR dtor, fbinteger base_idx );
FBCALL void       fb_ArrayDestructObj  ( FBARRAY *array, FB_DEFCTOR dtor );
FBCALL void       fb_ArrayDestructStr  ( FBARRAY *array );
FBCALL fbinteger  fb_ArrayClear        ( FBARRAY *array, fbinteger isvarlen );
FBCALL fbinteger  fb_ArrayClearObj     ( FBARRAY *array, FB_DEFCTOR ctor, FB_DEFCTOR dtor, fbinteger dofill );
FBCALL fbinteger  fb_ArrayErase        ( FBARRAY *array, fbinteger isvarlen );
FBCALL fbinteger  fb_ArrayEraseObj     ( FBARRAY *array, FB_DEFCTOR dtor );
FBCALL void       fb_ArrayStrErase     ( FBARRAY *array );
       fbinteger  fb_ArrayRedim        ( FBARRAY *array, fbinteger element_len, fbinteger preserve, fbinteger dimensions, ... );
       fbinteger  fb_ArrayRedimEx      ( FBARRAY *array, fbinteger element_len, fbinteger doclear, fbinteger isvarlen, fbinteger dimensions, ... );
       fbinteger  fb_ArrayRedimObj     ( FBARRAY *array, fbinteger element_len, FB_DEFCTOR ctor, FB_DEFCTOR dtor, fbinteger dimensions, ... );
       fbinteger  fb_ArrayRedimPresv   ( FBARRAY *array, fbinteger element_len, fbinteger preserve, fbinteger dimensions, ... );
       fbinteger  fb_ArrayRedimPresvEx ( FBARRAY *array, fbinteger element_len, fbinteger doclear, fbinteger isvarlen, fbinteger dimensions, ... );
       fbinteger  fb_ArrayRedimPresvObj( FBARRAY *array, fbinteger element_len, FB_DEFCTOR ctor, FB_DEFCTOR dtor, fbinteger dimensions, ... );
FBCALL void       fb_ArrayResetDesc    ( FBARRAY *array );
FBCALL fbinteger  fb_ArrayLBound       ( FBARRAY *array, fbinteger dimension );
FBCALL fbinteger  fb_ArrayUBound       ( FBARRAY *array, fbinteger dimension );
       fbinteger  fb_hArrayCalcElements( fbinteger dimensions, const fbinteger *lboundTB, const fbinteger *uboundTB );
       fbinteger  fb_hArrayCalcDiff    ( fbinteger dimensions, const fbinteger *lboundTB, const fbinteger *uboundTB );

fbinteger fb_hArrayAlloc
	(
		FBARRAY *array,
		fbinteger element_len,
		fbinteger doclear,
		FB_DEFCTOR ctor,
		fbinteger dimensions,
		va_list ap
	);

fbinteger fb_hArrayRealloc
	(
		FBARRAY *array,
		fbinteger element_len,
		fbinteger doclear,
		FB_DEFCTOR ctor,
		FB_DTORMULT dtor_mult,
		FB_DEFCTOR dtor,
		fbinteger dimensions,
		va_list ap
	);
