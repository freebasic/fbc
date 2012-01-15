''
''
'' Xthreads -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Xthreads_bi__
#define __Xthreads_bi__

type xthread_t as pthread_t
type xthread_key_t as pthread_key_t
type xcondition_rec as pthread_cond_t
type xmutex_rec as pthread_mutex_t
type xcondition_t as xcondition_rec ptr
type xmutex_t as xmutex_rec ptr

#endif
