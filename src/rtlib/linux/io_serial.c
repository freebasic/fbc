/* serial port access for Linux */

#include "../fb.h"
#include "../io_serial_private.h"

#include <sys/ioctl.h>
#include <sys/select.h>
#include <signal.h>
#include <fcntl.h>

#ifdef HAS_LOCKDEV
#include <lockdev.h>
#endif

#define BUFFERSIZE	BUFSIZ*16
#define ENDSPD		111111
#define BADSPEED	999999
#define SERIAL_TIMEOUT	3	/* seconds  for write on open*/
#define SREAD_TIMEOUT	70	/* if not receive any character in less 50 millisecs finish read process */

static void alrm(int signal_number)
{
	/* signal callback, do nothing */
	(void)signal_number;
}

static speed_t get_speed( int speed )
{
	static unsigned int sp[][2] =
    {
    	{0,     B0},
        {50,    B50},
        {150,   B150},
        {300,   B300},
        {600,   B600},
        {1200,  B1200},
        {1800,  B1800},
        {2400,  B2400},
        {4800,  B4800},
        {9600,  B9600},
        {19200, B19200},
        {38400, B38400},
#ifdef B57600
        {57600, B57600 },
#endif
#ifdef B115200
        {115200, B115200 },
#endif
#ifdef B230400
        {230400, B230400 },
#endif
#ifdef B460800
        {460800, B460800 },
#endif
#ifdef B500000
		{500000, B500000 },
#endif
#ifdef  B576000
		{576000, B576000 },
#endif
#ifdef  B921600
		{921600, B921600 },
#endif
#ifdef  B1000000
		{1000000, B1000000 },
#endif
#ifdef  B1152000
		{1152000, B1152000 },
#endif
#ifdef  B1500000
		{1500000, B1500000 },
#endif
#ifdef  B2000000
		{2000000, B2000000 },
#endif
#ifdef  B2500000
		{2500000, B2500000 },
#endif
#ifdef  B3000000
		{3000000, B3000000 },
#endif
#ifdef  B3500000
		{3500000, B3500000 },
#endif
#ifdef  B4000000
		{4000000, B4000000 },
#endif

        {ENDSPD, 0},
        {0, 0}
	};

    int n;
    speed_t Rspeed;

    for (n = 0; sp[n][0] != (unsigned int)speed; n++)
    {
    	if (sp[n][0] == ENDSPD)		/*invalid speed */
        	return (BADSPEED);
	}
    Rspeed = sp[n][1];

	return(Rspeed);
}

