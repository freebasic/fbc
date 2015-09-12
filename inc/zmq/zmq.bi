'' FreeBASIC binding for zeromq-4.1.3
''
'' based on the C header files:
''   Copyright (c) 2007-2015 Contributors as noted in the AUTHORS file
''
''   This file is part of 0MQ.
''
''   0MQ is free software; you can redistribute it and/or modify it under
''   the terms of the GNU Lesser General Public License as published by
''   the Free Software Foundation; either version 3 of the License, or
''   (at your option) any later version.
''
''   0MQ is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''   GNU Lesser General Public License for more details.
''
''   You should have received a copy of the GNU Lesser General Public License
''   along with this program.  If not, see <http://www.gnu.org/licenses/>.
''
''   *************************************************************************
''   NOTE to contributors. This file comprises the principal public contract
''   for ZeroMQ API users (along with zmq_utils.h). Any change to this file
''   supplied in a stable release SHOULD not break existing applications.
''   In practice this means that the value of constants must not change, and
''   that old values may not be reused for new constants.
''   *************************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "zmq"

#include once "crt/long.bi"
#include once "crt/errno.bi"
#include once "crt/stddef.bi"
#include once "crt/stdio.bi"

#ifdef __FB_WIN32__
	#include once "win/winsock2.bi"
#endif

#include once "crt/stdint.bi"
#include once "crt/sys/uio.bi"

'' The following symbols have been renamed:
''     #define ZMQ_VERSION => ZMQ_VERSION_

extern "C"

#define __ZMQ_H_INCLUDED__
const ZMQ_VERSION_MAJOR = 4
const ZMQ_VERSION_MINOR = 1
const ZMQ_VERSION_PATCH = 3
#define ZMQ_MAKE_VERSION(major, minor, patch) ((((major) * 10000) + ((minor) * 100)) + (patch))
#define ZMQ_VERSION_ ZMQ_MAKE_VERSION(ZMQ_VERSION_MAJOR, ZMQ_VERSION_MINOR, ZMQ_VERSION_PATCH)
const ZMQ_DEFINED_STDINT = 1
const ZMQ_HAUSNUMERO = 156384712
const ENOTSUP = ZMQ_HAUSNUMERO + 1
const EPROTONOSUPPORT = ZMQ_HAUSNUMERO + 2
const ENOBUFS = ZMQ_HAUSNUMERO + 3
const ENETDOWN = ZMQ_HAUSNUMERO + 4
const EADDRINUSE = ZMQ_HAUSNUMERO + 5
const EADDRNOTAVAIL = ZMQ_HAUSNUMERO + 6
const ECONNREFUSED = ZMQ_HAUSNUMERO + 7
const EINPROGRESS = ZMQ_HAUSNUMERO + 8
const ENOTSOCK = ZMQ_HAUSNUMERO + 9
const EMSGSIZE = ZMQ_HAUSNUMERO + 10
const EAFNOSUPPORT = ZMQ_HAUSNUMERO + 11
const ENETUNREACH = ZMQ_HAUSNUMERO + 12
const ECONNABORTED = ZMQ_HAUSNUMERO + 13
const ECONNRESET = ZMQ_HAUSNUMERO + 14
const ENOTCONN = ZMQ_HAUSNUMERO + 15
const ETIMEDOUT = ZMQ_HAUSNUMERO + 16
const EHOSTUNREACH = ZMQ_HAUSNUMERO + 17
const ENETRESET = ZMQ_HAUSNUMERO + 18
const EFSM = ZMQ_HAUSNUMERO + 51
const ENOCOMPATPROTO = ZMQ_HAUSNUMERO + 52
const ETERM = ZMQ_HAUSNUMERO + 53
const EMTHREAD = ZMQ_HAUSNUMERO + 54

declare function zmq_errno() as long
declare function zmq_strerror(byval errnum as long) as const zstring ptr
declare sub zmq_version(byval major as long ptr, byval minor as long ptr, byval patch as long ptr)

