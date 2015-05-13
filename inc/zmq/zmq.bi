/'
    0MQ is a software library that lets you quickly design and
    implement a fast message-based application.

    http://www.zeromq.org

    FreeBASIC header translated by Ebben Feagan <sir@mud.owlbox.net>
    Based on version 2.1.10 

    Copyright (c) 2007-2011 iMatix Corporation
    Copyright (c) 2007-2011 Other contributors as noted in the AUTHORS file (distributed with 0mq)

    This file is part of 0MQ.

    0MQ is free software; you can redistribute it and/or modify it under
    the terms of the Lesser GNU General Public License as published by
    the Free Software Foundation; either version 3 of the License, or
    (at your option) any later version.

    0MQ is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    Lesser GNU General Public License for more details.

    You should have received a copy of the Lesser GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
'/

#ifndef __ZMQ_BI_INCLUDED__
#define __ZMQ_BI_INCLUDED__

#inclib "zmq"

extern "C"

#include once "crt/errno.bi"
#include once "crt/stddef.bi"
#ifdef __FB_WIN32__
#include once "windows/winsock2.bi"
#endif

'/******************************************************************************/
'/*  0MQ versioning support.                                                    */
'/******************************************************************************/
#define ZMQ_VERSION_MAJOR 2
#define ZMQ_VERSION_MINOR 1
#define ZMQ_VERSION_PATCH 10

#define ZMQ_MAKE_VERSION(major, minor, patch) ((major) * 10000 + (minor) * 100 + (patch))
#define ZMQ_VERSION_ ZMQ_MAKE_VERSION(ZMQ_VERSION_MAJOR, ZMQ_VERSION_MINOR, ZMQ_VERSION_PATCH)

declare sub zmq_version ( byval major as integer ptr, byval minor as integer ptr, byval patch as integer ptr)

'/******************************************************************************/
'//  0MQ errors.
'/******************************************************************************/

'/*  A number random anough not to collide with different errno ranges on      */
'/*  different OSes. The assumption is that error_t is at least 32-bit type.   */
#define ZMQ_HAUSNUMERO 156384712

'/*  On Windows platform some of the standard POSIX errnos are not defined.    */
#ifndef ENOTSUP
#define ENOTSUP (ZMQ_HAUSNUMERO + 1)
#endif
#ifndef EPROTONOSUPPORT
#define EPROTONOSUPPORT (ZMQ_HAUSNUMERO + 2)
#endif
#ifndef ENOBUFS
#define ENOBUFS (ZMQ_HAUSNUMERO + 3)
#endif
#ifndef ENETDOWN
#define ENETDOWN (ZMQ_HAUSNUMERO + 4)
#endif
#ifndef EADDRINUSE
#define EADDRINUSE (ZMQ_HAUSNUMERO + 5)
#endif
#ifndef EADDRNOTAVAIL
#define EADDRNOTAVAIL (ZMQ_HAUSNUMERO + 6)
#endif
#ifndef ECONNREFUSED
#define ECONNREFUSED (ZMQ_HAUSNUMERO + 7)
#endif
#ifndef EINPROGRESS
#define EINPROGRESS (ZMQ_HAUSNUMERO + 8)
#endif
#ifndef ENOTSOCK
#define ENOTSOCK (ZMQ_HAUSNUMERO + 9)
#endif

'/*  Native 0MQ error codes.                                                   */
#define EMTHREAD (ZMQ_HAUSNUMERO + 50)
#define EFSM (ZMQ_HAUSNUMERO + 51)
#define ENOCOMPATPROTO (ZMQ_HAUSNUMERO + 52)
#define ETERM (ZMQ_HAUSNUMERO + 53)

'/*  This function retrieves the errno as it is known to 0MQ library. The goal */
'/*  of this function is to make the code 100% portable, including where 0MQ   */
'/*  compiled with certain CRT library (on Windows) is linked to an            */
'/*  application that uses different CRT library.                              */
declare function zmq_errno () as integer

'/*  Resolves system errors and 0MQ errors to human-readable string.           */
declare function zmq_strerror ( byval errnum as integer ) as const zstring ptr

'/******************************************************************************/
'/*  0MQ message definition.                                                   */
'/******************************************************************************/

'/*  Maximal size of "Very Small Message". VSMs are passed by value            */
'/*  to avoid excessive memory allocation/deallocation.                        */
'/*  If VMSs larger than 255 bytes are required, type of 'vsm_size'            */
'/*  field in zmq_msg_t structure should be modified accordingly.              */
#define ZMQ_MAX_VSM_SIZE 30

'/*  Message types. These integers may be stored in 'content' member of the    */
'/*  message instead of regular pointer to the data.                           */
#define ZMQ_DELIMITER 31
#define ZMQ_VSM 32

'/*  Message flags. ZMQ_MSG_SHARED is strictly speaking not a message flag     */
'/*  (it has no equivalent in the wire format), however, making  it a flag     */
'/*  allows us to pack the stucture tigher and thus improve performance.       */
#define ZMQ_MSG_MORE 1
#define ZMQ_MSG_SHARED 128

'/*  A message. Note that 'content' is not a pointer to the raw data.          */
'/*  Rather it is pointer to zmq::msg_content_t structure                      */
'/*  (see src/msg_content.hpp for its definition).                             */
type zmq_msg_t
    content as any ptr
    flags as ubyte
    vsm_size as ubyte
    as ubyte vsm_data (ZMQ_MAX_VSM_SIZE)
