/* VESA VBE structures and constants */

#ifndef __FB_DOS_VESA_H__
#define __FB_DOS_VESA_H__

/* Info block for the VESA controller */
typedef struct VbeInfoBlock
{
	char            vbe_signature[4];	/* Must be 'VESA', or 'VBE2' for VESA2          */
	unsigned short  vbe_version;		/* 0200h for VESA2                              */
	unsigned int    oem_string_ptr;		/* Pointer to OEM string                        */
	unsigned int    capabilities;		/* Capabilities of the controller               */
	unsigned int    video_mode_ptr;		/* Pointer to a video mode list                 */
	unsigned short  total_memory;		/* Number of 64 KB memory blocks (VESA2)        */
	unsigned short  oem_software_rev;	/* VBE implementation software revision         */
	unsigned int    oem_vendor_name;	/* Pointer to Vendor Name string                */
	unsigned int    oem_product_name;	/* Pointer to Product Name string               */
	unsigned int    oem_product_rev;	/* Pointer to Product Revision string           */
	unsigned char   reserved[222];		/* Reserved for VBE implementation scratch area */
	unsigned char   oem_data[256];		/* Data area for OEM strings                    */
} FBPACKED VbeInfoBlock;


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
	/* mandatory for all VBE versions */
	unsigned short ModeAttributes;
	unsigned char  WinAAttributes;
	unsigned char  WinBAttributes;
	unsigned short WinGranularity;
	unsigned short WinSize;
	unsigned short WinASegment;
	unsigned short WinBSegment;
	unsigned long  WinFuncPtr;
	unsigned short BytesPerScanLine;
	
	/* mandatory for VBE 1.2 and above */
	unsigned short XResolution;
	unsigned short YResolution;
	unsigned char  XCharSize;
	unsigned char  YCharSize;
	unsigned char  NumberOfPlanes;
	unsigned char  BitsPerPixel;
	unsigned char  NumberOfBanks;
	unsigned char  MemoryModel;
	unsigned char  BankSize;              /* bank size in KB */
	unsigned char  NumberOfImagePages;
	unsigned char  Reserved_page;
	
	/* direct color fields (required for direct and YUV memory models) */
	unsigned char  RedMaskSize;
	unsigned char  RedFieldPosition;
	unsigned char  GreenMaskSize;
	unsigned char  GreenFieldPosition;
	unsigned char  BlueMaskSize;
	unsigned char  BlueFieldPosition;
	unsigned char  RsvdMaskSize;
	unsigned char  RsvdFieldPosition;
	unsigned char  DirectColorModeInfo;
	
	/* mandatory for VBE 2.0 and above */
	unsigned long  PhysBasePtr;
	unsigned long  OffScreenMemOffset;    /* reserved in VBE 3.0 */
	unsigned short OffScreenMemSize;      /* reserved in VBE 3.0 */
	
	/* mandatory for VBE 3.0 and above */
	unsigned short LinBytesPerScanLine;
	unsigned char  BnkNumberOfImagePages;
	unsigned char  LinNumberOfImagePages;
	unsigned char  LinRedMaskSize;
	unsigned char  LinRedFieldPosition;
	unsigned char  LinGreenMaskSize;
	unsigned char  LinGreenFieldPosition;
	unsigned char  LinBlueMaskSize;
	unsigned char  LinBlueFieldPosition;
	unsigned char  LinRsvdMaskSize;
	unsigned char  LinRsvdFieldPosition;
	unsigned long  MaxPixelClock;
	
	unsigned char  Reserved[189];
}
FBPACKED VesaModeInfo;


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
	VMI_WA_WRITE = 1 << 2  /* Window is writeable             */
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

typedef struct VesaPMInfo
{
	unsigned short setWindow;
	unsigned short setDisplayStart;
	unsigned short setPalette;
	unsigned short IOPrivInfo;
} FBPACKED VesaPMInfo;

enum VBE_FUNCS
{
	VBE_INFO            = 0x4F00,
	VBE_MODEINFO        = 0x4F01,
	VBE_SETMODE         = 0x4F02,
	VBE_GETMODE         = 0x4F03,
	VBE_SAVERESTORE     = 0x4F04,
	VBE_WINCTRL         = 0x4F05,
	VBE_SETGETLOGLEN    = 0x4F06,
	VBE_SETGETDISPSTART = 0x4F07,
	VBE_SETGETDACFMT    = 0x4F08,
	VBE_SETGETPAL       = 0x4F09,
	VBE_PMODE           = 0x4F0A
};

enum VBE_STATUS
{
	VBE_STATUS_OK       = 0x004F
};

enum
{
	VBE_SETGETPAL_SET       = 0x00, /* set palette data */
	VBE_SETGETPAL_GET       = 0x01, /* get palette data */
	VBE_SETGETPAL_SETSEC    = 0x02, /* set secondary palette data */
	VBE_SETGETPAL_GETSEC    = 0x03, /* get secondary palette data */
	VBE_SETGETPAL_SET_BLANK = 0x80  /* wait for vertical blank */
};

enum
{
	VBE_PMODE_GET = 0x00 /* return protected mode table */
};

#endif
