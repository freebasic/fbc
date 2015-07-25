/* strings */

/** Flag to identify a string as a temporary string.
 *
 * This flag is stored in struct _FBSTRING::len so it's absolutely required
 * to use FB_STRSIZE(s) to query a strings length.
 */
#ifdef HOST_64BIT
	#define FB_TEMPSTRBIT ((long long)0x8000000000000000ll)
#else
	#define FB_TEMPSTRBIT ((int)0x80000000)
#endif

/** Returns if the string is a temporary string.
 */
#define FB_ISTEMP(s) ((((FBSTRING *)s)->len & FB_TEMPSTRBIT) != 0)

/** Returns a string length.
 */
#define FB_STRSIZE(s) ((ssize_t)(((FBSTRING *)s)->len & ~FB_TEMPSTRBIT))

/** Returns the string data.
 */
#define FB_STRPTR(s,size)                     \
    ( s == NULL? NULL : ( size == -1? ((FBSTRING *)s)->data : (char *)s ) )

#define FB_STRSETUP_FIX(s,size,ptr,len)                     \
do {                                                        \
    if( s == NULL )                                         \
    {                                                       \
        ptr = NULL;                                         \
        len = 0;                                            \
    }                                                       \
    else                                                    \
    {                                                       \
        if( size == -1 )                                    \
        {                                                   \
            ptr = ((FBSTRING *)s)->data;                    \
            len = FB_STRSIZE( s );                          \
        }                                                   \
        else                                                \
        {                                                   \
            ptr = (char *)s;                                \
            /* always get the real len, as fix-len string */ \
            /* will have garbage at end (nulls or spaces) */ \
            len = strlen( (char *)s );                      \
        }                                                   \
    }                                                       \
} while (0)

#define FB_STRSETUP_DYN(s,size,ptr,len)                     \
do {                                                        \
    if( s == NULL )                                         \
    {                                                       \
        ptr = NULL;                                         \
        len = 0;                                            \
    }                                                       \
    else                                                    \
    {                                                       \
        switch ( size ) {                                   \
        case -1:                                            \
            ptr = ((FBSTRING *)s)->data;                    \
            len = FB_STRSIZE( s );                          \
            break;                                          \
        case 0:                                             \
            ptr = (char *) s;                               \
            len = strlen( ptr );                            \
            break;                                          \
        default:                                            \
            ptr = (char *) s;                               \
            len = size - 1; /* without terminating NUL */   \
            break;                                          \
        }                                                   \
    }                                                       \
} while (0)

/** Structure containing information about a specific string.
 *
 * This structure hols all informations about a specific string. This is
 * required to allow BASIC-style strings that may contain NUL characters.
 */
typedef struct _FBSTRING {
    char           *data;    /**< pointer to the real string data */
    ssize_t         len;     /**< String length. */
    ssize_t         size;    /**< Size of allocated memory block. */
} FBSTRING;


typedef struct _FB_STR_TMPDESC {
    FB_LISTELEM     elem;
    FBSTRING        desc;
} FB_STR_TMPDESC;


/* protos */

/** Sets the length of a string (without reallocation).
 *
 * This function preserves any flags set for this string descriptor.
 */
static __inline__ void fb_hStrSetLength( FBSTRING *str, size_t size ) {
    str->len = size | (str->len & FB_TEMPSTRBIT);
}

FBCALL FBSTRING    *fb_hStrAllocTmpDesc         ( void );
FBCALL int          fb_hStrDelTempDesc          ( FBSTRING *str );
FBCALL FBSTRING    *fb_hStrAlloc                ( FBSTRING *str, ssize_t size );
FBCALL FBSTRING    *fb_hStrRealloc              ( FBSTRING *str, ssize_t size, int preserve );
FBCALL FBSTRING    *fb_hStrAllocTemp            ( FBSTRING *str, ssize_t size );
FBCALL FBSTRING    *fb_hStrAllocTemp_NoLock     ( FBSTRING *str, ssize_t size );
FBCALL int          fb_hStrDelTemp              ( FBSTRING *str );
FBCALL int          fb_hStrDelTemp_NoLock       ( FBSTRING *str );
FBCALL void         fb_hStrCopy                 ( char *dst, const char *src, ssize_t bytes );
FBCALL char        *fb_hStrSkipChar             ( char *s, ssize_t len, int c );
FBCALL char        *fb_hStrSkipCharRev          ( char *s, ssize_t len, int c );


