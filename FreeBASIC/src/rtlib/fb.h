/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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

#ifdef __cplusplus
extern "C" {
#endif

#define FB_TRUE -1
#define FB_FALSE 0


#ifdef WIN32
# if defined(NOSTDCALL) || defined(TARGET_XBOX)
#  define FBCALL __cdecl
# else
#  define FBCALL __stdcall
# endif
#else /* WIN32 */
# define FBCALL
#endif /* WIN32 */

#ifndef FALSE
#define FALSE	0
#endif
#ifndef TRUE
#define TRUE	1
#endif
#ifndef NULL
#define NULL 	0
#endif

#ifndef WIN32
#define MAX_PATH	1024
#endif

#ifdef TARGET_WIN32
#include "win32/fb_win32.h"
#elif defined(TARGET_LINUX)
#include "linux/fb_linux.h"
#elif defined(TARGET_XBOX)
#include "xbox/fb_xbox.h"
#endif

#ifndef FB_LOCK
# define FB_LOCK()
#endif
#ifndef FB_UNLOCK
# define FB_UNLOCK()
#endif
#ifndef FB_STRLOCK
# define FB_STRLOCK()
#endif
#ifndef FB_STRUNLOCK
# define FB_STRUNLOCK()
#endif
#ifndef FB_TLSENTRY
# define FB_TLSENTRY				unsigned int
#endif
#ifndef FB_TLSSET
# define FB_TLSSET(key,value)		key = (unsigned int)value
#endif
#ifndef FB_TLSGET
# define FB_TLSGET(key)				key
#endif


#define FB_NEWLINE "\n"

/**************************************************************************************************
 * internal lists
 **************************************************************************************************/

typedef struct _FB_LISTELEM {
	struct _FB_LISTELEM	*prev;
	struct _FB_LISTELEM	*next;
} FB_LISTELEM;

typedef struct _FB_LIST {
	int				cnt;
	FB_LISTELEM		*head;
	FB_LISTELEM		*tail;
	FB_LISTELEM		*fhead;
} FB_LIST;

void				fb_hListInit			( FB_LIST *list, void *table, int elem_size, int size );
FB_LISTELEM			*fb_hListAllocElem		( FB_LIST *list );
void				fb_hListFreeElem		( FB_LIST *list, FB_LISTELEM *elem );

/**************************************************************************************************
 * strings
 **************************************************************************************************/

#include <string.h>
#include <stdio.h>

#define FB_TEMPSTRBIT 0x80000000L

#define FB_ISTEMP(s) ((((FBSTRING *)s)->len & FB_TEMPSTRBIT) != 0)

#define FB_STRSIZE(s) (((FBSTRING *)s)->len & ~FB_TEMPSTRBIT)

#define FB_STRSETUP(s,size,ptr,len)  								\
	if( s == NULL )													\
	{																\
		ptr = NULL;													\
		len = 0;													\
	}																\
	else															\
	{																\
		if( size == -1 )                                            \
		{                                                           \
			ptr = ((FBSTRING *)s)->data;                            \
			len = FB_STRSIZE( s );                                  \
		}                                                           \
		else                                                        \
		{                                                           \
			ptr = (char *)s;                                        \
			/* always get the real len, as fix-len string */		\
			/* will have garbage at end (nulls or spaces) */		\
			if( ptr != NULL )										\
				len = strlen( (char *)s );                      	\
			else													\
				len = 0;											\
		}															\
	}

typedef struct _FBSTRING {
	char			*data;						/* must be at ofs 0! */
	int				len;						/* length */
	int				size;						/* real size */
} FBSTRING;


#define FB_STR_TMPDESCRIPTORS 256

typedef struct _FB_STR_TMPDESC {
	FBSTRING		desc;

	FB_LISTELEM		elem;
} FB_STR_TMPDESC;


/* protos */

/* intern */
extern    FBSTRING 	fb_strNullDesc;

FB_STR_TMPDESC 		*fb_hStrAllocTmpDesc	( void );
		  int 		fb_hStrDelTempDesc		( FBSTRING *str );
		  void 		fb_hStrRealloc			( FBSTRING *str, int size, int preserve );
		  void 		fb_hStrAllocTemp		( FBSTRING *str, int size );
		  int 		fb_hStrDelTemp			( FBSTRING *str );
		  void 		fb_hStrCopy				( char *dst, char *src, int bytes );
		  char 		*fb_hStrSkipChar		( char *s, int len, int c );
		  char 		*fb_hStrSkipCharRev		( char *s, int len, int c );


/* public */

FBCALL void 		fb_StrDelete			( FBSTRING *str );
#ifdef MULTITHREADED
	   void			fb_hStrDeleteLocked		( FBSTRING *str );
#endif
FBCALL void 		*fb_StrAssign 			( void *dst, int dst_size, void *src, int src_size, int fillrem );
FBCALL FBSTRING		*fb_StrConcat 			( FBSTRING *dst, void *str1, int str1_size, void *str2, int str2_size );
FBCALL void 		*fb_StrConcatAssign 	( void *dst, int dst_size, void *src, int src_size, int fillrem );
FBCALL int 			fb_StrCompare 			( void *str1, int str1_size, void *str2, int str2_size );
FBCALL FBSTRING		*fb_StrAllocTempResult 	( FBSTRING *src );
FBCALL FBSTRING     *fb_StrAllocTempDescF   ( char *str, int str_size );
FBCALL FBSTRING     *fb_StrAllocTempDescV   ( FBSTRING *str );
FBCALL FBSTRING     *fb_StrAllocTempDescZ   ( char *str );
FBCALL int 			fb_StrLen				( void *str, int str_size );

FBCALL FBSTRING 	*fb_IntToStr 			( int num );
FBCALL FBSTRING 	*fb_FloatToStr 			( float num );
FBCALL FBSTRING 	*fb_DoubleToStr 		( double num );

#define FB_F2A_ADDBLANK	 0x00000001
#define FB_F2A_NOEXP	 0x00000002

FBCALL double 		fb_hStr2Double			( char *src, int len );
FBCALL int 			fb_hStr2Int				( char *src, int len );
FBCALL long long 	fb_hStr2Longint			( char *src, int len );
FBCALL int 			fb_hStrRadix2Int		( char *src, int len, int radix );
	   char 		*fb_hFloat2Str			( double val, char *buffer, int digits, int mask );

	   FBSTRING 	*fb_CHR 				( int args, ... );
FBCALL unsigned int fb_ASC 					( FBSTRING *str, int pos );
FBCALL double 		fb_VAL 					( FBSTRING *str );
FBCALL double 		fb_CVD 					( FBSTRING *str );
FBCALL int 			fb_CVI 					( FBSTRING *str );
FBCALL FBSTRING 	*fb_HEX 				( int num );
FBCALL FBSTRING 	*fb_OCT 				( int num );
FBCALL FBSTRING 	*fb_BIN 				( int num );
FBCALL FBSTRING 	*fb_MKD 				( double num );
FBCALL FBSTRING 	*fb_MKI 				( int num );
FBCALL FBSTRING 	*fb_MKS 				( float num );
FBCALL FBSTRING 	*fb_LEFT 				( FBSTRING *str, int chars );
FBCALL FBSTRING 	*fb_RIGHT 				( FBSTRING *str, int chars );
FBCALL FBSTRING 	*fb_SPACE 				( int chars );
FBCALL FBSTRING 	*fb_LTRIM 				( FBSTRING *str );
FBCALL FBSTRING 	*fb_RTRIM 				( FBSTRING *str );
FBCALL FBSTRING 	*fb_TRIM 				( FBSTRING *src );
FBCALL FBSTRING 	*fb_LCASE 				( FBSTRING *str );
FBCALL FBSTRING 	*fb_UCASE 				( FBSTRING *str );
FBCALL FBSTRING 	*fb_StrFill1 			( int cnt, int fchar );
FBCALL FBSTRING 	*fb_StrFill2 			( int cnt, FBSTRING *src );
FBCALL int 			fb_StrInstr 			( int start, FBSTRING *src, FBSTRING *patt );
FBCALL FBSTRING 	*fb_StrMid 				( FBSTRING *src, int start, int len );
FBCALL void 		fb_StrAssignMid 		( FBSTRING *dst, int start, int len, FBSTRING *src );

/**************************************************************************************************
 * arrays
 **************************************************************************************************/

#define FB_MAXDIMENSIONS 16

typedef struct _FBARRAYDIM {
	int				elements;
	int				lbound;
} FBARRAYDIM;

typedef struct _FBARRAY {
    void			*data;					/* ptr + diff, must be at ofs 0! */
	void			*ptr;
    int				size;
    int				element_len;
    int				dimensions;
	FBARRAYDIM		dimTB[1];				/* dimtb[dimensions] */
} FBARRAY;

typedef struct _FB_ARRAY_TMPDESC {
	FB_LISTELEM		elem;

	FBARRAY			array;
	FBARRAYDIM		dimTB[FB_MAXDIMENSIONS-1];
} FB_ARRAY_TMPDESC;


#define FB_ARRAY_TMPDESCRIPTORS (FB_STR_TMPDESCRIPTORS / 4)

/* protos */

	   int 			fb_ArrayRedim		( FBARRAY *array, int element_len, int isvarlen, int preserve, int dimensions, ... );
	   void 		fb_ArraySetDesc		( FBARRAY *array, void *ptr, int element_len, int dimensions, ... );
FBCALL int 			fb_ArrayErase		( FBARRAY *array, int isvarlen );
FBCALL void 		fb_ArrayStrErase	( FBARRAY *array );
FBCALL int 			fb_ArrayLBound		( FBARRAY *array, int dimension );
FBCALL int 			fb_ArrayUBound		( FBARRAY *array, int dimension );

	   int 			fb_hArrayCalcElements ( int dimensions, const int *lboundTB, const int *uboundTB );
	   int 			fb_hArrayCalcDiff	( int dimensions, const int *lboundTB, const int *uboundTB );
	   int 			fb_hArrayFreeVarLenStrs ( FBARRAY *array );


/**************************************************************************************************
 * system
 **************************************************************************************************/

FBCALL FBSTRING 	*fb_Command 		( int argc );
FBCALL FBSTRING 	*fb_CurDir 			( void );
FBCALL FBSTRING 	*fb_ExePath 		( void );
FBCALL int			fb_Shell			( FBSTRING *program );
FBCALL int 			fb_Run 				( FBSTRING *program );
FBCALL int 			fb_Chain 			( FBSTRING *program );
FBCALL int 			fb_Exec 			( FBSTRING *program, FBSTRING *args );
FBCALL void 		*fb_DylibLoad		( FBSTRING *library );
FBCALL void			*fb_DylibSymbol		( void *library, FBSTRING *symbol );
FBCALL void			fb_DylibFree		( void *library );

	   char 		*fb_hGetShortPath	( char *src, char *dst, int maxlen );

	   int 			fb_hGetCurrentDir 	( char *dst, int maxlen );
	   char 		*fb_hGetCommandLine	( void );
	   char 		*fb_hGetExePath		( char *dst, int maxlen );
	   char 		*fb_hGetExeName		( char *dst, int maxlen );

/**************************************************************************************************
 * math
 **************************************************************************************************/

FBCALL double 		fb_Rnd 				( int n );
FBCALL void 		fb_Randomize 		( double seed );
FBCALL int 			fb_SGNSingle 		( float x );
FBCALL int 			fb_SGNDouble 		( double x );
FBCALL float 		fb_FIXSingle		( float x );
FBCALL double 		fb_FIXDouble		( double x );


/**************************************************************************************************
 * data
 **************************************************************************************************/

extern char 		*fb_DataPtr;

#define FB_DATATYPE_LINK -1
#define FB_DATATYPE_OFS  -2

FBCALL void 		fb_DataReadStr		( void *dst, int dst_size, int fillrem );
FBCALL void 		fb_DataReadByte		( char *dst );
FBCALL void 		fb_DataReadShort	( short *dst );
FBCALL void 		fb_DataReadInt		( int *dst );
FBCALL void 		fb_DataReadSingle	( float *dst );
FBCALL void 		fb_DataReadDouble	( double *dst );

	   short 		fb_DataRead			( void );

/**************************************************************************************************
 * console
 **************************************************************************************************/

typedef struct _FB_PRINTUSGCTX {
	FB_TLSENTRY		chars;
	FB_TLSENTRY		ptr;
	struct {
		FB_TLSENTRY	data;
		FB_TLSENTRY len;
		FB_TLSENTRY size;
	} fmtstr;
} FB_PRINTUSGCTX;


#define FB_TAB_WIDTH     14
#if FB_TAB_WIDTH == 8
#define FB_NATIVE_TAB
#endif

#define FB_PRINT_NEWLINE 0x00000001
#define FB_PRINT_PAD 	 0x00000002
#define FB_PRINT_ISLAST  0x80000000     /* only for USING */

/** masked bits for "high level" flags
 *
 * I.e. flags that are set by the BASIC PRINT command directly.
 */
#define FB_PRINT_HLMASK  0x00000003

#define FB_PRINT_EX(fnum, s, len, mask)           		\
    {                                          			\
        if( fnum == 0 ) {                       	  	\
            fb_PrintBufferEx( s, len, mask );     		\
        } else {                                  		\
            fb_hFilePrintBufferEx( fnum, s, len ); 		\
        }                                         		\
    }

#define FB_PRINT(fnum, s, mask)           				\
    FB_PRINT_EX(fnum, s, strlen(s), mask)

#define FB_PRINTNUM(fnum, val, mask, fmt, type)			\
    char buffer[80];									\
    													\
    if( mask & FB_PRINT_NEWLINE )           			\
    	sprintf( buffer, fmt type FB_NEWLINE, val );    \
    else if( mask & FB_PRINT_PAD )          			\
    	sprintf( buffer, fmt "-14" type, val );			\
    else												\
    	sprintf( buffer, fmt type, val );              	\
    													\
    FB_PRINT( fnum, buffer, mask );

extern FB_PRINTUSGCTX fb_printusgctx;


	   int 			fb_ConsoleWidth		( int cols, int rows );
	   void 		fb_ConsoleClear		( int mode );

	   int	 		fb_ConsoleLocate	( int row, int col, int cursor );
	   int 			fb_ConsoleGetY		( void );
       int 			fb_ConsoleGetX		( void );
FBCALL void 		fb_ConsoleGetSize	( int *cols, int *rows );
FBCALL void 		fb_ConsoleGetXY		( int *col, int *row );

FBCALL int			fb_ConsoleReadXY	( int col, int row, int colorflag );
	   int 			fb_ConsoleColor		( int fc, int bc );
	   int 			fb_ConsoleGetColorAtt( void );

FBCALL void 		fb_ConsoleView		( int toprow, int botrow );
	   void 		fb_ConsoleGetView	( int *toprow, int *botrow );
	   int 			fb_ConsoleGetMaxRow ( void );
	   void 		fb_ConsoleViewUpdate( void );

	   void 		fb_ConsoleScroll	( int nrows );

FBCALL void         fb_PrintPad         ( int fnum, int mask );
FBCALL void 		fb_PrintVoid 		( int fnum, int mask );
FBCALL void 		fb_PrintByte 		( int fnum, char val, int mask );
FBCALL void 		fb_PrintUByte 		( int fnum, unsigned char val, int mask );
FBCALL void 		fb_PrintShort 		( int fnum, short val, int mask );
FBCALL void 		fb_PrintUShort 		( int fnum, unsigned short val, int mask );
FBCALL void 		fb_PrintInt 		( int fnum, int val, int mask );
FBCALL void 		fb_PrintUInt 		( int fnum, unsigned int val, int mask );
FBCALL void 		fb_PrintSingle 		( int fnum, float val, int mask );
FBCALL void 		fb_PrintDouble 		( int fnum, double val, int mask );
FBCALL void 		fb_PrintString 		( int fnum, FBSTRING *s, int mask );
FBCALL void 		fb_PrintFixString 	( int fnum, const char *s, int mask );

FBCALL void 		fb_PrintTab			( int fnum, int newcol );
FBCALL void 		fb_PrintSPC			( int fnum, int n );

FBCALL void 		fb_WriteVoid 		( int fnum, int mask );
FBCALL void 		fb_WriteByte 		( int fnum, char val, int mask );
FBCALL void 		fb_WriteUByte 		( int fnum, unsigned char val, int mask );
FBCALL void 		fb_WriteShort 		( int fnum, short val, int mask );
FBCALL void 		fb_WriteUShort 		( int fnum, unsigned short val, int mask );
FBCALL void 		fb_WriteInt 		( int fnum, int val, int mask );
FBCALL void 		fb_WriteUInt 		( int fnum, unsigned int val, int mask );
FBCALL void 		fb_WriteSingle 		( int fnum, float val, int mask );
FBCALL void 		fb_WriteDouble 		( int fnum, double val, int mask );
FBCALL void 		fb_WriteString 		( int fnum, FBSTRING *s, int mask );
FBCALL void 		fb_WriteFixString 	( int fnum, char *s, int mask );

	   int 			fb_ConsoleGetkey	( void );
	   FBSTRING 	*fb_ConsoleInkey	( void );
	   int 			fb_ConsoleKeyHit	( void );

	   int			fb_ConsoleMultikey	( int scancode );
	   int			fb_ConsoleGetMouse	( int *x, int *y, int *z, int *buttons );
	   int			fb_ConsoleSetMouse	( int x, int y, int cursor );

	   void 		fb_ConsolePrintBuffer( const char *buffer, int mask );
	   void 		fb_ConsolePrintBufferEx( const void *buffer, size_t len, int mask );

	   char 		*fb_ConsoleReadStr	( char *buffer, int len );

	   int 			fb_ConsoleGetTopRow	( void );
	   int 			fb_ConsoleGetBotRow	( void );
	   void 		fb_ConsoleSetTopBotRows( int top, int bot );

/**************************************************************************************************
 * files
 **************************************************************************************************/

#define FB_MAX_FILES		255
#define FB_FILE_BUFSIZE		8192

#include <stdio.h>

typedef struct _FB_FILE {
	FILE			*f;
    int				mode;
    int				len;
    long			size;
    int				type;
    int				access;
    unsigned        line_length;
} FB_FILE;

typedef struct _FB_INPCTX {
	FB_TLSENTRY		f;
	FB_TLSENTRY		i;
	struct {
		FB_TLSENTRY	data;
		FB_TLSENTRY len;
		FB_TLSENTRY size;
	} s;
} FB_INPCTX;


extern FB_FILE fb_fileTB[];
extern FB_INPCTX fb_inpctx;


#define FB_FILE_MODE_BINARY			0
#define FB_FILE_MODE_RANDOM			1
#define FB_FILE_MODE_INPUT			2
#define FB_FILE_MODE_OUTPUT			3
#define FB_FILE_MODE_APPEND			4

#define FB_FILE_ACCESS_ANY			0
#define FB_FILE_ACCESS_READ			1
#define FB_FILE_ACCESS_WRITE		2
#define FB_FILE_ACCESS_READWRITE	3

#define FB_FILE_LOCK_SHARED			0
#define FB_FILE_LOCK_READ			1
#define FB_FILE_LOCK_WRITE			2
#define FB_FILE_LOCK_READWRITE		3

#define FB_FILE_TYPE_NORMAL			0
#define FB_FILE_TYPE_CONSOLE		1
#define FB_FILE_TYPE_ERR			2
#define FB_FILE_TYPE_PIPE			3
#define FB_FILE_TYPE_PRINTER        4

FBCALL int 			fb_FileFree 		( void );
FBCALL int 			fb_FileOpen			( FBSTRING *str, unsigned int mode, unsigned int access,
										  unsigned int lock, int fnum, int len );
FBCALL int 			fb_FileClose		( int fnum );
FBCALL int 			fb_FilePut			( int fnum, long pos, void* value, unsigned int valuelen );
FBCALL int 			fb_FilePutStr		( int fnum, long pos, void *str, int str_len );
FBCALL int 			fb_FilePutArray		( int fnum, long pos, FBARRAY *src );
FBCALL int 			fb_FileGet			( int fnum, long pos, void* value, unsigned int valuelen );
FBCALL int 			fb_FileGetStr		( int fnum, long pos, void *str, int str_len );
FBCALL int 			fb_FileGetArray		( int fnum, long pos, FBARRAY *dst );
FBCALL int 			fb_FileEof			( int fnum );
FBCALL long 		fb_FileTell			( int fnum );
FBCALL int 			fb_FileSeek			( int fnum, long newpos );
FBCALL long 		fb_FileLocation		( int fnum );
FBCALL int 			fb_FileKill			( FBSTRING *str );
FBCALL void 		fb_FileReset 		( void );
FBCALL unsigned int fb_FileSize			( int fnum );

FBCALL FBSTRING 	*fb_FileStrInput	( int bytes, int fnum );

FBCALL int 			fb_FileLineInput	( int fnum, void *dst, int dst_len, int fillrem );
FBCALL int 			fb_LineInput		( FBSTRING *text, void *dst, int dst_len, int fillrem, int addquestion, int addnewline );

FBCALL void 		fb_FileSetLineLen	( int fnum, int len );
FBCALL int 			fb_FileGetLineLen	( int fnum );

	   int 			fb_hFilePrintBuffer	( int fnum, const char *buffer );
       int          fb_hFilePrintBufferEx( int fnum, const void *buffer, size_t len );
       int          fb_hFilePrintBufferUnlocked( int fnum, const void *buffer, size_t len );

	   int 			fb_hFileLock		( FILE *f, unsigned int inipos, unsigned int endpos );
	   int 			fb_hFileUnlock		( FILE *f, unsigned int inipos, unsigned int endpos );
	   char 		*fb_hConvertPath	( char *path, int len );

/**************************************************************************************************
 * data/time
 **************************************************************************************************/

FBCALL double 		fb_Timer 			( void );
FBCALL FBSTRING 	*fb_Time 			( void );
FBCALL int 			fb_SetTime			( FBSTRING *time );
FBCALL FBSTRING 	*fb_Date 			( void );
FBCALL int 			fb_SetDate			( FBSTRING *date );
FBCALL void 		fb_Sleep 			( int msecs );

	   int 			fb_hSetTime			( int h, int m, int s );
	   int 			fb_hSetDate			( int y, int m, int d );

	   void 		fb_hSleep 			( int msecs );

/**************************************************************************************************
 * error
 **************************************************************************************************/

typedef struct _FB_ERRORCTX {
	FB_TLSENTRY		handler;
	FB_TLSENTRY		num;
	FB_TLSENTRY		reslbl;
	FB_TLSENTRY		resnxtlbl;
} FB_ERRORCTX;

extern FB_ERRORCTX fb_errctx;

typedef void (*FB_ERRHANDLER) (void);

	   FB_ERRHANDLER fb_ErrorThrowEx	( int errnum, void *res_label, void *resnext_label );
	   FB_ERRHANDLER fb_ErrorThrow 		( void *res_label, void *resnext_label );
FBCALL FB_ERRHANDLER fb_ErrorSetHandler ( FB_ERRHANDLER newhandler );
FBCALL int 			fb_ErrorGetNum 		( void );
FBCALL int 			fb_ErrorSetNum 		( int errnum );
	   void 		*fb_ErrorResume		( void );
	   void 		*fb_ErrorResumeNext	( void );

/**************************************************************************************************
 * thread
 **************************************************************************************************/

#define FB_MAXTHREADS		256
#define FB_MAXMUTEXES		256
#define FB_MAXCONDS		256

struct _FBTHREAD;
struct _FBMUTEX;
struct _FBCOND;

FBCALL struct _FBTHREAD		*fb_ThreadCreate	( void *proc, int param );
FBCALL void			fb_ThreadWait		( struct _FBTHREAD *thread );

FBCALL struct _FBMUTEX		*fb_MutexCreate		( void );
FBCALL void			fb_MutexDestroy		( struct _FBMUTEX *mutex );
FBCALL void			fb_MutexLock		( struct _FBMUTEX *mutex );
FBCALL void			fb_MutexUnlock		( struct _FBMUTEX *mutex );

FBCALL struct _FBCOND		*fb_CondCreate		( void );
FBCALL void			fb_CondDestroy		( struct _FBCOND *cond );
FBCALL void			fb_CondSignal		( struct _FBCOND *cond );
FBCALL void			fb_CondBroadcast	( struct _FBCOND *cond );
FBCALL void			fb_CondWait		( struct _FBCOND *cond );

/**************************************************************************************************
 * misc
 **************************************************************************************************/

FBCALL void 		fb_AtExit 			( void (*proc)(void) );

FBCALL void 		fb_Init 			( int argc, char **argv );
FBCALL void 		fb_End 				( int errlevel );
FBCALL void 		fb_InitSignals		( void );

FBCALL void			fb_MemSwap			( unsigned char *dst, unsigned char *src, int bytes );
FBCALL void			fb_StrSwap			( void *str1, int str1_size, void *str2, int str2_size );

	   void 		fb_hInit 			( int argc, char **argv );
	   void 		fb_hEnd 			( int errlevel );
	   void			fb_hInitSignals		( void );

FBCALL void			fb_ProfileInit		( void );
FBCALL void			fb_ProfileEnd		( void );
FBCALL void			*fb_ProfileBeginCall( const char *procname );
FBCALL void			fb_ProfileEndCall	( void *call );

/**************************************************************************************************
 * hooks
 **************************************************************************************************/

typedef FBSTRING 	*(*FB_INKEYPROC)	( void );
typedef int		  	(*FB_GETKEYPROC)	( void );
typedef int		  	(*FB_KEYHITPROC)	( void );

FBCALL FBSTRING 	*fb_Inkey			( void );
FBCALL int		 	fb_Getkey			( void );
FBCALL int		 	fb_KeyHit			( void );

typedef void	  	(*FB_CLSPROC)		( int mode );

FBCALL void 		fb_Cls				( int mode );

typedef int	  		(*FB_COLORPROC)		( int fc, int bc );

FBCALL int 			fb_Color			( int fc, int bc );

typedef int		  	(*FB_LOCATEPROC)	( int row, int col, int cursor );

FBCALL int 			fb_Locate			( int row, int col, int cursor );

typedef int	  		(*FB_WIDTHPROC)		( int cols, int rows );

FBCALL int 			fb_Width			( int cols, int rows );

typedef int	  		(*FB_GETXPROC)		( void );
typedef int	  		(*FB_GETYPROC)		( void );
typedef void  		(*FB_GETXYPROC)		( int *col, int *row );
typedef void  		(*FB_GETSIZEPROC)	( int *cols, int *rows );

FBCALL int 			fb_GetX				( void );
FBCALL int 			fb_GetY				( void );
FBCALL void 		fb_GetXY			( int *col, int *row );
FBCALL void 		fb_GetSize			( int *cols, int *rows );

typedef void	  	(*FB_PRINTBUFFPROC)	( const void *buffer, size_t len, int mask );

FBCALL void 		fb_PrintBuffer		( const char *buffer, int mask );
FBCALL void 		fb_PrintBufferEx	( const void *buffer, size_t len, int mask );

typedef char 		*(*FB_READSTRPROC)	( char *buffer, int len );
		char 		*fb_ReadString		( char *buffer, int len, FILE *f );

FBCALL int			fb_Multikey			( int scancode );
FBCALL int			fb_GetMouse			( int *x, int *y, int *z, int *buttons );
FBCALL int			fb_SetMouse			( int x, int y, int cursor );
typedef int			(*FB_MULTIKEYPROC)	( int scancode );
typedef int			(*FB_GETMOUSEPROC)	( int *x, int *y, int *z, int *buttons );
typedef int			(*FB_SETMOUSEPROC)	( int x, int y, int cursor );


typedef struct _FB_HOOKSTB {
	FB_INKEYPROC		inkeyproc;
	FB_GETKEYPROC		getkeyproc;
	FB_KEYHITPROC		keyhitproc;
	FB_CLSPROC			clsproc;
	FB_COLORPROC		colorproc;
	FB_LOCATEPROC		locateproc;
	FB_WIDTHPROC		widthproc;
	FB_GETXPROC			getxproc;
	FB_GETYPROC			getyproc;
	FB_GETXYPROC		getxyproc;
	FB_GETSIZEPROC		getsizeproc;
	FB_PRINTBUFFPROC	printbuffproc;
	FB_READSTRPROC		readstrproc;
	FB_MULTIKEYPROC		multikeyproc;
	FB_GETMOUSEPROC		getmouseproc;
	FB_SETMOUSEPROC		setmouseproc;
} FB_HOOKSTB;

extern FB_HOOKSTB fb_hooks;

#ifdef __cplusplus
}
#endif

#endif /*__FB_H__*/
