typedef struct _DEV_COM_INFO {
	void *hSerial;
	char *pszDevice;
	int iPort;
	FB_SERIAL_OPTIONS Options;
} DEV_COM_INFO;
