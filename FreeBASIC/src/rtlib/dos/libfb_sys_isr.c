/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and others.
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

/*
 * sys_isr.c -- ISR handling for DOS
 *
 * chng: aug/2005 written [mjs]
 *
 */

#include "fb.h"
#include "fb_rterr.h"
#include "fb_dos.h"

#include <assert.h>

#include <dpmi.h>
#include <go32.h>
#include <pc.h>

static int isr_inited = FALSE;
static size_t function_sizes[16] = { 0 };

/* This is the code layout for isr.S */
extern char fb_hDrvIntHandler_start;
extern __dpmi_paddr fb_hDrvIntHandler_OldIRQs[16];
extern FnIntHandler fb_hDrvIntHandler[16];
extern unsigned short fb_hDrvSelectors[4];
void fb_hDrvIntHandler_PIC1(void);
void fb_hDrvIntHandler_PIC2(void);
extern char fb_hDrvIntHandler_end;

/** Ensures that the specified memory region isn't swappable.
 */
#define fb_lock_memory( var_start, var_end ) \
    fb_dos_lock_mem( &(var_start), (const char *) &(var_end) - (const char *) &(var_start) )

#define fb_lock_memory_fn( fn_name ) \
    fb_lock_memory( fn_name, fn_name ## _end )

#define fb_lock_memory_data( var_name ) \
    fb_lock_memory( var_name ## _start, var_name ## _end )

static int dos_cli_level = 0;

int fb_dos_cli( void )
{
    int next_value = ++dos_cli_level;
    if( next_value>=1 )
        __asm__ volatile ("cli");
    return next_value;
}

int fb_dos_sti( void )
{
    int next_value = --dos_cli_level;
    if( next_value <= 0 )
        __asm__ volatile ("sti");
    return next_value;
}

/*:::::*/
int fb_dos_lock_mem(const void *address, size_t size)
{
	static __dpmi_meminfo mi;
	mi.address = (unsigned long) address;
	mi.size = size;
	return __dpmi_lock_linear_region(&mi);
}

/*:::::*/
int fb_dos_unlock_mem(const void *address, size_t size)
{
	static __dpmi_meminfo mi;
	mi.address = (unsigned long) address;
	mi.size = size;
	return __dpmi_unlock_linear_region(&mi);
}

static __inline__ int
_my_es(void)
{
    unsigned short result;
    __asm__("movw %%es,%0" : "=r" (result));
    return result;
}

static __inline__ int
_my_fs(void)
{
    unsigned short result;
    __asm__("movw %%fs,%0" : "=r" (result));
    return result;
}

static __inline__ int
_my_gs(void)
{
    unsigned short result;
    __asm__("movw %%gs,%0" : "=r" (result));
    return result;
}

static int fb_isr_init(void)
{
    __dpmi_version_ret version;
    int succeeded;
    size_t i, j;

    FB_LOCK();
    if( isr_inited ) {
        FB_UNLOCK();
        return TRUE;
    }

    /* store all selectors */
    fb_hDrvSelectors[0] = _my_ds();
    fb_hDrvSelectors[1] = _my_es();
    fb_hDrvSelectors[2] = _my_fs();
    fb_hDrvSelectors[3] = _my_gs();

    /* query DPMI version */
    if( __dpmi_get_version( &version )!=0 ) {
        FB_UNLOCK();
        return FALSE;
    }

    /* query ISR offsets for master PIC */
    for( i=0; i!=8; ++i ) {
        int irq_vector = version.master_pic + i;
        __dpmi_paddr *offset = fb_hDrvIntHandler_OldIRQs + i;
        if( __dpmi_get_protected_mode_interrupt_vector( irq_vector, offset ) != 0 ) {
            FB_UNLOCK();
            return FALSE;
        }
    }

    /* query ISR offsets for slave PIC */
    for( i=0; i!=8; ++i ) {
        int irq_vector = version.slave_pic + i;
        __dpmi_paddr *offset = fb_hDrvIntHandler_OldIRQs + i + 8;
        if( __dpmi_get_protected_mode_interrupt_vector( irq_vector, offset ) != 0 ) {
            FB_UNLOCK();
            return FALSE;
        }
    }

    /* lock all generic ISR code/data */
    if( fb_lock_memory_data( fb_hDrvIntHandler )!=0 ) {
        FB_UNLOCK();
        return FALSE;
    }


    fb_dos_cli();
    succeeded = TRUE;
    /* Redirection for PIC1 */
    for( i=0; i!=8; ++i ) {
        int irq_vector = version.master_pic + i;
        __dpmi_paddr offset = {
            (unsigned long) fb_hDrvIntHandler_PIC1,
            (unsigned short) _my_cs()
        };
        if( __dpmi_set_protected_mode_interrupt_vector( irq_vector, &offset )!=0 ) {
            /* When an error occurred, restore the old ISR offsets */
            for( j=0; j!=i; ++j ) {
                int irq_vector = version.master_pic + j;
                __dpmi_paddr *offset = fb_hDrvIntHandler_OldIRQs + j;
                __dpmi_set_protected_mode_interrupt_vector( irq_vector, offset );
            }
            succeeded = FALSE;
            break;
        }
    }
    if( succeeded ) {
        /* Redirection for PIC2 */
        for( i=0; i!=8; ++i ) {
            int irq_vector = version.slave_pic + i;
            __dpmi_paddr offset = {
                (unsigned long) fb_hDrvIntHandler_PIC2,
                (unsigned short) _my_cs()
            };
            if( __dpmi_set_protected_mode_interrupt_vector( irq_vector, &offset )!=0 ) {
                /* When an error occurred, restore the old ISR offsets
                 * for both the master and the slave PIC */
                for( j=0; j!=8; ++j ) {
                    int irq_vector = version.master_pic + j;
                    __dpmi_paddr *offset = fb_hDrvIntHandler_OldIRQs + j;
                    __dpmi_set_protected_mode_interrupt_vector( irq_vector, offset );
                }
                for( j=0; j!=i; ++j ) {
                    int irq_vector = version.slave_pic + j;
                    __dpmi_paddr *offset = fb_hDrvIntHandler_OldIRQs + j + 8;
                    __dpmi_set_protected_mode_interrupt_vector( irq_vector, offset );
                }
                succeeded = FALSE;
                break;
            }
        }
    }
    fb_dos_sti();

    if( !succeeded ) {
        FB_UNLOCK();
        return FALSE;
    }

    isr_inited = TRUE;

    FB_UNLOCK();

    return TRUE;
}

int fb_isr_set( unsigned irq_number,
                FnIntHandler pfnIntHandler,
                size_t fn_size )
{
    assert( irq_number < 16 );

    if( !fb_isr_init() )
        return FALSE;

    if( fb_hDrvIntHandler[irq_number]!=NULL )
        fb_isr_reset( irq_number );

    if( fb_dos_lock_mem( pfnIntHandler, fn_size )!=0 )
        return FALSE;

    fb_dos_cli();
    function_sizes[irq_number] = fn_size;
    fb_hDrvIntHandler[irq_number] = pfnIntHandler;
    fb_dos_sti();

    return TRUE;
}

int fb_isr_reset( unsigned irq_number )
{
    assert( irq_number < 16 );

    if( !fb_isr_init() )
        return FALSE;

    if( fb_hDrvIntHandler[irq_number]!=NULL ) {
        if( fb_dos_unlock_mem( fb_hDrvIntHandler[irq_number],
                               function_sizes[irq_number] )!=0 )
            return FALSE;

        fb_dos_cli();
        fb_hDrvIntHandler[irq_number] = NULL;
        function_sizes[irq_number] = 0;
        fb_dos_sti();
    }

    return TRUE;
}

FnIntHandler fb_isr_get( unsigned irq_number )
{
    assert( irq_number < 16 );
    return fb_hDrvIntHandler[irq_number];
}
