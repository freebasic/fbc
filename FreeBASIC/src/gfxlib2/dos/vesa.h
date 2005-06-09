/* Info block for the VESA controller */
typedef struct VbeInfoBlock
{
	char		vbe_signature[4];	/* Must be 'VESA', or 'VBE2' for VESA2          */
	unsigned short	vbe_version;		/* 0200h for VESA2                              */
	unsigned int	oem_string_ptr;		/* Pointer to OEM string                        */
	unsigned int	capabilities;		/* Capabilities of the controller               */
	unsigned int	video_mode_ptr;		/* Pointer to a video mode list                 */
	unsigned short	total_memory;		/* Number of 64 KB memory blocks (VESA2)        */
	unsigned short	oem_software_rev;	/* VBE implementation software revision         */
	unsigned int	oem_vendor_name;	/* Pointer to Vendor Name string                */
	unsigned int	oem_product_name;	/* Pointer to Product Name string               */
	unsigned int	oem_product_rev;	/* Pointer to Product Revision string           */
	unsigned char	reserved[222];		/* Reserved for VBE implementation scratch area */
	unsigned char	oem_data[256];		/* Data area for OEM strings                    */
}
__attribute__ ((packed)) VbeInfoBlock;


/* Mnemonics for VbeInfoBlock.capabilities flags */
enum
{
	VIB_8BITDAC = 1 << 0, /* DAC width switchable to 8 bits per primary color */
	VIB_NOTVGA  = 1 << 1, /* Controller is not VGA compatible                 */
	VIB_BLANK   = 1 << 2  /* RAMDAC recommentds programming during blank      */
};


/* Info block for a VESA video mode */
typedef struct VesaModeInfo
{
	/* Mandatory information for all VBE revisions */
	unsigned short	mode_attributes;        /* See enumerated flags below                 */
	unsigned char	window_attributes[2];   /* See enumerated flags below                 */
	unsigned short	window_granularity;     /* KiB boundary for frame buffer placement    */
	unsigned short	window_size;            /* Window size in KiB                         */
	unsigned short	window_segment[2];      /* Real-mode segments for the two windows     */
	unsigned short	window_function_ptr;    /* Real-mode pointer to windowing function    */
	unsigned short	bytes_per_scanline;
	/* Mandatory information for VBE 1.2 and above */
	unsigned short	x_res;                  /* horizontal resolution in pixels or chars   */
	unsigned short	y_res;                  /* vertical resolution in pixels or chars     */
	unsigned char	x_char_size;            /* character cell width in pixels             */
	unsigned char	y_char_size;            /* character cell height in pixels            */
	unsigned char	number_of_planes;       /* number of memory planes                    */
	unsigned char	bits_per_pixel;
	unsigned char	number_of_banks;
	unsigned char	mem_model;              /* memory model type                          */
	unsigned char	bank_size;              /* bank size in KiB                           */
	unsigned char	number_of_image_pages;
	unsigned char	reserved;               /* reserved for page function                 */
	/* Direct Color fields (required for direct/6 and YUV/7 memory models) */
	unsigned char	red_mask_size;          /* size of direct color red mask in bits      */
	unsigned char	red_field_pos;          /* bit position of lsb of red mask            */
	unsigned char	green_mask_size;        /* size of direct color green mask in bits    */
	unsigned char	green_field_pos;        /* bit position of lsb of green mask          */
	unsigned char	blue_mask_size;         /* size of direct color blue mask in bits     */
	unsigned char	blue_field_pos;         /* bit position of lsb of blue mask           */
	unsigned char	rsvd_mask_size;         /* size of direct color reserved mask in bits */
	unsigned char	rsvd_field_pos;         /* bit position of lsb of reserved mask       */
	unsigned char	direct_color_mode_info; /* direct color mode attributes               */
	/* Mandatory information for VBE 2.0 and above */
	unsigned int	phys_base_ptr;          /* physical address for flat frame buffer     */
	unsigned int	off_screen_memoffset;   /* pointer to start of off screen memory      */
	unsigned short	off_screen_memsize;     /* amount of off screen memory in 1k units    */
	unsigned char	__Reserved[206];        /* pads VesaModeInfo to 512 bytes             */
}
__attribute__ ((packed)) VesaModeInfo;


/* Mnemonics for VesaModeInfo.mode_attributes flags */
enum
{
	VMI_MA_SUPPORTED = 1 << 0, /* Mode supported by hardware configuration   */
	VMI_MA_TTY       = 1 << 2, /* TTY output functions supported by the BIOS */
	VMI_MA_COLOR     = 1 << 3, /* Color mode if set, monochrome if not       */
	VMI_MA_GRAPHICS  = 1 << 4, /* Graphics mode if set, text mode if not     */
	VMI_MA_NOTVGA    = 1 << 5, /* VGA compatible mode                        */
	VMI_MA_NOTVGAWIN = 1 << 6, /* VGA compatible windowed memory available   */
	VMI_MA_LFB       = 1 << 7  /* Linear frame buffer mode available         */
};


/* Mnemonics for VesaModeInfo.window_attributes flags */
enum
{
	VMI_WA_RELOC = 1 << 0, /* Relocatable window(s) supported */
	VMI_WA_READ  = 1 << 1, /* Window is readable              */
	WMI_WA_WRITE = 1 << 2  /* Window is writeable             */
};


/* Valid values for VesaModeInfo.mem_model */
typedef enum VmiMemModel
{
	VMI_MM_TEXT = 0x00, /* Text mode                   */
	VMI_MM_CGA  = 0x01, /* CGA graphics                */
	VMI_MM_HERC = 0x02, /* Hercules graphics           */
	VMI_MM_PLAN = 0x03, /* Planar                      */
	VMI_MM_PACK = 0x04, /* Packed pixel                */
	VMI_MM_NCHN = 0x05, /* Non-chain 4, 256 color      */
	VMI_MM_DIR  = 0x06, /* Direct color                */
	VMI_MM_YUV  = 0x07, /* YUV color                   */
	VMI_MM_OEM  = 0x10  /* Start of OEM defined models */
}
VmiMemModel;


/* Mnemonics for VesaModeInfo.direct_color_mode_info */
enum
{
	VMI_DC_RAMP = 1 << 0, /* Color ramp programmable if set, fixed if not     */
	VMI_DC_RSVD = 1 << 1  /* Bits in rsvd field are usable by the application */
};