end type

type zmq_free_fn as sub cdecl ( byval data_ as any ptr, byval hint as any ptr )

declare function zmq_msg_init ( byval msg as zmq_msg_t ptr ) as integer
declare function zmq_msg_init_size ( byval msg as zmq_msg_t ptr, byval size as size_t ) as integer
declare function zmq_msg_init_data ( byval msg as zmq_msg_t ptr, byval data_ as any ptr, _
    byval size as size_t, byval ffn as zmq_free_fn, byval hint as any ptr) as integer
declare function zmq_msg_close ( byval msg as zmq_msg_t ptr) as integer
declare function zmq_msg_move ( byval dest as zmq_msg_t ptr,  byval src as zmq_msg_t ptr) as integer
declare function zmq_msg_copy ( byval dest as zmq_msg_t ptr,  byval src as zmq_msg_t ptr) as integer
declare function zmq_msg_data ( byval msg as zmq_msg_t ptr) as any ptr
declare function zmq_msg_size ( byval msg as zmq_msg_t ptr) as size_t

'/******************************************************************************/
'/*  0MQ infrastructure (a.k.a. context) initialisation & termination.         */
'/******************************************************************************/

declare function zmq_init ( byval io_threads as integer ) as any ptr
declare function zmq_term ( byval context as any ptr ) as integer

'/******************************************************************************/
'/*  0MQ socket definition.                                                    */
'/******************************************************************************/

'/*  Socket types.                                                             */
#define ZMQ_PAIR 0
#define ZMQ_PUB 1
#define ZMQ_SUB 2
#define ZMQ_REQ 3
#define ZMQ_REP 4
#define ZMQ_DEALER 5
#define ZMQ_ROUTER 6
#define ZMQ_PULL 7
#define ZMQ_PUSH 8
#define ZMQ_XPUB 9
#define ZMQ_XSUB 10
#define ZMQ_XREQ ZMQ_DEALER        '/*  Old alias, remove in 3.x               */
#define ZMQ_XREP ZMQ_ROUTER        '/*  Old alias, remove in 3.x               */
#define ZMQ_UPSTREAM ZMQ_PULL      '/*  Old alias, remove in 3.x               */
#define ZMQ_DOWNSTREAM ZMQ_PUSH    '/*  Old alias, remove in 3.x               */

'/*  Socket options.                                                           */
#define ZMQ_HWM 1
#define ZMQ_SWAP 3
#define ZMQ_AFFINITY 4
#define ZMQ_IDENTITY 5
#define ZMQ_SUBSCRIBE 6
#define ZMQ_UNSUBSCRIBE 7
#define ZMQ_RATE 8
#define ZMQ_RECOVERY_IVL 9
#define ZMQ_MCAST_LOOP 10
#define ZMQ_SNDBUF 11
#define ZMQ_RCVBUF 12
#define ZMQ_RCVMORE 13
#define ZMQ_FD 14
#define ZMQ_EVENTS 15
#define ZMQ_TYPE 16
#define ZMQ_LINGER 17
#define ZMQ_RECONNECT_IVL 18
#define ZMQ_BACKLOG 19
#define ZMQ_RECOVERY_IVL_MSEC 20   /'  opt. recovery time, reconcile in 3.x   '/
#define ZMQ_RECONNECT_IVL_MAX 21

'/*  Send/recv options.                                                        */
#define ZMQ_NOBLOCK 1
#define ZMQ_SNDMORE 2

declare function zmq_socket ( byval context as any ptr, byval type_ as integer ) as any ptr
declare function zmq_close ( byval s as any ptr ) as integer
declare function zmq_setsockopt ( byval s as any ptr, byval option_ as integer, byval optval as const any ptr, _
    byval optvallen as size_t ) as integer
declare function zmq_getsockopt ( byval s as any ptr, byval option_ as integer, byval optval as void ptr, _
    optvallen as size_t ptr) as integer
declare function zmq_bind ( byval s as any ptr, byval addr as const zstring ptr ) as integer
declare function zmq_connect ( byval s as any ptr, byval addr as const zstring ptr ) as integer
declare function zmq_send ( byval s as any ptr, byval msg as zmq_msg_t ptr, byval flags as integer ) as integer
declare function zmq_recv ( byval s as any ptr, byval msg as zmq_msg_t ptr, byval flags as integer ) as integer

'/******************************************************************************/
'/*  I/O multiplexing.                                                         */
'/******************************************************************************/

#define ZMQ_POLLIN 1
#define ZMQ_POLLOUT 2
#define ZMQ_POLLERR 4

type zmq_pollitem_t
    as any ptr socket
#ifdef __FB_WIN32__
    as SOCKET fd
#else
    as integer fd
#endif
    as short events
    as short revents
end type

declare function zmq_poll ( byval items as zmq_pollitem_t ptr, byval nitems as integer, byval timeout as long ) as integer

'/******************************************************************************/
'/*  Devices - Experimental.                                                   */
'/******************************************************************************/

#define ZMQ_STREAMER 1
#define ZMQ_FORWARDER 2
#define ZMQ_QUEUE 3

declare function zmq_device ( byval device as integer, byval insocket as any ptr, byval outsocket as any ptr ) as integer

end extern

#endif