/* public */

FBCALL void        *fb_StrInit          ( void *dst, ssize_t dst_size, void *src, ssize_t src_size, int fill_rem );
FBCALL void        *fb_StrAssign        ( void *dst, ssize_t dst_size, void *src, ssize_t src_size, int fill_rem );
FBCALL void        *fb_StrAssignEx      ( void *dst, ssize_t dst_size, void *src, ssize_t src_size, int fill_rem, int is_init );
FBCALL void         fb_StrDelete        ( FBSTRING *str );
FBCALL FBSTRING    *fb_StrConcat        ( FBSTRING *dst, void *str1, ssize_t str1_size, void *str2, ssize_t str2_size );
FBCALL void        *fb_StrConcatAssign  ( void *dst, ssize_t dst_size, void *src, ssize_t src_size, int fillrem );
FBCALL int          fb_StrCompare       ( void *str1, ssize_t str1_size, void *str2, ssize_t str2_size );
FBCALL FBSTRING    *fb_StrAllocTempResult ( FBSTRING *src );
FBCALL FBSTRING    *fb_StrAllocTempDescF( char *str, ssize_t str_size );
FBCALL FBSTRING    *fb_StrAllocTempDescV( FBSTRING *str );
FBCALL FBSTRING    *fb_StrAllocTempDescZEx( const char *str, ssize_t len );
FBCALL FBSTRING    *fb_StrAllocTempDescZ( const char *str );
FBCALL ssize_t      fb_StrLen           ( void *str, ssize_t str_size );

FBCALL char        *fb_hBoolToStr       ( char num );
FBCALL FBSTRING    *fb_BoolToStr        ( char num );
FBCALL FBSTRING    *fb_IntToStr         ( int num );
FBCALL FBSTRING    *fb_IntToStrQB       ( int num );
FBCALL FBSTRING    *fb_UIntToStr        ( unsigned int num );
FBCALL FBSTRING    *fb_UIntToStrQB      ( unsigned int num );
FBCALL FBSTRING    *fb_LongintToStr     ( long long num );
FBCALL FBSTRING    *fb_LongintToStrQB   ( long long num );
FBCALL FBSTRING    *fb_ULongintToStr    ( unsigned long long num );
FBCALL FBSTRING    *fb_ULongintToStrQB  ( unsigned long long num );
FBCALL FBSTRING    *fb_FloatToStr       ( float num );
FBCALL FBSTRING    *fb_FloatToStrQB     ( float num );
FBCALL FBSTRING    *fb_DoubleToStr      ( double num );
FBCALL FBSTRING    *fb_DoubleToStrQB    ( double num );

#define FB_F2A_ADDBLANK     0x00000001

FBCALL char         fb_hStr2Bool        ( char *src, ssize_t len );
FBCALL double       fb_hStr2Double      ( char *src, ssize_t len );
FBCALL int          fb_hStr2Int         ( char *src, ssize_t len );
FBCALL unsigned int fb_hStr2UInt        ( char *src, ssize_t len );
FBCALL long long    fb_hStr2Longint     ( char *src, ssize_t len );
FBCALL unsigned long long fb_hStr2ULongint( char *src, ssize_t len );
FBCALL int          fb_hStrRadix2Int    ( char *src, ssize_t len, int radix );
FBCALL long long    fb_hStrRadix2Longint( char *s, ssize_t len, int radix );
       char        *fb_hFloat2Str       ( double val, char *buffer, int digits, int mask );

       FBSTRING    *fb_CHR              ( int args, ... );
FBCALL unsigned int fb_ASC              ( FBSTRING *str, ssize_t pos );
FBCALL double       fb_VAL              ( FBSTRING *str );
FBCALL double       fb_CVD              ( FBSTRING *str );
FBCALL float        fb_CVS              ( FBSTRING *str );
FBCALL short        fb_CVSHORT          ( FBSTRING *str );
FBCALL int          fb_CVI              ( FBSTRING *str ); /* 32bit legacy */
FBCALL int          fb_CVL              ( FBSTRING *str );
FBCALL long long    fb_CVLONGINT        ( FBSTRING *str );
FBCALL FBSTRING    *fb_HEX              ( int num );
FBCALL FBSTRING    *fb_OCT              ( int num );
FBCALL FBSTRING    *fb_BIN              ( int num );

