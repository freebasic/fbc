/* thread local context storage */

#include "fb.h"
#include "fb_private_thread.h"
#include "fb_gfx_private.h"

#if defined ENABLE_MT && defined HOST_UNIX
	#define FB_TLSENTRY           pthread_key_t
	#define FB_TLSALLOC(key)      pthread_key_create( &(key), NULL )
	#define FB_TLSFREE(key)       pthread_key_delete( (key) )
	#define FB_TLSSET(key,value)  pthread_setspecific( (key), (const void *)(value) )
	#define FB_TLSGET(key)        pthread_getspecific( (key) )
#elif defined ENABLE_MT && defined HOST_WIN32
	#define FB_TLSENTRY           DWORD
	#define FB_TLSALLOC(key)      key = TlsAlloc( )
	#define FB_TLSFREE(key)       TlsFree( (key) )
	#define FB_TLSSET(key,value)  TlsSetValue( (key), (LPVOID)(value) )
	#define FB_TLSGET(key)        TlsGetValue( (key) )
#else
	#define FB_TLSENTRY           uintptr_t
	#define FB_TLSALLOC(key)      key = NULL
	#define FB_TLSFREE(key)       key = NULL
	#define FB_TLSSET(key,value)  key = (FB_TLSENTRY)value
	#define FB_TLSGET(key)        key
#endif

static FB_TLSENTRY __fb_tls_ctxtb[FB_TLSKEYS];

/* Retrieve or create new TLS context for given key */
FBCALL void *fb_TlsGetCtx( int index, size_t len )
{
	void *ctx = (void *)FB_TLSGET( __fb_tls_ctxtb[index] );

	if( ctx == NULL ) {
		ctx = (void *)calloc( 1, len );
		FB_TLSSET( __fb_tls_ctxtb[index], ctx );
	}

	return ctx;
}

FBCALL void fb_TlsDelCtx( int index )
{
	void *ctx = (void *)FB_TLSGET( __fb_tls_ctxtb[index] );

	/* free mem block if any */
	if( ctx != NULL ) {
		if( index == FB_TLSKEY_GFX ) {
			/* gfxlib2's TLS context is a special case: it stores
			   some malloc'ed data, so it requires extra clean-up.
			   see also gfxlib2's fb_hGetContext() */
			free( ((FB_GFXCTX *)ctx)->line );
		}
		free( ctx );
		FB_TLSSET( __fb_tls_ctxtb[index], NULL );
	}
}

FBCALL void fb_TlsFreeCtxTb( void )
{
	/* free all thread local storage ctx's */
	int i;
	for( i = 0; i < FB_TLSKEYS; i++ ) {
		fb_TlsDelCtx( i );
	}
}

#ifdef ENABLE_MT
void fb_TlsInit( void )
{
	/* allocate thread local storage keys */
	int i;
	for( i = 0; i < FB_TLSKEYS; i++ )
		FB_TLSALLOC( __fb_tls_ctxtb[i] );
}

void fb_TlsExit( void )
{
	/* free thread local storage plus the keys */
	int i;
	for( i = 0; i < FB_TLSKEYS; i++ ) {
		fb_TlsDelCtx( i );

		/* del key/index */
		FB_TLSFREE( __fb_tls_ctxtb[i] );
	}
}
#endif