const ZMQ_IO_THREADS = 1
const ZMQ_MAX_SOCKETS = 2
const ZMQ_SOCKET_LIMIT = 3
const ZMQ_THREAD_PRIORITY = 3
const ZMQ_THREAD_SCHED_POLICY = 4
const ZMQ_IO_THREADS_DFLT = 1
const ZMQ_MAX_SOCKETS_DFLT = 1023
const ZMQ_THREAD_PRIORITY_DFLT = -1
const ZMQ_THREAD_SCHED_POLICY_DFLT = -1

declare function zmq_ctx_new() as any ptr
declare function zmq_ctx_term(byval context as any ptr) as long
declare function zmq_ctx_shutdown(byval ctx_ as any ptr) as long
declare function zmq_ctx_set(byval context as any ptr, byval option as long, byval optval as long) as long
declare function zmq_ctx_get(byval context as any ptr, byval option as long) as long
declare function zmq_init(byval io_threads as long) as any ptr
declare function zmq_term(byval context as any ptr) as long
declare function zmq_ctx_destroy(byval context as any ptr) as long

type zmq_msg_t
	__(0 to 63) as ubyte
end type

declare function zmq_msg_init(byval msg as zmq_msg_t ptr) as long
declare function zmq_msg_init_size(byval msg as zmq_msg_t ptr, byval size as uinteger) as long
declare function zmq_msg_init_data(byval msg as zmq_msg_t ptr, byval data as any ptr, byval size as uinteger, byval ffn as sub(byval data as any ptr, byval hint as any ptr), byval hint as any ptr) as long
declare function zmq_msg_send(byval msg as zmq_msg_t ptr, byval s as any ptr, byval flags as long) as long
declare function zmq_msg_recv(byval msg as zmq_msg_t ptr, byval s as any ptr, byval flags as long) as long
declare function zmq_msg_close(byval msg as zmq_msg_t ptr) as long
declare function zmq_msg_move(byval dest as zmq_msg_t ptr, byval src as zmq_msg_t ptr) as long
declare function zmq_msg_copy(byval dest as zmq_msg_t ptr, byval src as zmq_msg_t ptr) as long
declare function zmq_msg_data(byval msg as zmq_msg_t ptr) as any ptr
declare function zmq_msg_size(byval msg as zmq_msg_t ptr) as uinteger
declare function zmq_msg_more(byval msg as zmq_msg_t ptr) as long
declare function zmq_msg_get(byval msg as zmq_msg_t ptr, byval property as long) as long
declare function zmq_msg_set(byval msg as zmq_msg_t ptr, byval property as long, byval optval as long) as long
declare function zmq_msg_gets(byval msg as zmq_msg_t ptr, byval property as const zstring ptr) as const zstring ptr

