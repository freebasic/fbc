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


#define FB_TRUE -1
#define FB_FALSE 0


#ifdef WIN32
# ifndef NOSTDCALL
#  define FBCALL __stdcall
# else
#  define FBCALL __cdecl
# endif
#else /* WIN32 */
# define FBCALL
#endif /* WIN32 */

#ifndef NULL
#define NULL 0
#endif

/**************************************************************************************************
 * strings
 **************************************************************************************************/

#include <string.h>

#define FB_TEMPSTRBIT 0x80000000L

#define FB_ISTEMP(s) ((((FBSTRING *)s)->len & FB_TEMPSTRBIT) != 0)

#define FB_STRSIZE(s) (((FBSTRING *)s)->len & ~FB_TEMPSTRBIT)

#define FB_STRSETUP(s,size,ptr,len)  							\
	if( size == -1 )                                            \
	{                                                           \
		ptr = ((FBSTRING *)s)->data;                            \
		len = FB_STRSIZE( s );                                  \
	}                                                           \
	else                                                        \
	{                                                           \
		ptr = (char *)s;                                        \
		/* always get the real len, as fix-len string will */	\
		/* have garbage at end (nulls or spaces) */				\
		len = strlen( (char *)s );                      		\
	}


typedef struct _FBSTRING {
	char		*data;							/* , must be at ofs 0! */
	int			len;
} FBSTRING;


#define FB_STR_TMPDESCRIPTORS 256

typedef struct _FB_STR_TMPDESC {
	char		*data;
	int			len;

    struct _FB_STR_TMPDESC *prev;
    struct _FB_STR_TMPDESC *next;
} FB_STR_TMPDESC;

typedef struct _FB_STR_TMPDESCLIST {
	int				cnt;
	FB_STR_TMPDESC	*head;
	FB_STR_TMPDESC	*tail;
	FB_STR_TMPDESC	*fhead;
} FB_STR_TMPDESCLIST;


/* protos */

/* intern */
extern    FBSTRING 	fb_strNullDesc;

FB_STR_TMPDESC 		*fb_hStrAllocTmpDesc	( void );
		  void 		fb_hStrDelTempDesc		( FBSTRING *str );
		  void 		fb_hStrRealloc			( FBSTRING *str, int size, int preserve );
		  void 		fb_hStrAllocTemp		( FBSTRING *str, int size );
		  void 		fb_hStrDelTemp			( FBSTRING *str );
		  void 		fb_hStrCopy				( char *dst, char *src, int bytes );
		  char 		*fb_hStrSkipChar		( char *s, int len, int c );
		  char 		*fb_hStrSkipCharRev		( char *s, int len, int c );


/* public */

FBCALL void 		fb_StrDelete			( FBSTRING *str );
FBCALL void 		fb_StrAssign 			( void *dst, int dst_size, void *src, int src_size );
FBCALL FBSTRING		*fb_StrConcat 			( FBSTRING *dst, void *str1, int str1_size, void *str2, int str2_size );
FBCALL void 		fb_StrConcatAssign 		( void *dst, int dst_size, void *src, int src_size );
FBCALL int 			fb_StrCompare 			( void *str1, int str1_size, void *str2, int str2_size );
FBCALL FBSTRING		*fb_StrAllocTempResult 	( FBSTRING *src );
FBCALL FBSTRING		*fb_StrAllocTempDesc	( void *str, int str_size );
FBCALL int 			fb_StrLen				( void *str, int str_size );

FBCALL FBSTRING 	*fb_IntToStr 			( int num );
FBCALL FBSTRING 	*fb_FloatToStr 			( float num );
FBCALL FBSTRING 	*fb_DoubleToStr 		( double num );

FBCALL double 		fb_hStr2Double			( char *src, int len );


FBCALL FBSTRING 	*fb_CHR 				( unsigned int num );
FBCALL unsigned int fb_ASC 					( FBSTRING *str );
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
	int			elements;
	int			lbound;
} FBARRAYDIM;

typedef struct _FBARRAY {
    void		*data;						/* ptr + diff, must be at ofs 0! */
	void		*ptr;
    int			size;
    int			element_len;
    int			dimensions;
	FBARRAYDIM	dimTB[1];					/* dimtb[dimensions] */
} FBARRAY;


/* protos */

	   void 		fb_ArrayRedim		( FBARRAY *array, int element_len, int isvarlen, int preserve, int dimensions, ... );
	   void 		fb_ArraySetDesc		( FBARRAY *array, void *ptr, int element_len, int dimensions, ... );
