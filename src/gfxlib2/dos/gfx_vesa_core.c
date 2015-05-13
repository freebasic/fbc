/* common VESA VBE routines
 * Partially based on Allegro src/dos/vesa.c
 */

#include "../fb_gfx.h"
#include "fb_gfx_dos.h"
#include <go32.h>
#include <sys/farptr.h>

VesaPMInfo *fb_dos_vesa_pm_info = NULL;
intptr_t fb_dos_vesa_pm_bank_switcher = 0;
intptr_t fb_dos_vesa_pm_set_palette = 0;

static int detected = FALSE;

void vesa_get_pm_functions( void )
{
	unsigned short *p;
	__dpmi_meminfo meminfo;
	
	fb_dos.vesa_use_pm = FALSE;
	
	if( fb_dos.vesa_info.vbe_version < 0x200 )
		return;
	
	fb_dos.regs.x.ax = VBE_PMODE;
	fb_dos.regs.x.bx = VBE_PMODE_GET;
	__dpmi_int( 0x10, &fb_dos.regs );
	if( fb_dos.regs.x.ax != VBE_STATUS_OK )
		return;
	
	fb_dos_vesa_pm_info = malloc( fb_dos.regs.x.cx );
	
	dosmemget( SEGOFF_TO_RM( fb_dos.regs.x.es, fb_dos.regs.x.di ), fb_dos.regs.x.cx, fb_dos_vesa_pm_info );
	
	if( fb_dos_vesa_pm_info->IOPrivInfo )
	{
		/* ports are always accessible; skip to memory */
		p = (unsigned short *)((intptr_t)fb_dos_vesa_pm_info + fb_dos_vesa_pm_info->IOPrivInfo);
		while( *p++ != 0xFFFF )
			;
		if( *++p != 0xFFFF ) /* need to map memory? */
		{
			meminfo.address = *(intptr_t *)p;
			meminfo.size = *(p + 2);
			
			if( __dpmi_physical_address_mapping( &meminfo ) != 0 )
				return;
			
			fb_dos.vesa_mmio_linear = meminfo.address;
			
			__dpmi_lock_linear_region( &meminfo );
			
			fb_dos.vesa_mmio_sel = __dpmi_allocate_ldt_descriptors( 1 );
			if( fb_dos.vesa_mmio_sel == -1 )
			{
				fb_dos.vesa_mmio_sel = 0;
				return;
			}
			
			if( __dpmi_set_segment_base_address( fb_dos.vesa_mmio_sel, meminfo.address ) == -1 )
			{
				return;
			}
			
			if( __dpmi_set_segment_limit( fb_dos.vesa_mmio_sel, MAX( meminfo.size - 1, 0xFFFF ) ) )
			{
				return;
			}
		}
	}
	
	fb_dos_vesa_pm_bank_switcher = (intptr_t)fb_dos_vesa_pm_info + fb_dos_vesa_pm_info->setWindow;
	fb_dos_vesa_pm_set_palette = (intptr_t)fb_dos_vesa_pm_info + fb_dos_vesa_pm_info->setPalette;
	
	fb_dos.vesa_use_pm = TRUE;
}

static int vesa_get_mode_info( int mode )
{
	fb_hFarMemSet( _dos_ds, MASK_LINEAR( __tb ), 0, sizeof( VesaModeInfo ) );
	
	fb_dos.regs.x.ax = VBE_MODEINFO;
	fb_dos.regs.x.di = RM_OFFSET( __tb );
	fb_dos.regs.x.es = RM_SEGMENT( __tb );
	fb_dos.regs.x.cx = mode;
	__dpmi_int( 0x10, &fb_dos.regs );
	if( fb_dos.regs.x.ax != VBE_STATUS_OK )
		return -1;
	
	dosmemget( MASK_LINEAR( __tb ), sizeof(fb_dos.vesa_mode_info), &fb_dos.vesa_mode_info );
	return 0;
}

