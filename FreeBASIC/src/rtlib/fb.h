/*
 *  libfb - FreeBASIC's runtime library
 *  Copyright (C) 2004-2005 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and others.
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
 */

#ifndef __FB_H__
#define __FB_H__

#if HAVE_CONFIG_H
#include <config.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif


    /* =================================================================
     * RTLIB configuration
     * ================================================================= */

    /** Defines the ASCII code that indicates a two-byte key code.
     *
     * A two-byte key code will be returned by GET on SCRN: or INKEY$.
     */
#define FB_EXT_CHAR           ((char)255)

    /** Maximum number of temporary string descriptors.
     */
#define FB_STR_TMPDESCRIPTORS 256

    /** Maximum number of array dimensions.
     */
#define FB_MAXDIMENSIONS      16

    /** Maximum number of temporary array descriptors.
     */
#define FB_ARRAY_TMPDESCRIPTORS (FB_STR_TMPDESCRIPTORS / 4)

    /** The padding width (for PRINT ,).
     */
#define FB_TAB_WIDTH          14

    /** Screen width returned by default when native console function failed.
     *
     * This is required when an applications output is redirected.
     */
#define FB_SCRN_DEFAULT_WIDTH  80

    /** Screen height returned by default when native console function failed.
     *
     * This is required when an applications output is redirected.
     */
#define FB_SCRN_DEFAULT_HEIGHT 25

    /** Number of reserved file handles.
     *
     * Index        Usage:
     * 0            SCRN:
     * 1            LPT1:
     */
#define FB_RESERVED_FILES     2

    /** Maximum number of file handles.
     */
#define FB_MAX_FILES          (FB_RESERVED_FILES + 255)

    /** File buffer size (for buffered read ?).
     */
#define FB_FILE_BUFSIZE       8192

    /** Max length to allocated for a temporary buffer on stack
     */
#define FB_LOCALBUFF_MAXLEN	  32768

    /* =================================================================
     * RTLIB default values
     * ================================================================= */

    /** BASIC's TRUE value.
     */
#define FB_TRUE -1

    /** BASIC's FALSE value.
     */
#define FB_FALSE 0

    /** FALSE value for pre C99.
     */
#ifndef FALSE
#define FALSE    0
#endif

    /** TRUE value for pre C99.
     */
#ifndef TRUE
#define TRUE    1
#endif

    /** NULL value for pre C99.
     */
#ifndef NULL
#define NULL     0
#endif

#if !(defined(TARGET_WIN32) || defined(TARGET_CYGWIN))
    /** Maximum path length for Non-Win32 targets.
     *
     * For Win32 targets, this value will be set automatically by the
     * <windows.h> header.
     */
#define MAX_PATH    1024
#endif

    /** Macro to convert a character to an integer.
     *
     * Use this macro to avoid sign-extension during conversion from char
     * (implicitly signed) to int.
     */
#define FB_CHAR_TO_INT(ch) \
    ((int) ((unsigned) (unsigned char) (ch)))

    /** Macro to calculate a key code from a character.
     */
#define FB_MAKE_KEY(ch) \
    ((int) ((unsigned) (unsigned char) (ch)))

    /** Macro to calculate an extended key code for a character.
     *
     * This macro is used to build the integer value of a two-byte key code
     * returned by SCRN: (and INKEY$).
     */
#define FB_MAKE_EXT_KEY(ch) \
    ((int) ((((unsigned) (unsigned char) (ch)) << 8) + (unsigned) (unsigned char) (FB_EXT_CHAR)))

    /** Macro to test if the key code is an extended key code.
     *
     * Returns true for every value created with FB_MAKE_EXT_KEY(ch).
     */
#define FB_IS_EXT_KEY(k) \
    ((int) (((((unsigned) (k)) & 0xFF)==FB_EXT_CHAR) && (((k) & 0xFF00)!=0)))

#if defined(TARGET_WIN32) || defined(TARGET_CYGWIN)
#include "win32/fb_win32.h"
#elif defined(TARGET_LINUX)
#include "linux/fb_linux.h"
#elif defined(TARGET_DOS)
#include "dos/fb_dos.h"
#elif defined(TARGET_XBOX)
#include "xbox/fb_xbox.h"
#endif


/**
 * CPU-dependent macros and inline functions
 */
#ifdef TARGET_X86
#include "fb_x86.h"
#else
#include "fb_port.h"
#endif

/**
 * unicode definitions
 */
#include "fb_unicode.h"


#ifndef FBCALL
# define FBCALL
#endif /* !defined FBCALL */

#ifndef FB_LOCK
    /** Acquire a global semaphore (recursive mutex).
     */
# define FB_LOCK()
#endif
#ifndef FB_UNLOCK
    /** Release a global semaphore (recursive mutex).
     */
# define FB_UNLOCK()
#endif
#ifndef FB_STRLOCK
    /** Acquire a semaphore (recursive mutex) especially for STRING functions.
     */
# define FB_STRLOCK()
#endif
#ifndef FB_STRUNLOCK
    /** Release a semaphore (recursive mutex) especially for STRING functions.
     */
# define FB_STRUNLOCK()
#endif

#ifndef FB_TLSENTRY
    /** Define a TLS (Thread local storage) slot.
     */
# define FB_TLSENTRY                unsigned int
#endif

#ifndef FB_TLSALLOC
# define FB_TLSALLOC(key) 			key = NULL
#endif
#ifndef FB_TLSFREE
# define FB_TLSFREE(key)			key = NULL
#endif

#ifndef FB_TLSSET
    /** Set the value of a TLS (Thread local storage) slot.
     */
# define FB_TLSSET(key,value)        key = (unsigned int)value
#endif
#ifndef FB_TLSGET
    /** Get the value from a TLS (Thread local storage) slot.
     */
# define FB_TLSGET(key)                key
#endif

#ifndef FB_THREADID
# define FB_THREADID int
#endif

#ifndef FB_BINARY_NEWLINE
    /** The "NEW LINE" string required for printer I/O
     *
     * The printer always requires both CR and LF.
     */
#define FB_BINARY_NEWLINE "\r\n"
#endif

#ifndef FB_NEWLINE
    /** The "NEW LINE" character used for all I/O.
     *
     * This is LF here because FB relies on the C RTL which only knows
     * LF as line-end character.
     */
#define FB_NEWLINE "\n"
#endif

#ifndef FB_LL_FMTMOD
    /** LONG LONG format modifier.
     *
     * This is the default "long long" format modifier for use with the
     * *printf functions.
     */
#define FB_LL_FMTMOD "ll"
#endif

#ifdef DEBUG
#include <assert.h>
#define DBG_ASSERT(e) assert(e)
#else
#define DBG_ASSERT(e) ((void)0)
#endif

/**************************************************************************************************
 * helpers
 **************************************************************************************************/

#define fb_hSign( x ) \
    ( ( (x) < 0 ) ? -1 : 1 )

/**************************************************************************************************
 * internal lists
 **************************************************************************************************/

    /** List element members.
     *
     * When you use this list implementation, you have to add a member of
     * this type to your list elements. This member must be the first(!)
     * member in your list element structure.
     */
typedef struct _FB_LISTELEM {
    struct _FB_LISTELEM    *prev;/**< Pointer to the previous member in this list */
    struct _FB_LISTELEM    *next;/**< Pointer to the next member in this list */
} FB_LISTELEM;

typedef struct _FB_LIST {
    int                cnt;      /**< Number of used elements. */
    FB_LISTELEM        *head;    /**< Pointer to the first used element. */
    FB_LISTELEM        *tail;    /**< Pointer to the last used element. */
    FB_LISTELEM        *fhead;   /**< Pointer to the first free element. */
} FB_LIST;

void                fb_hListInit            ( FB_LIST *list, void *table, int elem_size,
											  int size );
FB_LISTELEM        *fb_hListAllocElem       ( FB_LIST *list );
void                fb_hListFreeElem        ( FB_LIST *list, FB_LISTELEM *elem );

void                fb_hListDynInit         ( FB_LIST *list );
void                fb_hListDynElemAdd      ( FB_LIST *list, FB_LISTELEM *elem );
void                fb_hListDynElemRemove   ( FB_LIST *list, FB_LISTELEM *elem );

/**************************************************************************************************
 * strings
 **************************************************************************************************/

#include <string.h>
#include <stdio.h>

