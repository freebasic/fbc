typedef struct {
	char * proto;
	int iPort;
	char * name;
	char * title;
	char * emu;
	char raw[];
} DEV_LPT_PROTOCOL;

typedef struct {
    void  *driver_opaque; /* this member must be first */
    char  *pszDevice;
    int    iPort;
    size_t uiRefCount;
} DEV_LPT_INFO;

       int          fb_DevLptParseProtocol( DEV_LPT_PROTOCOL ** lpt_proto_out, const char * proto_raw, size_t proto_raw_len, int substprn );
       int          fb_DevLptTestProtocol( FB_FILE *handle, const char *filename, size_t filename_len );

       int          fb_DevLptOpen       ( FB_FILE *handle, const char *filename, size_t filename_len );
       int          fb_DevLptWrite      ( FB_FILE *handle, const void* value, size_t valuelen );
       int          fb_DevLptWriteWstr  ( FB_FILE *handle, const FB_WCHAR* value, size_t valuelen );
       int          fb_DevLptClose      ( FB_FILE *handle );

       int          fb_DevPrinterSetWidth ( const char *pszDevice, int width,int default_width );
       int          fb_DevPrinterGetOffset( const char *pszDevice );

       int          fb_PrinterOpen      ( DEV_LPT_INFO *devInfo, int iPort, const char *pszDevice );
       int          fb_PrinterWrite     ( DEV_LPT_INFO *devInfo, const void *data, size_t length );
       int          fb_PrinterWriteWstr ( DEV_LPT_INFO *devInfo, const FB_WCHAR *data,size_t length );
       int          fb_PrinterClose     ( DEV_LPT_INFO *devInfo );
