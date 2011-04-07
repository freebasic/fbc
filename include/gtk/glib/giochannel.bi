''
''
'' giochannel -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __giochannel_bi__
#define __giochannel_bi__

#include once "gconvert.bi"
#include once "gmain.bi"
#include once "gstring.bi"

type GIOChannel as _GIOChannel
type GIOFuncs as _GIOFuncs

enum GIOError
	G_IO_ERROR_NONE
	G_IO_ERROR_AGAIN
	G_IO_ERROR_INVAL
	G_IO_ERROR_UNKNOWN
end enum


enum GIOChannelError
	G_IO_CHANNEL_ERROR_FBIG
	G_IO_CHANNEL_ERROR_INVAL
	G_IO_CHANNEL_ERROR_IO
	G_IO_CHANNEL_ERROR_ISDIR
	G_IO_CHANNEL_ERROR_NOSPC
	G_IO_CHANNEL_ERROR_NXIO
	G_IO_CHANNEL_ERROR_OVERFLOW
	G_IO_CHANNEL_ERROR_PIPE
	G_IO_CHANNEL_ERROR_FAILED
end enum


enum GIOStatus
	G_IO_STATUS_ERROR
	G_IO_STATUS_NORMAL
	G_IO_STATUS_EOF
	G_IO_STATUS_AGAIN
end enum


enum GSeekType
	G_SEEK_CUR
	G_SEEK_SET
	G_SEEK_END
end enum


enum GIOCondition
	G_IO_IN = 1
	G_IO_OUT = 4
	G_IO_PRI = 2
	G_IO_ERR = 8
	G_IO_HUP = 16
	G_IO_NVAL = 32
end enum


enum GIOFlags
	G_IO_FLAG_APPEND = 1 shl 0
	G_IO_FLAG_NONBLOCK = 1 shl 1
	G_IO_FLAG_IS_READABLE = 1 shl 2
	G_IO_FLAG_IS_WRITEABLE = 1 shl 3
	G_IO_FLAG_IS_SEEKABLE = 1 shl 4
	G_IO_FLAG_MASK = (1 shl 5) -1
	G_IO_FLAG_GET_MASK = G_IO_FLAG_MASK
	G_IO_FLAG_SET_MASK = G_IO_FLAG_APPEND or G_IO_FLAG_NONBLOCK
end enum


type _GIOChannel
	ref_count as guint
	funcs as GIOFuncs ptr
	encoding as zstring ptr
	read_cd as GIConv
	write_cd as GIConv
	line_term as zstring ptr
	line_term_len as guint
	buf_size as gsize
	read_buf as GString ptr
	encoded_read_buf as GString ptr
	write_buf as GString ptr
	partial_write_buf as zstring * 6
	use_buffer:1 as guint
	do_encode:1 as guint
	close_on_unref:1 as guint
	is_readable:1 as guint
	is_writeable:1 as guint
	is_seekable:1 as guint
	reserved1 as gpointer
	reserved2 as gpointer
end type

type GIOFunc as function cdecl(byval as GIOChannel ptr, byval as GIOCondition, byval as gpointer) as gboolean

type _GIOFuncs
	io_read as function cdecl(byval as GIOChannel ptr, byval as zstring ptr, byval as gsize, byval as gsize ptr, byval as GError ptr ptr) as GIOStatus
	io_write as function cdecl(byval as GIOChannel ptr, byval as zstring ptr, byval as gsize, byval as gsize ptr, byval as GError ptr ptr) as GIOStatus
	io_seek as function cdecl(byval as GIOChannel ptr, byval as gint64, byval as GSeekType, byval as GError ptr ptr) as GIOStatus
	io_close as function cdecl(byval as GIOChannel ptr, byval as GError ptr ptr) as GIOStatus
	io_create_watch as function cdecl(byval as GIOChannel ptr, byval as GIOCondition) as GSource
	io_free as sub cdecl(byval as GIOChannel ptr)
	io_set_flags as function cdecl(byval as GIOChannel ptr, byval as GIOFlags, byval as GError ptr ptr) as GIOStatus
	io_get_flags as function cdecl(byval as GIOChannel ptr) as GIOFlags
end type

