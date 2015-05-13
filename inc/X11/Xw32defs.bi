#pragma once

#ifdef __FB_WIN32__
	#define _XW32DEFS_H
	type caddr_t as zstring ptr
	#define lstat stat

	type iovec
		iov_base as caddr_t
		iov_len as long
	end type
#endif
