
#ifndef __FB_H__
#define __FB_H__


#define FB_TRUE -1
#define FB_FALSE 0

/**************************************************************************************************
 * strings
 **************************************************************************************************/

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
		len = fb_hStrLen( (char *)s );                      	\
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
		  void 		fb_hStrRealloc			( FBSTRING *str, int size );
		  void 		fb_hStrAllocTemp		( FBSTRING *str, int size );
		  void 		fb_hStrDelTemp			( FBSTRING *str );
		  int 		fb_hStrLen 				( char *str );
		  void 		fb_hStrCopy				( char *dst, char *src, int bytes );
		  void 		fb_hStrRevCopy			( char *dst, char *src, int bytes );
		  char 		*fb_hStrSkipChar		( char *s, int len, int c );
		  char 		*fb_hStrSkipCharRev		( char *s, int len, int c );


/* public */

__stdcall void 		fb_StrDelete			( FBSTRING *str );
__stdcall void 		fb_StrAssign 			( void *dst, int dst_size, void *src, int src_size );
__stdcall FBSTRING	*fb_StrConcat 			( FBSTRING *dst, void *str1, int str1_size, void *str2, int str2_size );
__stdcall int 		fb_StrCompare 			( void *str1, int str1_size, void *str2, int str2_size );
__stdcall FBSTRING	*fb_StrAllocTempResult 	( FBSTRING *src );
__stdcall FBSTRING	*fb_StrAllocTempDesc	( void *str, int str_size );
__stdcall int 		fb_StrLen				( void *str, int str_size );

__stdcall FBSTRING 	*fb_IntToStr 			( int num );
__stdcall FBSTRING 	*fb_FloatToStr 			( float num );
__stdcall FBSTRING 	*fb_DoubleToStr 		( double num );

__stdcall double 	fb_hStr2Double			( char *src, int len );


__stdcall FBSTRING 	*fb_CHR 				( unsigned int num );
__stdcall unsigned int fb_ASC 				( FBSTRING *str );
__stdcall double 	fb_VAL 					( FBSTRING *str );
__stdcall double 	fb_CVD 					( FBSTRING *str );
__stdcall int 		fb_CVI 					( FBSTRING *str );
__stdcall FBSTRING 	*fb_HEX 				( int num );
__stdcall FBSTRING 	*fb_OCT 				( int num );
__stdcall FBSTRING 	*fb_BIN 				( int num );
__stdcall FBSTRING 	*fb_MKD 				( double num );
__stdcall FBSTRING 	*fb_MKI 				( int num );
__stdcall FBSTRING 	*fb_MKS 				( float num );
__stdcall FBSTRING 	*fb_LEFT 				( FBSTRING *str, int chars );
__stdcall FBSTRING 	*fb_RIGHT 				( FBSTRING *str, int chars );
__stdcall FBSTRING 	*fb_SPACE 				( int chars );
__stdcall FBSTRING 	*fb_LTRIM 				( FBSTRING *str );
__stdcall FBSTRING 	*fb_RTRIM 				( FBSTRING *str );
__stdcall FBSTRING 	*fb_TRIM 				( FBSTRING *src );
__stdcall FBSTRING 	*fb_LCASE 				( FBSTRING *str );
__stdcall FBSTRING 	*fb_UCASE 				( FBSTRING *str );
__stdcall FBSTRING 	*fb_StrFill1 			( int cnt, int fchar );
__stdcall FBSTRING 	*fb_StrFill2 			( int cnt, FBSTRING *src );
__stdcall int 		fb_StrInstr 			( int start, FBSTRING *src, FBSTRING *patt );
__stdcall FBSTRING 	*fb_StrMid 				( FBSTRING *src, int start, int len );
__stdcall void 		fb_StrAssignMid 		( FBSTRING *dst, int start, int len, FBSTRING *src );


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
__stdcall void 		fb_ArrayErase		( FBARRAY *array, int isvarlen );
__stdcall void 		fb_ArrayStrErase	( FBARRAY *array );
__stdcall int 		fb_ArrayLBound		( FBARRAY *array, int dimension );
__stdcall int 		fb_ArrayUBound		( FBARRAY *array, int dimension );


/**************************************************************************************************
 * system
 **************************************************************************************************/

