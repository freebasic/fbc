'' FreeBASIC binding for postgresql-12.0
''
'' based on the C header files:
''   PostgreSQL Database Management System
''   (formerly known as Postgres, then as Postgres95)
''
''   Portions Copyright (c) 1996-2019, PostgreSQL Global Development Group
''
''   Portions Copyright (c) 1994, The Regents of the University of California
''
''   Permission to use, copy, modify, and distribute this software and its
''   documentation for any purpose, without fee, and without a written agreement
''   is hereby granted, provided that the above copyright notice and this
''   paragraph and the following two paragraphs appear in all copies.
''
''   IN NO EVENT SHALL THE UNIVERSITY OF CALIFORNIA BE LIABLE TO ANY PARTY FOR
''   DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING
''   LOST PROFITS, ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS
''   DOCUMENTATION, EVEN IF THE UNIVERSITY OF CALIFORNIA HAS BEEN ADVISED OF THE
''   POSSIBILITY OF SUCH DAMAGE.
''
''   THE UNIVERSITY OF CALIFORNIA SPECIFICALLY DISCLAIMS ANY WARRANTIES,
''   INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
''   AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS
''   ON AN "AS IS" BASIS, AND THE UNIVERSITY OF CALIFORNIA HAS NO OBLIGATIONS TO
''   PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
''
'' translated to FreeBASIC by:
''   Copyright © 2019 FreeBASIC development team

#pragma once

#inclib "pq"

#include once "crt/stdio.bi"
#include once "postgres_ext.bi"

extern "C"

#define LIBPQ_FE_H
const PG_COPYRES_ATTRS = &h01
const PG_COPYRES_TUPLES = &h02
const PG_COPYRES_EVENTS = &h04
const PG_COPYRES_NOTICEHOOKS = &h08

type ConnStatusType as long
enum
	CONNECTION_OK
	CONNECTION_BAD
	CONNECTION_STARTED
	CONNECTION_MADE
	CONNECTION_AWAITING_RESPONSE
	CONNECTION_AUTH_OK
	CONNECTION_SETENV
	CONNECTION_SSL_STARTUP
	CONNECTION_NEEDED
	CONNECTION_CHECK_WRITABLE
	CONNECTION_CONSUME
	CONNECTION_GSS_STARTUP
end enum

type PostgresPollingStatusType as long
enum
	PGRES_POLLING_FAILED = 0
	PGRES_POLLING_READING
	PGRES_POLLING_WRITING
	PGRES_POLLING_OK
	PGRES_POLLING_ACTIVE
end enum

type ExecStatusType as long
enum
	PGRES_EMPTY_QUERY = 0
	PGRES_COMMAND_OK
	PGRES_TUPLES_OK
	PGRES_COPY_OUT
	PGRES_COPY_IN
	PGRES_BAD_RESPONSE
	PGRES_NONFATAL_ERROR
	PGRES_FATAL_ERROR
	PGRES_COPY_BOTH
	PGRES_SINGLE_TUPLE
end enum

type PGTransactionStatusType as long
enum
	PQTRANS_IDLE
	PQTRANS_ACTIVE
	PQTRANS_INTRANS
	PQTRANS_INERROR
	PQTRANS_UNKNOWN
end enum

type PGVerbosity as long
enum
	PQERRORS_TERSE
	PQERRORS_DEFAULT
	PQERRORS_VERBOSE
	PQERRORS_SQLSTATE
end enum

type PGContextVisibility as long
enum
	PQSHOW_CONTEXT_NEVER
	PQSHOW_CONTEXT_ERRORS
	PQSHOW_CONTEXT_ALWAYS
end enum

type PGPing as long
enum
	PQPING_OK
	PQPING_REJECT
	PQPING_NO_RESPONSE
	PQPING_NO_ATTEMPT
end enum

type PGconn as pg_conn
type PGresult as pg_result
type PGcancel as pg_cancel

type PGnotify
	relname as zstring ptr
	be_pid as long
	extra as zstring ptr
	next as PGnotify ptr
end type

type PQnoticeReceiver as sub(byval arg as any ptr, byval res as const PGresult ptr)
type PQnoticeProcessor as sub(byval arg as any ptr, byval message as const zstring ptr)
type pqbool as zstring

type _PQprintOpt
	header as byte
	align as byte
	standard as byte
	html3 as byte
	expanded as byte
	pager as byte
	fieldSep as zstring ptr
	tableOpt as zstring ptr
	caption as zstring ptr
	fieldName as zstring ptr ptr