/** Flag to identify a string as a temporary string.
 *
 * This flag is stored in struct _FBSTRING::len so it's absolutely required
 * to use FB_STRSIZE(s) to query a strings length.
 */
#define FB_TEMPSTRBIT 0x80000000L

/** Returns if the string is a temporary string.
 */
#define FB_ISTEMP(s) ((((FBSTRING *)s)->len & FB_TEMPSTRBIT) != 0)

/** Returns a string length.
 */
#define FB_STRSIZE(s) (((FBSTRING *)s)->len & ~FB_TEMPSTRBIT)

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
    int             len;     /**< String length. */
    int             size;    /**< Size of allocated memory block. */
} FBSTRING;


typedef struct _FB_STR_TMPDESC {
    FB_LISTELEM     elem;
    FBSTRING        desc;
} FB_STR_TMPDESC;


/* protos */

/* intern */
/** Descriptor for an empty string, descriptors can't be NULL,
 *  only the data field, or passing them to a BYVAL string
 *  argument would cause an exception.
 */
extern    FBSTRING     fb_strNullDesc;

/** Sets the length of a string (without reallocation).
 *
 * This function preserves any flags set for this string descriptor.
 */
static __inline__ void fb_hStrSetLength( FBSTRING *str, size_t size ) {
    str->len = size | (str->len & FB_TEMPSTRBIT);
}

FBCALL FBSTRING    *fb_hStrAllocTmpDesc 	( void );
FBCALL int          fb_hStrDelTempDesc  	( FBSTRING *str );
FBCALL FBSTRING    *fb_hStrRealloc      	( FBSTRING *str, int size, int preserve );
FBCALL FBSTRING    *fb_hStrRealloc_NoLock	( FBSTRING *str, int size, int preserve );
FBCALL FBSTRING    *fb_hStrAllocTemp    	( FBSTRING *str, int size );
FBCALL FBSTRING    *fb_hStrAllocTemp_NoLock	( FBSTRING *str, int size );
FBCALL int          fb_hStrDelTemp      	( FBSTRING *str );
FBCALL int          fb_hStrDelTemp_NoLock  	( FBSTRING *str );
FBCALL void         fb_hStrCopy         	( char *dst, const char *src, int bytes );
FBCALL char        *fb_hStrSkipChar     	( char *s, int len, int c );
FBCALL char        *fb_hStrSkipCharRev  	( char *s, int len, int c );


/* public */

FBCALL void         fb_StrDelete        ( FBSTRING *str );
FBCALL void         fb_StrDelete_NoLock ( FBSTRING *str );
FBCALL void        *fb_StrAssign        ( void *dst, int dst_size, void *src, int src_size,
										  int fillrem );
FBCALL FBSTRING    *fb_StrConcat        ( FBSTRING *dst, void *str1, int str1_size,
										  void *str2, int str2_size );
FBCALL void        *fb_StrConcatAssign  ( void *dst, int dst_size, void *src, int src_size,
										  int fillrem );
FBCALL int          fb_StrCompare       ( void *str1, int str1_size, void *str2,
										  int str2_size );
FBCALL FBSTRING    *fb_StrAllocTempResult ( FBSTRING *src );
FBCALL FBSTRING    *fb_StrAllocTempDescF( char *str, int str_size );
FBCALL FBSTRING    *fb_StrAllocTempDescV( FBSTRING *str );
FBCALL FBSTRING    *fb_StrAllocTempDescZ( const char *str );
FBCALL int          fb_StrLen           ( void *str, int str_size );

FBCALL FBSTRING    *fb_IntToStr        	( int num );
FBCALL FBSTRING    *fb_UIntToStr        ( unsigned int num );
FBCALL FBSTRING    *fb_FloatToStr      	( float num );
FBCALL FBSTRING    *fb_DoubleToStr     	( double num );

#define FB_F2A_ADDBLANK     0x00000001

FBCALL double       fb_hStr2Double      ( char *src, int len );
FBCALL int          fb_hStr2Int         ( char *src, int len );
FBCALL unsigned int fb_hStr2UInt        ( char *src, int len );
FBCALL long long    fb_hStr2Longint     ( char *src, int len );
FBCALL unsigned long long fb_hStr2ULongint ( char *src, int len );
FBCALL int          fb_hStrRadix2Int    ( char *src, int len, int radix );
FBCALL long long 	fb_hStrRadix2Longint( char *s, int len, int radix );
       char        *fb_hFloat2Str       ( double val, char *buffer, int digits, int mask );

       FBSTRING    *fb_CHR              ( int args, ... );
FBCALL unsigned int fb_ASC              ( FBSTRING *str, int pos );
FBCALL double       fb_VAL              ( FBSTRING *str );
FBCALL double       fb_CVD              ( FBSTRING *str );
FBCALL int          fb_CVI              ( FBSTRING *str );
FBCALL FBSTRING    *fb_HEX              ( int num );
FBCALL FBSTRING    *fb_OCT              ( int num );
FBCALL FBSTRING    *fb_BIN              ( int num );
FBCALL FBSTRING    *fb_MKD              ( double num );
FBCALL FBSTRING    *fb_MKI              ( int num );
FBCALL FBSTRING    *fb_MKS              ( float num );
FBCALL FBSTRING    *fb_LEFT             ( FBSTRING *str, int chars );
FBCALL FBSTRING    *fb_RIGHT            ( FBSTRING *str, int chars );
FBCALL FBSTRING    *fb_SPACE            ( int chars );
FBCALL FBSTRING    *fb_LTRIM            ( FBSTRING *str );
FBCALL FBSTRING    *fb_LTrimEx          ( FBSTRING *str, FBSTRING *pattern );
FBCALL FBSTRING    *fb_LTrimAny         ( FBSTRING *str, FBSTRING *pattern );
FBCALL FBSTRING    *fb_RTRIM            ( FBSTRING *str );
FBCALL FBSTRING    *fb_RTrimEx          ( FBSTRING *str, FBSTRING *pattern );
FBCALL FBSTRING    *fb_RTrimAny         ( FBSTRING *str, FBSTRING *pattern );
FBCALL FBSTRING    *fb_TRIM             ( FBSTRING *src );
FBCALL FBSTRING    *fb_TrimEx           ( FBSTRING *str, FBSTRING *pattern );
FBCALL FBSTRING    *fb_TrimAny          ( FBSTRING *str, FBSTRING *pattern );
FBCALL FBSTRING    *fb_LCASE            ( FBSTRING *str );
FBCALL FBSTRING    *fb_UCASE            ( FBSTRING *str );
FBCALL FBSTRING    *fb_StrFill1         ( int cnt, int fchar );
FBCALL FBSTRING    *fb_StrFill2         ( int cnt, FBSTRING *src );
FBCALL int          fb_StrInstr         ( int start, FBSTRING *src, FBSTRING *patt );
FBCALL int          fb_StrInstrAny      ( int start, FBSTRING *src, FBSTRING *patt );
FBCALL FBSTRING    *fb_StrMid           ( FBSTRING *src, int start, int len );
FBCALL void         fb_StrAssignMid     ( FBSTRING *dst, int start, int len, FBSTRING *src );

/**************************************************************************************************
 * Unicode strings
 **************************************************************************************************/

FBCALL void         fb_WstrDelete       ( FB_WCHAR *str );
FBCALL FB_WCHAR    *fb_WstrAssign       ( FB_WCHAR *dst, int dst_chars, FB_WCHAR *src );
FBCALL FB_WCHAR    *fb_WstrAssignFromA 	( FB_WCHAR *dst, int dst_chars, void *src,
										  int src_chars );
FBCALL FB_WCHAR    *fb_WstrConcat 		( const FB_WCHAR *str1, const FB_WCHAR *str2 );
FBCALL FB_WCHAR    *fb_WstrConcatWA 	( const FB_WCHAR *str1, const void *str2,
										  int str2_size );
FBCALL FB_WCHAR    *fb_WstrConcatAW 	( const void *str1, int str1_size,
										  const FB_WCHAR *str2 );
FBCALL FB_WCHAR    *fb_WstrConcatAssign ( FB_WCHAR *dst, int dst_chars,
										  const FB_WCHAR *src );

FBCALL int          fb_WstrLen          ( FB_WCHAR *str );
FBCALL int 			fb_WstrCompare 		( const FB_WCHAR *str1, const FB_WCHAR *str2 );

