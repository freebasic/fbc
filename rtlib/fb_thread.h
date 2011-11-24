#ifndef __FB_THREAD_H__
#define __FB_THREAD_H__

#include "ffi.h"

typedef void (FBCALL *FB_THREADPROC)( void *param );

typedef struct _FBTHREAD
{
	FB_THREADID   id;
	FB_THREADPROC proc;
	void         *param;
	void         *opaque;
} FBTHREAD;

struct _FBMUTEX;
struct _FBCOND;

FBCALL FBTHREAD         *fb_ThreadCreate( FB_THREADPROC proc, void *param, int stack_size );
FBCALL void              fb_ThreadWait  ( FBTHREAD *thread );

FBCALL struct _FBMUTEX  *fb_MutexCreate ( void );
FBCALL void              fb_MutexDestroy( struct _FBMUTEX *mutex );
FBCALL void              fb_MutexLock   ( struct _FBMUTEX *mutex );
FBCALL void              fb_MutexUnlock ( struct _FBMUTEX *mutex );

FBCALL struct _FBCOND   *fb_CondCreate  ( void );
FBCALL void              fb_CondDestroy ( struct _FBCOND *cond );
FBCALL void              fb_CondSignal  ( struct _FBCOND *cond );
FBCALL void              fb_CondBroadcast( struct _FBCOND *cond );
FBCALL void              fb_CondWait    ( struct _FBCOND *cond, struct _FBMUTEX *mutex );

/**************************************************************************************************
 * per-thread local storage context
 **************************************************************************************************/

enum {
	FB_TLSKEY_ERROR,
	FB_TLSKEY_DIR,
	FB_TLSKEY_INPUT,
	FB_TLSKEY_PRINTUSG,

	FB_TLSKEY_GFX,
	
	FB_TLSKEYS
};

enum {
	FB_TLSLEN_ERROR 	= sizeof( FB_ERRORCTX ),
	FB_TLSLEN_DIR		= sizeof( FB_DIRCTX ),
	FB_TLSLEN_INPUT		= sizeof( FB_INPUTCTX ),
	FB_TLSLEN_PRINTUSG  = sizeof( FB_PRINTUSGCTX ),
};

FBCALL void		   *fb_TlsGetCtx		( int index, int len );
FBCALL void			fb_TlsDelCtx		( int index );
FBCALL void 		fb_TlsFreeCtxTb		( void );

#define FB_TLSGETCTX(id) (FB_##id##CTX *)fb_TlsGetCtx( FB_TLSKEY_##id, FB_TLSLEN_##id );


/**************************************************************************************************
 * multiple-argument threads
 **************************************************************************************************/
#define FB_THREADCALL_MAX_ELEMS 1024
 
typedef struct _FBTHREADCALL
{
	void         *proc;
    int           abi;
    int           num_args;
	ffi_type    **ffi_arg_types;
    void        **values;
} FBTHREADCALL;
 
enum {
    FB_THREADCALL_STDCALL,
    FB_THREADCALL_CDECL,
    FB_THREADCALL_BYTE,
    FB_THREADCALL_UBYTE,
    FB_THREADCALL_SHORT,
    FB_THREADCALL_USHORT,
    FB_THREADCALL_INTEGER,
    FB_THREADCALL_UINTEGER,
    FB_THREADCALL_LONGINT,
    FB_THREADCALL_ULONGINT,
    FB_THREADCALL_SINGLE,
    FB_THREADCALL_DOUBLE,
    FB_THREADCALL_TYPE,
    FB_THREADCALL_PTR
};

// Spotty Linux symbols
#ifndef _cdecl
#define _cdecl
#endif

ffi_type                *fb_ThreadCall_GetArgument( va_list *args_list );
ffi_type                *fb_ThreadCall_GetType( va_list *args_list );
FBCALL void              fb_ThreadCall_ThreadProc( void *param );
_cdecl FBTHREAD         *fb_ThreadCall( void *proc, int abi, int stack_size, int num_args, ... );

#endif /* __FB_THREAD_H__ */
