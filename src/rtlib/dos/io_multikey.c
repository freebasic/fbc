/* multikey function for DOS console mode apps */

#include "../fb.h"
#include "fb_private_console.h"
#include <pc.h>
#include <go32.h>
#include <dpmi.h>
#include <sys/farptr.h>

void (*__fb_dos_multikey_hook)(int scancode, int flags) = NULL;

static void end_fb_ConsoleMultikey(void);

static int inited = FALSE;
static volatile char key[128];
static volatile int  got_extended_key = FALSE;

static __inline__
int fb_hWriteControlCommand( unsigned char uchValue )
{
	unsigned char uchStatus;
	size_t count = 65535;
	do {
		uchStatus = inportb(0x64);         /* read keyboard status */
	} while( ((uchStatus & 0x02)!=0) && --count );
	outportb( 0x64, uchValue );
	return (uchStatus & 0x02)==0;
}

static int fb_MultikeyHandler(unsigned irq_number)
{
#if 1
    __dpmi_regs regs;
#endif
	unsigned char scancode_raw;

	fb_hWriteControlCommand( 0xAD );    /* Lock keyboard */

	/* read the raw scancode from the keyboard */
	scancode_raw = inportb(0x60);       /* read scancode */

#if 0
	printf(":%02x", scancode_raw);
#endif

#if 1
	/* Translate scancode */
	regs.h.ah = 0x4F;
	regs.h.al = scancode_raw;
	__dpmi_int(0x15, &regs);
	if( regs.x.flags & 1 )
#endif
	{
#if 0
		size_t code = regs.h.al;
#else
		size_t code = scancode_raw;
#endif
		if( code==0xE0 )
		{
			got_extended_key = TRUE;
		}
		else
		{
			int release_code = (code & 0x80)!=0;
			code &= 0x7F;
			if( got_extended_key ) {
				switch( code ) {
				case 0x2A:
					code = 0;
					break;
				}
			}
			if( code != 0 )
			{
				int prev;
				int kbflags;

				prev = key[code];

				/* make sure there is at least one free entry in the keyboard buffer */
				{
					unsigned int beg, end, fre, nxt;
					unsigned short old_sel;

					old_sel = _fargetsel();
					_farsetsel(_dos_ds);

					beg = _farnspeekw( (0x40 << 4) | 0x80 );
					end = _farnspeekw( (0x40 << 4) | 0x82 );
					fre = _farnspeekw( (0x40 << 4) | 0x1C );
					nxt = _farnspeekw( (0x40 << 4) | 0x1A );

					if( (fre == nxt - 2) || ((nxt == beg) && (fre == end - 2)) )
					{
						nxt += 2;
						if( nxt == end )
						{
							nxt = beg;
						}
						_farnspokew( (0x40 << 4) | 0x1A, nxt);
					}

					kbflags = _farnspeekb( (0x40 << 4) | 0x17 );

					_farsetsel(old_sel);
				}

				/* Remeber scancode status */
				__fb_con.forceInpBufferChanged = key[code] = !release_code;
				if( __fb_dos_multikey_hook != 0 )
				{
					int flags = 0;

					if( !release_code )
					{
						flags |= KB_PRESS;
						if( prev )
							flags |= KB_REPEAT;
					}

					if( key[SC_CONTROL] )
						flags |= KB_CTRL;

					if( key[SC_LSHIFT] || key[SC_RSHIFT] )
						flags |= KB_SHIFT;

					if( key[SC_ALT] )
						flags |= KB_ALT;

					if( kbflags & (1 << 6) )
						flags |= KB_CAPSLOCK;

					if( kbflags & (1 << 5) )
						flags |= KB_NUMLOCK;

					if( got_extended_key )
					{
						flags |= KB_EXTENDED;
					}

					__fb_dos_multikey_hook(code, flags);
				}
			}
			got_extended_key = FALSE;
		}
	}

	fb_hWriteControlCommand( 0xAE );    /* Unlock keyboard */

	return FALSE;
}
END_OF_STATIC_FUNCTION(fb_MultikeyHandler);

static void fb_ConsoleMultikeyExit(void)
{
	fb_isr_reset( 1 );
	unlock_proc(fb_ConsoleMultikey);
	unlock_proc(fb_MultikeyHandler);
	unlock_array(key);
	unlock_var(got_extended_key);
	unlock_var(__fb_con.forceInpBufferChanged);
	unlock_var(__fb_dos_multikey_hook);
}

void fb_ConsoleMultikeyInit( void )
{
	if (inited)
		return;

	inited = TRUE;
	memset((void*)key, FALSE, sizeof(key));

	/* We have to lock the memory BEFORE we redirect the ISR! */
	lock_array(key);
	lock_var(got_extended_key);
	lock_var(__fb_con.forceInpBufferChanged);
	lock_var(__fb_dos_multikey_hook);
	lock_proc(fb_MultikeyHandler);
	lock_proc(fb_ConsoleMultikey);
	fb_isr_set( 1,
	            fb_MultikeyHandler,
	            0,
	            16384 );

	atexit( fb_ConsoleMultikeyExit );
}

int fb_ConsoleMultikey( int scancode )
{
	if( (scancode < 0) || ((unsigned int)scancode >= sizeof( key )) )
		return FB_FALSE;

	fb_ConsoleMultikeyInit( );

	return (key[scancode]? FB_TRUE: FB_FALSE);
}
END_OF_FUNCTION(fb_ConsoleMultikey);