end type

type PQprintOpt as _PQprintOpt

type _PQconninfoOption
	keyword as zstring ptr
	envvar as zstring ptr
	compiled as zstring ptr
	val as zstring ptr
	label as zstring ptr
	dispchar as zstring ptr
	dispsize as long
end type

type PQconninfoOption as _PQconninfoOption

union PQArgBlock_u
	ptr as long ptr
	integer as long
end union

type PQArgBlock
	len as long
	isint as long
	u as PQArgBlock_u
end type

type PGresAttDesc
	name as zstring ptr
	tableid as Oid
	columnid as long
	format as long
	typid as Oid
	typlen as long
	atttypmod as long
end type

declare function PQconnectStart(byval conninfo as const zstring ptr) as PGconn ptr
declare function PQconnectStartParams(byval keywords as const zstring const ptr ptr, byval values as const zstring const ptr ptr, byval expand_dbname as long) as PGconn ptr
declare function PQconnectPoll(byval conn as PGconn ptr) as PostgresPollingStatusType
declare function PQconnectdb(byval conninfo as const zstring ptr) as PGconn ptr
declare function PQconnectdbParams(byval keywords as const zstring const ptr ptr, byval values as const zstring const ptr ptr, byval expand_dbname as long) as PGconn ptr
declare function PQsetdbLogin(byval pghost as const zstring ptr, byval pgport as const zstring ptr, byval pgoptions as const zstring ptr, byval pgtty as const zstring ptr, byval dbName as const zstring ptr, byval login as const zstring ptr, byval pwd as const zstring ptr) as PGconn ptr
#define PQsetdb(M_PGHOST, M_PGPORT, M_PGOPT, M_PGTTY, M_DBNAME) PQsetdbLogin(M_PGHOST, M_PGPORT, M_PGOPT, M_PGTTY, M_DBNAME, NULL, NULL)
declare sub PQfinish(byval conn as PGconn ptr)
declare function PQconndefaults() as PQconninfoOption ptr
declare function PQconninfoParse(byval conninfo as const zstring ptr, byval errmsg as zstring ptr ptr) as PQconninfoOption ptr
declare function PQconninfo(byval conn as PGconn ptr) as PQconninfoOption ptr
declare sub PQconninfoFree(byval connOptions as PQconninfoOption ptr)
declare function PQresetStart(byval conn as PGconn ptr) as long
declare function PQresetPoll(byval conn as PGconn ptr) as PostgresPollingStatusType
declare sub PQreset(byval conn as PGconn ptr)
declare function PQgetCancel(byval conn as PGconn ptr) as PGcancel ptr
declare sub PQfreeCancel(byval cancel as PGcancel ptr)
declare function PQcancel(byval cancel as PGcancel ptr, byval errbuf as zstring ptr, byval errbufsize as long) as long
declare function PQrequestCancel(byval conn as PGconn ptr) as long
declare function PQdb(byval conn as const PGconn ptr) as zstring ptr
declare function PQuser(byval conn as const PGconn ptr) as zstring ptr
declare function PQpass(byval conn as const PGconn ptr) as zstring ptr
declare function PQhost(byval conn as const PGconn ptr) as zstring ptr
declare function PQhostaddr(byval conn as const PGconn ptr) as zstring ptr
declare function PQport(byval conn as const PGconn ptr) as zstring ptr
declare function PQtty(byval conn as const PGconn ptr) as zstring ptr
declare function PQoptions(byval conn as const PGconn ptr) as zstring ptr
declare function PQstatus(byval conn as const PGconn ptr) as ConnStatusType
declare function PQtransactionStatus(byval conn as const PGconn ptr) as PGTransactionStatusType
declare function PQparameterStatus(byval conn as const PGconn ptr, byval paramName as const zstring ptr) as const zstring ptr
declare function PQprotocolVersion(byval conn as const PGconn ptr) as long
declare function PQserverVersion(byval conn as const PGconn ptr) as long
declare function PQerrorMessage(byval conn as const PGconn ptr) as zstring ptr
declare function PQsocket(byval conn as const PGconn ptr) as long
declare function PQbackendPID(byval conn as const PGconn ptr) as long
declare function PQconnectionNeedsPassword(byval conn as const PGconn ptr) as long
declare function PQconnectionUsedPassword(byval conn as const PGconn ptr) as long
declare function PQclientEncoding(byval conn as const PGconn ptr) as long
declare function PQsetClientEncoding(byval conn as PGconn ptr, byval encoding as const zstring ptr) as long
declare function PQsslInUse(byval conn as PGconn ptr) as long
declare function PQsslStruct(byval conn as PGconn ptr, byval struct_name as const zstring ptr) as any ptr
declare function PQsslAttribute(byval conn as PGconn ptr, byval attribute_name as const zstring ptr) as const zstring ptr
declare function PQsslAttributeNames(byval conn as PGconn ptr) as const zstring const ptr ptr
declare function PQgetssl(byval conn as PGconn ptr) as any ptr
declare sub PQinitSSL(byval do_init as long)
declare sub PQinitOpenSSL(byval do_ssl as long, byval do_crypto as long)
declare function PQgssEncInUse(byval conn as PGconn ptr) as long
declare function PQgetgssctx(byval conn as PGconn ptr) as any ptr
declare function PQsetErrorVerbosity(byval conn as PGconn ptr, byval verbosity as PGVerbosity) as PGVerbosity
declare function PQsetErrorContextVisibility(byval conn as PGconn ptr, byval show_context as PGContextVisibility) as PGContextVisibility
declare sub PQtrace(byval conn as PGconn ptr, byval debug_port as FILE ptr)
declare sub PQuntrace(byval conn as PGconn ptr)
declare function PQsetNoticeReceiver(byval conn as PGconn ptr, byval proc as PQnoticeReceiver, byval arg as any ptr) as PQnoticeReceiver
declare function PQsetNoticeProcessor(byval conn as PGconn ptr, byval proc as PQnoticeProcessor, byval arg as any ptr) as PQnoticeProcessor
type pgthreadlock_t as sub(byval acquire as long)
declare function PQregisterThreadLock(byval newhandler as pgthreadlock_t) as pgthreadlock_t
declare function PQexec(byval conn as PGconn ptr, byval query as const zstring ptr) as PGresult ptr
declare function PQexecParams(byval conn as PGconn ptr, byval command as const zstring ptr, byval nParams as long, byval paramTypes as const Oid ptr, byval paramValues as const zstring const ptr ptr, byval paramLengths as const long ptr, byval paramFormats as const long ptr, byval resultFormat as long) as PGresult ptr
declare function PQprepare(byval conn as PGconn ptr, byval stmtName as const zstring ptr, byval query as const zstring ptr, byval nParams as long, byval paramTypes as const Oid ptr) as PGresult ptr
declare function PQexecPrepared(byval conn as PGconn ptr, byval stmtName as const zstring ptr, byval nParams as long, byval paramValues as const zstring const ptr ptr, byval paramLengths as const long ptr, byval paramFormats as const long ptr, byval resultFormat as long) as PGresult ptr
declare function PQsendQuery(byval conn as PGconn ptr, byval query as const zstring ptr) as long
declare function PQsendQueryParams(byval conn as PGconn ptr, byval command as const zstring ptr, byval nParams as long, byval paramTypes as const Oid ptr, byval paramValues as const zstring const ptr ptr, byval paramLengths as const long ptr, byval paramFormats as const long ptr, byval resultFormat as long) as long
declare function PQsendPrepare(byval conn as PGconn ptr, byval stmtName as const zstring ptr, byval query as const zstring ptr, byval nParams as long, byval paramTypes as const Oid ptr) as long
declare function PQsendQueryPrepared(byval conn as PGconn ptr, byval stmtName as const zstring ptr, byval nParams as long, byval paramValues as const zstring const ptr ptr, byval paramLengths as const long ptr, byval paramFormats as const long ptr, byval resultFormat as long) as long
declare function PQsetSingleRowMode(byval conn as PGconn ptr) as long
declare function PQgetResult(byval conn as PGconn ptr) as PGresult ptr
declare function PQisBusy(byval conn as PGconn ptr) as long
declare function PQconsumeInput(byval conn as PGconn ptr) as long
declare function PQnotifies(byval conn as PGconn ptr) as PGnotify ptr
declare function PQputCopyData(byval conn as PGconn ptr, byval buffer as const zstring ptr, byval nbytes as long) as long
declare function PQputCopyEnd(byval conn as PGconn ptr, byval errormsg as const zstring ptr) as long
declare function PQgetCopyData(byval conn as PGconn ptr, byval buffer as zstring ptr ptr, byval async as long) as long
declare function PQgetline(byval conn as PGconn ptr, byval string as zstring ptr, byval length as long) as long
declare function PQputline(byval conn as PGconn ptr, byval string as const zstring ptr) as long
declare function PQgetlineAsync(byval conn as PGconn ptr, byval buffer as zstring ptr, byval bufsize as long) as long
declare function PQputnbytes(byval conn as PGconn ptr, byval buffer as const zstring ptr, byval nbytes as long) as long
declare function PQendcopy(byval conn as PGconn ptr) as long
declare function PQsetnonblocking(byval conn as PGconn ptr, byval arg as long) as long
declare function PQisnonblocking(byval conn as const PGconn ptr) as long
declare function PQisthreadsafe() as long
declare function PQping(byval conninfo as const zstring ptr) as PGPing
declare function PQpingParams(byval keywords as const zstring const ptr ptr, byval values as const zstring const ptr ptr, byval expand_dbname as long) as PGPing
declare function PQflush(byval conn as PGconn ptr) as long
declare function PQfn(byval conn as PGconn ptr, byval fnid as long, byval result_buf as long ptr, byval result_len as long ptr, byval result_is_int as long, byval args as const PQArgBlock ptr, byval nargs as long) as PGresult ptr
declare function PQresultStatus(byval res as const PGresult ptr) as ExecStatusType
declare function PQresStatus(byval status as ExecStatusType) as zstring ptr
declare function PQresultErrorMessage(byval res as const PGresult ptr) as zstring ptr
declare function PQresultVerboseErrorMessage(byval res as const PGresult ptr, byval verbosity as PGVerbosity, byval show_context as PGContextVisibility) as zstring ptr
declare function PQresultErrorField(byval res as const PGresult ptr, byval fieldcode as long) as zstring ptr
declare function PQntuples(byval res as const PGresult ptr) as long
declare function PQnfields(byval res as const PGresult ptr) as long
declare function PQbinaryTuples(byval res as const PGresult ptr) as long
declare function PQfname(byval res as const PGresult ptr, byval field_num as long) as zstring ptr
declare function PQfnumber(byval res as const PGresult ptr, byval field_name as const zstring ptr) as long
declare function PQftable(byval res as const PGresult ptr, byval field_num as long) as Oid
declare function PQftablecol(byval res as const PGresult ptr, byval field_num as long) as long
declare function PQfformat(byval res as const PGresult ptr, byval field_num as long) as long
declare function PQftype(byval res as const PGresult ptr, byval field_num as long) as Oid
declare function PQfsize(byval res as const PGresult ptr, byval field_num as long) as long
declare function PQfmod(byval res as const PGresult ptr, byval field_num as long) as long
declare function PQcmdStatus(byval res as PGresult ptr) as zstring ptr
declare function PQoidStatus(byval res as const PGresult ptr) as zstring ptr
declare function PQoidValue(byval res as const PGresult ptr) as Oid
declare function PQcmdTuples(byval res as PGresult ptr) as zstring ptr
declare function PQgetvalue(byval res as const PGresult ptr, byval tup_num as long, byval field_num as long) as zstring ptr
declare function PQgetlength(byval res as const PGresult ptr, byval tup_num as long, byval field_num as long) as long
declare function PQgetisnull(byval res as const PGresult ptr, byval tup_num as long, byval field_num as long) as long
declare function PQnparams(byval res as const PGresult ptr) as long
declare function PQparamtype(byval res as const PGresult ptr, byval param_num as long) as Oid
declare function PQdescribePrepared(byval conn as PGconn ptr, byval stmt as const zstring ptr) as PGresult ptr
declare function PQdescribePortal(byval conn as PGconn ptr, byval portal as const zstring ptr) as PGresult ptr
declare function PQsendDescribePrepared(byval conn as PGconn ptr, byval stmt as const zstring ptr) as long
declare function PQsendDescribePortal(byval conn as PGconn ptr, byval portal as const zstring ptr) as long
declare sub PQclear(byval res as PGresult ptr)
declare sub PQfreemem(byval ptr as any ptr)
#define PQfreeNotify(ptr) PQfreemem(ptr)
#define PQnoPasswordSupplied !"fe_sendauth: no password supplied\n"
declare function PQmakeEmptyPGresult(byval conn as PGconn ptr, byval status as ExecStatusType) as PGresult ptr
declare function PQcopyResult(byval src as const PGresult ptr, byval flags as long) as PGresult ptr
declare function PQsetResultAttrs(byval res as PGresult ptr, byval numAttributes as long, byval attDescs as PGresAttDesc ptr) as long
declare function PQresultAlloc(byval res as PGresult ptr, byval nBytes as uinteger) as any ptr
declare function PQresultMemorySize(byval res as const PGresult ptr) as uinteger
declare function PQsetvalue(byval res as PGresult ptr, byval tup_num as long, byval field_num as long, byval value as zstring ptr, byval len as long) as long
declare function PQescapeStringConn(byval conn as PGconn ptr, byval to as zstring ptr, byval from as const zstring ptr, byval length as uinteger, byval error as long ptr) as uinteger
declare function PQescapeLiteral(byval conn as PGconn ptr, byval str as const zstring ptr, byval len as uinteger) as zstring ptr
declare function PQescapeIdentifier(byval conn as PGconn ptr, byval str as const zstring ptr, byval len as uinteger) as zstring ptr
declare function PQescapeByteaConn(byval conn as PGconn ptr, byval from as const ubyte ptr, byval from_length as uinteger, byval to_length as uinteger ptr) as ubyte ptr
declare function PQunescapeBytea(byval strtext as const ubyte ptr, byval retbuflen as uinteger ptr) as ubyte ptr
declare function PQescapeString(byval to as zstring ptr, byval from as const zstring ptr, byval length as uinteger) as uinteger
declare function PQescapeBytea(byval from as const ubyte ptr, byval from_length as uinteger, byval to_length as uinteger ptr) as ubyte ptr
declare sub PQprint(byval fout as FILE ptr, byval res as const PGresult ptr, byval ps as const PQprintOpt ptr)
declare sub PQdisplayTuples(byval res as const PGresult ptr, byval fp as FILE ptr, byval fillAlign as long, byval fieldSep as const zstring ptr, byval printHeader as long, byval quiet as long)
declare sub PQprintTuples(byval res as const PGresult ptr, byval fout as FILE ptr, byval printAttName as long, byval terseOutput as long, byval width as long)
declare function lo_open(byval conn as PGconn ptr, byval lobjId as Oid, byval mode as long) as long
declare function lo_close(byval conn as PGconn ptr, byval fd as long) as long
declare function lo_read(byval conn as PGconn ptr, byval fd as long, byval buf as zstring ptr, byval len as uinteger) as long
declare function lo_write(byval conn as PGconn ptr, byval fd as long, byval buf as const zstring ptr, byval len as uinteger) as long
declare function lo_lseek(byval conn as PGconn ptr, byval fd as long, byval offset as long, byval whence as long) as long
declare function lo_lseek64(byval conn as PGconn ptr, byval fd as long, byval offset as pg_int64, byval whence as long) as pg_int64
declare function lo_creat(byval conn as PGconn ptr, byval mode as long) as Oid
declare function lo_create(byval conn as PGconn ptr, byval lobjId as Oid) as Oid
declare function lo_tell(byval conn as PGconn ptr, byval fd as long) as long
declare function lo_tell64(byval conn as PGconn ptr, byval fd as long) as pg_int64
declare function lo_truncate(byval conn as PGconn ptr, byval fd as long, byval len as uinteger) as long
declare function lo_truncate64(byval conn as PGconn ptr, byval fd as long, byval len as pg_int64) as long
declare function lo_unlink(byval conn as PGconn ptr, byval lobjId as Oid) as long
declare function lo_import(byval conn as PGconn ptr, byval filename as const zstring ptr) as Oid
declare function lo_import_with_oid(byval conn as PGconn ptr, byval filename as const zstring ptr, byval lobjId as Oid) as Oid
declare function lo_export(byval conn as PGconn ptr, byval lobjId as Oid, byval filename as const zstring ptr) as long
declare function PQlibVersion() as long
declare function PQmblen(byval s as const zstring ptr, byval encoding as long) as long
declare function PQdsplen(byval s as const zstring ptr, byval encoding as long) as long
declare function PQenv2encoding() as long
declare function PQencryptPassword(byval passwd as const zstring ptr, byval user as const zstring ptr) as zstring ptr
declare function PQencryptPasswordConn(byval conn as PGconn ptr, byval passwd as const zstring ptr, byval user as const zstring ptr, byval algorithm as const zstring ptr) as zstring ptr
declare function pg_char_to_encoding(byval name as const zstring ptr) as long
declare function pg_encoding_to_char(byval encoding as long) as const zstring ptr
declare function pg_valid_server_encoding_id(byval encoding as long) as long

end extern
