'   Public API for GNU gettext PO files - contained in libgettextpo.
'   Copyright (C) 2003-2007 Free Software Foundation, Inc.
'   Written by Bruno Haible <bruno@clisp.org>, 2003.
'
'   This program is free software: you can redistribute it and/or modify
'   it under the terms of the GNU General Public License as published by
'   the Free Software Foundation; either version 3 of the License, or
'   (at your option) any later version.
'
'   This program is distributed in the hope that it will be useful,
'   but WITHOUT ANY WARRANTY; without even the implied warranty of
'   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'   GNU General Public License for more details.
'
'   You should have received a copy of the GNU General Public License
'   along with this program.  If not, see <http://www.gnu.org/licenses/>.

#ifndef __gettext_po_bi__
#define __gettext_po_bi__

#define _GETTEXT_PO_H 1
#define LIBGETTEXTPO_VERSION &h001100
extern libgettextpo_version alias "libgettextpo_version" as integer

'/* A po_file_t represents the contents of a PO file.  */
type po_file_t as po_file ptr

'/* A po_message_iterator_t represents an iterator through a domain of a
'   PO file.  */
type po_message_iterator_t as po_message_iterator ptr

'/* A po_message_t represents a message in a PO file.  */
type po_message_t as po_message ptr

'/* A po_filepos_t represents a string's position within a source file.  */
type po_filepos_t as po_filepos ptr

'/* A po_error_handler handles error situations.  */
type po_error_handler

  '/* Signal an error.  The error message is built from FORMAT and the following
   '  arguments.  ERRNUM, if nonzero, is an errno value.
    ' Must increment the error_message_count variable declared in error.h.
     'Must not return if STATUS is nonzero.  */
	error_ as sub cdecl(byval as integer, byval as integer, byval as const zstring ptr, ...)

  '/* Signal an error.  The error message is built from FORMAT and the following
   '  arguments.  The error location is at FILENAME line LINENO. ERRNUM, if
  '   nonzero, is an errno value.
  '   Must increment the error_message_count variable declared in error.h.
  '   Must not return if STATUS is nonzero.  */
    error_at_line as sub cdecl(byval as integer, byval as integer, byval as const zstring ptr, byval as uinteger, byval as const zstring ptr, ...)

  '/* Signal a multiline warning.  The PREFIX applies to all lines of the
   '  MESSAGE.  Free the PREFIX and MESSAGE when done.  */
	multiline_warning as sub cdecl(byval as zstring ptr, byval as zstring ptr)

	'  /* Signal a multiline error.  The PREFIX applies to all lines of the
    ' MESSAGE.  Free the PREFIX and MESSAGE when done.
    ' Must increment the error_message_count variable declared in error.h if
    ' PREFIX is non-NULL.  */
	multiline_error as sub cdecl(byval as zstring ptr, byval as zstring ptr)
end type

type po_error_handler_t as po_error_handler ptr

'/* A po_xerror_handler handles warnings, error and fatal error situations.  */
#define PO_SEVERITY_WARNING 0 '/* just a warning, tell the user */
#define PO_SEVERITY_ERROR 1 '/* an error, the operation cannot complete */
#define PO_SEVERITY_FATAL_ERROR 2 '/* an error, the operation must be aborted */

type po_xerror_handler

  '/* Signal a problem of the given severity.
   '  MESSAGE and/or FILENAME + LINENO indicate where the problem occurred.
   '  If FILENAME is NULL, FILENAME and LINENO and COLUMN should be ignored.
   '  If LINENO is (size_t)(-1), LINENO and COLUMN should be ignored.
   '  If COLUMN is (size_t)(-1), it should be ignored.
   '  MESSAGE_TEXT is the problem description (if MULTILINE_P is true,
   '  multiple lines of text, each terminated with a newline, otherwise
   '  usually a single line).
   '  Must not return if SEVERITY is PO_SEVERITY_FATAL_ERROR.  */
	xerror as sub cdecl(byval as integer, byval as po_message_t, byval as const zstring ptr, byval as size_t, byval as size_t, byval as integer, byval as const zstring ptr)

	'  /* Signal a problem that refers to two messages.
     'Similar to two calls to xerror.
    ' If possible, a "..." can be appended to MESSAGE_TEXT1 and prepended to
    ' MESSAGE_TEXT2.  */
	xerror2 as sub cdecl(byval as integer, byval as po_message_t, byval as const zstring ptr, byval as size_t, byval as size_t, byval as integer, byval as const zstring ptr, byval as po_message_t, byval as const zstring ptr, byval as size_t, byval as size_t, byval as integer, byval as const zstring ptr)
