/* ISR handling for DOS */

#include "../fb.h"
#include <dpmi.h>
#include <go32.h>
#include <pc.h>

typedef struct _FB_DOS_STACK_INFO {
    void  *offset;
    size_t size;
} FB_DOS_STACK_INFO;

static int isr_inited = FALSE;
static size_t function_sizes[16] = { 0 };

/* This is the code layout for isr.S */
extern char __fb_hDrvIntHandler_start;
extern __dpmi_paddr __fb_hDrvIntHandler_OldIRQs[16];
extern FnIntHandler __fb_hDrvIntHandler[16];
extern FB_DOS_STACK_INFO __fb_hDrvIntStacks[16];
extern unsigned __fb_hDrvSelectors[5];
extern int __fb_dos_cli_level;
void __fb_hDrvIntHandler_PIC1(void);
void __fb_hDrvIntHandler_PIC2(void);
extern char __fb_hDrvIntHandler_end;

/** Ensures that the specified memory region isn't swappable.
 */

#define fb_lock_memory_fn( fn_name ) \
	fb_dos_lock_code( fn_name, fn_name ## _end - fn_name )

#define fb_lock_memory_data( var_name ) \
	fb_dos_lock_data( &var_name ## _start, &var_name ## _end - &var_name ## _start )

static int do_lock(int is_code, int (*proc)(__dpmi_meminfo *), const void *address, size_t size)
{
	unsigned long base;
	__dpmi_meminfo mi;
	
	if ( __dpmi_get_segment_base_address( is_code ? _go32_my_cs() : _go32_my_ds(), &base ) == -1 )
		return -1;
	
	mi.address = base + (unsigned long)address;
	mi.size = size;
	
	return proc( &mi );
}

int fb_dos_lock_data(const void *address, size_t size)
{
	return do_lock(FALSE, __dpmi_lock_linear_region, address, size);
}

int fb_dos_lock_code(const void *address, size_t size)
{
	return do_lock(TRUE, __dpmi_lock_linear_region, address, size);
}

int fb_dos_unlock_data(const void *address, size_t size)
{
	return do_lock(FALSE, __dpmi_unlock_linear_region, address, size);
}

int fb_dos_unlock_code(const void *address, size_t size)
{
	return do_lock(TRUE, __dpmi_unlock_linear_region, address, size);
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

static void fb_isr_exit(void)
{
    __dpmi_version_ret version;
    int i;

    FB_LOCK();
    if( !isr_inited ) {
        FB_UNLOCK();
        return;
    }

    /* query DPMI version */
    if( __dpmi_get_version( &version )!=0 ) {
        FB_UNLOCK();
        abort();
    }

    fb_dos_cli();

    /* restore ISR offsets for master PIC */
    for( i=0; i!=8; ++i ) {
        int irq_vector = version.master_pic + i;
        __dpmi_paddr *offset = __fb_hDrvIntHandler_OldIRQs + i;
        if( __dpmi_set_protected_mode_interrupt_vector( irq_vector, offset ) != 0 ) {
            FB_UNLOCK();
            abort();
            return;
        }
    }

    /* restore ISR offsets for slave PIC */
    for( i=0; i!=8; ++i ) {
        int irq_vector = version.slave_pic + i;
        __dpmi_paddr *offset = __fb_hDrvIntHandler_OldIRQs + i + 8;
        if( __dpmi_set_protected_mode_interrupt_vector( irq_vector, offset ) != 0 ) {
            FB_UNLOCK();
            abort();
        }
    }

    fb_dos_sti();

    isr_inited = FALSE;

    FB_UNLOCK();
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
    __fb_hDrvSelectors[0] = _my_ds();
    __fb_hDrvSelectors[1] = _my_es();
    __fb_hDrvSelectors[2] = _my_fs();
    __fb_hDrvSelectors[3] = _my_gs();
    __fb_hDrvSelectors[4] = _my_ss();

    /* query DPMI version */
    if( __dpmi_get_version( &version )!=0 ) {
        FB_UNLOCK();
        return FALSE;
    }

    /* query ISR offsets for master PIC */
    for( i=0; i!=8; ++i ) {
        int irq_vector = version.master_pic + i;
        __dpmi_paddr *offset = __fb_hDrvIntHandler_OldIRQs + i;
        if( __dpmi_get_protected_mode_interrupt_vector( irq_vector, offset ) != 0 ) {
            FB_UNLOCK();
            return FALSE;
        }
    }

    /* query ISR offsets for slave PIC */
    for( i=0; i!=8; ++i ) {
        int irq_vector = version.slave_pic + i;
        __dpmi_paddr *offset = __fb_hDrvIntHandler_OldIRQs + i + 8;
        if( __dpmi_get_protected_mode_interrupt_vector( irq_vector, offset ) != 0 ) {
            FB_UNLOCK();
            return FALSE;
        }
    }

    /* lock all generic ISR code/data */
    if( fb_lock_memory_data( __fb_hDrvIntHandler )!=0 ) {
        FB_UNLOCK();
        return FALSE;
    }


    fb_dos_cli();
    succeeded = TRUE;
    /* Redirection for PIC1 */
    for( i=0; i!=8; ++i ) {
        int irq_vector = version.master_pic + i;
        __dpmi_paddr offset = {
            (unsigned long) __fb_hDrvIntHandler_PIC1,
            (unsigned short) _my_cs()
        };
        if( __dpmi_set_protected_mode_interrupt_vector( irq_vector, &offset )!=0 ) {
            /* When an error occurred, restore the old ISR offsets */
            for( j=0; j!=i; ++j ) {
                int irq_vector = version.master_pic + j;
                __dpmi_paddr *offset = __fb_hDrvIntHandler_OldIRQs + j;
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
                (unsigned long) __fb_hDrvIntHandler_PIC2,
                (unsigned short) _my_cs()
            };
            if( __dpmi_set_protected_mode_interrupt_vector( irq_vector, &offset )!=0 ) {
                /* When an error occurred, restore the old ISR offsets
                 * for both the master and the slave PIC */
                for( j=0; j!=8; ++j ) {
                    int irq_vector = version.master_pic + j;
                    __dpmi_paddr *offset = __fb_hDrvIntHandler_OldIRQs + j;
                    __dpmi_set_protected_mode_interrupt_vector( irq_vector, offset );
                }
                for( j=0; j!=i; ++j ) {
                    int irq_vector = version.slave_pic + j;
                    __dpmi_paddr *offset = __fb_hDrvIntHandler_OldIRQs + j + 8;
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
    atexit( fb_isr_exit );

    FB_UNLOCK();

    return TRUE;
}

int fb_isr_set( unsigned irq_number,
                FnIntHandler pfnIntHandler,
                size_t fn_size,
                size_t stack_size )
{
    void *pStack;
    DBG_ASSERT( irq_number < 16 );

    if( !fb_isr_init() )
        return FALSE;

    if( __fb_hDrvIntHandler[irq_number]!=NULL )
        fb_isr_reset( irq_number );

    if( fb_dos_lock_code( pfnIntHandler, fn_size )!=0 )
        return FALSE;

    if( stack_size!=0 ) {
        if( stack_size < _go32_interrupt_stack_size )
            stack_size = _go32_interrupt_stack_size;
        if( stack_size < 512 )
            stack_size = 512;

        pStack = malloc( stack_size );
        if( pStack==NULL )
            return FALSE;

        if( fb_dos_lock_data( pStack, stack_size )!=0 ) {
            free( pStack );
            return FALSE;
        }
    } else {
        pStack = NULL;
    }

    fb_dos_cli();
    function_sizes[irq_number] = fn_size;
    __fb_hDrvIntHandler[irq_number] = pfnIntHandler;
    __fb_hDrvIntStacks[irq_number].offset = pStack;
    __fb_hDrvIntStacks[irq_number].size   = stack_size;
    fb_dos_sti();

    return TRUE;
}

int fb_isr_reset( unsigned irq_number )
{
    DBG_ASSERT( irq_number < 16 );

    if( !fb_isr_init() )
        return FALSE;

    if( __fb_hDrvIntHandler[irq_number]!=NULL ) {
        void *pStack;
        size_t stack_size;
        FnIntHandler pfnIntHandler;
        size_t fn_size;

        fb_dos_cli();
        pfnIntHandler = __fb_hDrvIntHandler[irq_number];
        fn_size = function_sizes[irq_number];
        __fb_hDrvIntHandler[irq_number] = NULL;
        function_sizes[irq_number] = 0;

        pStack = __fb_hDrvIntStacks[irq_number].offset;
        stack_size = __fb_hDrvIntStacks[irq_number].size;
        __fb_hDrvIntStacks[irq_number].offset = NULL;
        __fb_hDrvIntStacks[irq_number].size = 0;
        fb_dos_sti();

        fb_dos_unlock_code( pfnIntHandler, fn_size );
        fb_dos_unlock_data( pStack, stack_size );

        free( pStack );
    }

    return TRUE;
}

FnIntHandler fb_isr_get( unsigned irq_number )
{
    DBG_ASSERT( irq_number < 16 );
    return __fb_hDrvIntHandler[irq_number];
}
