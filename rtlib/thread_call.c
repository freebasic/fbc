/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2011 The FreeBASIC development team.
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
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
 */

/*
 * libfb_thread_call.c -- Calls a thread 
 *
 * chng: sep/2011 written [jofers]
 *
 */

#include <stdio.h>
#include <ffi.h>
#include "fb.h"

/*:::::*/
void fb_ThreadCall_FreeType( ffi_type *arg ) 
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
            fb_ThreadCall_FreeType( *elem );
            
        elem++;
        i++;
    }
    
    free( arg->elements );
    free( arg );
}

/*:::::*/
ffi_type *fb_ThreadCall_GetType( va_list *args_list )
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
        ffi_arg->elements[i] = fb_ThreadCall_GetArgument( args_list );
        if( ffi_arg->elements[i] == NULL )
        {
            /* error, free memory and return NULL */
            for( j=0; j<i; j++ )
            {
                if( ffi_arg->elements[j]->type == FFI_TYPE_STRUCT )
                    fb_ThreadCall_FreeType( ffi_arg );
            }       
            free( ffi_arg->elements );
            free( ffi_arg );
            return NULL;
        }
    }
    
    return ffi_arg;
}

/*:::::*/
ffi_type *fb_ThreadCall_GetArgument( va_list *args_list )
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
            return fb_ThreadCall_GetType( args_list );
        case FB_THREADCALL_PTR:
            return &ffi_type_pointer;
        default:
            return NULL;
    }
}

/*:::::*/
_cdecl FBTHREAD *fb_ThreadCall( void *proc, int abi, int stack_size, int num_args, ... )
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
        ffi_args[i] = fb_ThreadCall_GetArgument( &args_list );
        if( ffi_args[i] == NULL )
        {
            /* error, free all memory allocated up to this point */
            for( j=0; j<i; j++ )
            {
                if( ffi_args[i]->type == FFI_TYPE_STRUCT )
                    fb_ThreadCall_FreeType( ffi_args[i] );
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
    return fb_ThreadCreate( fb_ThreadCall_ThreadProc, (void *)param, stack_size );
}

/*:::::*/
FBCALL void fb_ThreadCall_ThreadProc( void *param )
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
            fb_ThreadCall_FreeType( info->ffi_arg_types[i] );
    }
    free( info->values );
    free( info->ffi_arg_types );
    free( info );
}