const ZMQ_PAIR = 0
const ZMQ_PUB = 1
const ZMQ_SUB = 2
const ZMQ_REQ = 3
const ZMQ_REP = 4
const ZMQ_DEALER = 5
const ZMQ_ROUTER = 6
const ZMQ_PULL = 7
const ZMQ_PUSH = 8
const ZMQ_XPUB = 9
const ZMQ_XSUB = 10
const ZMQ_STREAM = 11
const ZMQ_XREQ = ZMQ_DEALER
const ZMQ_XREP = ZMQ_ROUTER
const ZMQ_AFFINITY = 4
const ZMQ_IDENTITY = 5
const ZMQ_SUBSCRIBE = 6
const ZMQ_UNSUBSCRIBE = 7
const ZMQ_RATE = 8
const ZMQ_RECOVERY_IVL = 9
const ZMQ_SNDBUF = 11
const ZMQ_RCVBUF = 12
const ZMQ_RCVMORE = 13
const ZMQ_FD = 14
const ZMQ_EVENTS = 15
const ZMQ_TYPE = 16
const ZMQ_LINGER = 17
const ZMQ_RECONNECT_IVL = 18
const ZMQ_BACKLOG = 19
const ZMQ_RECONNECT_IVL_MAX = 21
const ZMQ_MAXMSGSIZE = 22
const ZMQ_SNDHWM = 23
const ZMQ_RCVHWM = 24
const ZMQ_MULTICAST_HOPS = 25
const ZMQ_RCVTIMEO = 27
const ZMQ_SNDTIMEO = 28
const ZMQ_LAST_ENDPOINT = 32
const ZMQ_ROUTER_MANDATORY = 33
const ZMQ_TCP_KEEPALIVE = 34
const ZMQ_TCP_KEEPALIVE_CNT = 35
const ZMQ_TCP_KEEPALIVE_IDLE = 36
const ZMQ_TCP_KEEPALIVE_INTVL = 37
const ZMQ_IMMEDIATE = 39
const ZMQ_XPUB_VERBOSE = 40
const ZMQ_ROUTER_RAW = 41
const ZMQ_IPV6 = 42
const ZMQ_MECHANISM = 43
const ZMQ_PLAIN_SERVER = 44
const ZMQ_PLAIN_USERNAME = 45
const ZMQ_PLAIN_PASSWORD = 46
const ZMQ_CURVE_SERVER = 47
const ZMQ_CURVE_PUBLICKEY = 48
const ZMQ_CURVE_SECRETKEY = 49
const ZMQ_CURVE_SERVERKEY = 50
const ZMQ_PROBE_ROUTER = 51
const ZMQ_REQ_CORRELATE = 52
const ZMQ_REQ_RELAXED = 53
const ZMQ_CONFLATE = 54
const ZMQ_ZAP_DOMAIN = 55
const ZMQ_ROUTER_HANDOVER = 56
const ZMQ_TOS = 57
const ZMQ_CONNECT_RID = 61
const ZMQ_GSSAPI_SERVER = 62
const ZMQ_GSSAPI_PRINCIPAL = 63
const ZMQ_GSSAPI_SERVICE_PRINCIPAL = 64
const ZMQ_GSSAPI_PLAINTEXT = 65
const ZMQ_HANDSHAKE_IVL = 66
const ZMQ_SOCKS_PROXY = 68
const ZMQ_XPUB_NODROP = 69
const ZMQ_MORE = 1
const ZMQ_SRCFD = 2
const ZMQ_SHARED = 3
const ZMQ_DONTWAIT = 1
const ZMQ_SNDMORE = 2
const ZMQ_NULL = 0
const ZMQ_PLAIN = 1
const ZMQ_CURVE = 2
const ZMQ_GSSAPI = 3
const ZMQ_TCP_ACCEPT_FILTER = 38
const ZMQ_IPC_FILTER_PID = 58
const ZMQ_IPC_FILTER_UID = 59
const ZMQ_IPC_FILTER_GID = 60
const ZMQ_IPV4ONLY = 31
const ZMQ_DELAY_ATTACH_ON_CONNECT = ZMQ_IMMEDIATE
const ZMQ_NOBLOCK = ZMQ_DONTWAIT
const ZMQ_FAIL_UNROUTABLE = ZMQ_ROUTER_MANDATORY
const ZMQ_ROUTER_BEHAVIOR = ZMQ_ROUTER_MANDATORY
const ZMQ_EVENT_CONNECTED = &h0001
const ZMQ_EVENT_CONNECT_DELAYED = &h0002
const ZMQ_EVENT_CONNECT_RETRIED = &h0004
const ZMQ_EVENT_LISTENING = &h0008
const ZMQ_EVENT_BIND_FAILED = &h0010
const ZMQ_EVENT_ACCEPTED = &h0020
const ZMQ_EVENT_ACCEPT_FAILED = &h0040
const ZMQ_EVENT_CLOSED = &h0080
const ZMQ_EVENT_CLOSE_FAILED = &h0100
const ZMQ_EVENT_DISCONNECTED = &h0200
const ZMQ_EVENT_MONITOR_STOPPED = &h0400
const ZMQ_EVENT_ALL = &hFFFF

