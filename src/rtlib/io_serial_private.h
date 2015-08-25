#if defined HOST_WIN32
	#include <windows.h>
	typedef struct _W32_SERIAL_INFO {
		HANDLE hDevice;
		int iPort;
		FB_SERIAL_OPTIONS *pOptions;
	} W32_SERIAL_INFO;
#elif defined HOST_LINUX
	/* Uncomment HAS_LOCKDEV to active lock file funcionality, not forget
	 * compile whith -llockdev
	 */
	/* #define HAS_LOCKDEV 1 */
	typedef struct _LINUX_SERIAL_INFO {
		int sfd;
		struct termios oldtty, newtty;
		#ifdef HAS_LOCKDEV
			pid_t pplckid;
		#endif
		int iPort;
		FB_SERIAL_OPTIONS *pOptions;
	} LINUX_SERIAL_INFO;
#elif defined HOST_DOS
	typedef struct {
		int com_num;
		FB_SERIAL_OPTIONS *pOptions;
	} DOS_SERIAL_INFO;
#endif
