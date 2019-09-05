typedef struct _FBARRAYDIM {
	size_t elements;
	ssize_t lbound;
	ssize_t ubound;
} FBARRAYDIM;

typedef enum _FBARRAY_FLAGS {
	FBARRAY_FLAGS_DIMENSIONS = 0x0000000f,
	FBARRAY_FLAGS_FIXED_DIM  = 0x00000010,
	FBARRAY_FLAGS_FIXED_LEN  = 0x00000020,
	FBARRAY_FLAGS_ATTACHED   = 0x00000040,
	FBARRAY_FLAGS_RESERVED   = 0xffffffc0
} FBARRAY_FLAGS;

typedef struct _FBARRAY {
	void           *data;        /* ptr + diff, must be at ofs 0! */
	void           *ptr;
	size_t          size;
	size_t          element_len;
	size_t          dimensions;
	size_t          flags;       /* FBARRAY_FLAGS */
	FBARRAYDIM      dimTB[1];    /* dimtb[dimensions] */
} FBARRAY;

/*!!!REMOVEME!!!*/
typedef struct _FB_ARRAY_TMPDESC {
    FB_LISTELEM     elem;

    FBARRAY         array;
    FBARRAYDIM      dimTB[FB_MAXDIMENSIONS-1];
} FB_ARRAY_TMPDESC;
/*!!!REMOVEME!!!*/

typedef void (*FB_DEFCTOR)( void *this_ );
typedef void (*FB_DTORMULT) ( FBARRAY *array, FB_DEFCTOR dtor, size_t base_idx );

FBCALL void *fb_ArrayBoundChk
	(
		ssize_t idx,
		ssize_t lbound,
		ssize_t ubound,
		int linenum,
		const char *fname
	);

FBCALL void *fb_ArraySngBoundChk
	(
		size_t idx,
		size_t ubound,
		int linenum,
		const char *fname
	);

       void       fb_hArrayCtorObj     ( FBARRAY *array, FB_DEFCTOR ctor, size_t base_idx );
       void       fb_hArrayDtorObj     ( FBARRAY *array, FB_DEFCTOR dtor, size_t base_idx );
       void       fb_hArrayDtorStr     ( FBARRAY *array, FB_DEFCTOR dtor, size_t base_idx );
FBCALL void       fb_ArrayDestructObj  ( FBARRAY *array, FB_DEFCTOR dtor );
FBCALL void       fb_ArrayDestructStr  ( FBARRAY *array );
FBCALL int        fb_ArrayClear        ( FBARRAY *array, int isvarlen );
FBCALL int        fb_ArrayClearObj     ( FBARRAY *array, FB_DEFCTOR ctor, FB_DEFCTOR dtor, int dofill );
FBCALL int        fb_ArrayErase        ( FBARRAY *array, int isvarlen );
FBCALL int        fb_ArrayEraseObj     ( FBARRAY *array, FB_DEFCTOR dtor );
FBCALL FBARRAY   *fb_ArrayGetDesc      ( FBARRAY *array );
FBCALL void       fb_ArrayStrErase     ( FBARRAY *array );
       int        fb_ArrayRedim        ( FBARRAY *array, size_t element_len, int preserve, size_t dimensions, ... );
       int        fb_ArrayRedimEx      ( FBARRAY *array, size_t element_len, int doclear, int isvarlen, size_t dimensions, ... );
       int        fb_ArrayRedimObj     ( FBARRAY *array, size_t element_len, FB_DEFCTOR ctor, FB_DEFCTOR dtor, size_t dimensions, ... );
       int        fb_ArrayRedimPresv   ( FBARRAY *array, size_t element_len, int preserve, size_t dimensions, ... );
       int        fb_ArrayRedimPresvEx ( FBARRAY *array, size_t element_len, int doclear, int isvarlen, size_t dimensions, ... );
       int        fb_ArrayRedimPresvObj( FBARRAY *array, size_t element_len, FB_DEFCTOR ctor, FB_DEFCTOR dtor, size_t dimensions, ... );
