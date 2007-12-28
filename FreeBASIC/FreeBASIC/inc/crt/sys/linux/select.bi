''
''
'' bits\select -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_sys_linux_select_bi__
#define __crt_sys_linux_select_bi__

'' begin include: bits/sigset.bi
type __sig_atomic_t as integer

#ifndef __sigset_t
const _SIGSET_NWORDS =1024 \ (8 * len(uinteger))
type __sigset_t
    as uinteger __val(0 to _SIGSET_NWORDS-1)
end type
#endif
'' end include: bits/sigset.bi

#macro __FD_ZERO(set)
  scope
    dim as integer __i
    dim as fd_set ptr __arr = (set)
    for __i = 0 to (len(fd_set) \ len(__fd_mask))-1
      __FDS_BITS(__arr)(__i) = 0
	next
  end scope
#endmacro

#define __FD_SET(d, set) __FDS_BITS(set) __FDELT(d) or= __FDMASK(d)
#define __FD_CLR(d, set) __FDS_BITS(set) __FDELT(d) and= not __FDMASK(d)
#define __FD_ISSET(d, set) ((__FDS_BITS(set) __FDELT(d) and __FDMASK(d)) <> 0)

#endif