FBCALL FB_WCHAR    *fb_IntToWstr     	( int num );
FBCALL FB_WCHAR    *fb_UIntToWstr    	( unsigned int num );
FBCALL FB_WCHAR    *fb_FloatToWstr   	( float num );
       FB_WCHAR    *fb_FloatExToWstr  	( double val, FB_WCHAR *buffer, int digits,
       									  int mask );
FBCALL FB_WCHAR    *fb_DoubleToWstr  	( double num );
FBCALL FB_WCHAR    *fb_StrToWstr		( const char *src );

FBCALL FBSTRING    *fb_WstrToStr		( const FB_WCHAR *src );
FBCALL double       fb_WstrToDouble     ( const FB_WCHAR *src, int len );
FBCALL int          fb_WstrToInt        ( const FB_WCHAR *src, int len );
FBCALL unsigned int fb_WstrToUInt       ( const FB_WCHAR *src, int len );
FBCALL long long    fb_WstrToLongint    ( const FB_WCHAR *src, int len );
FBCALL unsigned long long fb_WstrToULongint ( const FB_WCHAR *src, int len );
FBCALL int          fb_WstrRadix2Int    ( const FB_WCHAR *src, int len, int radix );
FBCALL long long 	fb_WstrRadix2Longint( const FB_WCHAR *s, int len, int radix );

FB_WCHAR    	   *fb_WstrChr			( int args, ... );
FBCALL unsigned int fb_WstrAsc          ( const FB_WCHAR *str, int pos );
FBCALL double       fb_WstrVal          ( const FB_WCHAR *str );
FBCALL int			fb_WstrValInt       ( const FB_WCHAR *str );
FBCALL unsigned int	fb_WstrValUInt      ( const FB_WCHAR *str );
FBCALL long long	fb_WstrValLng       ( const FB_WCHAR *str );
FBCALL unsigned long long fb_WstrValULng( const FB_WCHAR *str );
FBCALL FB_WCHAR    *fb_WstrLeft         ( const FB_WCHAR *str, int chars );
FBCALL FB_WCHAR    *fb_WstrRight        ( const FB_WCHAR *str, int chars );
FBCALL FB_WCHAR    *fb_WstrSpace        ( int chars );
FBCALL FB_WCHAR    *fb_WstrLTrim        ( const FB_WCHAR *str );
FBCALL FB_WCHAR    *fb_WstrLTrimEx      ( const FB_WCHAR *str, const FB_WCHAR *pattern );
FBCALL FB_WCHAR    *fb_WstrLTrimAny     ( const FB_WCHAR *str, const FB_WCHAR *pattern );
FBCALL FB_WCHAR    *fb_WstrRTrim        ( const FB_WCHAR *str );
FBCALL FB_WCHAR    *fb_WstrRTrimEx      ( const FB_WCHAR *str, const FB_WCHAR *pattern );
FBCALL FB_WCHAR    *fb_WstrRTrimAny     ( const FB_WCHAR *str, const FB_WCHAR *pattern );
FBCALL FB_WCHAR    *fb_WstrTrim         ( const FB_WCHAR *src );
FBCALL FB_WCHAR    *fb_WstrTrimEx       ( const FB_WCHAR *str, const FB_WCHAR *pattern );
FBCALL FB_WCHAR    *fb_WstrTrimAny      ( const FB_WCHAR *str, const FB_WCHAR *pattern );
FBCALL FB_WCHAR    *fb_WstrLcase        ( const FB_WCHAR *str );
FBCALL FB_WCHAR    *fb_WstrUcase        ( const FB_WCHAR *str );
FBCALL FB_WCHAR    *fb_WstrFill1        ( int cnt, FB_WCHAR c );
FBCALL FB_WCHAR    *fb_WstrFill2        ( int cnt, const FB_WCHAR *src );
FBCALL int          fb_WstrInstr        ( int start, const FB_WCHAR *src,
										  const FB_WCHAR *patt );
FBCALL int          fb_WstrInstrAny     ( int start, const FB_WCHAR *src,
										  const FB_WCHAR *patt );
FBCALL FB_WCHAR    *fb_WstrMid          ( const FB_WCHAR *src, int start, int len );
FBCALL void         fb_WstrAssignMid    ( FB_WCHAR *dst, int dst_len, int start, int len,
										  const FB_WCHAR *src );

/**************************************************************************************************
 * arrays
 **************************************************************************************************/

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

typedef struct _FB_ARRAY_TMPDESC {
    FB_LISTELEM     elem;

    FBARRAY         array;
    FBARRAYDIM      dimTB[FB_MAXDIMENSIONS-1];
} FB_ARRAY_TMPDESC;


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

       int          fb_ArrayRedim       ( FBARRAY *array, int element_len, int preserve,
       									  int dimensions, ... );
       int          fb_ArrayRedimPresv  ( FBARRAY *array, int element_len, int preserve,
       									  int dimensions, ... );
       void         fb_ArraySetDesc     ( FBARRAY *array, void *ptr, int element_len,
       									  int dimensions, ... );
FBCALL int          fb_ArrayErase       ( FBARRAY *array, int isvarlen );
FBCALL void         fb_ArrayStrErase    ( FBARRAY *array );
FBCALL int          fb_ArrayLBound      ( FBARRAY *array, int dimension );
FBCALL int          fb_ArrayUBound      ( FBARRAY *array, int dimension );

       int          fb_hArrayCalcElements( int dimensions, const int *lboundTB,
       									   const int *uboundTB );
       int          fb_hArrayCalcDiff   ( int dimensions, const int *lboundTB,
       									  const int *uboundTB );
       int          fb_hArrayFreeVarLenStrs( FBARRAY *array, int base );


/**************************************************************************************************
 * system
 **************************************************************************************************/

FBCALL FBSTRING    *fb_Command          ( int argc );
FBCALL FBSTRING    *fb_CurDir           ( void );
FBCALL FBSTRING    *fb_ExePath          ( void );
FBCALL int          fb_Shell            ( FBSTRING *program );
FBCALL int          fb_Run              ( FBSTRING *program );
FBCALL int          fb_Chain            ( FBSTRING *program );
FBCALL int          fb_Exec             ( FBSTRING *program, FBSTRING *args );
FBCALL int 			fb_ExecEx 			( FBSTRING *program, FBSTRING *args, int do_wait );
FBCALL void        *fb_DylibLoad        ( FBSTRING *library );
FBCALL void        *fb_DylibSymbol      ( void *library, FBSTRING *symbol );
FBCALL void         fb_DylibFree        ( void *library );

       char        *fb_hGetShortPath    ( char *src, char *dst, int maxlen );

       int          fb_hGetCurrentDir   ( char *dst, int maxlen );
       char        *fb_hGetExePath      ( char *dst, int maxlen );
       char        *fb_hGetExeName      ( char *dst, int maxlen );

       int          fb_hIn              ( unsigned short port );
       int          fb_hOut             ( unsigned short port, unsigned char value );
FBCALL int          fb_Wait             ( unsigned short port, int and, int xor);

/**************************************************************************************************
 * math
 **************************************************************************************************/

FBCALL double       fb_Rnd              ( int n );
FBCALL void         fb_Randomize        ( double seed );
FBCALL int          fb_SGNSingle        ( float x );
FBCALL int          fb_SGNDouble        ( double x );
FBCALL float        fb_FIXSingle        ( float x );
FBCALL double       fb_FIXDouble        ( double x );


/**************************************************************************************************
 * data
 **************************************************************************************************/

extern char        *fb_DataPtr;

#define FB_DATATYPE_LINK -1
#define FB_DATATYPE_OFS  -2

FBCALL void         fb_DataReadStr      ( void *dst, int dst_size, int fillrem );
FBCALL void         fb_DataReadByte     ( char *dst );
FBCALL void         fb_DataReadShort    ( short *dst );
FBCALL void         fb_DataReadInt      ( int *dst );
FBCALL void         fb_DataReadSingle   ( float *dst );
FBCALL void         fb_DataReadDouble   ( double *dst );

       short        fb_DataRead         ( void );

/**************************************************************************************************
 * console
 **************************************************************************************************/

#if FB_TAB_WIDTH == 8
#define FB_NATIVE_TAB 1
#endif

#define FB_PRINT_NEWLINE      0x00000001
#define FB_PRINT_PAD          0x00000002
#define FB_PRINT_BIN_NEWLINE  0x00000004
#define FB_PRINT_FORCE_ADJUST 0x00000008     /* Enforce position adjustment
                                              * when last character in screen
                                              * buffer gets handles in a special
                                              * way */