end type

type po_xerror_handler_t as po_xerror_handler ptr

'/* Memory allocation:
'   The memory allocations performed by these functions use xmalloc(),
'   therefore will cause a program exit if memory is exhausted.
'   The memory allocated by po_file_read, and implicitly returned through
'   the po_message_* functions, lasts until freed with po_file_free.  */


'/* ============================= po_file_t API ============================= */

'/* Create an empty PO file representation in memory.  */
declare function po_file_create cdecl alias "po_file_create" () as po_file_t

'/* Read a PO file into memory.
'   Return its contents.  Upon failure, return NULL and set errno.  */
declare function po_file_read cdecl alias "po_file_read_v3" (byval filename as const zstring ptr, byval handler as po_xerror_handler_t) as po_file_t

'/* Write an in-memory PO file to a file.
'   Upon failure, return NULL and set errno.  */
declare function po_file_write cdecl alias "po_file_write_v2" (byval file as po_file_t, byval filename as const zstring ptr, byval handler as po_xerror_handler_t) as po_file_t

'/* Free a PO file from memory.  */
declare sub po_file_free cdecl alias "po_file_free" (byval file as po_file_t)

'/* Return the names of the domains covered by a PO file in memory.  */
declare function po_file_domains cdecl alias "po_file_domains" (byval file as po_file_t) as byte ptr ptr

'/* =========================== Header entry API ============================ */

'/* Return the header entry of a domain of a PO file in memory.
'   The domain NULL denotes the default domain.
'   Return NULL if there is no header entry.  */
declare function po_file_domain_header cdecl alias "po_file_domain_header" (byval file as po_file_t, byval domain as const zstring ptr) as const zstring ptr

'/* Return the value of a field in a header entry.
'   The return value is either a freshly allocated string, to be freed by the
'   caller, or NULL.  */
declare function po_header_field cdecl alias "po_header_field" (byval header as const zstring ptr, byval field as const zstring ptr) as zstring ptr

'/* Return the header entry with a given field set to a given value.  The field
'   is added if necessary.
'   The return value is a freshly allocated string.  */
declare function po_header_set_field cdecl alias "po_header_set_field" (byval header as const zstring ptr, byval field as const zstring ptr, byval value as const zstring ptr) as zstring ptr

'/* ======================= po_message_iterator_t API ======================= */

'/* Create an iterator for traversing a domain of a PO file in memory.
'   The domain NULL denotes the default domain.  */
declare function po_message_iterator cdecl alias "po_message_iterator" (byval file as po_file_t, byval domain as const zstring ptr) as po_message_iterator_t

'/* Free an iterator.  */
declare sub po_message_iterator_free cdecl alias "po_message_iterator_free" (byval iterator as po_message_iterator_t)

'/* Return the next message, and advance the iterator.
'   Return NULL at the end of the message list.  */
declare function po_next_message cdecl alias "po_next_message" (byval iterator as po_message_iterator_t) as po_message_t

'/* Insert a message in a PO file in memory, in the domain and at the position
'   indicated by the iterator.  The iterator thereby advances past the freshly
'   inserted message.  */
declare sub po_message_insert cdecl alias "po_message_insert" (byval iterator as po_message_iterator_t, byval message as po_message_t)


'/* =========================== po_message_t API ============================ */

'/* Return a freshly constructed message.
'   To finish initializing the message, you must set the msgid and msgstr.  */
declare function po_message_create cdecl alias "po_message_create" () as po_message_t

'/* Return the context of a message, or NULL for a message not restricted to a
'   context.  */
declare function po_message_msgctxt cdecl alias "po_message_msgctxt" (byval message as po_message_t) as const zstring ptr