FBCALL void 		fb_ArrayErase		( FBARRAY *array, int isvarlen );
FBCALL void 		fb_ArrayStrErase	( FBARRAY *array );
FBCALL int 			fb_ArrayLBound		( FBARRAY *array, int dimension );
FBCALL int 			fb_ArrayUBound		( FBARRAY *array, int dimension );


/**************************************************************************************************
 * system
 **************************************************************************************************/

FBCALL FBSTRING 	*fb_Command 		( void );
FBCALL FBSTRING 	*fb_CurDir 			( void );
FBCALL FBSTRING 	*fb_ExePath 		( void );
FBCALL void 		fb_Sleep 			( int msecs );
FBCALL int 			fb_Run 				( FBSTRING *program );
FBCALL int 			fb_Chain 			( FBSTRING *program );
FBCALL int 			fb_Exec 			( FBSTRING *program, FBSTRING *args );

	   char 		*fb_hGetShortPath	( char *src, char *dst, int maxlen );

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

FBCALL void 		fb_DataReadStr		( void *dst, int dst_size );
FBCALL void 		fb_DataReadByte		( char *dst );
FBCALL void 		fb_DataReadShort	( short *dst );
FBCALL void 		fb_DataReadInt		( int *dst );
FBCALL void 		fb_DataReadSingle	( float *dst );
FBCALL void 		fb_DataReadDouble	( double *dst );

/**************************************************************************************************
 * console
 **************************************************************************************************/

#define FB_PRINT_NEWLINE 0x00000001
#define FB_PRINT_PAD 	 0x00000002
#define FB_PRINT_ISLAST  0x80000000

extern int fb_viewTopRow;
extern int fb_viewBotRow;


	   void 		fb_ConsoleWidth		( int cols, int rows );
FBCALL void 		fb_ConsoleScreen	( int mode );
	   void 		fb_ConsoleClear		( int mode );

	   void 		fb_ConsoleLocate	( int row, int col, int cursor );
	   int 			fb_ConsoleGetY		( void );
       int 			fb_ConsoleGetX		( void );
FBCALL void 		fb_ConsoleGetSize	( int *cols, int *rows );
FBCALL void 		fb_ConsoleGetXY		( int *col, int *row );

	   void 		fb_ConsoleColor		( int fc, int bc );
	   int 			fb_ConsoleGetColorAtt( void );

FBCALL void 		fb_ConsoleView		( int toprow, int botrow );
	   void 		fb_ConsoleGetView	( int *toprow, int *botrow );
	   int 			fb_ConsoleGetMaxRow ( void );

	   void 		fb_ConsoleScroll	( int nrows );

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
FBCALL void 		fb_PrintFixString 	( int fnum, char *s, int mask );

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


	   int 			fb_ConsoleGetkey	( void );
	   FBSTRING 	*fb_ConsoleInkey	( void );

	   void 		fb_ConsolePrintBuffer( char *buffer, int mask );

/**************************************************************************************************
 * files
 **************************************************************************************************/

#define FB_MAX_FILES				255

#include <stdio.h>

typedef struct _FB_FILE {
	FILE	*f;
    int		mode;
    int		len;
    long	size;
} FB_FILE;


extern FB_FILE fb_fileTB[];


#define FB_FILE_MODE_BINARY			0
#define FB_FILE_MODE_RANDOM			1
#define FB_FILE_MODE_INPUT			2
#define FB_FILE_MODE_OUTPUT			3
#define FB_FILE_MODE_APPEND			4

#define FB_FILE_ACCESS_READ			1
#define FB_FILE_ACCESS_WRITE		2
#define FB_FILE_ACCESS_READWRITE	3

#define FB_FILE_LOCK_SHARED			0
#define FB_FILE_LOCK_READ			1
#define FB_FILE_LOCK_WRITE			2
#define FB_FILE_LOCK_READWRITE		3


FBCALL int 			fb_FileFree 		( void );
FBCALL int 			fb_FileOpen			( FBSTRING *str, unsigned int mode, unsigned int access,
										  unsigned int lock, int fnum, int len );