#define FB_PRINT_ISLAST       0x80000000     /* only for USING */

typedef struct _FB_PRINTUSGCTX {
    int     		chars;
    char 			*ptr;
    FBSTRING		fmtstr;
} FB_PRINTUSGCTX;

/** Small helper function that converts a TEXT new-line to a BINARY new-line.
 *
 * This is required for all the LPRINT functions.
 */
static __inline__ int FB_PRINT_CONVERT_BIN_NEWLINE(int mask)
{
    if( mask & FB_PRINT_NEWLINE ) {
        mask = (mask & ~FB_PRINT_NEWLINE) | FB_PRINT_BIN_NEWLINE;
    }
    return mask;
}

/** masked bits for "high level" flags
 *
 * I.e. flags that are set by the BASIC PRINT command directly.
 */
#define FB_PRINT_HLMASK  0x00000003

#define FB_PRINT_EX(handle, s, len, mask)                             \
    fb_hFilePrintBufferEx( handle, s, len )

#define FB_PRINT(fnum, s, mask)                                       \
    FB_PRINT_EX( FB_FILE_TO_HANDLE(fnum), s, strlen(s), 0 )

#define FB_PRINTWSTR_EX(handle, s, len, mask)                         \
    fb_hFilePrintBufferWstrEx( handle, s, len )

#define FB_PRINTWSTR(fnum, s, mask)                                   \
    FB_PRINTWSTR_EX( FB_FILE_TO_HANDLE(fnum), s, fb_wstr_len(s), 0 )

#define FB_PRINTNUM_EX(handle, val, mask, fmt, type)                  \
    do {                                                              \
        char buffer[80];                                              \
        int len;                                                      \
                                                                      \
        if( mask & FB_PRINT_BIN_NEWLINE )                             \
            len = sprintf( buffer, fmt type FB_BINARY_NEWLINE, val ); \
        else if( mask & FB_PRINT_NEWLINE )                            \
            len = sprintf( buffer, fmt type FB_NEWLINE, val );        \
        else                                                          \
            len = sprintf( buffer, fmt type, val );                   \
                                                                      \
        FB_PRINT_EX( handle, buffer, len, mask );                     \
                                                                      \
        if( mask & FB_PRINT_PAD )                                     \
            fb_PrintPadEx ( handle, mask );                           \
                                                                      \
    } while (0)

#define FB_PRINTNUM(fnum, val, mask, fmt, type)                       \
    FB_PRINTNUM_EX( FB_FILE_TO_HANDLE(fnum), val, mask, fmt, type )

#define FB_WRITENUM_EX(handle, val, mask, type )                      \
    do {                                                              \
        char buffer[80];									          \
        size_t len;                                                   \
                                                                      \
        if( mask & FB_PRINT_BIN_NEWLINE )           		          \
            len = sprintf( buffer, type FB_BINARY_NEWLINE, val );     \
        else if( mask & FB_PRINT_NEWLINE )           		          \
            len = sprintf( buffer, type FB_NEWLINE, val );            \
        else												          \
            len = sprintf( buffer, type ",", val );                   \
                                                                      \
        fb_hFilePrintBufferEx( handle, buffer, len );	              \
    } while (0)

#define FB_WRITENUM(fnum, val, mask, type) 				    \
    FB_WRITENUM_EX(FB_FILE_TO_HANDLE(fnum), val, mask, type)

struct _FB_FILE;

       int          fb_ConsoleWidth     ( int cols, int rows );
       void         fb_ConsoleClear     ( int mode );

       int          fb_ConsoleLocate    ( int row, int col, int cursor );
       int          fb_ConsoleGetY      ( void );
       int          fb_ConsoleGetX      ( void );
FBCALL void         fb_ConsoleGetSize   ( int *cols, int *rows );
FBCALL void         fb_ConsoleGetXY     ( int *col, int *row );

FBCALL int          fb_ConsoleReadXY    ( int col, int row, int colorflag );
       int          fb_ConsoleColor     ( int fc, int bc );
       int          fb_ConsoleGetColorAtt( void );

FBCALL int          fb_ConsoleView      ( int toprow, int botrow );
       int          fb_ConsoleViewEx    ( int toprow, int botrow, int set_cursor );
       void         fb_ConsoleGetView   ( int *toprow, int *botrow );
       int          fb_ConsoleGetMaxRow ( void );
       void         fb_ConsoleViewUpdate( void );

       void         fb_ConsoleScroll    ( int nrows );

       void         fb_ConReadLineEx    ( FBSTRING *dst );
FBCALL FBSTRING    *fb_ConReadLine      ( void );

FBCALL void         fb_PrintPad         ( int fnum, int mask );
       void         fb_PrintPadEx       ( struct _FB_FILE *handle, int mask );
FBCALL void         fb_PrintVoid        ( int fnum, int mask );
       void         fb_PrintVoidEx      ( struct _FB_FILE *handle, int mask );
FBCALL void         fb_PrintByte        ( int fnum, char val, int mask );
FBCALL void         fb_PrintUByte       ( int fnum, unsigned char val, int mask );
FBCALL void         fb_PrintShort       ( int fnum, short val, int mask );
FBCALL void         fb_PrintUShort      ( int fnum, unsigned short val, int mask );
FBCALL void         fb_PrintInt         ( int fnum, int val, int mask );
FBCALL void         fb_PrintUInt        ( int fnum, unsigned int val, int mask );
FBCALL void         fb_PrintSingle      ( int fnum, float val, int mask );
FBCALL void         fb_PrintDouble      ( int fnum, double val, int mask );
FBCALL void         fb_PrintString      ( int fnum, FBSTRING *s, int mask );
FBCALL void 		fb_PrintWstr 		( int fnum, const FB_WCHAR *s, int mask );
       void         fb_PrintStringEx    ( struct _FB_FILE *handle, FBSTRING *s, int mask );
       void 		fb_PrintWstrEx 		( struct _FB_FILE *handle, const FB_WCHAR *s,
       									  int mask );
FBCALL void         fb_PrintFixString   ( int fnum, const char *s, int mask );
       void         fb_PrintFixStringEx ( struct _FB_FILE *handle, const char *s, int mask );

FBCALL void         fb_PrintBuffer      ( const char *s, int mask );
FBCALL void         fb_PrintBufferEx    ( const void *buffer, size_t len, int mask );
FBCALL void 		fb_PrintBufferWstrEx( const FB_WCHAR *buffer, size_t len, int mask );

FBCALL void         fb_PrintTab         ( int fnum, int newcol );
FBCALL void         fb_PrintSPC         ( int fnum, int n );

FBCALL void         fb_WriteVoid        ( int fnum, int mask );
FBCALL void         fb_WriteByte        ( int fnum, char val, int mask );
FBCALL void         fb_WriteUByte       ( int fnum, unsigned char val, int mask );
FBCALL void         fb_WriteShort       ( int fnum, short val, int mask );
FBCALL void         fb_WriteUShort      ( int fnum, unsigned short val, int mask );
FBCALL void         fb_WriteInt         ( int fnum, int val, int mask );
FBCALL void         fb_WriteUInt        ( int fnum, unsigned int val, int mask );
FBCALL void         fb_WriteSingle      ( int fnum, float val, int mask );
FBCALL void         fb_WriteDouble      ( int fnum, double val, int mask );
FBCALL void         fb_WriteString      ( int fnum, FBSTRING *s, int mask );
FBCALL void         fb_WriteFixString   ( int fnum, char *s, int mask );

       int          fb_ConsoleGetkey    ( void );
       FBSTRING    *fb_ConsoleInkey     ( void );
       int          fb_ConsoleKeyHit    ( void );

       int          fb_ConsoleMultikey  ( int scancode );
       int          fb_ConsoleGetMouse  ( int *x, int *y, int *z, int *buttons );
       int          fb_ConsoleSetMouse  ( int x, int y, int cursor );

       void         fb_ConsolePrintBuffer( const char *buffer, int mask );
       void         fb_ConsolePrintBufferWstr( const FB_WCHAR *buffer, int mask );
       void         fb_ConsolePrintBufferEx( const void *buffer, size_t len, int mask );
       void         fb_ConsolePrintBufferWstrEx( const FB_WCHAR *buffer, size_t len,
       											 int mask );

       char        *fb_ConsoleReadStr   ( char *buffer, int len );

       int          fb_ConsoleGetTopRow ( void );
       int          fb_ConsoleGetBotRow ( void );
       void         fb_ConsoleSetTopBotRows( int top, int bot );