'/* Change the context of a message. NULL means a message not restricted to a
'   context.  */
declare sub po_message_set_msgctxt cdecl alias "po_message_set_msgctxt" (byval message as po_message_t, byval msgctxt as const zstring ptr)

'/* Return the msgid (untranslated English string) of a message.  */
declare function po_message_msgid cdecl alias "po_message_msgid" (byval message as po_message_t) as const zstring ptr

'/* Change the msgid (untranslated English string) of a message.  */
declare sub po_message_set_msgid cdecl alias "po_message_set_msgid" (byval message as po_message_t, byval msgid as const zstring ptr)

'/* Return the msgid_plural (untranslated English plural string) of a message,
'   or NULL for a message without plural.  */
declare function po_message_msgid_plural cdecl alias "po_message_msgid_plural" (byval message as po_message_t) as const zstring ptr

'/* Change the msgid_plural (untranslated English plural string) of a message.
'   NULL means a message without plural.  */
declare sub po_message_set_msgid_plural cdecl alias "po_message_set_msgid_plural" (byval message as po_message_t, byval msgid_plural as const zstring ptr)

'/* Return the msgstr (translation) of a message.
'   Return the empty string for an untranslated message.  */
declare function po_message_msgstr cdecl alias "po_message_msgstr" (byval message as po_message_t) as const zstring ptr

'/* Change the msgstr (translation) of a message.
'   Use an empty string to denote an untranslated message.  */
declare sub po_message_set_msgstr cdecl alias "po_message_set_msgstr" (byval message as po_message_t, byval msgstr as const zstring ptr)

'/* Return the msgstr[index] for a message with plural handling, or
'   NULL when the index is out of range or for a message without plural.  */
declare function po_message_msgstr_plural cdecl alias "po_message_msgstr_plural" (byval message as po_message_t, byval index as integer) as const zstring ptr

'/* Change the msgstr[index] for a message with plural handling.
'   Use a NULL value at the end to reduce the number of plural forms.  */
declare sub po_message_set_msgstr_plural cdecl alias "po_message_set_msgstr_plural" (byval message as po_message_t, byval index as integer, byval msgstr as const zstring ptr)

'/* Return the comments for a message.  */
declare function po_message_comments cdecl alias "po_message_comments" (byval message as po_message_t) as const zstring ptr

'/* Change the comments for a message.
'   comments should be a multiline string, ending in a newline, or empty.  */
declare sub po_message_set_comments cdecl alias "po_message_set_comments" (byval message as po_message_t, byval comments as const zstring ptr)

'/* Return the extracted comments for a message.  */
declare function po_message_extracted_comments cdecl alias "po_message_extracted_comments" (byval message as po_message_t) as const zstring ptr

'/* Change the extracted comments for a message.
'   comments should be a multiline string, ending in a newline, or empty.  */
declare sub po_message_set_extracted_comments cdecl alias "po_message_set_extracted_comments" (byval message as po_message_t, byval comments as const zstring ptr)

'/* Return the i-th file position for a message, or NULL if i is out of
'   range.  */
declare function po_message_filepos cdecl alias "po_message_filepos" (byval message as po_message_t, byval i as integer) as po_filepos_t

'/* Remove the i-th file position from a message.
'   The indices of all following file positions for the message are decremented
'   by one.  */
declare sub po_message_remove_filepos cdecl alias "po_message_remove_filepos" (byval message as po_message_t, byval i as integer)

'/* Add a file position to a message, if it is not already present for the
'   message.
'   file is the file name.
'   start_line is the line number where the string starts, or (size_t)(-1) if no
'   line number is available.  */
declare sub po_message_add_filepos cdecl alias "po_message_add_filepos" (byval message as po_message_t, byval file as const zstring ptr, byval start_line as size_t)

'/* Return the previous context of a message, or NULL for none.  */
declare function po_message_prev_msgctxt cdecl alias "po_message_prev_msgctxt" (byval message as po_message_t) as const zstring ptr

'/* Change the previous context of a message.  NULL is allowed.  */
declare sub po_message_set_prev_msgctxt cdecl alias "po_message_set_prev_msgctxt" (byval message as po_message_t, byval prev_msgctxt as const zstring ptr)

