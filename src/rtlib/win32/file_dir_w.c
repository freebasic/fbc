/* dir() */

#include "../fb.h"
#ifndef HOST_CYGWIN
    #include <direct.h>
#endif
#include <windows.h>

typedef struct
{
	int in_use;
	int attrib;
#ifdef HOST_CYGWIN
	WIN32_FIND_DATAW data;
	HANDLE handle;
#else
	struct _wfinddata_t data;
	long handle;
#endif
} FB_DIRWCTX;


static void close_dir_w ( void )
{
	FB_DIRWCTX *ctx = FB_TLSGETCTX( DIRW );
#ifdef HOST_MINGW
    _findclose( ctx->handle );
#else
    FindClose( ctx->handle );
#endif
	ctx->in_use = FALSE;
}

static FB_WCHAR *find_next_w ( int *attrib )
{
	FB_WCHAR *name = NULL;
	FB_DIRWCTX *ctx = FB_TLSGETCTX( DIRW );

#ifdef HOST_MINGW
	do
	{
		if( _wfindnext( ctx->handle, &ctx->data ) )
		{
			close_dir_w( );
			name = NULL;
			break;
		}
        name = ctx->data.name;
	}
	while( ctx->data.attrib & ~ctx->attrib );

	*attrib = ctx->data.attrib & ~0xFFFFFF00;

#else
    do {
        if( !FindNextFileW( ctx->handle, &ctx->data ) ) {
            close_dir_w();
            name = NULL;
            break;
        }
        name = ctx->data.cFileName;
    } while( ctx->data.dwFileAttributes & ~ctx->attrib );

    *attrib = ctx->data.dwFileAttributes & ~0xFFFFFF00;
#endif

	return name;
}

FBCALL FB_WCHAR *fb_Dir_W( FB_WCHAR *filespec, int attrib, int *out_attrib )
{
	FB_DIRWCTX *ctx;
	FB_WCHAR *res;
	ssize_t len;
	int tmp_attrib;
    FB_WCHAR *name;
    int handle_ok;

	if( out_attrib == NULL )
		out_attrib = &tmp_attrib;

	len = fb_wstr_Len( filespec );
	name = NULL;

	ctx = FB_TLSGETCTX( DIRW );

	if( len > 0 )
	{
		/* findfirst */
		if( ctx->in_use )
			close_dir_w( );

#ifdef HOST_MINGW
        ctx->handle = _wfindfirst( filespec, &ctx->data );
        handle_ok = ctx->handle != -1;
#else
        ctx->handle = FindFirstFileW( filespec, &ctx->data );
        handle_ok = ctx->handle != INVALID_HANDLE_VALUE;
#endif
		if( handle_ok )
		{
			/* Handle any other possible bits different Windows versions could return */
			ctx->attrib = attrib | 0xFFFFFF00;

			/* archive bit not set? set the dir bit at least.. */
			if( (attrib & 0x10) == 0 )
				ctx->attrib |= 0x20;

#ifdef HOST_MINGW
			if( ctx->data.attrib & ~ctx->attrib )
				name = find_next_w( out_attrib );
			else
			{
                name = ctx->data.name;
				*out_attrib = ctx->data.attrib & ~0xFFFFFF00;
            }
#else
			if( ctx->data.dwFileAttributes & ~ctx->attrib )
				name = find_next_w( out_attrib );
			else
			{
                name = ctx->data.cFileName;
                *out_attrib = ctx->data.dwFileAttributes & ~0xFFFFFF00;
            }
#endif
			if( name )
				ctx->in_use = TRUE;
		}
	} else {
		/* findnext */
		if( ctx->in_use )
			name = find_next_w( out_attrib );
	}

//	FB_STRLOCK();

	/* store filename if found */
	if( name )
    {
		len = fb_wstr_Len( name );
        res = fb_wstr_AllocTemp( len );                   

        if( res != NULL )
        {
            memcpy(res, name, len*2);
            res[len] = 0;
        }
        else
			res = NULL;
	} 
    else 
    {
		res = NULL;
		*out_attrib = 0;
	}

//	fb_hStrDelTemp_NoLock( filespec );
//
//	FB_STRUNLOCK();

	return res;
}