/**************************************************************************************************
 * files
 **************************************************************************************************/

#define FB_FILE_MODE_BINARY             0
#define FB_FILE_MODE_RANDOM             1
#define FB_FILE_MODE_INPUT              2
#define FB_FILE_MODE_OUTPUT             3
#define FB_FILE_MODE_APPEND             4

#define FB_FILE_ACCESS_ANY              0
#define FB_FILE_ACCESS_READ             1
#define FB_FILE_ACCESS_WRITE            2
#define FB_FILE_ACCESS_READWRITE        3

#define FB_FILE_LOCK_SHARED             0
#define FB_FILE_LOCK_READ               1
#define FB_FILE_LOCK_WRITE              2
#define FB_FILE_LOCK_READWRITE          3

#define FB_FILE_TYPE_NORMAL             0
#define FB_FILE_TYPE_CONSOLE            1
#define FB_FILE_TYPE_ERR                2
#define FB_FILE_TYPE_PIPE               3
#define FB_FILE_TYPE_VFS                4

typedef enum _FB_FILE_ENCOD {
	FB_FILE_ENCOD_ASCII,
	FB_FILE_ENCOD_UTF8,
	FB_FILE_ENCOD_UTF16,
	FB_FILE_ENCOD_UTF32
} FB_FILE_ENCOD;

#define FB_FILE_ENCOD_DEFAULT FB_FILE_ENCOD_ASCII


#define FB_FILE_FROM_HANDLE(handle) \
    (((handle) - fb_fileTB) + 1 - FB_RESERVED_FILES)
#define FB_FILE_INDEX_VALID(index) \
    ((index)>=1 && ((index)<(FB_MAX_FILES-FB_RESERVED_FILES)))