FBCALL FBSTRING    *fb_BIN_b            ( unsigned char num );
FBCALL FBSTRING    *fb_BIN_s            ( unsigned short num );
FBCALL FBSTRING    *fb_BIN_i            ( unsigned int num );
FBCALL FBSTRING    *fb_BIN_l            ( unsigned long long num );
FBCALL FBSTRING    *fb_BIN_p            ( const void *p );
FBCALL FBSTRING    *fb_BINEx_b          ( unsigned char num, int digits );
FBCALL FBSTRING    *fb_BINEx_s          ( unsigned short num, int digits );
FBCALL FBSTRING    *fb_BINEx_i          ( unsigned int num, int digits );
FBCALL FBSTRING    *fb_BINEx_l          ( unsigned long long num, int digits );
FBCALL FBSTRING    *fb_BINEx_p          ( const void *p, int digits );

FBCALL FBSTRING    *fb_OCT_b            ( unsigned char num );
FBCALL FBSTRING    *fb_OCT_s            ( unsigned short num );
FBCALL FBSTRING    *fb_OCT_i            ( unsigned int num );
FBCALL FBSTRING    *fb_OCT_l            ( unsigned long long num );
FBCALL FBSTRING    *fb_OCT_p            ( const void *p );
FBCALL FBSTRING    *fb_OCTEx_b          ( unsigned char num, int digits );
FBCALL FBSTRING    *fb_OCTEx_s          ( unsigned short num, int digits );
FBCALL FBSTRING    *fb_OCTEx_i          ( unsigned int num, int digits );
FBCALL FBSTRING    *fb_OCTEx_l          ( unsigned long long num, int digits );
FBCALL FBSTRING    *fb_OCTEx_p          ( const void *p, int digits );

FBCALL FBSTRING    *fb_HEX_b            ( unsigned char num );
FBCALL FBSTRING    *fb_HEX_s            ( unsigned short num );
FBCALL FBSTRING    *fb_HEX_i            ( unsigned int num );
FBCALL FBSTRING    *fb_HEX_l            ( unsigned long long num );
FBCALL FBSTRING    *fb_HEX_p            ( const void *p );
FBCALL FBSTRING    *fb_HEXEx_b          ( unsigned char num, int digits );
FBCALL FBSTRING    *fb_HEXEx_s          ( unsigned short num, int digits );
FBCALL FBSTRING    *fb_HEXEx_i          ( unsigned int num, int digits );
FBCALL FBSTRING    *fb_HEXEx_l          ( unsigned long long num, int digits );
FBCALL FBSTRING    *fb_HEXEx_p          ( const void *p, int digits );

FBCALL FB_WCHAR    *fb_WstrBin_b        ( unsigned char num );
FBCALL FB_WCHAR    *fb_WstrBin_s        ( unsigned short num );
FBCALL FB_WCHAR    *fb_WstrBin_i        ( unsigned int num );
FBCALL FB_WCHAR    *fb_WstrBin_l        ( unsigned long long num );
FBCALL FB_WCHAR    *fb_WstrBin_p        ( const void *p );
FBCALL FB_WCHAR    *fb_WstrBinEx_b      ( unsigned char num, int digits );
FBCALL FB_WCHAR    *fb_WstrBinEx_s      ( unsigned short num, int digits );
FBCALL FB_WCHAR    *fb_WstrBinEx_i      ( unsigned int num, int digits );
FBCALL FB_WCHAR    *fb_WstrBinEx_l      ( unsigned long long num, int digits );
FBCALL FB_WCHAR    *fb_WstrBinEx_p      ( const void *p, int digits );

