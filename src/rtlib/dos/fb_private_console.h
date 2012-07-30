typedef struct _FB_CONSOLE_CTX {
	int           active, visible;
	int           w, h;
	unsigned long phys_addr;
	int           scrollWasOff;
	int           forceInpBufferChanged;
} FB_CONSOLE_CTX;

extern FB_CONSOLE_CTX __fb_con;

int fb_ConsoleLocate_BIOS( int row, int col, int cursor );
void fb_ConsoleGetXY_BIOS( int *col, int *row );
unsigned int fb_ConsoleReadXY_BIOS( int col, int row, int colorflag );
void fb_ConsoleScroll_BIOS( int x1, int y1, int x2, int y2, int nrows );
void fb_ConsoleScrollEx( int x1, int y1, int x2, int y2, int nrows );
void fb_ConsoleMultikeyInit( void );
unsigned short fb_hSetCursorPos( int col, int row );