#define FB_INDEX_IS_SPECIAL(index) \
    (((index) < 1) && (((index) > (-FB_RESERVED_FILES))

#define FB_HANDLE_IS_SCREEN(handle) \
    ((handle)!=NULL && FB_HANDLE_DEREF(handle)==FB_HANDLE_SCREEN)

#define FB_HANDLE_USED(handle) \
    ((handle)!=NULL && ((handle)->hooks!=NULL))

#define FB_HANDLE_SCREEN    fb_fileTB
#define FB_HANDLE_PRINTER   (fb_fileTB+1)

#include <stdio.h>

struct _FB_FILE;

typedef int (*FnFileSetWidth) 		( struct _FB_FILE *handle, int new_width );
typedef int (*FnFileTest)     		( struct _FB_FILE *handle, const char *filename,
									  size_t filename_len );
typedef int (*FnFileOpen)     		( struct _FB_FILE *handle, const char *filename,
									  size_t filename_len );
typedef int (*FnFileEof)      		( struct _FB_FILE *handle );
typedef int (*FnFileClose)    		( struct _FB_FILE *handle );
typedef int (*FnFileSeek)     		( struct _FB_FILE *handle, long offset, int whence );
typedef int (*FnFileTell)     		( struct _FB_FILE *handle, long *pOffset );
typedef int (*FnFileRead)     		( struct _FB_FILE *handle, void *value,
									  size_t *pValuelen );
typedef int (*FnFileReadWstr) 		( struct _FB_FILE *handle, FB_WCHAR *value,
									  size_t *pValuelen );
typedef int (*FnFileWrite)    		( struct _FB_FILE *handle, const void *value,
									  size_t valuelen );
typedef int (*FnFileWriteWstr)		( struct _FB_FILE *handle, const FB_WCHAR *value,
									  size_t valuelen );
typedef int (*FnFileLock)     		( struct _FB_FILE *handle, unsigned int position,
									  unsigned int size );
typedef int (*FnFileUnlock)   		( struct _FB_FILE *handle, unsigned int position,
									  unsigned int size );
typedef int (*FnFileReadLine) 		( struct _FB_FILE *handle, FBSTRING *dst );
typedef int (*FnFileReadLineWstr)	( struct _FB_FILE *handle, FB_WCHAR *dst, int dst_chars );
typedef int (*FnFileFlush)			( struct _FB_FILE *handle );

typedef struct _FB_FILE_HOOKS {
    FnFileEof       	pfnEof;
    FnFileClose     	pfnClose;
    FnFileSeek      	pfnSeek;
    FnFileTell      	pfnTell;
    FnFileRead      	pfnRead;
    FnFileReadWstr  	pfnReadWstr;
    FnFileWrite     	pfnWrite;
    FnFileWriteWstr 	pfnWriteWstr;
    FnFileLock      	pfnLock;
    FnFileUnlock    	pfnUnlock;
    FnFileReadLine  	pfnReadLine;
    FnFileReadLineWstr  pfnReadLineWstr;
    FnFileSetWidth  	pfnSetWidth;
    FnFileFlush     	pfnFlush;
} FB_FILE_HOOKS;

typedef struct _FB_FILE {
    int             mode;
    int             len;
    FB_FILE_ENCOD	encod;
    long            size;
    int             type;
    int             access;
    int             lock;
    unsigned        line_length;
    unsigned        width;

    /* for a device-independent put back feature */
    char            putback_buffer[4];
    size_t          putback_size;

    FB_FILE_HOOKS   *hooks;
    /* an i/o handler might store additional (handler specific) data here */
    void 			*opaque;
    /* used when opening SCRN: to create an redirection handle */
    struct _FB_FILE *redirection_to;
} FB_FILE;

typedef struct _FB_INPUTCTX {
    FB_FILE			*handle;
    int      		status;
    FBSTRING 		str;
    int     		index;
} FB_INPUTCTX;


typedef FBCALL int (*FnDevOpenHook)( FBSTRING *filename,
                                     unsigned open_mode,
                                     unsigned access_mode,
                                     unsigned lock_mode,
                                     int rec_len,
                                     FnFileOpen *pfnFileOpen );

extern FB_FILE                fb_fileTB[];
extern FnDevOpenHook          fb_pfnDevOpenHook;
#ifdef MULTITHREADED
extern int __fb_io_is_exiting;
#define FB_IO_EXIT_LOCK() \
    if( !__fb_io_is_exiting) FB_LOCK()
#define FB_IO_EXIT_UNLOCK() \
    if( !__fb_io_is_exiting) FB_UNLOCK()
#else
#define FB_IO_EXIT_LOCK()
#define FB_IO_EXIT_UNLOCK()
#endif

static __inline__ struct _FB_FILE *FB_FILE_TO_HANDLE(int index)
{
    if( index==0 )
        return FB_HANDLE_SCREEN;
    if( index==-1 )
        return FB_HANDLE_PRINTER;
    if( FB_FILE_INDEX_VALID(index) )
        return fb_fileTB + index - 1 + FB_RESERVED_FILES;
    return NULL;
}


static __inline__ struct _FB_FILE *FB_HANDLE_DEREF(struct _FB_FILE *handle)
{
    if( handle != NULL ) {
        FB_LOCK();
        while( handle->redirection_to != NULL ) {
            handle = handle->redirection_to;
        }
        FB_UNLOCK();
    }
    return handle;
}

       int          fb_FilePutData      ( int fnum, long pos, const void *data,
       									  size_t length, int adjust_rec_pos,
       									  int checknewline );
       int          fb_FilePutDataEx    ( FB_FILE *handle, long pos, const void *data,
       									  size_t length, int adjust_rec_pos,
       									  int checknewline, int isunicode );
       int          fb_FileGetData      ( int fnum, long pos, void *data,
                                          size_t length, int adjust_rec_pos );
       int          fb_FileGetDataEx    ( FB_FILE *handle, long pos, void *data,
       									  size_t *pLength, int adjust_rec_pos,
       									  int isunicode );

       int          fb_FileOpenVfsRawEx ( FB_FILE *handle, const char *filename,
                                          size_t filename_length,
                                          unsigned int mode, unsigned int access,
                                          unsigned int lock, int len, FB_FILE_ENCOD encoding,
                                          FnFileOpen pfnOpen );
       int          fb_FileOpenVfsEx    ( FB_FILE *handle, FBSTRING *str_filename,
                                          unsigned int mode, unsigned int access,
                                          unsigned int lock, int len, FB_FILE_ENCOD encoding,
                                          FnFileOpen pfnOpen );
FBCALL int          fb_FileOpenCons     ( FBSTRING *str_filename, unsigned int mode,
                                          unsigned int access, unsigned int lock,
                                          int fnum, int len, const char *encoding );
FBCALL int          fb_FileOpenErr      ( FBSTRING *str_filename, unsigned int mode,
                                          unsigned int access, unsigned int lock,
                                          int fnum, int len, const char *encoding );
FBCALL int          fb_FileOpenPipe     ( FBSTRING *str_filename, unsigned int mode,
                                          unsigned int access, unsigned int lock,
                                          int fnum, int len, const char *encoding );
FBCALL int          fb_FileOpenScrn     ( FBSTRING *str_filename, unsigned int mode,
                                          unsigned int access, unsigned int lock,
                                          int fnum, int len, const char *encoding );
FBCALL int          fb_FileOpenLpt      ( FBSTRING *str_filename, unsigned int mode,
                                          unsigned int access, unsigned int lock,
                                          int fnum, int len, const char *encoding );
FBCALL int          fb_FileOpenCom      ( FBSTRING *str_filename, unsigned int mode,
                                          unsigned int access, unsigned int lock,
                                          int fnum, int len, const char *encoding );

FBCALL int          fb_FileFree         ( void );
FBCALL int          fb_FileOpen         ( FBSTRING *str, unsigned int mode,
										  unsigned int access, unsigned int lock,
										  int fnum, int len );
       int          fb_FileOpenEx       ( FB_FILE *handle, FBSTRING *str,
                                          unsigned int mode, unsigned int access,
                                          unsigned int lock, int len );
FBCALL int          fb_FileOpenShort    ( FBSTRING *str_file_mode, int fnum,
                                          FBSTRING *filename, int len,
                                          FBSTRING *str_access_mode,
                                          FBSTRING *str_lock_mode);
FBCALL int          fb_FileClose        ( int fnum );
       int          fb_FileCloseEx      ( FB_FILE *handle );
FBCALL int          fb_FilePut          ( int fnum, long pos, void* value,
										  unsigned int valuelen );
       int          fb_FilePutEx        ( FB_FILE *handle, long pos, void* value,
       									  unsigned int valuelen );
FBCALL int          fb_FilePutStr       ( int fnum, long pos, void *str, int str_len );
       int          fb_FilePutStrEx     ( FB_FILE *handle, long pos, void *str, int str_len );
FBCALL int          fb_FilePutArray     ( int fnum, long pos, FBARRAY *src );
FBCALL int          fb_FileGet          ( int fnum, long pos, void* value,
										  unsigned int valuelen );
       int          fb_FileGetEx        ( FB_FILE *handle, long pos, void* value,
       									  unsigned int valuelen );
FBCALL int          fb_FileGetStr       ( int fnum, long pos, void *str, int str_len );
       int          fb_FileGetStrEx     ( FB_FILE *handle, long pos, void *str, int str_len );
FBCALL int          fb_FileGetArray     ( int fnum, long pos, FBARRAY *dst );
FBCALL int          fb_FileEof          ( int fnum );
       int          fb_FileEofEx        ( FB_FILE *handle );
FBCALL long         fb_FileTell         ( int fnum );
       long         fb_FileTellEx       ( FB_FILE *handle );
FBCALL int          fb_FileSeek         ( int fnum, long newpos );
       int          fb_FileSeekEx       ( FB_FILE *handle, long newpos );
FBCALL long         fb_FileLocation     ( int fnum );
       long         fb_FileLocationEx   ( FB_FILE *handle );
FBCALL int          fb_FileKill         ( FBSTRING *str );
FBCALL void         fb_FileReset        ( void );
FBCALL unsigned int fb_FileSize         ( int fnum );
       unsigned int fb_FileSizeEx       ( FB_FILE *handle );
FBCALL int          fb_FilePutBack      ( int fnum, const void *data, size_t length );
FBCALL int 			fb_FilePutBackWstr	( int fnum, const FB_WCHAR *src, size_t chars );
       int          fb_FilePutBackEx    ( FB_FILE *handle, const void *data,
       									  size_t length );
	   int 			fb_FilePutBackWstrEx( FB_FILE *handle, const FB_WCHAR *src,
	   									  size_t chars );


FBCALL FBSTRING    *fb_FileStrInput     ( int bytes, int fnum );

FBCALL int          fb_FileLineInput    ( int fnum, void *dst, int dst_len, int fillrem );

       int          fb_hFilePrintBuffer ( int fnum, const char *buffer );
       int          fb_hFilePrintBufferWstr ( int fnum, const FB_WCHAR *buffer );
       int          fb_hFilePrintBufferEx( FB_FILE *handle, const void *buffer, size_t len );
       int          fb_hFilePrintBufferWstrEx( FB_FILE *handle, const FB_WCHAR *buffer,
       										   size_t len );

       int          fb_hFileLock        ( FILE *f, unsigned int inipos, unsigned int size );
       int          fb_hFileUnlock      ( FILE *f, unsigned int inipos, unsigned int size );
       char        *fb_hConvertPath     ( char *path, int len );

	  FB_FILE_ENCOD fb_hFileStrToEncoding( const char *encoding );

FBCALL int          fb_SetPos           ( FB_FILE *handle, int line_length );

/**************************************************************************************************
 * devices
 **************************************************************************************************/

       /* CONS */
       int          fb_DevConsOpen      ( struct _FB_FILE *handle, const char *filename,
       									  size_t filename_len );

       /* ERR */
       int          fb_DevErrOpen       ( struct _FB_FILE *handle, const char *filename,
       									  size_t filename_len );

       /* FILE */
       int          fb_DevFileOpen      ( struct _FB_FILE *handle, const char *filename,
       									  size_t filename_len );
       int          fb_DevFileClose     ( struct _FB_FILE *handle );
       int          fb_DevFileEof       ( struct _FB_FILE *handle );
       int          fb_DevFileLock      ( struct _FB_FILE *handle, unsigned int position,
       									  unsigned int size );
       int          fb_DevFileRead      ( struct _FB_FILE *handle, void* value,
       									  size_t *pLength );
       int 			fb_DevFileReadWstr	( struct _FB_FILE *handle, FB_WCHAR *dst,
       									  size_t *pchars );
       int          fb_DevFileReadLine  ( struct _FB_FILE *handle, FBSTRING *dst );
       int          fb_DevFileReadLineWstr( struct _FB_FILE *handle, FB_WCHAR *dst,
       										int dst_chars );
       int          fb_DevFileSeek      ( struct _FB_FILE *handle, long offset, int whence );
       int          fb_DevFileTell      ( struct _FB_FILE *handle, long *pOffset );
       int          fb_DevFileUnlock    ( struct _FB_FILE *handle, unsigned int position,
       									  unsigned int size );
       int          fb_DevFileWrite     ( struct _FB_FILE *handle, const void* value,
       									  size_t valuelen );
       int          fb_DevFileWriteWstr ( struct _FB_FILE *handle, const FB_WCHAR* value,
       									  size_t valuelen );
       int          fb_DevFileFlush     ( struct _FB_FILE *handle );

       typedef char* (*fb_FnDevReadString)( char *buffer,
                                            size_t count,
                                            FILE *fp );
       int          fb_DevFileReadLineDumb( FILE *fp,
                                            FBSTRING *dst,
                                            fb_FnDevReadString pfnReadString );

       /* ENCOD */
	   int 			fb_DevFileOpenEncod	( struct _FB_FILE *handle, const char *filename,
	   									  size_t fname_len );
       int          fb_DevFileOpenUTF   ( struct _FB_FILE *handle, const char *filename,
       									  size_t filename_len );

       /* PIPE */
       int          fb_DevPipeOpen      ( struct _FB_FILE *handle, const char *filename,
       									  size_t filename_len );
       int          fb_DevPipeClose     ( struct _FB_FILE *handle );

       /* SCRN */
typedef struct _DEV_SCRN_INFO {
	char            buffer[16];
    unsigned        length;
} DEV_SCRN_INFO;

       void 		fb_DevScrnInit				( void );
       void 		fb_DevScrnInit_NoOpen		( void );
       void 		fb_DevScrnInit_Write		( void );
       void 		fb_DevScrnInit_WriteWstr	( void );
       void 		fb_DevScrnInit_Read			( void );
       void 		fb_DevScrnInit_ReadWstr		( void );
       void 		fb_DevScrnInit_ReadLine		( void );
       void 		fb_DevScrnInit_ReadLineWstr	( void );

       int          fb_DevScrnOpen      ( struct _FB_FILE *handle, const char *filename,
       									  size_t filename_len );
       int 			fb_DevScrnClose		( struct _FB_FILE *handle );
       int 			fb_DevScrnEof		( struct _FB_FILE *handle );
       int 			fb_DevScrnRead		( struct _FB_FILE *handle, void* value,
       									  size_t *pLength );
       int 			fb_DevScrnReadWstr	( struct _FB_FILE *handle, FB_WCHAR *dst,
       									  size_t *pchars );
       int 			fb_DevScrnWrite		( struct _FB_FILE *handle, const void* value,
       									  size_t valuelen );
       int 			fb_DevScrnWriteWstr	( struct _FB_FILE *handle, const FB_WCHAR* value,
       									  size_t valuelen );
       int 			fb_DevScrnReadLine	( struct _FB_FILE *handle, FBSTRING *dst );
       int 			fb_DevScrnReadLineWstr ( struct _FB_FILE *handle, FB_WCHAR *dst,
       										 int dst_chars );
       void 		fb_DevScrnFillInput	( DEV_SCRN_INFO *info );

       /* STDIO */
       int          fb_DevStdIoClose    ( struct _FB_FILE *handle );

       /* LPT */
       int          fb_DevLptOpen       ( struct _FB_FILE *handle, const char *filename,
       									  size_t filename_len );

       /* COM */
       int          fb_DevComOpen       ( struct _FB_FILE *handle, const char *filename,
       									  size_t filename_len );

/**************************************************************************************************
 * printer
 **************************************************************************************************/

       int          fb_DevPrinterSetWidth ( const char *pszDevice, int width,
       										int default_width );
       int          fb_DevPrinterGetOffset( const char *pszDevice );
       int          fb_PrinterOpen      ( int iPort, const char *pszDevice,
       									  void **ppvHandle );
       int          fb_PrinterWrite     ( void *pvHandle, const void *data, size_t length );
       int          fb_PrinterWriteWstr ( void *pvHandle, const FB_WCHAR *data,
       									  size_t length );
       int          fb_PrinterClose     ( void *pvHandle );

/**************************************************************************************************
 * serial
 **************************************************************************************************/

typedef enum _FB_SERIAL_PARITY {
    FB_SERIAL_PARITY_NONE,
    FB_SERIAL_PARITY_EVEN,
    FB_SERIAL_PARITY_ODD,
    FB_SERIAL_PARITY_SPACE,
    FB_SERIAL_PARITY_MARK
} FB_SERIAL_PARITY;

typedef enum _FB_SERIAL_STOP_BITS {
    FB_SERIAL_STOP_BITS_1,
    FB_SERIAL_STOP_BITS_1_5,
	FB_SERIAL_STOP_BITS_2
} FB_SERIAL_STOP_BITS;

typedef struct _FB_SERIAL_OPTIONS {
	unsigned           uiSpeed;
    unsigned           uiDataBits;
    FB_SERIAL_PARITY   Parity;
    FB_SERIAL_STOP_BITS StopBits;
    unsigned           DurationCTS;        /* CS[msec] */
    unsigned           DurationDSR;        /* DS[msec] */
    unsigned           DurationCD;         /* CD[msec] */
    unsigned           OpenTimeout;        /* OP[msec] */
    int                SuppressRTS;        /* RS */
    int                AddLF;              /* LF, or ASC, or BIN */
    int                CheckParity;        /* PE */
    int                KeepDTREnabled;     /* DT */
    int                DiscardOnError;     /* FE */
    int                IgnoreAllErrors;    /* ME */
    unsigned           IRQNumber;          /* IR2..IR15 */
    unsigned           TransmitBuffer;     /* TBn - a value 0 means: default value */
    unsigned           ReceiveBuffer;      /* RBn - a value 0 means: default value */
} FB_SERIAL_OPTIONS;

       int          fb_DevSerialSetWidth( const char *pszDevice, int width,
       									  int default_width );
       int          fb_SerialOpen       ( struct _FB_FILE *handle,
                                          int iPort,
                                          FB_SERIAL_OPTIONS *options,
                                          const char *pszDevice,
                                          void **ppvHandle );
       int          fb_SerialGetRemaining( struct _FB_FILE *handle,
                                           void *pvHandle, long *pLength );
       int          fb_SerialWrite      ( struct _FB_FILE *handle,
                                          void *pvHandle, const void *data, size_t length );
       int          fb_SerialWriteWstr  ( struct _FB_FILE *handle,
                                          void *pvHandle, const FB_WCHAR *data,
                                          size_t length );
       int          fb_SerialRead       ( struct _FB_FILE *handle,
                                          void *pvHandle, void *data, size_t *pLength );
       int          fb_SerialReadWstr   ( struct _FB_FILE *handle,
                                          void *pvHandle, FB_WCHAR *data, size_t *pLength );
       int          fb_SerialClose      ( struct _FB_FILE *handle,
                                          void *pvHandle );

/**************************************************************************************************
 * UTF Encoding
 **************************************************************************************************/

extern const UTF_8 fb_utf8_bmarkTb[7];

	void 		   fb_hCharToUTF8			( const char *src, int chars,
											  char *dst, int *bytes );

	char 		   *fb_CharToUTF			( FB_FILE_ENCOD encod, const char *src,
										  	  int chars, char *dst, int *bytes );
	char 		   *fb_WCharToUTF			( FB_FILE_ENCOD encod, const FB_WCHAR *src,
										  	  int chars, char *dst, int *bytes );

	int 		   fb_hFileRead_UTFToChar	( FILE *fp, FB_FILE_ENCOD encod, char *dst,
											  int max_chars );
	int 		   fb_hFileRead_UTFToWchar	( FILE *fp, FB_FILE_ENCOD encod,
											  FB_WCHAR *dst, int max_chars );


/**************************************************************************************************
 * date/time
 **************************************************************************************************/

FBCALL double       fb_Timer            ( void );
FBCALL FBSTRING    *fb_Time             ( void );
FBCALL int          fb_SetTime          ( FBSTRING *time );
FBCALL FBSTRING    *fb_Date             ( void );
FBCALL int          fb_SetDate          ( FBSTRING *date );

       int          fb_hSetTime         ( int h, int m, int s );
       int          fb_hSetDate         ( int y, int m, int d );

/**************************************************************************************************
 * error
 **************************************************************************************************/

#define FB_ERROR_MESSAGE_SIZE		1024
extern char *fb_error_message;

typedef void (*FB_ERRHANDLER) (void);

typedef struct _FB_ERRORCTX {
    FB_ERRHANDLER  	handler;
    int				num;
    int				linenum;
    const char	   *fname;
    void		   *reslbl;
    void		   *resnxtlbl;
} FB_ERRORCTX;

       FB_ERRHANDLER fb_ErrorThrowEx    ( int errnum, int linenum, const char *fname,
       									  void *res_label, void *resnext_label );
FBCALL FB_ERRHANDLER fb_ErrorSetHandler ( FB_ERRHANDLER newhandler );
FBCALL int           fb_ErrorGetNum     ( void );
FBCALL int           fb_ErrorSetNum     ( int errnum );
       void         *fb_ErrorResume     ( void );
       void         *fb_ErrorResumeNext ( void );

/**************************************************************************************************
 * thread
 **************************************************************************************************/

typedef void (FBCALL *FB_THREADPROC)( int param );

typedef struct _FBTHREAD
{
	FB_THREADID		id;
	FB_THREADPROC	proc;
	int 			param;
} FBTHREAD;

struct _FBMUTEX;
struct _FBCOND;

FBCALL FBTHREAD 		*fb_ThreadCreate( FB_THREADPROC proc, int param );
FBCALL void              fb_ThreadWait  ( FBTHREAD *thread );

FBCALL struct _FBMUTEX  *fb_MutexCreate ( void );
FBCALL void              fb_MutexDestroy( struct _FBMUTEX *mutex );
FBCALL void              fb_MutexLock   ( struct _FBMUTEX *mutex );
FBCALL void              fb_MutexUnlock ( struct _FBMUTEX *mutex );

FBCALL struct _FBCOND   *fb_CondCreate  ( void );
FBCALL void              fb_CondDestroy ( struct _FBCOND *cond );
FBCALL void              fb_CondSignal  ( struct _FBCOND *cond );
FBCALL void              fb_CondBroadcast( struct _FBCOND *cond );
FBCALL void              fb_CondWait    ( struct _FBCOND *cond );

/**************************************************************************************************
 * misc
 **************************************************************************************************/

FBCALL void         fb_Init             ( int argc, char **argv );
FBCALL void         fb_End              ( int errlevel );
FBCALL void 		fb_RtInit 			( void );
	   void 		fb_RtExit 			( void );
FBCALL void         fb_InitSignals      ( void );

FBCALL void         fb_MemSwap          ( unsigned char *dst, unsigned char *src, int bytes );
FBCALL void         fb_StrSwap          ( void *str1, int str1_size,
										  void *str2, int str2_size );

       void         fb_hInit            ( void );
       void         fb_hEnd             ( int errlevel );
       void         fb_hInitSignals     ( void );

FBCALL void         fb_Beep             ( void );

/**************************************************************************************************
 * hooks
 **************************************************************************************************/

typedef FBSTRING   *(*FB_INKEYPROC)     ( void );
typedef int         (*FB_GETKEYPROC)    ( void );
typedef int         (*FB_KEYHITPROC)    ( void );

FBCALL FBSTRING    *fb_Inkey            ( void );
FBCALL int          fb_Getkey           ( void );
FBCALL int          fb_KeyHit           ( void );

typedef void        (*FB_CLSPROC)       ( int mode );

FBCALL void         fb_Cls              ( int mode );

typedef int         (*FB_COLORPROC)     ( int fc, int bc );

FBCALL int          fb_Color            ( int fc, int bc );

typedef int         (*FB_LOCATEPROC)    ( int row, int col, int cursor );

FBCALL int          fb_LocateEx         ( int row, int col, int cursor, int *current_pos );
FBCALL int          fb_Locate           ( int row, int col, int cursor );
FBCALL int          fb_LocateSub        ( int row, int col, int cursor );

typedef void        (*FB_VIEWUPDATEPROC)( void );

FBCALL void         fb_ViewUpdate       ( void );

typedef int         (*FB_WIDTHPROC)     ( int cols, int rows );

FBCALL int          fb_Width            ( int cols, int rows );
FBCALL int          fb_WidthDev         ( FBSTRING *dev, int width );
FBCALL int          fb_WidthFile        ( int fnum, int width );

typedef int         (*FB_GETXPROC)      ( void );
typedef int         (*FB_GETYPROC)      ( void );
typedef void        (*FB_GETXYPROC)     ( int *col, int *row );
typedef void        (*FB_GETSIZEPROC)   ( int *cols, int *rows );

FBCALL int          fb_Pos              ( int dummy );
FBCALL int          fb_GetX             ( void );
FBCALL int          fb_GetY             ( void );
FBCALL void         fb_GetXY            ( int *col, int *row );
FBCALL void         fb_GetSize          ( int *cols, int *rows );

typedef int         (*FB_READXYPROC)    ( int col, int row, int colorflag );
FBCALL int          fb_ReadXY           ( int col, int row, int colorflag );

typedef void        (*FB_PRINTBUFFPROC) ( const void *buffer, size_t len, int mask );
typedef void        (*FB_PRINTBUFFWPROC)( const FB_WCHAR *buffer, size_t len, int mask );

typedef char        *(*FB_READSTRPROC)  ( char *buffer, int len );
        char        *fb_ReadString      ( char *buffer, int len, FILE *f );

typedef int         (*FB_LINEINPUTPROC) ( FBSTRING *text, void *dst, int dst_len,
										  int fillrem, int addquestion, int addnewline );
typedef int         (*FB_LINEINPUTWPROC)( const FB_WCHAR *text, FB_WCHAR *dst,
										  int max_chars, int addquestion, int addnewline );
FBCALL int          fb_LineInput        ( FBSTRING *text, void *dst, int dst_len,
										  int fillrem, int addquestion, int addnewline );
FBCALL int          fb_LineInputWstr    ( const FB_WCHAR *text, FB_WCHAR *dst,
										  int max_chars, int addquestion, int addnewline );
	   int 			fb_ConsoleLineInput	( FBSTRING *text, void *dst, int dst_len,
	   									  int fillrem, int addquestion, int addnewline );
       int          fb_ConsoleLineInputWstr ( const FB_WCHAR *text, FB_WCHAR *dst,
       										  int max_chars, int addquestion,
       										  int addnewline );

FBCALL int          fb_Multikey         ( int scancode );
FBCALL int          fb_GetMouse         ( int *x, int *y, int *z, int *buttons );
FBCALL int          fb_SetMouse         ( int x, int y, int cursor );
typedef int         (*FB_MULTIKEYPROC)  ( int scancode );
typedef int         (*FB_GETMOUSEPROC)  ( int *x, int *y, int *z, int *buttons );
typedef int         (*FB_SETMOUSEPROC)  ( int x, int y, int cursor );

FBCALL int          fb_In               ( unsigned short port );
FBCALL int          fb_Out              ( unsigned short port, unsigned char value );
typedef int         (*FB_INPROC)        ( unsigned short port );
typedef int         (*FB_OUTPROC)       ( unsigned short port, unsigned char value );

FBCALL void         fb_Sleep            ( int msecs );
FBCALL void         fb_Delay            ( int msecs );
FBCALL int          fb_SleepEx          ( int msecs, int kind );
       void         fb_ConsoleSleep     ( int msecs );
typedef void        (*FB_SLEEPPROC)     ( int msecs );

FBCALL int 			fb_IsRedirected		( int is_input );
       int 			fb_ConsoleIsRedirected( int is_input );
typedef int         (*FB_ISREDIRPROC)  	( int is_input );

typedef struct _FB_HOOKSTB {
    FB_INKEYPROC    		inkeyproc;
    FB_GETKEYPROC   		getkeyproc;
    FB_KEYHITPROC   		keyhitproc;
    FB_CLSPROC      		clsproc;
    FB_COLORPROC    		colorproc;
    FB_LOCATEPROC   		locateproc;
    FB_WIDTHPROC    		widthproc;
    FB_GETXPROC     		getxproc;
    FB_GETYPROC     		getyproc;
    FB_GETXYPROC    		getxyproc;
    FB_GETSIZEPROC  		getsizeproc;
    FB_PRINTBUFFPROC 		printbuffproc;
    FB_PRINTBUFFWPROC 		printbuffwproc;
    FB_READSTRPROC  		readstrproc;
    FB_MULTIKEYPROC 		multikeyproc;
    FB_GETMOUSEPROC 		getmouseproc;
    FB_SETMOUSEPROC 		setmouseproc;
    FB_INPROC       		inproc;
    FB_OUTPROC      		outproc;
    FB_VIEWUPDATEPROC 		viewupdateproc;
    FB_LINEINPUTPROC 		lineinputproc;
    FB_LINEINPUTWPROC 		lineinputwproc;
    FB_READXYPROC   		readxyproc;
    FB_SLEEPPROC    		sleepproc;
    FB_ISREDIRPROC			isredirproc;
} FB_HOOKSTB;

extern FB_HOOKSTB   fb_hooks;

/**************************************************************************************************
 * per-thread local storage context
 **************************************************************************************************/

enum {
	FB_TLSKEY_ERROR,
	FB_TLSKEY_DIR,
	FB_TLSKEY_INPUT,
	FB_TLSKEY_PRINTUSG,

	FB_TLSKEYS
};

enum {
	FB_TLSLEN_ERROR 	= sizeof( FB_ERRORCTX ),
	FB_TLSLEN_DIR		= sizeof( FB_DIRCTX ),
	FB_TLSLEN_INPUT		= sizeof( FB_INPUTCTX ),
	FB_TLSLEN_PRINTUSG  = sizeof( FB_PRINTUSGCTX ),
};

extern FB_TLSENTRY fb_tls_ctxtb[];

FBCALL void		   *fb_TlsGetCtx		( int index, int len );
FBCALL void			fb_TlsDelCtx		( int index );
FBCALL void 		fb_TlsFreeCtxTb		( void );

#define FB_TLSGETCTX(id) (FB_##id##CTX *)fb_TlsGetCtx( FB_TLSKEY_##id, FB_TLSLEN_##id );

#ifdef __cplusplus
}
#endif

#endif /*__FB_H__*/
