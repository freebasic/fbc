''
''
'' errno -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_errno_bi__
#define __crt_errno_bi__

#if defined(__FB_LINUX__)
        #define EPERM 1
        #define ENOFILE 2
        #define ENOENT 2
        #define ESRCH 3
        #define EINTR 4
        #define EIO 5
        #define ENXIO 6
        #define E2BIG 7
        #define ENOEXEC 8
        #define EBADF 9
        #define ECHILD 10
        #define EAGAIN 11
        #define ENOMEM 12
        #define EACCES 13
        #define EFAULT 14
        #define EBUSY 16
        #define EEXIST 17
        #define EXDEV 18
        #define ENODEV 19
        #define ENOTDIR 20
        #define EISDIR 21
        #define EINVAL 22
        #define ENFILE 23
        #define EMFILE 24
        #define ENOTTY 25
        #define EFBIG 27
        #define ENOSPC 28
        #define ESPIPE 29
        #define EROFS 30
        #define EMLINK 31
        #define EPIPE 32
        #define EDOM 33
        #define ERANGE 34
        #define EDEADLOCK 36
        #define EDEADLK 36
        #define ENAMETOOLONG 38
        #define ENOLCK 39
        #define ENOSYS 40
        #define ENOTEMPTY 41
        #define EILSEQ 42
#elseif defined(__FB_FREEBSD__)
	#define	EPERM		1
	#define	ENOENT		2
	#define	ESRCH		3
	#define	EINTR		4
	#define	EIO		5
	#define	ENXIO		6
	#define	E2BIG		7
	#define	ENOEXEC		8
	#define	EBADF		9
	#define	ECHILD		10
	#define	EDEADLK		11
	#define	ENOMEM		12
	#define	EACCES		13
	#define	EFAULT		14
	#define	ENOTBLK		15
	#define	EBUSY		16
	#define	EEXIST		17
	#define	EXDEV		18
	#define	ENODEV		19
	#define	ENOTDIR		20
	#define	EISDIR		21
	#define	EINVAL		22
	#define	ENFILE		23
	#define	EMFILE		24
	#define	ENOTTY		25
	#define	ETXTBSY		26
	#define	EFBIG		27
	#define	ENOSPC		28
	#define	ESPIPE		29
	#define	EROFS		30
	#define	EMLINK		31
	#define	EPIPE		32
	#define	EDOM		33
	#define	ERANGE		34
	#define	EAGAIN		35
	#define	EWOULDBLOCK	EAGAIN
	#define	EINPROGRESS	36
	#define	EALREADY	37
	#define	ENOTSOCK	38
	#define	EDESTADDRREQ	39
	#define	EMSGSIZE	40
	#define	EPROTOTYPE	41
	#define	ENOPROTOOPT	42
	#define	EPROTONOSUPPORT	43
	#define	ESOCKTNOSUPPORT	44
	#define	EOPNOTSUPP	45
	#define	ENOTSUP		EOPNOTSUPP
	#define	EPFNOSUPPORT	46
	#define	EAFNOSUPPORT	47
	#define	EADDRINUSE	48
	#define	EADDRNOTAVAIL	49
	#define	ENETDOWN	50
	#define	ENETUNREACH	51
	#define	ENETRESET	52
	#define	ECONNABORTED	53
	#define	ECONNRESET	54
	#define	ENOBUFS		55
	#define	EISCONN		56
	#define	ENOTCONN	57
	#define	ESHUTDOWN	58
	#define	ETOOMANYREFS	59
	#define	ETIMEDOUT	60
	#define	ECONNREFUSED	61
	#define	ELOOP		62
	#define	ENAMETOOLONG	63
	#define	EHOSTDOWN	64
	#define	EHOSTUNREACH	65
	#define	ENOTEMPTY	66
	#define	EPROCLIM	67
	#define	EUSERS		68
	#define	EDQUOT		69
	#define	ESTALE		70
	#define	EREMOTE		71
	#define	EBADRPC		72
	#define	ERPCMISMATCH	73
	#define	EPROGUNAVAIL	74
	#define	EPROGMISMATCH	75
	#define	EPROCUNAVAIL	76
	#define	ENOLCK		77
	#define	ENOSYS		78
	#define	EFTYPE		79
	#define	EAUTH		80
	#define	ENEEDAUTH	81
	#define	EIDRM		82
	#define	ENOMSG		83
	#define	EOVERFLOW	84
	#define	ECANCELED	85
	#define	EILSEQ		86
	#define	ENOATTR		87
	#define	EDOOFUS		88
	#define	EBADMSG		89
	#define	EMULTIHOP	90
	#define	ENOLINK		91
	#define	EPROTO		92
	#define	ENOTCAPABLE	93
	#define	ECAPMODE	94
	#define	ENOTRECOVERABLE	95
	#define	EOWNERDEAD	96
#endif

extern "C"

#ifdef __FB_WIN32__
	declare function _errno() as long ptr
	#define errno (*_errno())
#elseif defined( __FB_LINUX__ )
	declare function __errno_location() as long ptr
	#define errno (*__errno_location())
#elseif defined( __FB_FREEBSD__ )
        declare function __error() as long ptr
        #define errno (*__error())
#else
	extern errno as long
#endif

end extern

#endif
