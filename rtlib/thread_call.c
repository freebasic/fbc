/**
 * ThreadCall: Launches any procedure as new thread, based on libffi.
 *
 * For example:
 *
 * FB code:
 *    declare sub MySub(x as integer, y as integer)
 *    thread = threadcall MySub(2, 3)
 *    threadwait thread
 *
 * Turned into this by fbc:
 *    a = 2
 *    b = 3
 *    thread = fb_ThreadCall(@MySub, STDCALL, 2, INT, @a, INT, @b)
 *    fb_ThreadWait(thread)
 *
 * fb_ThreadCall() packs the call and parameter data it's given into an array
 * of pointers and then launches a thread. The new thread reconstructs the call
 * using LibFFI and then calls the user's procedure.
 */

#include "fb.h"

#ifdef HOST_DOS

FBTHREAD *fb_ThreadCall( void *proc, int abi, int stack_size, int num_args, ... )
{
	return NULL;
}

#else

#include <stdio.h>
#include <ffi.h>

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

/*:::::*/
static void freeType( ffi_type *arg )
{
    int i = 0;
    ffi_type **elem = arg->elements;
    
    while( *elem != NULL )
    {
        /* cap element count to limit buffer overrun */
        if ( i >= FB_THREADCALL_MAX_ELEMS )
            break;
        
        /* free embedded types */
        if( (*elem)->type == FFI_TYPE_STRUCT )
            freeType( *elem );
            
        elem++;
        i++;
    }
    
    free( arg->elements );
    free( arg );
}

static ffi_type *getArgument( va_list *args_list );

/*:::::*/
static ffi_type *getType( va_list *args_list )
{
    int num_elems = va_arg( (*args_list), int );
    int i, j;

    /* prepare type */
    ffi_type *ffi_arg = (ffi_type *)malloc( sizeof( ffi_type ) );
    ffi_arg->size = 0;
    ffi_arg->alignment = 0;
    ffi_arg->type = FFI_TYPE_STRUCT;
    ffi_arg->elements = 
        (ffi_type **)malloc( sizeof( ffi_type * ) * ( num_elems + 1 ) );
    ffi_arg->elements[num_elems] = NULL;
    
    /* scan elements */
    for( i=0; i<num_elems; i++ )
    {
        ffi_arg->elements[i] = getArgument( args_list );
        if( ffi_arg->elements[i] == NULL )
        {
            /* error, free memory and return NULL */
            for( j=0; j<i; j++ )
            {
                if( ffi_arg->elements[j]->type == FFI_TYPE_STRUCT )
                    freeType( ffi_arg );
            }
            free( ffi_arg->elements );
            free( ffi_arg );
            return NULL;
        }
    }
    
    return ffi_arg;
}

/*:::::*/
static ffi_type *getArgument( va_list *args_list )
{
    int arg_type = va_arg( (*args_list), int );
    switch( arg_type )
    {
        case FB_THREADCALL_BYTE:
            return &ffi_type_schar;
        case FB_THREADCALL_UBYTE:
            return &ffi_type_uchar;
        case FB_THREADCALL_SHORT:
            return &ffi_type_sshort;
        case FB_THREADCALL_USHORT:
            return &ffi_type_ushort;
        case FB_THREADCALL_INTEGER:
            return &ffi_type_sint;
        case FB_THREADCALL_UINTEGER:
            return &ffi_type_uint;
        case FB_THREADCALL_LONGINT:
            return &ffi_type_sint64;
        case FB_THREADCALL_ULONGINT:
            return &ffi_type_uint64;
        case FB_THREADCALL_SINGLE:
            return &ffi_type_float;
        case FB_THREADCALL_DOUBLE:
            return &ffi_type_double;
        case FB_THREADCALL_TYPE:
            return getType( args_list );
        case FB_THREADCALL_PTR:
            return &ffi_type_pointer;
        default:
            return NULL;
    }
}

static FBCALL void threadproc( void *param );

/*:::::*/
FBTHREAD *fb_ThreadCall( void *proc, int abi, int stack_size, int num_args, ... )
{
    ffi_type     **ffi_args;
    void         **values;
    FBTHREADCALL  *param;
    int i, j;
    
    /* initialize lists and arrays */
    ffi_args = (ffi_type **)malloc( sizeof( ffi_type * ) * num_args );
    values = (void **)malloc( sizeof( void * ) * num_args );
    va_list args_list; 
    va_start(args_list, num_args);
    
    /* scan arguments and values from var_args */
    for( i=0; i<num_args; i++ )
    {
        ffi_args[i] = getArgument( &args_list );
        if( ffi_args[i] == NULL )
        {
            /* error, free all memory allocated up to this point */
            for( j=0; j<i; j++ )
            {
                if( ffi_args[i]->type == FFI_TYPE_STRUCT )
                    freeType( ffi_args[i] );
            }
            return NULL;
        }
        values[i] = va_arg( args_list, void * );
    }
    va_end( args_list );
    
    /* pack into thread parameter */
    param = malloc( sizeof( FBTHREADCALL ) );
    param->proc = proc;
    param->abi = abi;
    param->num_args = num_args;
    param->ffi_arg_types = ffi_args;
    param->values = values;
    
    /* actually start thread */
    return fb_ThreadCreate( threadproc, (void *)param, stack_size );
}

/*:::::*/
static FBCALL void threadproc( void *param )
{
    FBTHREADCALL *info = ( FBTHREADCALL * )param;
    ffi_status status = FFI_OK;
    ffi_abi abi = -1;
    ffi_cif cif;
    int i;
    
    /* check calling convention */
    if( info->abi == FB_THREADCALL_CDECL )
        abi = FFI_SYSV;
#if defined( X86_WIN32 )
    else if( info->abi == FB_THREADCALL_STDCALL )
        abi = FFI_STDCALL;
#endif
    else
        status = ~FFI_OK;

    /* prep FFI call interface */
    if( status == FFI_OK )
        status = ffi_prep_cif( 
            &cif,               // handle
            abi,                // ABI (CDECL or STDCALL)
            info->num_args,     // number of arguments
            &ffi_type_void,     // return type
            info->ffi_arg_types // argument types
        );
        
    /* execute */
    if( status == FFI_OK )
        ffi_call( &cif, FFI_FN( info->proc ), NULL, info->values );
    

    /* free memory and exit */
    for( i=0; i<info->num_args; i++ )
    {
        if( info->ffi_arg_types[i]->type == FFI_TYPE_STRUCT )
            freeType( info->ffi_arg_types[i] );
    }
    free( info->values );
    free( info->ffi_arg_types );
    free( info );
}

#endif
