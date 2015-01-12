#pragma once

#include once "_bsd_types.bi"

union __in6_addr_u
	Byte(0 to 15) as u_char
	Word(0 to 7) as u_short
end union

type in6_addr
	u as __in6_addr_u
end type

type PIN6_ADDR as in6_addr ptr
type LPIN6_ADDR as in6_addr ptr

#define in_addr6 in6_addr
#define _S6_un u
#define _S6_u8 Byte
#define s6_addr _S6_un._S6_u8
#define s6_bytes u.Byte
#define s6_words u.Word