__stdcall FBSTRING 	*fb_Command 		( void );
__stdcall FBSTRING 	*fb_CurDir 			( void );
__stdcall FBSTRING 	*fb_ExePath 		( void );
__stdcall void 		fb_Sleep 			( int msecs );
__stdcall int 		fb_Run 				( FBSTRING *program );
__stdcall int 		fb_Chain 			( FBSTRING *program );
__stdcall int 		fb_Exec 			( FBSTRING *program, FBSTRING *args );

/**************************************************************************************************
 * math
 **************************************************************************************************/

__stdcall double 	fb_Rnd 				( int n );
__stdcall void 		fb_Randomize 		( double seed );
__stdcall int 		fb_SGNSingle 		( float x );
__stdcall int 		fb_SGNDouble 		( double x );
__stdcall float 	fb_FIXSingle		( float x );
__stdcall double 	fb_FIXDouble		( double x );


/**************************************************************************************************
 * data
 **************************************************************************************************/

__stdcall void 		fb_DataReadStr		( void *dst, int dst_size );
__stdcall void 		fb_DataReadByte		( char *dst );
__stdcall void 		fb_DataReadShort	( short *dst );
__stdcall void 		fb_DataReadInt		( int *dst );
__stdcall void 		fb_DataReadSingle	( float *dst );
__stdcall void 		fb_DataReadDouble	( double *dst );

/**************************************************************************************************
 * console
 **************************************************************************************************/

#define FB_PRINT_NEWLINE 0x00000001
#define FB_PRINT_PAD 	 0x00000002
#define FB_PRINT_ISLAST  0x80000000

extern int fb_viewTopRow;
extern int fb_viewBotRow;


		  void 		fb_ConsoleWidth		( int cols, int rows );
__stdcall void 		fb_ConsoleScreen	( int mode );
		  void 		fb_ConsoleClear		( int mode );

		  void 		fb_ConsoleLocate	( int row, int col );
__stdcall int 		fb_ConsoleGetY		( void );
__stdcall int 		fb_ConsoleGetX		( void );
__stdcall void 		fb_ConsoleGetSize	( int *cols, int *rows );
__stdcall void 		fb_ConsoleGetXY		( int *col, int *row );

		  void 		fb_ConsoleColor		( int fc, int bc );
		  int 		fb_ConsoleGetColorAtt( void );

__stdcall void 		fb_ConsoleView		( int toprow, int botrow );
		  void 		fb_ConsoleGetView	( int *toprow, int *botrow );
		  int 		fb_ConsoleGetMaxRow ( void );

		  void 		fb_ConsoleScroll	( int nrows );

__stdcall void 		fb_PrintVoid 		( int fnum, int mask );
__stdcall void 		fb_PrintByte 		( int fnum, char val, int mask );
__stdcall void 		fb_PrintUByte 		( int fnum, unsigned char val, int mask );
__stdcall void 		fb_PrintShort 		( int fnum, short val, int mask );
__stdcall void 		fb_PrintUShort 		( int fnum, unsigned short val, int mask );
__stdcall void 		fb_PrintInt 		( int fnum, int val, int mask );
__stdcall void 		fb_PrintUInt 		( int fnum, unsigned int val, int mask );
__stdcall void 		fb_PrintSingle 		( int fnum, float val, int mask );
__stdcall void 		fb_PrintDouble 		( int fnum, double val, int mask );
__stdcall void 		fb_PrintString 		( int fnum, FBSTRING *s, int mask );
__stdcall void 		fb_PrintFixString 	( int fnum, char *s, int mask );

__stdcall void 		fb_PrintTab			( int fnum, int newcol );
__stdcall void 		fb_PrintSPC			( int fnum, int n );

__stdcall void 		fb_WriteVoid 		( int fnum, int mask );
__stdcall void 		fb_WriteByte 		( int fnum, char val, int mask );
__stdcall void 		fb_WriteUByte 		( int fnum, unsigned char val, int mask );
__stdcall void 		fb_WriteShort 		( int fnum, short val, int mask );
__stdcall void 		fb_WriteUShort 		( int fnum, unsigned short val, int mask );
__stdcall void 		fb_WriteInt 		( int fnum, int val, int mask );
__stdcall void 		fb_WriteUInt 		( int fnum, unsigned int val, int mask );
__stdcall void 		fb_WriteSingle 		( int fnum, float val, int mask );
__stdcall void 		fb_WriteDouble 		( int fnum, double val, int mask );
__stdcall void 		fb_WriteString 		( int fnum, FBSTRING *s, int mask );


		  int 		fb_ConsoleGetkey	( void );
		  FBSTRING 	*fb_ConsoleInkey	( void );

		  void 		fb_hPrintBuffer		( char *buffer, int mask );

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