FBCALL FB_WCHAR    *fb_WstrHex_b        ( unsigned char num );
FBCALL FB_WCHAR    *fb_WstrHex_s        ( unsigned short num );
FBCALL FB_WCHAR    *fb_WstrHex_i        ( unsigned int num );
FBCALL FB_WCHAR    *fb_WstrHex_l        ( unsigned long long num );
FBCALL FB_WCHAR    *fb_WstrHex_p        ( const void *p );
FBCALL FB_WCHAR    *fb_WstrHexEx_b      ( unsigned char num, int digits );
FBCALL FB_WCHAR    *fb_WstrHexEx_s      ( unsigned short num, int digits );
FBCALL FB_WCHAR    *fb_WstrHexEx_i      ( unsigned int num, int digits );
FBCALL FB_WCHAR    *fb_WstrHexEx_l      ( unsigned long long num, int digits );
FBCALL FB_WCHAR    *fb_WstrHexEx_p      ( const void *p, int digits );

FBCALL FB_WCHAR    *fb_WstrOct_b        ( unsigned char num );
FBCALL FB_WCHAR    *fb_WstrOct_s        ( unsigned short num );
FBCALL FB_WCHAR    *fb_WstrOct_i        ( unsigned int num );
FBCALL FB_WCHAR    *fb_WstrOct_l        ( unsigned long long num );
FBCALL FB_WCHAR    *fb_WstrOct_p        ( const void *p );
FBCALL FB_WCHAR    *fb_WstrOctEx_b      ( unsigned char num, int digits );
FBCALL FB_WCHAR    *fb_WstrOctEx_s      ( unsigned short num, int digits );
FBCALL FB_WCHAR    *fb_WstrOctEx_i      ( unsigned int num, int digits );
FBCALL FB_WCHAR    *fb_WstrOctEx_l      ( unsigned long long num, int digits );
FBCALL FB_WCHAR    *fb_WstrOctEx_p      ( const void *p, int digits );

FBCALL FBSTRING    *fb_MKD              ( double num );
FBCALL FBSTRING    *fb_MKS              ( float num );
FBCALL FBSTRING    *fb_MKSHORT          ( short num );
FBCALL FBSTRING    *fb_MKI              ( ssize_t num );
FBCALL FBSTRING    *fb_MKL              ( int num );
FBCALL FBSTRING    *fb_MKLONGINT        ( long long num );
FBCALL FBSTRING    *fb_LEFT             ( FBSTRING *str, ssize_t chars );
FBCALL FBSTRING    *fb_RIGHT            ( FBSTRING *str, ssize_t chars );
FBCALL FBSTRING    *fb_SPACE            ( ssize_t chars );
FBCALL FBSTRING    *fb_LTRIM            ( FBSTRING *str );
FBCALL FBSTRING    *fb_LTrimEx          ( FBSTRING *str, FBSTRING *pattern );
FBCALL FBSTRING    *fb_LTrimAny         ( FBSTRING *str, FBSTRING *pattern );
FBCALL FBSTRING    *fb_RTRIM            ( FBSTRING *str );
FBCALL FBSTRING    *fb_RTrimEx          ( FBSTRING *str, FBSTRING *pattern );
FBCALL FBSTRING    *fb_RTrimAny         ( FBSTRING *str, FBSTRING *pattern );
FBCALL FBSTRING    *fb_TRIM             ( FBSTRING *src );
FBCALL FBSTRING    *fb_TrimEx           ( FBSTRING *str, FBSTRING *pattern );
FBCALL FBSTRING    *fb_TrimAny          ( FBSTRING *str, FBSTRING *pattern );
FBCALL void         fb_StrLset          ( FBSTRING *dst, FBSTRING *src );
FBCALL void         fb_StrRset          ( FBSTRING *dst, FBSTRING *src );
FBCALL FBSTRING    *fb_StrLcase2        ( FBSTRING *src, int mode );
FBCALL FBSTRING    *fb_StrUcase2        ( FBSTRING *src, int mode );
FBCALL FBSTRING    *fb_StrFill1         ( ssize_t cnt, int fchar );
FBCALL FBSTRING    *fb_StrFill2         ( ssize_t cnt, FBSTRING *src );
FBCALL ssize_t      fb_StrInstr         ( ssize_t start, FBSTRING *src, FBSTRING *patt );
FBCALL ssize_t      fb_StrInstrAny      ( ssize_t start, FBSTRING *src, FBSTRING *patt );
FBCALL ssize_t      fb_StrInstrRev      ( FBSTRING *src, FBSTRING *patt, ssize_t start );
FBCALL ssize_t      fb_StrInstrRevAny   ( FBSTRING *src, FBSTRING *patt, ssize_t start );
FBCALL FBSTRING    *fb_StrMid           ( FBSTRING *src, ssize_t start, ssize_t len );
FBCALL void         fb_StrAssignMid     ( FBSTRING *dst, ssize_t start, ssize_t len, FBSTRING *src );

