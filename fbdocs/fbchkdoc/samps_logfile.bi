#ifndef __SAMPS_LOGFILE_BI__
#define __SAMPS_LOGFILE_BI__

extern logfileh as integer

#ifndef FALSE
const FALSE = 0
#endif

#ifndef TRUE
const TRUE = NOT FALSE
#endif

declare sub logopen()
declare sub logprint( byref txt as string = "", byval bContinue as integer = FALSE )
declare sub logclose()

#endif
