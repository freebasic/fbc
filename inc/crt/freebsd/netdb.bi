'' FreeBASIC binding for FreeBSD 11.0 system headers
''
'' based on the C header files:
''   Copyright (c) 1980, 1983, 1988, 1993
''  	The Regents of the University of California.  All rights reserved.
''  
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions
''   are met:
''   1. Redistributions of source code must retain the above copyright
''      notice, this list of conditions and the following disclaimer.
''   2. Redistributions in binary form must reproduce the above copyright
''      notice, this list of conditions and the following disclaimer in the
''      documentation and/or other materials provided with the distribution.
''   3. Neither the name of the University nor the names of its contributors
''      may be used to endorse or promote products derived from this software
''      without specific prior written permission.
''  
''   THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
''   ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
''   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
''   ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
''   FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
''   DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
''   OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
''   HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
''   LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
''   OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
''   SUCH DAMAGE.
''  
''   -
''   Portions Copyright (c) 1993 by Digital Equipment Corporation.
''  
''   Permission to use, copy, modify, and distribute this software for any
''   purpose with or without fee is hereby granted, provided that the above
''   copyright notice and this permission notice appear in all copies, and that
''   the name of Digital Equipment Corporation not be used in advertising or
''   publicity pertaining to distribution of the document or software without
''   specific, written prior permission.
''  
''   THE SOFTWARE IS PROVIDED "AS IS" AND DIGITAL EQUIPMENT CORP. DISCLAIMS ALL
''   WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING ALL IMPLIED WARRANTIES
''   OF MERCHANTABILITY AND FITNESS.   IN NO EVENT SHALL DIGITAL EQUIPMENT
''   CORPORATION BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
''   DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
''   PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS
''   ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
''   SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2017 FreeBASIC development team

#pragma once

'#include once "crt/sys/freebsd/cdefs.bi"
#include once "crt/sys/freebsd/types.bi"

extern "C"

type socklen_t as __socklen_t
#define _PATH_HEQUIV "/etc/hosts.equiv"
#define _PATH_HOSTS "/etc/hosts"
#define _PATH_NETWORKS "/etc/networks"
#define _PATH_PROTOCOLS "/etc/protocols"
#define _PATH_SERVICES "/etc/services"
#define _PATH_SERVICES_DB "/var/db/services.db"
#define h_errno (*__h_errno())

type hostent
	h_name as zstring ptr
	h_aliases as zstring ptr ptr
	h_addrtype as long
	h_length as long
	h_addr_list as zstring ptr ptr
end type

#define h_addr h_addr_list[0]

type netent
	n_name as zstring ptr
	n_aliases as zstring ptr ptr
	n_addrtype as long
	n_net as ulong
end type

type servent
	s_name as zstring ptr
	s_aliases as zstring ptr ptr
	s_port as long
	s_proto as zstring ptr
end type

type protoent
	p_name as zstring ptr
	p_aliases as zstring ptr ptr
	p_proto as long
end type

type addrinfo
	ai_flags as long
	ai_family as long
	ai_socktype as long
	ai_protocol as long
	ai_addrlen as socklen_t
	ai_canonname as zstring ptr
	ai_addr as sockaddr ptr
	ai_next as addrinfo ptr
end type

const IPPORT_RESERVED = 1024
const NETDB_INTERNAL = -1
const NETDB_SUCCESS = 0
const HOST_NOT_FOUND = 1
const TRY_AGAIN = 2
const NO_RECOVERY = 3
const NO_DATA = 4
const NO_ADDRESS = NO_DATA
const EAI_AGAIN = 2
const EAI_BADFLAGS = 3
const EAI_FAIL = 4
const EAI_FAMILY = 5
const EAI_MEMORY = 6
const EAI_NONAME = 8
const EAI_SERVICE = 9
const EAI_SOCKTYPE = 10
const EAI_SYSTEM = 11
const EAI_BADHINTS = 12
const EAI_PROTOCOL = 13
const EAI_OVERFLOW = 14
const EAI_MAX = 15
const AI_PASSIVE = &h00000001
const AI_CANONNAME = &h00000002
const AI_NUMERICHOST = &h00000004
const AI_NUMERICSERV = &h00000008
#define AI_MASK ((((((AI_PASSIVE or AI_CANONNAME) or AI_NUMERICHOST) or AI_NUMERICSERV) or AI_ADDRCONFIG) or AI_ALL) or AI_V4MAPPED)
const AI_ALL = &h00000100
const AI_V4MAPPED_CFG = &h00000200
const AI_ADDRCONFIG = &h00000400
const AI_V4MAPPED = &h00000800
const AI_DEFAULT = AI_V4MAPPED_CFG or AI_ADDRCONFIG
const NI_MAXHOST = 1025
const NI_MAXSERV = 32
const NI_NOFQDN = &h00000001
const NI_NUMERICHOST = &h00000002
const NI_NAMEREQD = &h00000004
const NI_NUMERICSERV = &h00000008
const NI_DGRAM = &h00000010
#define SCOPE_DELIMITER asc("%")