int fb_SerialOpen
	(
		FB_FILE *handle,
		int iPort,
		FB_SERIAL_OPTIONS *options,
		const char *pszDevice,
		void **ppvHandle
	)
{
    int res = FB_RTERROR_OK;
    int DesiredAccess = O_RDWR|O_NOCTTY|O_NONBLOCK;
    int SerialFD = (-1);
    char DeviceName[512];
    struct termios oldserp, nwserp;
    speed_t TermSpeed;
#ifdef HAS_LOCKDEV
    pid_t plckid;
#endif

    /* The IRQ stuff is not supported on Linux ... */
    if( options->IRQNumber != 0 )
    {
    	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    res = fb_ErrorSetNum( FB_RTERROR_OK );

    switch( handle->access )
    {
    case FB_FILE_ACCESS_READ:
        DesiredAccess |= O_RDONLY;
        break;
    case FB_FILE_ACCESS_WRITE:
        DesiredAccess |= O_WRONLY;
        break;
    case FB_FILE_ACCESS_READWRITE:
    	/* fall through */
    case FB_FILE_ACCESS_ANY:
        DesiredAccess |= O_RDWR;
        break;
    }

	DeviceName[0] = '\0';

    if( iPort == 0 )
	{
		if( strcasecmp(pszDevice, "COM") == 0 )
		{
			strcpy( DeviceName, "/dev/modem" );
		}
		else
		{
			strcpy( DeviceName, pszDevice );
		}
	}
	else
	{
		sprintf(DeviceName, "/dev/ttyS%d", (iPort-1));
	}

    /* Setting speed baud line */
    TermSpeed = get_speed(options->uiSpeed);
    if( TermSpeed == BADSPEED )
    {
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

#ifdef HAS_LOCKDEV
    if( dev_testlock(DeviceName) )
    {
        return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
    }

    plckid = dev_lock(DeviceName);
    if( plckid < 0 )
    {
        return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
    }
#endif

    alarm(SERIAL_TIMEOUT);
    SerialFD =  open( DeviceName, DesiredAccess );
    alarm(0);
    if( SerialFD < 0)
    {
#ifdef HAS_LOCKDEV
		dev_unlock(DeviceName, plckid);
#endif
        return fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
    }

	/* !!!FIXME!!! Lock file handle (handle->lock) pending, you can use fcnctl or flock functions */

    /* Make the file descriptor asynchronous */
    /* fcntl(SerialFD, F_SETFL, FASYNC); */

    /* Save old status of serial port discipline */
    if( tcgetattr ( SerialFD, &oldserp ) )
    {
        res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    /* Discard data write/read in serial port not transmitted */
    if( tcflush( SerialFD, TCIOFLUSH)  )
    {
        res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    /* Inittialize new struct termios with old values */
    if( tcgetattr ( SerialFD, &nwserp ) )
    {
        res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

	/* Set timeouts
	 * Timeout not are defined in UNIX termio/s
	 * set CTS > 0 enable CTSRTS flow control,
	 * other are ignored are setting for default in open function
	 * !!!FIXME!!! ???
	 */

	/* setup generic serial port configuration */
    if( res == FB_RTERROR_OK )
    {
		/* Initialize */
    	nwserp.c_cflag |= CREAD; /* Enable receiver */
		nwserp.c_iflag &= ~(IXON | IXOFF | IXANY); /* Disable Software Flow Control */
    	nwserp.c_cflag |= CREAD; /* Enable receiver */

	    if( options->AddLF )
	    {
			/*With AddFl Set, Process Canonical output/input */
			nwserp.c_lflag |= (ICANON|OPOST|ONLCR); /* Postprocess output and map newline at nl/cr */
		}
		else
		{
			/* Set raw tty settings */
	    		cfmakeraw(&nwserp);
			nwserp.c_cc[VMIN] = 1 ; /* Wait min for 1 char */
			nwserp.c_cc[VTIME] = 0 ; /* Not use timeout */
		}

		if( options->KeepDTREnabled )
			nwserp.c_cflag &= ~(HUPCL); /* Not Hangup (set DTR) on last close */
		else
			nwserp.c_cflag |= (HUPCL); /* Hangup (drop DTR) on last close */

		/* CD (Carrier Detect) and DS (Data Set Ready) are modem signal
		 * in UNIXes the flag CLOCAL attend the modem signals. Quickly, if your conection is
		 * a modem telephony device active CD[0-n] and DS[0-n]
		 * else for local conections set CD0 or DS0
		 */
		 /* DS and CD are ignored */
		if( options->DurationDSR || options->DurationCD )
		{
			nwserp.c_cflag &= ~(CLOCAL);
		}
		else
		{
		 	nwserp.c_cflag |= CLOCAL; /* Ignore modem control Lines */
		}

		/* Termios not manage timeout for CTS, but understand RTSCTS flow control
		 * if DurationCTS is greater zero CTSRTS flow will be activate
		 */
		if( options->DurationCTS != 0 && !options->SuppressRTS )
			nwserp.c_cflag |= CRTSCTS;
		else
			nwserp.c_cflag &= ~CRTSCTS;

		/* Setting speed baud and other serial parameters */
		nwserp.c_cflag |= TermSpeed ;
		/* Set size word 5,6,7,8 sonly support */
		nwserp.c_cflag &= ~(CSIZE);

		switch ( options->uiDataBits)
		{
		case 5:
			nwserp.c_cflag |= CS5 ;
			break;
		case 6:
			nwserp.c_cflag |= CS6 ;
			break;
		case 7:
			nwserp.c_cflag |= CS7 ;
			break;
		case 8:
			/* fall through */
		default:
			nwserp.c_cflag |= CS8 ;
		}

		/* Setting parity, 1.5 StopBit not supported */
		switch ( options->Parity )
		{
	    case FB_SERIAL_PARITY_NONE:
	        nwserp.c_cflag &= ~(PARENB);
			break;

	    /* 7bits and Space parity is the same (7S1) that (8N1) 8 bits without parity */
	    case FB_SERIAL_PARITY_SPACE:
	        nwserp.c_cflag &= ~(PARENB);
			nwserp.c_cflag |= CS8;
	        break;

		/* !!!FIXME!!! I'm not sure for mark parity, set the input line. Fix me! for output */
	    case FB_SERIAL_PARITY_MARK:
		    nwserp.c_iflag |= (PARMRK);
		    /* fall through */

	    case FB_SERIAL_PARITY_EVEN:
			nwserp.c_iflag |= (INPCK | ISTRIP);
	        nwserp.c_cflag |= PARENB;
			break;

	    case FB_SERIAL_PARITY_ODD:
			nwserp.c_iflag |= (INPCK | ISTRIP);
	        nwserp.c_cflag |= (PARENB|PARODD);
	    	break;
		}

		/* Ignore all parity errors, can be dangerous */
		if ( options->IgnoreAllErrors ) {
			nwserp.c_iflag |= (IGNPAR);
		} else {
			nwserp.c_iflag &= ~(IGNPAR);
		}

	    switch ( options->StopBits )
	    {
	    case FB_SERIAL_STOP_BITS_1:
			nwserp.c_cflag &= ~(CSTOPB);
	        break;

		/* 1.5 Stop not support 2 Stop bits assumed */
		case FB_SERIAL_STOP_BITS_1_5:
	    	/* fall through */

	    case FB_SERIAL_STOP_BITS_2:
			nwserp.c_cflag |= CSTOPB;
	        break;
		}

		/* If not RTS hardware flow, sotfware IXANY softflow assumed */
		if( options->SuppressRTS )
		{
			nwserp.c_iflag &= ~(IXON | IXOFF | IXANY);
			nwserp.c_iflag |= (IXON | IXANY);
		}

		if( res == FB_RTERROR_OK )
		{
			/* Active set serial parameters */
			if( tcsetattr( SerialFD, TCSAFLUSH, &nwserp ) )
		   		res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	    }
	}

    /* error? */
    if( res != FB_RTERROR_OK )
    {
#ifdef HAS_LOCKDEV
		dev_unlock(DeviceName, plckid);
#endif
        tcsetattr( SerialFD, TCSAFLUSH, &oldserp); /* Restore old parameter of serial line */
    	close(SerialFD);
    }
    else
    {
	    LINUX_SERIAL_INFO *pInfo = (LINUX_SERIAL_INFO *) calloc( 1, sizeof(LINUX_SERIAL_INFO) );
	    DBG_ASSERT( ppvHandle!=NULL );
	    *ppvHandle = pInfo;
	    pInfo->sfd = SerialFD;
	    pInfo->oldtty = oldserp;
	    pInfo->newtty = nwserp;
#ifdef HAS_LOCKDEV
	    pInfo->pplckid = plckid;
#endif
	    pInfo->iPort = iPort;
	    pInfo->pOptions = options;
    }

    return res;
}

int fb_SerialGetRemaining( FB_FILE *handle, void *pvHandle, fb_off_t *pLength )
{
    int rBytes;
    int SerialFD;
    LINUX_SERIAL_INFO *pInfo = (LINUX_SERIAL_INFO *) pvHandle;

    SerialFD = pInfo->sfd;
    if( ioctl(SerialFD, FIONREAD, &rBytes) )
	    return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	if( pLength )
		*pLength = rBytes;

    return fb_ErrorSetNum( FB_RTERROR_OK );
}

int fb_SerialWrite
	(
		FB_FILE *handle,
		void *pvHandle,
		const void *data,
		size_t length
	)
{
    ssize_t rlng=0;
    LINUX_SERIAL_INFO *pInfo = (LINUX_SERIAL_INFO *) pvHandle;
    int SerialFD = pInfo->sfd;

    (void) signal(SIGALRM,  alrm);
    alarm( SERIAL_TIMEOUT );
    rlng=write(SerialFD, data, length);
    alarm(0);

    if( rlng <= 0 )
        return fb_ErrorSetNum( FB_RTERROR_FILEIO );

    if( length != (size_t)rlng  )
        return fb_ErrorSetNum( FB_RTERROR_FILEIO );

    return fb_ErrorSetNum( FB_RTERROR_OK );
}

int fb_SerialRead( FB_FILE *handle, void *pvHandle, void *data, size_t *pLength )
{
    LINUX_SERIAL_INFO *pInfo = (LINUX_SERIAL_INFO *) pvHandle;
    int SerialFD;
    ssize_t count = 0;
    fd_set rfds;
    struct timeval tmout;

    SerialFD = pInfo->sfd;

    FD_ZERO( &rfds );
    FD_SET( SerialFD, &rfds );

    tmout.tv_sec = 0;
    tmout.tv_usec = (SREAD_TIMEOUT*1000L); /* convert to microsecs */

    select( SerialFD+1, &rfds, NULL, NULL, &tmout );
    if ( FD_ISSET(SerialFD, &rfds) )
    {
    	if ( (count = read(SerialFD, data, *pLength)) < 0 )
    	{
    		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
		}
    }

    *pLength = count;

    return fb_ErrorSetNum( FB_RTERROR_OK );
}

int fb_SerialClose( FB_FILE *handle, void *pvHandle )
{
    int SerialFD;
    struct termios oserp;
#ifdef HAS_LOCKDEV
    pid_t plckid;
#endif
    LINUX_SERIAL_INFO *pInfo = (LINUX_SERIAL_INFO *) pvHandle;

    SerialFD = pInfo->sfd;
    oserp = pInfo->oldtty;
#ifdef HAS_LOCKDEV
    plckid = pInfo->pplckid;
#endif
#ifdef HAS_LOCKDEV
	dev_unlock(DeviceName, plckid);
#endif

	/* Restore old parameter of serial line */
	tcsetattr( SerialFD, TCSAFLUSH, &oserp);

    close(SerialFD);
	free(pInfo);

    return fb_ErrorSetNum( FB_RTERROR_OK );
}