/**************************************************************************************************
 * Unicode strings
 **************************************************************************************************/

FBCALL FB_WCHAR    *fb_WstrAlloc        ( ssize_t chars );
FBCALL void        *fb_WstrAssignToA_Init( void *dst, ssize_t dst_chars, FB_WCHAR *src, int fill_rem );
FBCALL void         fb_WstrDelete       ( FB_WCHAR *str );
FBCALL FB_WCHAR    *fb_WstrAssign       ( FB_WCHAR *dst, ssize_t dst_chars, FB_WCHAR *src );
FBCALL FB_WCHAR    *fb_WstrAssignFromA  ( FB_WCHAR *dst, ssize_t dst_chars, void *src, ssize_t src_chars );
FBCALL void        *fb_WstrAssignToA    ( void *dst, ssize_t dst_chars, FB_WCHAR *src, int fill_rem );
FBCALL void        *fb_WstrAssignToAEx  ( void *dst, ssize_t dst_chars, FB_WCHAR *src, int fill_rem, int is_init );
FBCALL FB_WCHAR    *fb_WstrConcat 		( const FB_WCHAR *str1, const FB_WCHAR *str2 );
FBCALL FB_WCHAR    *fb_WstrConcatWA     ( const FB_WCHAR *str1, const void *str2, ssize_t str2_size );
FBCALL FB_WCHAR    *fb_WstrConcatAW     ( const void *str1, ssize_t str1_size, const FB_WCHAR *str2 );
FBCALL FB_WCHAR    *fb_WstrConcatAssign ( FB_WCHAR *dst, ssize_t dst_chars, const FB_WCHAR *src );

FBCALL ssize_t      fb_WstrLen          ( FB_WCHAR *str );
FBCALL int          fb_WstrCompare      ( const FB_WCHAR *str1, const FB_WCHAR *str2 );

FBCALL FB_WCHAR    *fb_hBoolToWstr      ( char num );
FBCALL FB_WCHAR    *fb_BoolToWstr       ( char num );
FBCALL FB_WCHAR    *fb_IntToWstr        ( int num );
FBCALL FB_WCHAR    *fb_UIntToWstr       ( unsigned int num );
FBCALL FB_WCHAR    *fb_LongintToWstr    ( long long num );
FBCALL FB_WCHAR    *fb_ULongintToWstr   ( unsigned long long num );
FBCALL FB_WCHAR    *fb_FloatToWstr      ( float num );
       FB_WCHAR    *fb_FloatExToWstr    ( double val, FB_WCHAR *buffer, int digits, int mask );
FBCALL FB_WCHAR    *fb_DoubleToWstr     ( double num );
FBCALL FB_WCHAR    *fb_StrToWstr        ( const char *src );

FBCALL FBSTRING    *fb_WstrToStr        ( const FB_WCHAR *src );
FBCALL double       fb_WstrToDouble     ( const FB_WCHAR *src, ssize_t len );
FBCALL char         fb_WstrToBool       ( const FB_WCHAR *src, ssize_t len );
FBCALL int          fb_WstrToInt        ( const FB_WCHAR *src, ssize_t len );
FBCALL unsigned int fb_WstrToUInt       ( const FB_WCHAR *src, ssize_t len );
FBCALL long long    fb_WstrToLongint    ( const FB_WCHAR *src, ssize_t len );
FBCALL unsigned long long fb_WstrToULongint( const FB_WCHAR *src, ssize_t len );
FBCALL int          fb_WstrRadix2Int    ( const FB_WCHAR *src, ssize_t len, int radix );
FBCALL long long    fb_WstrRadix2Longint( const FB_WCHAR *s, ssize_t len, int radix );