'/* Return the previous msgid (untranslated English string) of a message, or
'   NULL for none.  */
declare function po_message_prev_msgid cdecl alias "po_message_prev_msgid" (byval message as po_message_t) as const zstring ptr

'/* Change the previous msgid (untranslated English string) of a message.
'   NULL is allowed.  */
declare sub po_message_set_prev_msgid cdecl alias "po_message_set_prev_msgid" (byval message as po_message_t, byval prev_msgid as const zstring ptr)

'/* Return the previous msgid_plural (untranslated English plural string) of a
'   message, or NULL for none.  */
declare function po_message_prev_msgid_plural cdecl alias "po_message_prev_msgid_plural" (byval message as po_message_t) as const zstring ptr

'/* Change the previous msgid_plural (untranslated English plural string) of a
'   message.  NULL is allowed.  */
declare sub po_message_set_prev_msgid_plural cdecl alias "po_message_set_prev_msgid_plural" (byval message as po_message_t, byval prev_msgid_plural as const zstring ptr)

'/* Return true if the message is marked obsolete.  */
declare function po_message_is_obsolete cdecl alias "po_message_is_obsolete" (byval message as po_message_t) as integer

'/* Change the obsolete mark of a message.  */
declare sub po_message_set_obsolete cdecl alias "po_message_set_obsolete" (byval message as po_message_t, byval obsolete as integer)

'/* Return true if the message is marked fuzzy.  */
declare function po_message_is_fuzzy cdecl alias "po_message_is_fuzzy" (byval message as po_message_t) as integer

'/* Change the fuzzy mark of a message.  */
declare sub po_message_set_fuzzy cdecl alias "po_message_set_fuzzy" (byval message as po_message_t, byval fuzzy as integer)

'/* Return true if the message is marked as being a format string of the given
'   type (e.g. "c-format").  */
declare function po_message_is_format cdecl alias "po_message_is_format" (byval message as po_message_t, byval format_type as const zstring ptr) as integer

'/* Change the format string mark for a given type of a message.  */
declare sub po_message_set_format cdecl alias "po_message_set_format" (byval message as po_message_t, byval format_type as const zstring ptr, byval value as integer)


'/* =========================== po_filepos_t API ============================ */

'/* Return the file name.  */
declare function po_filepos_file cdecl alias "po_filepos_file" (byval filepos as po_filepos_t) as const zstring ptr

'/* Return the line number where the string starts, or (size_t)(-1) if no line
'   number is available.  */
declare function po_filepos_start_line cdecl alias "po_filepos_start_line" (byval filepos as po_filepos_t) as size_t


'/* ============================ Format type API ============================= */

'/* Return a NULL terminated array of the supported format types.  */
declare function po_format_list cdecl alias "po_format_list" () as const zstring ptr const ptr

'/* Return the pretty name associated with a format type.
'   For example, for "csharp-format", return "C#".
'   Return NULL if the argument is not a supported format type.  */
declare function po_format_pretty_name cdecl alias "po_format_pretty_name" (byval format_type as const zstring ptr) as const zstring ptr


'/* ============================= Checking API ============================== */

'/* Test whether an entire file PO file is valid, like msgfmt does it.
'   If it is invalid, pass the reasons to the handler.  */
declare sub po_file_check_all cdecl alias "po_file_check_all" (byval file as po_file_t, byval handler as po_xerror_handler_t)

'/* Test a single message, to be inserted in a PO file in memory, like msgfmt
'   does it.  If it is invalid, pass the reasons to the handler.  The iterator
'   is not modified by this call; it only specifies the file and the domain.  */
declare sub po_message_check_all cdecl alias "po_message_check_all" (byval message as po_message_t, byval iterator as po_message_iterator_t, byval handler as po_xerror_handler_t)

'/* Test whether the message translation is a valid format string if the message
'   is marked as being a format string.  If it is invalid, pass the reasons to
'   the handler.  */
declare sub po_message_check_format cdecl alias "po_message_check_format_v2" (byval message as po_message_t, byval handler as po_xerror_handler_t)

#endif
