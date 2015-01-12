#pragma once

#include once "_bsd_types.bi"

type __in_addr_S_un_b
	s_b1 as u_char
	s_b2 as u_char
	s_b3 as u_char
	s_b4 as u_char
end type

type __in_addr_S_un_w
	s_w1 as u_short
	s_w2 as u_short
end type

union __in_addr_S_un
	S_un_b as __in_addr_S_un_b
	S_un_w as __in_addr_S_un_w
	S_addr as u_long
end union

type in_addr
	S_un as __in_addr_S_un
end type

type PIN_ADDR as in_addr ptr
type LPIN_ADDR as in_addr ptr

#define s_addr S_un.S_addr
#define s_host S_un.S_un_b.s_b2
#define s_net S_un.S_un_b.s_b1
#define s_imp S_un.S_un_w.s_w2
#define s_impno S_un.S_un_b.s_b4
#define s_lh S_un.S_un_b.s_b3