void fb_dos_vesa_detect(void)
{
	int mode_list[256];
	int number_of_modes;
	long mode_ptr;
	int c;
	int attribs = VMI_MA_SUPPORTED | VMI_MA_COLOR | VMI_MA_GRAPHICS;
	
	if( detected )
		return;
	
	detected = TRUE;
	
	fb_dos.vesa_ok = FALSE;
	
	fb_hFarMemSet( _dos_ds, MASK_LINEAR( __tb ), 0, sizeof( VbeInfoBlock ) );
	dosmemput( "VBE2", 4, MASK_LINEAR( __tb ) ); /* get VESA 2 info if available */
	
	fb_dos.regs.x.ax = VBE_INFO;
	fb_dos.regs.x.di = RM_OFFSET( __tb );
	fb_dos.regs.x.es = RM_SEGMENT( __tb );
	__dpmi_int( 0x10, &fb_dos.regs );
	
	if( fb_dos.regs.x.ax != VBE_STATUS_OK )
	{
		return;
	}
	
	dosmemget( MASK_LINEAR( __tb ), sizeof( VbeInfoBlock ), &fb_dos.vesa_info );
	
	if( strncmp( fb_dos.vesa_info.vbe_signature, "VESA", 4 ) != 0 )
	{
		return;
	}
	
	fb_dos.vesa_ok = TRUE;
	
	/* get VESA modes */
	mode_ptr = RM_TO_LINEAR( fb_dos.vesa_info.video_mode_ptr );
	
	number_of_modes = 0;
	
	while( _farpeekw( _dos_ds, mode_ptr ) != 0xFFFF )
	{
		mode_list[number_of_modes] = _farpeekw( _dos_ds, mode_ptr );
		number_of_modes++;
		mode_ptr += 2;
	}
	
	fb_dos.num_vesa_modes = number_of_modes;
	
	fb_dos.vesa_modes = malloc( number_of_modes * sizeof(VesaModeInfo) );
	
	for( c = 0; c < number_of_modes; c++ )
	{
		if ( (vesa_get_mode_info(mode_list[c]) == 0) &&
		     ((fb_dos.vesa_mode_info.ModeAttributes & attribs) == attribs) && /* color graphics mode and supported */
		     (fb_dos.vesa_mode_info.NumberOfPlanes == 1) &&
		     ((fb_dos.vesa_mode_info.MemoryModel == VMI_MM_PACK) ||
		      (fb_dos.vesa_mode_info.MemoryModel == VMI_MM_DIR)) &&
			 ((fb_dos.vesa_info.vbe_version < 0x200) ||
			  ((unsigned int)fb_dos.vesa_info.total_memory << 16 >=
			   (unsigned int)(fb_dos.vesa_mode_info.BytesPerScanLine * fb_dos.vesa_mode_info.YResolution))) )
		{
			/* clobber WinFuncPtr to hold mode number */
			fb_dos.vesa_mode_info.WinFuncPtr = mode_list[c];
			
			/* add to list */
			memcpy( &fb_dos.vesa_modes[c], &fb_dos.vesa_mode_info, sizeof(VesaModeInfo) );
		}
	}
}

int fb_dos_vesa_set_mode( int w, int h, int depth, int linear )
{
	int i, mode = 0;
	int bpp;
	int tries;
	int good_bpp;
	int success = 0;
	
	if( depth == 15 ) depth = 16;
	if( depth == 24 ) depth = 32;
	
	for( tries = 0; tries <= 2; tries++ )
	{
		for( i = 0; i < fb_dos.num_vesa_modes; i++ )
		{
			if( (fb_dos.vesa_modes[i].XResolution == w) && (fb_dos.vesa_modes[i].YResolution == h) )
			{
				bpp = fb_dos.vesa_modes[i].BitsPerPixel;
				if( tries == 0 )
				{
					good_bpp = (bpp == depth);
				}
				else if( tries == 1 )
				{
					good_bpp = (bpp == 24 && depth == 32) ||
					           (bpp == 15 && depth == 16);
				}
				else /*if( tries == 2 )*/
				{
					good_bpp = ((bpp == 24 || bpp == 32) && depth < 24) ||
					           ((bpp == 15 || bpp == 16) && depth < 15);
				}
				
				if( good_bpp )
				{
					if ( !linear || (fb_dos.vesa_modes[i].ModeAttributes & VMI_MA_LFB) )
					{
						memcpy( &fb_dos.vesa_mode_info, &fb_dos.vesa_modes[i], sizeof(VesaModeInfo) );
						mode = fb_dos.vesa_modes[i].WinFuncPtr;
						break;
					}
				}
			}
		}
		
		if( !mode )
			continue;
		
		fb_dos.regs.x.ax = VBE_SETMODE;
		fb_dos.regs.x.bx = mode;
		
		if( linear )
		{
			fb_dos.regs.x.bx |= 0x4000;
		}
		
		__dpmi_int( 0x10, &fb_dos.regs );
		success = (fb_dos.regs.h.ah == 0);
		
		if( success )
		{
			break;
		}
	}
	
	if( success )
	{
		fb_dos.palbuf_seg = __dpmi_allocate_dos_memory( (256 * 4) >> 4, &fb_dos.palbuf_sel ); // FIXME
		if( fb_dos.palbuf_seg == -1 )
		{
			fb_dos.palbuf_seg = fb_dos.palbuf_sel = 0;
			return -1;
		}
	}
	
	return (success ? 0 : -1);
}

