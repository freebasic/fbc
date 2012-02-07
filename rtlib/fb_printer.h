typedef struct _DEV_LPT_PROTOCOL 
{
	char * proto;
	int iPort;
	char * name;
	char * title;
	char * emu;
	char raw[];
} DEV_LPT_PROTOCOL;

typedef struct _DEV_LPT_INFO {
    void  *driver_opaque; /* this member must be first */
    char  *pszDevice;
    int    iPort;
    size_t uiRefCount;
} DEV_LPT_INFO;

int fb_DevLptParseProtocol( 
	DEV_LPT_PROTOCOL ** lpt_proto_out, 
	const char * proto_raw, 
	size_t proto_raw_len,  
	int substprn
	);

       int          fb_DevLptOpen       ( struct _FB_FILE *handle, const char *filename, size_t filename_len );
       int          fb_DevLptWrite      ( struct _FB_FILE *handle, const void* value, size_t valuelen );
       int          fb_DevLptWriteWstr  ( struct _FB_FILE *handle, const FB_WCHAR* value, size_t valuelen );
       int          fb_DevLptClose      ( struct _FB_FILE *handle );

       int          fb_DevPrinterSetWidth ( const char *pszDevice, int width,int default_width );
       int          fb_DevPrinterGetOffset( const char *pszDevice );

       int          fb_PrinterOpen      ( struct _DEV_LPT_INFO *devInfo, int iPort, const char *pszDevice );
       int          fb_PrinterWrite     ( struct _DEV_LPT_INFO *devInfo, const void *data, size_t length );
       int          fb_PrinterWriteWstr ( struct _DEV_LPT_INFO *devInfo, const FB_WCHAR *data,size_t length );
       int          fb_PrinterClose     ( struct _DEV_LPT_INFO *devInfo );