FB_WCHAR           *fb_WstrChr          ( int args, ... );
FBCALL unsigned int fb_WstrAsc          ( const FB_WCHAR *str, ssize_t pos );
FBCALL double       fb_WstrVal          ( const FB_WCHAR *str );
FBCALL char         fb_WstrValBool      ( const FB_WCHAR *str );
FBCALL int          fb_WstrValInt       ( const FB_WCHAR *str );
FBCALL unsigned int fb_WstrValUInt      ( const FB_WCHAR *str );
FBCALL long long    fb_WstrValLng       ( const FB_WCHAR *str );
FBCALL unsigned long long fb_WstrValULng( const FB_WCHAR *str );
FBCALL FB_WCHAR    *fb_WstrLeft         ( const FB_WCHAR *str, ssize_t chars );
FBCALL FB_WCHAR    *fb_WstrRight        ( const FB_WCHAR *str, ssize_t chars );
FBCALL FB_WCHAR    *fb_WstrSpace        ( ssize_t chars );
FBCALL FB_WCHAR    *fb_WstrLTrim        ( const FB_WCHAR *str );
FBCALL FB_WCHAR    *fb_WstrLTrimEx      ( const FB_WCHAR *str, const FB_WCHAR *pattern );
FBCALL FB_WCHAR    *fb_WstrLTrimAny     ( const FB_WCHAR *str, const FB_WCHAR *pattern );
FBCALL FB_WCHAR    *fb_WstrRTrim        ( const FB_WCHAR *str );
FBCALL FB_WCHAR    *fb_WstrRTrimEx      ( const FB_WCHAR *str, const FB_WCHAR *pattern );
FBCALL FB_WCHAR    *fb_WstrRTrimAny     ( const FB_WCHAR *str, const FB_WCHAR *pattern );
FBCALL FB_WCHAR    *fb_WstrTrim         ( const FB_WCHAR *src );
FBCALL FB_WCHAR    *fb_WstrTrimEx       ( const FB_WCHAR *str, const FB_WCHAR *pattern );
FBCALL FB_WCHAR    *fb_WstrTrimAny      ( const FB_WCHAR *str, const FB_WCHAR *pattern );
FBCALL void         fb_WstrLset         ( FB_WCHAR *dst, FB_WCHAR *src );
FBCALL void         fb_WstrRset         ( FB_WCHAR *dst, FB_WCHAR *src );
FBCALL FB_WCHAR    *fb_WstrLcase2       ( const FB_WCHAR *src, int mode );
FBCALL FB_WCHAR    *fb_WstrUcase2       ( const FB_WCHAR *src, int mode );
FBCALL FB_WCHAR    *fb_WstrFill1        ( ssize_t chars, int c );
FBCALL FB_WCHAR    *fb_WstrFill2        ( ssize_t cnt, const FB_WCHAR *src );
FBCALL ssize_t      fb_WstrInstr        ( ssize_t start, const FB_WCHAR *src, const FB_WCHAR *patt );
FBCALL ssize_t      fb_WstrInstrAny     ( ssize_t start, const FB_WCHAR *src, const FB_WCHAR *patt );
FBCALL ssize_t      fb_WstrInstrRev     ( const FB_WCHAR *src, const FB_WCHAR *patt, ssize_t start );
FBCALL ssize_t      fb_WstrInstrRevAny  ( const FB_WCHAR *src, const FB_WCHAR *patt, ssize_t start );
FBCALL FB_WCHAR    *fb_WstrMid          ( const FB_WCHAR *src, ssize_t start, ssize_t len );
FBCALL void         fb_WstrAssignMid    ( FB_WCHAR *dst, ssize_t dst_len, ssize_t start, ssize_t len, const FB_WCHAR *src );

/**************************************************************************************************
 * VB-compatible functions
 **************************************************************************************************/

FBCALL FBSTRING *   fb_StrFormat        ( double value, FBSTRING *mask );
FBCALL FBSTRING *   fb_hStrFormat       ( double value, const char *mask, size_t mask_length );

FBCALL char         fb_VALBOOL          ( FBSTRING *str );
FBCALL int          fb_VALINT           ( FBSTRING *str );
FBCALL long long    fb_VALLNG           ( FBSTRING *str );
FBCALL unsigned int fb_VALUINT          ( FBSTRING *str );
FBCALL unsigned long long fb_VALULNG    ( FBSTRING *str );