int *fb_dos_vesa_fetch_modes(int depth, int *size)
{
	int *modes;
	int count, i;
	int bpp;

	if (!fb_dos.detected) fb_dos_detect();
	if (!detected) fb_dos_vesa_detect();

	modes = malloc(sizeof(VesaModeInfo) * fb_dos.num_vesa_modes);

	for( i = 0, count = 0; i < fb_dos.num_vesa_modes; i++ )
	{
		if( fb_dos.vesa_modes[i].XResolution != 0 )
		{
			bpp = fb_dos.vesa_modes[i].BitsPerPixel;
			if( (bpp == depth) ||
			    (bpp == 15 && depth == 16) ||
			    (bpp == 16 && depth == 15) ||
			    (bpp == 24 && depth == 32) ||
			    (bpp == 32 && depth == 24) )
			{
				modes[count++] = SCREENLIST( fb_dos.vesa_modes[i].XResolution, fb_dos.vesa_modes[i].YResolution );
			}
		}
	}
	*size = count;
	return modes;
}

static void fb_dos_vesa_set_palette_int10(void)
{
	int color_count;
	
	color_count = MIN( (1 << fb_dos.depth), fb_dos.pal_last - fb_dos.pal_first + 1 );
	
	movedata( _my_ds( ), (unsigned)fb_dos.pal, fb_dos.palbuf_sel, fb_dos.pal_first * 4, color_count * 4 );
	
	fb_dos.regs.x.ax = VBE_SETGETPAL;
	fb_dos.regs.x.bx = (fb_dos.vesa_info.capabilities & VIB_BLANK
	                    ? VBE_SETGETPAL_SET_BLANK
	                    : VBE_SETGETPAL_SET);
	fb_dos.regs.x.cx = color_count;
	fb_dos.regs.x.dx = fb_dos.pal_first;
	
	fb_dos.regs.x.es = fb_dos.palbuf_seg;
	fb_dos.regs.x.di = 0;
	
	__dpmi_int( 0x10, &fb_dos.regs );
	
	if( fb_dos.regs.x.ax != VBE_STATUS_OK )
	{
		fb_dos.set_palette = fb_dos_vga_set_palette;
		fb_dos_vga_set_palette( );
		return;
	}
	
	fb_dos.pal_dirty = FALSE;
	fb_dos.pal_last = 0;
	fb_dos.pal_first = 256;
}

#if 0
/* !!!FIXME!!! */

static void fb_dos_vesa_set_palette_pm(void)
{
	int color_count;
	unsigned short data_sel;
	
	data_sel = fb_dos.vesa_mmio_sel ? fb_dos.vesa_mmio_sel : _my_ds();
	
	color_count = MIN( (1 << fb_dos.depth), fb_dos.pal_last - fb_dos.pal_first + 1 );
	
	__asm__ __volatile__ (
		"pushw %%ds \n\t"
		"movw %1, %%ds \n\t"
		"call *%0 \n\t"
		"popw %%ds \n\t"
		:
		: "r"(fb_dos_vesa_pm_set_palette),
		  "m"(data_sel),
		  "a"(VBE_SETGETPAL),                /* ax = 4F09h (set/get palette data) */
		  "b"(fb_dos.vesa_info.capabilities & VIB_BLANK
		      ? VBE_SETGETPAL_SET_BLANK
		      : VBE_SETGETPAL_SET),          /* bl = 00h (set) or 80h (wait for blank and set) */
		  "c"(color_count),                  /* cx = number of entries to update */
		  "d"(fb_dos.pal_first),             /* dx = first entry to update */
		  "D"(fb_dos.pal + fb_dos.pal_first) /* edi = table of palette values */
		: "cc"
	);

	fb_dos.pal_dirty = FALSE;
	fb_dos.pal_last = 0;
	fb_dos.pal_first = 256;
}

#endif

void fb_dos_vesa_set_palette( void )
{
	fb_dos.set_palette = fb_dos_vesa_set_palette_int10;
	fb_dos.set_palette( );
}
void fb_dos_vesa_set_palette_end(void){}
