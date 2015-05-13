typedef enum _FB_SERIAL_PARITY {
    FB_SERIAL_PARITY_NONE,
    FB_SERIAL_PARITY_EVEN,
    FB_SERIAL_PARITY_ODD,
    FB_SERIAL_PARITY_SPACE,
    FB_SERIAL_PARITY_MARK
} FB_SERIAL_PARITY;

typedef enum _FB_SERIAL_STOP_BITS {
    FB_SERIAL_STOP_BITS_1,
    FB_SERIAL_STOP_BITS_1_5,
	FB_SERIAL_STOP_BITS_2
} FB_SERIAL_STOP_BITS;

typedef struct _FB_SERIAL_OPTIONS {
	unsigned           uiSpeed;
    unsigned           uiDataBits;
    FB_SERIAL_PARITY   Parity;
    FB_SERIAL_STOP_BITS StopBits;
    unsigned           DurationCTS;        /* CS[msec] */
    unsigned           DurationDSR;        /* DS[msec] */
    unsigned           DurationCD;         /* CD[msec] */
    unsigned           OpenTimeout;        /* OP[msec] */
    int                SuppressRTS;        /* RS */
    int                AddLF;              /* LF, or ASC, or BIN */
    int                CheckParity;        /* PE */
    int                KeepDTREnabled;     /* DT */
    int                DiscardOnError;     /* FE */
    int                IgnoreAllErrors;    /* ME */
    unsigned           IRQNumber;          /* IR2..IR15 */
    unsigned           TransmitBuffer;     /* TBn - a value 0 means: default value */
    unsigned           ReceiveBuffer;      /* RBn - a value 0 means: default value */
} FB_SERIAL_OPTIONS;

       int          fb_DevSerialSetWidth( const char *pszDevice, int width, int default_width );
       int          fb_SerialOpen       ( FB_FILE *handle, int iPort, FB_SERIAL_OPTIONS *options, const char *pszDevice, void **ppvHandle );
       int          fb_SerialGetRemaining( FB_FILE *handle, void *pvHandle, fb_off_t *pLength );
       int          fb_SerialWrite      ( FB_FILE *handle, void *pvHandle, const void *data, size_t length );
       int          fb_SerialWriteWstr  ( FB_FILE *handle, void *pvHandle, const FB_WCHAR *data, size_t length );
       int          fb_SerialRead       ( FB_FILE *handle, void *pvHandle, void *data, size_t *pLength );
       int          fb_SerialReadWstr   ( FB_FILE *handle, void *pvHandle, FB_WCHAR *data, size_t *pLength );
       int          fb_SerialClose      ( FB_FILE *handle, void *pvHandle );
