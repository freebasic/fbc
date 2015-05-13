#pragma once

#include once "crt/long.bi"

type __sig_atomic_t as long

#define _SIGSET_NWORDS (1024 \ (8 * sizeof( culong )))
type __sigset_t
	__val(0 to _SIGSET_NWORDS-1) as culong
end type
