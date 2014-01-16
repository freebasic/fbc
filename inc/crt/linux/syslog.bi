#ifndef __FB_UNIX__
#error "This interface is only defined on *nix systems."
#endif

#ifndef __SYS_SYSLOG_BI__
#define __SYS_SYSLOG_BI__ -1

#define	LOG_EMERG	0	'system is unusable
#define	LOG_ALERT	1	'action must be taken immediately
#define	LOG_CRIT	2	'critical conditions
#define	LOG_ERR		3	'error conditions
#define	LOG_WARNING	4	'warning conditions
#define	LOG_NOTICE	5	'normal but significant condition
#define	LOG_INFO	6	'informational
#define	LOG_DEBUG	7	'debug-level messages

#define	LOG_PRIMASK	&h07	'mask to extract priority part (internal)
#define	LOG_PRI(p)	((p) AND LOG_PRIMASK) 'extract priority
#define	LOG_MAKEPRI(fac, pri)	(((fac)  shl  3) OR (pri))

'facility codes
#define	LOG_KERN	(0 shl 3)	'kernel messages
#define	LOG_USER	(1 shl 3)	'random user-level messages
#define	LOG_MAIL	(2 shl 3)	'mail system
#define	LOG_DAEMON	(3 shl 3)	'system daemons
#define	LOG_AUTH	(4 shl 3)	'security/authorization messages
#define	LOG_SYSLOG	(5 shl 3)	'messages generated internally by syslogd
#define	LOG_LPR		(6 shl 3)	'line printer subsystem
#define	LOG_NEWS	(7 shl 3)	'network news subsystem
#define	LOG_UUCP	(8 shl 3)	'UUCP subsystem
#define	LOG_CRON	(9 shl 3)	'clock daemon
#define	LOG_AUTHPRIV	(10 shl 3)	'security/authorization messages (private)
#define	LOG_FTP		(11 shl 3)	'ftp daemon

'other codes through 15 reserved for system use
#define	LOG_LOCAL0	(16 shl 3)	'reserved for local use
#define	LOG_LOCAL1	(17 shl 3)	'reserved for local use
#define	LOG_LOCAL2	(18 shl 3)	'reserved for local use
#define	LOG_LOCAL3	(19 shl 3)	'reserved for local use
#define	LOG_LOCAL4	(20 shl 3)	'reserved for local use
#define	LOG_LOCAL5	(21 shl 3)	'reserved for local use
#define	LOG_LOCAL6	(22 shl 3)	'reserved for local use
#define	LOG_LOCAL7	(23 shl 3)	'reserved for local use

#define	LOG_NFACILITIES	24	'current number of facilities
#define	LOG_FACMASK	&h03f8	'mask to extract facility part

'facility of pri
#define	LOG_FAC(p)	(((p) AND LOG_FACMASK) SHR 3)

'arguments to setlogmask.
#define	LOG_MASK(pri)	(1 SHL (pri))		'mask for one priority
#define	LOG_UPTO(pri)	((1 SHL ((pri)+1)) - 1)	'all priorities through pri

'Option flags for openlog.
#define	LOG_PID		&h01	'log the pid with each message
#define	LOG_CONS	&h02	'log on the console if errors in sending
#define	LOG_ODELAY	&h04	'delay open until first syslog() (default)
#define	LOG_NDELAY	&h08	'don't delay open
#define	LOG_NOWAIT	&h10	'don't wait for console forks: DEPRECATED
#define	LOG_PERROR	&h20	'log to stderr as well

extern "C"

'Close connection to system logger.
declare sub closelog()

'Open connection to system logger.
declare sub openlog(byval __ident as const zstring ptr, byval __option as long, byval __facility as long)

'Set the log mask level
declare function setlogmask(byval __mask as long) as long

'Generate a log message using FMT string and option arguments.
declare sub syslog(byval __pri as long, byval __fmt as const zstring ptr, ...)

end extern

#endif '__SYS_SYSLOG_BI__
