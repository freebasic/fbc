struct _FB_DATADESC {
	short 					len;
	union {
		char 				*zstr;
		FB_WCHAR			*wstr;
		void   				*ofs;
		struct _FB_DATADESC *next;
	};
} FBPACKED;

typedef struct _FB_DATADESC FB_DATADESC;

extern FB_DATADESC *__fb_data_ptr;

#define FB_DATATYPE_LINK -1
#define FB_DATATYPE_OFS  -2
#define FB_DATATYPE_WSTR 0x8000

FBCALL void 		fb_DataRestore		( FB_DATADESC *labeladdr );
FBCALL void         fb_DataReadStr      ( void *dst, int dst_size, int fillrem );
FBCALL void         fb_DataReadByte     ( char *dst );
FBCALL void         fb_DataReadUByte    ( unsigned char *dst );
FBCALL void         fb_DataReadShort    ( short *dst );
FBCALL void         fb_DataReadUShort   ( unsigned short *dst );
FBCALL void         fb_DataReadInt      ( int *dst );
FBCALL void         fb_DataReadUInt     ( unsigned int *dst );
FBCALL void 		fb_DataReadLongint	( long long *dst );
FBCALL void 		fb_DataReadULongint	( unsigned long long *dst );
FBCALL void         fb_DataReadSingle   ( float *dst );
FBCALL void         fb_DataReadDouble   ( double *dst );

       short        fb_DataGetLen       ( void );