FBCALL int        fb_ArrayRedimTo      ( FBARRAY *dest, const FBARRAY *source, int isvarlen, FB_DEFCTOR ctor, FB_DEFCTOR dtor );
FBCALL void       fb_ArrayResetDesc    ( FBARRAY *array );
FBCALL ssize_t    fb_ArrayLBound       ( FBARRAY *array, ssize_t dimension );
FBCALL ssize_t    fb_ArrayUBound       ( FBARRAY *array, ssize_t dimension );
       size_t     fb_hArrayCalcElements( size_t dimensions, const ssize_t *lboundTB, const ssize_t *uboundTB );
       ssize_t    fb_hArrayCalcDiff    ( size_t dimensions, const ssize_t *lboundTB, const ssize_t *uboundTB );

typedef struct _array_index {
    size_t   n;                                       
    size_t   li;                                      
    ssize_t  i1;                                      
    ssize_t  i2;                                      
    ssize_t  i3;                                      
    ssize_t  i4;
    ssize_t  i5;
    ssize_t  i6;
    ssize_t  i7;
    ssize_t  i8;
} array_index;

typedef struct _array_dim_type {
    ssize_t  i1s;                                     
    ssize_t  i1e;
    ssize_t  i2s;
    ssize_t  i2e;
    ssize_t  i3s;
    ssize_t  i3e;
    ssize_t  i4s;
    ssize_t  i4e;
    ssize_t  i5s;
    ssize_t  i5e;
    ssize_t  i6s;
    ssize_t  i6e;
    ssize_t  i7s;
    ssize_t  i7e;
    ssize_t  i8s;
    ssize_t  i8e;
} array_dim_type;

FBCALL void       *fb_ArrayDesc        ( FBARRAY *array, int mode );     
                                                     
FBCALL size_t     fb_ArrayCalcPos      ( FBARRAY *array, void *p );      
FBCALL int        fb_ArrayCalcIdxPos   ( FBARRAY *array, size_t pos, array_index *ai ); 
FBCALL int        fb_ArrayCalcIdxPtr   ( FBARRAY *array, void *p, array_index *ai ); 

FBCALL void       *fb_ArrayShift       ( FBARRAY *array, void *p, size_t li, size_t c, int flag ); 
FBCALL int        fb_ArraySort         ( FBARRAY *array, FBARRAY *array2, int t, void *cbp, void *p, size_t li, size_t c, size_t o ); 

FBCALL int        fb_ArrayAttach       ( FBARRAY *array, array_dim_type *adt, int n, void *mp ); 
FBCALL int        fb_ArrayReset        ( FBARRAY *array );          
FBCALL size_t     fb_ArrayScan         ( FBARRAY *array, void *cbp, int len, void *ps, ssize_t offset, int caseflag, array_index *ai, int flag, size_t c, size_t o ); 

enum array_enums_                                     
{
    adt_byte         =  1,                            
    adt_ubyte            ,
    adt_short            ,
    adt_ushort           ,
    adt_integer          ,
    adt_uinteger         ,
    adt_long             ,
    adt_ulong            ,
    adt_longint          ,
    adt_ulongint         ,
                     
    adt_single       = 20,
    adt_double           ,
                     
    adt_zstring      = 30,
    adt_fixstring        ,
    adt_string           ,
    adt_wstring          ,
    adt_ustring          ,
                     
    adt_struct       = 40,
    adt_function     = 50,
                     
    array_desc       = 60,                            
    array_data           ,                            
    array_dimensions     ,                            
    array_totalsize      ,                            
    array_totalcount     ,                            
    array_size           ,                            
    array_is_fixed_len   ,                            
    array_is_fixed_dim   ,                            
    array_is_dynamic     ,                            
    array_is_attached    ,                            
};  

int fb_hArrayAlloc
	(
		FBARRAY *array,
		size_t element_len,
		int doclear,
		FB_DEFCTOR ctor,
		size_t dimensions,
		va_list ap
	);

int fb_hArrayRealloc
	(
		FBARRAY *array,
		size_t element_len,
		int doclear,
		FB_DEFCTOR ctor,
		FB_DTORMULT dtor_mult,
		FB_DEFCTOR dtor,
		size_t dimensions,
		va_list ap
	);
