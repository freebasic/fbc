/* Mach-O (Darwin) requires pointer-sized relocations to be aligned; the packed
   layout would place the embedded pointers at 2-byte offsets, which ld64
   rejects ("pointer not aligned ...", a hard error on arm64).  The compiler
   emits the matching naturally-aligned layout for Darwin targets, see
   hCreateDataDesc() in src/compiler/ast-node-data.bas. */
#if defined(__APPLE__)
	#define FB_DATADESC_PACKED
#else
	#define FB_DATADESC_PACKED FBPACKED
#endif

struct _FB_DATADESC {
	short 					len;
	union {
		char 				*zstr;
		FB_WCHAR			*wstr;
		void   				*ofs;
		struct _FB_DATADESC *next;
	};
} FB_DATADESC_PACKED;

typedef struct _FB_DATADESC FB_DATADESC;

extern FB_DATADESC *__fb_data_ptr;

#define FB_DATATYPE_LINK -1
#define FB_DATATYPE_OFS  -2
#define FB_DATATYPE_WSTR 0x8000

FBCALL void         fb_DataRestore      ( FB_DATADESC *labeladdr );
       void         fb_DataNext         ( void );
FBCALL void         fb_DataReadStr      ( void *dst, ssize_t dst_size, int fillrem );
FBCALL void         fb_DataReadWstr     ( FB_WCHAR *dst, ssize_t dst_size );
FBCALL void         fb_DataReadBool     ( char *dst );
FBCALL void         fb_DataReadByte     ( char *dst );
FBCALL void         fb_DataReadUByte    ( unsigned char *dst );
FBCALL void         fb_DataReadShort    ( short *dst );
FBCALL void         fb_DataReadUShort   ( unsigned short *dst );
FBCALL void         fb_DataReadInt      ( int *dst );
FBCALL void         fb_DataReadUInt     ( unsigned int *dst );
FBCALL void         fb_DataReadLongint  ( long long *dst );
FBCALL void         fb_DataReadULongint ( unsigned long long *dst );
FBCALL void         fb_DataReadSingle   ( float *dst );
FBCALL void         fb_DataReadDouble   ( double *dst );