declare sub endhostent()
declare sub endnetent()
declare sub endprotoent()
declare sub endservent()
declare function gethostbyaddr(byval as const any ptr, byval as socklen_t, byval as long) as hostent ptr
declare function gethostbyname(byval as const zstring ptr) as hostent ptr
declare function gethostent() as hostent ptr
declare function getnetbyaddr(byval as ulong, byval as long) as netent ptr
declare function getnetbyname(byval as const zstring ptr) as netent ptr
declare function getnetent() as netent ptr
declare function getprotobyname(byval as const zstring ptr) as protoent ptr
declare function getprotobynumber(byval as long) as protoent ptr
declare function getprotoent() as protoent ptr
declare function getservbyname(byval as const zstring ptr, byval as const zstring ptr) as servent ptr
declare function getservbyport(byval as long, byval as const zstring ptr) as servent ptr
declare function getservent() as servent ptr
declare sub sethostent(byval as long)
declare sub setnetent(byval as long)
declare sub setprotoent(byval as long)
declare function getaddrinfo(byval as const zstring ptr, byval as const zstring ptr, byval as const addrinfo ptr, byval as addrinfo ptr ptr) as long
declare function getnameinfo(byval as const sockaddr ptr, byval as socklen_t, byval as zstring ptr, byval as uinteger, byval as zstring ptr, byval as uinteger, byval as long) as long
declare sub freeaddrinfo(byval as addrinfo ptr)
declare function gai_strerror(byval as long) as const zstring ptr
declare sub setservent(byval as long)
declare sub endnetgrent()
declare sub freehostent(byval as hostent ptr)
declare function gethostbyaddr_r(byval as const any ptr, byval as socklen_t, byval as long, byval as hostent ptr, byval as zstring ptr, byval as uinteger, byval as hostent ptr ptr, byval as long ptr) as long
declare function gethostbyname_r(byval as const zstring ptr, byval as hostent ptr, byval as zstring ptr, byval as uinteger, byval as hostent ptr ptr, byval as long ptr) as long
declare function gethostbyname2(byval as const zstring ptr, byval as long) as hostent ptr
declare function gethostbyname2_r(byval as const zstring ptr, byval as long, byval as hostent ptr, byval as zstring ptr, byval as uinteger, byval as hostent ptr ptr, byval as long ptr) as long
declare function gethostent_r(byval as hostent ptr, byval as zstring ptr, byval as uinteger, byval as hostent ptr ptr, byval as long ptr) as long
declare function getipnodebyaddr(byval as const any ptr, byval as uinteger, byval as long, byval as long ptr) as hostent ptr
declare function getipnodebyname(byval as const zstring ptr, byval as long, byval as long, byval as long ptr) as hostent ptr
declare function getnetbyaddr_r(byval as ulong, byval as long, byval as netent ptr, byval as zstring ptr, byval as uinteger, byval as netent ptr ptr, byval as long ptr) as long
declare function getnetbyname_r(byval as const zstring ptr, byval as netent ptr, byval as zstring ptr, byval as uinteger, byval as netent ptr ptr, byval as long ptr) as long
declare function getnetent_r(byval as netent ptr, byval as zstring ptr, byval as uinteger, byval as netent ptr ptr, byval as long ptr) as long
declare function getnetgrent(byval as zstring ptr ptr, byval as zstring ptr ptr, byval as zstring ptr ptr) as long
declare function getnetgrent_r(byval as zstring ptr ptr, byval as zstring ptr ptr, byval as zstring ptr ptr, byval as zstring ptr, byval as uinteger) as long
declare function getprotobyname_r(byval as const zstring ptr, byval as protoent ptr, byval as zstring ptr, byval as uinteger, byval as protoent ptr ptr) as long
declare function getprotobynumber_r(byval as long, byval as protoent ptr, byval as zstring ptr, byval as uinteger, byval as protoent ptr ptr) as long
declare function getprotoent_r(byval as protoent ptr, byval as zstring ptr, byval as uinteger, byval as protoent ptr ptr) as long
declare function getservbyname_r(byval as const zstring ptr, byval as const zstring ptr, byval as servent ptr, byval as zstring ptr, byval as uinteger, byval as servent ptr ptr) as long
declare function getservbyport_r(byval as long, byval as const zstring ptr, byval as servent ptr, byval as zstring ptr, byval as uinteger, byval as servent ptr ptr) as long
declare function getservent_r(byval as servent ptr, byval as zstring ptr, byval as uinteger, byval as servent ptr ptr) as long
declare sub herror(byval as const zstring ptr)
declare function hstrerror(byval as long) as const zstring ptr
declare function innetgr(byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr) as long
declare sub setnetgrent(byval as const zstring ptr)
declare function __h_errno() as long ptr

end extern