declare function zmq_socket(byval as any ptr, byval type as long) as any ptr
declare function zmq_close(byval s as any ptr) as long
declare function zmq_setsockopt(byval s as any ptr, byval option as long, byval optval as const any ptr, byval optvallen as uinteger) as long
declare function zmq_getsockopt(byval s as any ptr, byval option as long, byval optval as any ptr, byval optvallen as uinteger ptr) as long
declare function zmq_bind(byval s as any ptr, byval addr as const zstring ptr) as long
declare function zmq_connect(byval s as any ptr, byval addr as const zstring ptr) as long
declare function zmq_unbind(byval s as any ptr, byval addr as const zstring ptr) as long
declare function zmq_disconnect(byval s as any ptr, byval addr as const zstring ptr) as long
declare function zmq_send(byval s as any ptr, byval buf as const any ptr, byval len as uinteger, byval flags as long) as long
declare function zmq_send_const(byval s as any ptr, byval buf as const any ptr, byval len as uinteger, byval flags as long) as long
declare function zmq_recv(byval s as any ptr, byval buf as any ptr, byval len as uinteger, byval flags as long) as long
declare function zmq_socket_monitor(byval s as any ptr, byval addr as const zstring ptr, byval events as long) as long

const ZMQ_POLLIN = 1
const ZMQ_POLLOUT = 2
const ZMQ_POLLERR = 4

type zmq_pollitem_t
	socket as any ptr

	#ifdef __FB_WIN32__
		fd as SOCKET
	#else
		fd as long
	#endif

	events as short
	revents as short
end type

const ZMQ_POLLITEMS_DFLT = 16
declare function zmq_poll(byval items as zmq_pollitem_t ptr, byval nitems as long, byval timeout as clong) as long
declare function zmq_proxy(byval frontend as any ptr, byval backend as any ptr, byval capture as any ptr) as long
declare function zmq_proxy_steerable(byval frontend as any ptr, byval backend as any ptr, byval capture as any ptr, byval control as any ptr) as long
const ZMQ_HAS_CAPABILITIES = 1
declare function zmq_has(byval capability as const zstring ptr) as long

const ZMQ_STREAMER = 1
const ZMQ_FORWARDER = 2
const ZMQ_QUEUE = 3

declare function zmq_device(byval type as long, byval frontend as any ptr, byval backend as any ptr) as long
declare function zmq_sendmsg(byval s as any ptr, byval msg as zmq_msg_t ptr, byval flags as long) as long
declare function zmq_recvmsg(byval s as any ptr, byval msg as zmq_msg_t ptr, byval flags as long) as long
declare function zmq_z85_encode(byval dest as zstring ptr, byval data as const ubyte ptr, byval size as uinteger) as zstring ptr
declare function zmq_z85_decode(byval dest as ubyte ptr, byval string as const zstring ptr) as ubyte ptr
declare function zmq_curve_keypair(byval z85_public_key as zstring ptr, byval z85_secret_key as zstring ptr) as long
declare function zmq_sendiov(byval s as any ptr, byval iov as iovec ptr, byval count as uinteger, byval flags as long) as long
declare function zmq_recviov(byval s as any ptr, byval iov as iovec ptr, byval count as uinteger ptr, byval flags as long) as long
declare function zmq_stopwatch_start() as any ptr
declare function zmq_stopwatch_stop(byval watch_ as any ptr) as culong
declare sub zmq_sleep(byval seconds_ as long)
declare function zmq_threadstart(byval func as sub(byval as any ptr), byval arg as any ptr) as any ptr
declare sub zmq_threadclose(byval thread as any ptr)

end extern