FBCALL int 			fb_FileClose		( int fnum );
FBCALL int 			fb_FilePut			( int fnum, long pos, void* value, unsigned int valuelen );
FBCALL int 			fb_FilePutStr		( int fnum, long pos, FBSTRING *str );
FBCALL int 			fb_FilePutArray		( int fnum, long pos, FBARRAY *src );
FBCALL int 			fb_FileGet			( int fnum, long pos, void* value, unsigned int valuelen );
FBCALL int 			fb_FileGetStr		( int fnum, long pos, FBSTRING *str );
FBCALL int 			fb_FileGetArray		( int fnum, long pos, FBARRAY *dst );
FBCALL int 			fb_FileEof			( int fnum );
FBCALL long 		fb_FileTell			( int fnum );
FBCALL int 			fb_FileSeek			( int fnum, long newpos );
FBCALL long 		fb_FileLocation		( int fnum );
FBCALL int 			fb_FileKill			( FBSTRING *str );
FBCALL void 		fb_FileReset 		( void );
FBCALL unsigned int fb_FileSize			( int fnum );

FBCALL FBSTRING 	*fb_FileStrInput	( int bytes, int fnum );

FBCALL int 			fb_FileLineInput	( int fnum, FBSTRING *dst );
FBCALL int 			fb_LineInput		( FBSTRING *text, FBSTRING *dst, int addquestion, int addnewline );

	   int 			fb_hFilePrintBuffer	( int fnum, char *buffer );


/**************************************************************************************************
 * data/time
 **************************************************************************************************/

FBCALL double 		fb_Timer 			( void );
FBCALL FBSTRING 	*fb_Time 			( void );
FBCALL int 			fb_SetTime			( FBSTRING *time );
FBCALL FBSTRING 	*fb_Date 			( void );
FBCALL int 			fb_SetDate			( FBSTRING *date );


/**************************************************************************************************
 * error
 **************************************************************************************************/

	   void 		*fb_ErrorThrow 		( int errnum, void *res_label, void *resnext_label );
FBCALL void 		*fb_ErrorSetHandler ( void *newhandler );
FBCALL int 			fb_ErrorGetNum 		( void );
	   void 		*fb_ErrorResume		( void );
	   void 		*fb_ErrorResumeNext	( void );

/**************************************************************************************************
 * misc
 **************************************************************************************************/

FBCALL void 		fb_AtExit 			( void (*proc)(void) );

FBCALL void 		fb_Init 			( void );
FBCALL void 		fb_End 				( int errlevel );

FBCALL void			fb_MemSwap			( unsigned char *dst, unsigned char *src, int bytes );
FBCALL void			fb_StrSwap			( void *str1, int str1_size, void *str2, int str2_size );

/**************************************************************************************************
 * hooks
 **************************************************************************************************/

typedef FBSTRING 	*(*FB_INKEYPROC)	( void );
typedef int		  	(*FB_GETKEYPROC)	( void );

FBCALL FBSTRING 	*fb_Inkey			( void );
FBCALL FB_INKEYPROC fb_SetInkeyProc		( FB_INKEYPROC newproc );
FBCALL int		 	fb_Getkey			( void );
FBCALL FB_GETKEYPROC fb_SetGetkeyProc	( FB_GETKEYPROC newproc );

typedef void	  	(*FB_CLSPROC)		( int mode );

FBCALL void 		fb_Cls				( int mode );
FBCALL FB_CLSPROC 	fb_SetClsProc		( FB_CLSPROC newproc );

typedef void	  	(*FB_COLORPROC)		( int fc, int bc );

FBCALL void 		fb_Color			( int fc, int bc );
FBCALL FB_COLORPROC fb_SetColorProc		( FB_COLORPROC newproc );

typedef void	  	(*FB_LOCATEPROC)	( int row, int col, int cursor );

FBCALL void 		fb_Locate			( int row, int col, int cursor );
FBCALL FB_LOCATEPROC fb_SetLocateProc	( FB_LOCATEPROC newproc );

typedef void	  	(*FB_WIDTHPROC)		( int cols, int rows );

FBCALL void 		fb_Width			( int cols, int rows );
FBCALL FB_WIDTHPROC fb_SetWidthProc		( FB_WIDTHPROC newproc );

typedef int	  		(*FB_GETXPROC)		( void );
typedef int	  		(*FB_GETYPROC)		( void );

FBCALL int 			fb_GetX				( void );
FBCALL FB_GETXPROC  fb_SetGetXProc		( FB_GETXPROC newproc );
FBCALL int 			fb_GetY				( void );
FBCALL FB_GETYPROC  fb_SetGetYProc		( FB_GETYPROC newproc );

typedef void	  	(*FB_PRINTBUFFPROC)	( char *buffer, int mask );

FBCALL void 		fb_PrintBuffer		( char *buffer, int mask );
FBCALL FB_PRINTBUFFPROC fb_SetPrintBufferProc( FB_PRINTBUFFPROC newproc );

#endif /*__FB_H__*/