declare sub g_io_channel_init (byval channel as GIOChannel ptr)
declare function g_io_channel_ref (byval channel as GIOChannel ptr) as GIOChannel ptr
declare sub g_io_channel_unref (byval channel as GIOChannel ptr)
declare function g_io_channel_read (byval channel as GIOChannel ptr, byval buf as zstring ptr, byval count as gsize, byval bytes_read as gsize ptr) as GIOError
declare function g_io_channel_write (byval channel as GIOChannel ptr, byval buf as zstring ptr, byval count as gsize, byval bytes_written as gsize ptr) as GIOError
declare function g_io_channel_seek (byval channel as GIOChannel ptr, byval offset as gint64, byval type as GSeekType) as GIOError
declare sub g_io_channel_close (byval channel as GIOChannel ptr)
declare function g_io_channel_shutdown (byval channel as GIOChannel ptr, byval flush as gboolean, byval err as GError ptr ptr) as GIOStatus
declare function g_io_add_watch_full (byval channel as GIOChannel ptr, byval priority as gint, byval condition as GIOCondition, byval func as GIOFunc, byval user_data as gpointer, byval notify as GDestroyNotify) as guint
declare function g_io_create_watch (byval channel as GIOChannel ptr, byval condition as GIOCondition) as GSource ptr
declare function g_io_add_watch (byval channel as GIOChannel ptr, byval condition as GIOCondition, byval func as GIOFunc, byval user_data as gpointer) as guint
declare sub g_io_channel_set_buffer_size (byval channel as GIOChannel ptr, byval size as gsize)
declare function g_io_channel_get_buffer_size (byval channel as GIOChannel ptr) as gsize
declare function g_io_channel_get_buffer_condition (byval channel as GIOChannel ptr) as GIOCondition
declare function g_io_channel_set_flags (byval channel as GIOChannel ptr, byval flags as GIOFlags, byval error as GError ptr ptr) as GIOStatus
declare function g_io_channel_get_flags (byval channel as GIOChannel ptr) as GIOFlags
declare sub g_io_channel_set_line_term (byval channel as GIOChannel ptr, byval line_term as zstring ptr, byval length as gint)
declare function g_io_channel_get_line_term (byval channel as GIOChannel ptr, byval length as gint ptr) as zstring ptr
declare sub g_io_channel_set_buffered (byval channel as GIOChannel ptr, byval buffered as gboolean)
declare function g_io_channel_get_buffered (byval channel as GIOChannel ptr) as gboolean
declare function g_io_channel_set_encoding (byval channel as GIOChannel ptr, byval encoding as zstring ptr, byval error as GError ptr ptr) as GIOStatus
declare function g_io_channel_get_encoding (byval channel as GIOChannel ptr) as zstring ptr
declare sub g_io_channel_set_close_on_unref (byval channel as GIOChannel ptr, byval do_close as gboolean)
declare function g_io_channel_get_close_on_unref (byval channel as GIOChannel ptr) as gboolean
declare function g_io_channel_flush (byval channel as GIOChannel ptr, byval error as GError ptr ptr) as GIOStatus
declare function g_io_channel_read_line (byval channel as GIOChannel ptr, byval str_return as zstring ptr ptr, byval length as gsize ptr, byval terminator_pos as gsize ptr, byval error as GError ptr ptr) as GIOStatus
declare function g_io_channel_read_line_string (byval channel as GIOChannel ptr, byval buffer as GString ptr, byval terminator_pos as gsize ptr, byval error as GError ptr ptr) as GIOStatus
declare function g_io_channel_read_to_end (byval channel as GIOChannel ptr, byval str_return as zstring ptr ptr, byval length as gsize ptr, byval error as GError ptr ptr) as GIOStatus
declare function g_io_channel_read_chars (byval channel as GIOChannel ptr, byval buf as zstring ptr, byval count as gsize, byval bytes_read as gsize ptr, byval error as GError ptr ptr) as GIOStatus
declare function g_io_channel_read_unichar (byval channel as GIOChannel ptr, byval thechar as gunichar ptr, byval error as GError ptr ptr) as GIOStatus
declare function g_io_channel_write_chars (byval channel as GIOChannel ptr, byval buf as zstring ptr, byval count as gssize, byval bytes_written as gsize ptr, byval error as GError ptr ptr) as GIOStatus
declare function g_io_channel_write_unichar (byval channel as GIOChannel ptr, byval thechar as gunichar, byval error as GError ptr ptr) as GIOStatus
declare function g_io_channel_seek_position (byval channel as GIOChannel ptr, byval offset as gint64, byval type as GSeekType, byval error as GError ptr ptr) as GIOStatus
declare function g_io_channel_new_file_utf8 (byval filename as zstring ptr, byval mode as zstring ptr, byval error as GError ptr ptr) as GIOChannel ptr
declare function g_io_channel_error_quark () as GQuark
declare function g_io_channel_error_from_errno (byval en as gint) as GIOChannelError
declare function g_io_channel_unix_new (byval fd as integer) as GIOChannel ptr
declare function g_io_channel_unix_get_fd (byval channel as GIOChannel ptr) as gint

#define G_WIN32_MSG_HANDLE 19981206

declare sub g_io_channel_win32_make_pollfd (byval channel as GIOChannel ptr, byval condition as GIOCondition, byval fd as GPollFD ptr)
declare function g_io_channel_win32_poll (byval fds as GPollFD ptr, byval n_fds as gint, byval timeout_ as gint) as gint
declare function g_io_channel_win32_new_messages (byval hwnd as guint) as GIOChannel ptr
declare function g_io_channel_win32_new_fd (byval fd as gint) as GIOChannel ptr
declare function g_io_channel_win32_get_fd (byval channel as GIOChannel ptr) as gint
declare function g_io_channel_win32_new_socket (byval socket as gint) as GIOChannel ptr

#endif