__stdcall int 		fb_FileFree 		( void );
__stdcall int 		fb_FileOpen			( FBSTRING *str, unsigned int mode, unsigned int access,
										  unsigned int lock, int fnum, int len );
__stdcall int 		fb_FileClose		( int fnum );
__stdcall int 		fb_FilePut			( int fnum, long pos, void* value, unsigned int valuelen );
__stdcall int 		fb_FilePutStr		( int fnum, long pos, FBSTRING *str );
__stdcall int 		fb_FileGet			( int fnum, long pos, void* value, unsigned int valuelen );
__stdcall int 		fb_FileGetStr		( int fnum, long pos, FBSTRING *str );
__stdcall int 		fb_FileEof			( int fnum );
__stdcall long 		fb_FileTell			( int fnum );
__stdcall int 		fb_FileSeek			( int fnum, long newpos );
__stdcall long 		fb_FileLocation		( int fnum );
__stdcall int 		fb_FileKill			( FBSTRING *str );
__stdcall void 		fb_FileReset 		( void );
__stdcall unsigned int fb_FileSize		( int fnum );

__stdcall FBSTRING *fb_FileStrInput		( int bytes, int fnum );

__stdcall int 		fb_FileLineInput	( int fnum, FBSTRING *dst );
__stdcall int 		fb_LineInput		( FBSTRING *text, FBSTRING *dst, int addquestion, int addnewline );

		  int 		fb_hFilePrintBuffer	( int fnum, char *buffer );


/**************************************************************************************************
 * data/time
 **************************************************************************************************/

__stdcall double 	fb_Timer 			( void );
__stdcall FBSTRING 	*fb_Time 			( void );
__stdcall FBSTRING 	*fb_Date 			( void );


/**************************************************************************************************
 * error
 **************************************************************************************************/

__stdcall void 		*fb_ErrorThrow 		( int errnum );
__stdcall void 		*fb_ErrorSetHandler ( void *newhandler );
__stdcall int 		fb_ErrorGetNum 		( void );


/**************************************************************************************************
 * misc
 **************************************************************************************************/

__stdcall void 		fb_AtExit 			( void (*proc)(void) );

__stdcall void 		fb_Init 			( void );
__stdcall void 		fb_End 				( int errlevel );

__stdcall void		fb_MemSwap			( unsigned char *dst, unsigned char *src, int bytes );
__stdcall void		fb_StrSwap			( void *str1, int str1_size, void *str2, int str2_size );

/**************************************************************************************************
 * hooks
 **************************************************************************************************/

typedef FBSTRING *(*FB_INKEYPROC)( void );
typedef int		  (*FB_GETKEYPROC)( void );

__stdcall FBSTRING 		*fb_Inkey			( void );
__stdcall FB_INKEYPROC 	fb_SetInkeyProc		( FB_INKEYPROC newproc );
__stdcall int		 	fb_Getkey			( void );
__stdcall FB_GETKEYPROC fb_SetGetkeyProc	( FB_GETKEYPROC newproc );

typedef void	  (*FB_CLSPROC)( int mode );

__stdcall void 			fb_Cls				( int mode );
__stdcall FB_CLSPROC 	fb_SetClsProc		( FB_CLSPROC newproc );

typedef void	  (*FB_COLORPROC)( int fc, int bc );

__stdcall void 			fb_Color			( int fc, int bc );
__stdcall FB_COLORPROC 	fb_SetColorProc		( FB_COLORPROC newproc );

typedef void	  (*FB_LOCATEPROC)( int row, int col );

__stdcall void 			fb_Locate			( int row, int col );
__stdcall FB_LOCATEPROC fb_SetLocateProc	( FB_LOCATEPROC newproc );

typedef void	  (*FB_WIDTHPROC)( int cols, int rows );

__stdcall void 			fb_Width			( int cols, int rows );
__stdcall FB_WIDTHPROC 	fb_SetWidthProc		( FB_WIDTHPROC newproc );

#endif /*__FB_H__*/
