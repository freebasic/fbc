''
''
'' postgresql -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __postgresql_libpq_fe_bi__
#define __postgresql_libpq_fe_bi__

#inclib "pq"

#ifndef	FILE
type FILE as any ptr
#endif

#ifndef size_t
type size_t	as long
#endif

type pg_conn as any ptr
type pg_result as any ptr
type pg_cancel as any ptr

#include "postgresql/postgres_ext.bi"

enum ConnStatusType
	CONNECTION_OK
	CONNECTION_BAD
	CONNECTION_STARTED
	CONNECTION_MADE
	CONNECTION_AWAITING_RESPONSE
	CONNECTION_AUTH_OK
	CONNECTION_SETENV
	CONNECTION_SSL_STARTUP
	CONNECTION_NEEDED
end enum


enum PostgresPollingStatusType
	PGRES_POLLING_FAILED = 0
	PGRES_POLLING_READING
	PGRES_POLLING_WRITING
	PGRES_POLLING_OK
	PGRES_POLLING_ACTIVE
end enum


enum ExecStatusType
	PGRES_EMPTY_QUERY = 0
	PGRES_COMMAND_OK
	PGRES_TUPLES_OK
	PGRES_COPY_OUT
	PGRES_COPY_IN
	PGRES_BAD_RESPONSE
	PGRES_NONFATAL_ERROR
	PGRES_FATAL_ERROR
end enum


enum PGTransactionStatusType
	PQTRANS_IDLE
	PQTRANS_ACTIVE
	PQTRANS_INTRANS
	PQTRANS_INERROR
	PQTRANS_UNKNOWN
end enum


enum PGVerbosity
	PQERRORS_TERSE
	PQERRORS_DEFAULT
	PQERRORS_VERBOSE
end enum

type PGconn as pg_conn
type PGresult as pg_result
type PGcancel as pg_cancel

type pgNotify
	relname as zstring ptr
	be_pid as integer
	extra as zstring ptr
	next as pgNotify ptr
end type

type PQnoticeReceiver as sub cdecl(byval as any ptr, byval as PGresult ptr)
type PQnoticeProcessor as sub cdecl(byval as any ptr, byval as zstring ptr)
type pqbool as byte

type PQprintOpt
	header as pqbool
	align as pqbool
	standard as pqbool
	html3 as pqbool
	expanded as pqbool
	pager as pqbool
	fieldSep as zstring ptr
	tableOpt as zstring ptr
	caption as zstring ptr
	fieldName as zstring ptr ptr
end type

type PQconninfoOption
	keyword as zstring ptr
	envvar as zstring ptr
	compiled as zstring ptr
	val as zstring ptr
	label as zstring ptr
	dispchar as zstring ptr
	dispsize as integer
end type

type PQArgBlock
	len as integer
	isint as integer
	union
		ptr as integer ptr
		integer as integer
	end union
end type

declare function PQconnectStart cdecl alias "PQconnectStart" (byval conninfo as zstring ptr) as PGconn ptr
declare function PQconnectPoll cdecl alias "PQconnectPoll" (byval conn as PGconn ptr) as PostgresPollingStatusType
declare function PQconnectdb cdecl alias "PQconnectdb" (byval conninfo as zstring ptr) as PGconn ptr
declare function PQsetdbLogin cdecl alias "PQsetdbLogin" (byval pghost as zstring ptr, byval pgport as zstring ptr, byval pgoptions as zstring ptr, byval pgtty as zstring ptr, byval dbName as zstring ptr, byval login as zstring ptr, byval pwd as zstring ptr) as PGconn ptr
declare sub PQfinish cdecl alias "PQfinish" (byval conn as PGconn ptr)
declare function PQconndefaults cdecl alias "PQconndefaults" () as PQconninfoOption ptr
declare sub PQconninfoFree cdecl alias "PQconninfoFree" (byval connOptions as PQconninfoOption ptr)
declare function PQresetStart cdecl alias "PQresetStart" (byval conn as PGconn ptr) as integer
declare function PQresetPoll cdecl alias "PQresetPoll" (byval conn as PGconn ptr) as PostgresPollingStatusType
declare sub PQreset cdecl alias "PQreset" (byval conn as PGconn ptr)
declare function PQgetCancel cdecl alias "PQgetCancel" (byval conn as PGconn ptr) as PGcancel ptr
declare sub PQfreeCancel cdecl alias "PQfreeCancel" (byval cancel as PGcancel ptr)
declare function PQcancel cdecl alias "PQcancel" (byval cancel as PGcancel ptr, byval errbuf as zstring ptr, byval errbufsize as integer) as integer
declare function PQrequestCancel cdecl alias "PQrequestCancel" (byval conn as PGconn ptr) as integer
declare function PQdb cdecl alias "PQdb" (byval conn as PGconn ptr) as zstring ptr
declare function PQuser cdecl alias "PQuser" (byval conn as PGconn ptr) as zstring ptr
declare function PQpass cdecl alias "PQpass" (byval conn as PGconn ptr) as zstring ptr
declare function PQhost cdecl alias "PQhost" (byval conn as PGconn ptr) as zstring ptr
declare function PQport cdecl alias "PQport" (byval conn as PGconn ptr) as zstring ptr
declare function PQtty cdecl alias "PQtty" (byval conn as PGconn ptr) as zstring ptr
declare function PQoptions cdecl alias "PQoptions" (byval conn as PGconn ptr) as zstring ptr
declare function PQstatus cdecl alias "PQstatus" (byval conn as PGconn ptr) as ConnStatusType
declare function PQtransactionStatus cdecl alias "PQtransactionStatus" (byval conn as PGconn ptr) as PGTransactionStatusType
declare function PQparameterStatus cdecl alias "PQparameterStatus" (byval conn as PGconn ptr, byval paramName as zstring ptr) as zstring ptr
declare function PQprotocolVersion cdecl alias "PQprotocolVersion" (byval conn as PGconn ptr) as integer
declare function PQserverVersion cdecl alias "PQserverVersion" (byval conn as PGconn ptr) as integer
declare function PQerrorMessage cdecl alias "PQerrorMessage" (byval conn as PGconn ptr) as zstring ptr
declare function PQsocket cdecl alias "PQsocket" (byval conn as PGconn ptr) as integer
declare function PQbackendPID cdecl alias "PQbackendPID" (byval conn as PGconn ptr) as integer
declare function PQclientEncoding cdecl alias "PQclientEncoding" (byval conn as PGconn ptr) as integer
declare function PQsetClientEncoding cdecl alias "PQsetClientEncoding" (byval conn as PGconn ptr, byval encoding as zstring ptr) as integer
declare function PQgetssl cdecl alias "PQgetssl" (byval conn as PGconn ptr) as any ptr
declare sub PQinitSSL cdecl alias "PQinitSSL" (byval do_init as integer)
declare function PQsetErrorVerbosity cdecl alias "PQsetErrorVerbosity" (byval conn as PGconn ptr, byval verbosity as PGVerbosity) as PGVerbosity
declare sub PQtrace cdecl alias "PQtrace" (byval conn as PGconn ptr, byval debug_port as FILE ptr)
declare sub PQuntrace cdecl alias "PQuntrace" (byval conn as PGconn ptr)
declare function PQsetNoticeReceiver cdecl alias "PQsetNoticeReceiver" (byval conn as PGconn ptr, byval proc as PQnoticeReceiver, byval arg as any ptr) as PQnoticeReceiver
declare function PQsetNoticeProcessor cdecl alias "PQsetNoticeProcessor" (byval conn as PGconn ptr, byval proc as PQnoticeProcessor, byval arg as any ptr) as PQnoticeProcessor

type pgthreadlock_t as sub cdecl(byval as integer)

declare function PQregisterThreadLock cdecl alias "PQregisterThreadLock" (byval newhandler as pgthreadlock_t) as pgthreadlock_t
declare function PQexec cdecl alias "PQexec" (byval conn as PGconn ptr, byval query as zstring ptr) as PGresult ptr
declare function PQexecParams cdecl alias "PQexecParams" (byval conn as PGconn ptr, byval command as zstring ptr, byval nParams as integer, byval paramTypes as Oid ptr, byval paramValues as byte ptr ptr, byval paramLengths as integer ptr, byval paramFormats as integer ptr, byval resultFormat as integer) as PGresult ptr
declare function PQprepare cdecl alias "PQprepare" (byval conn as PGconn ptr, byval stmtName as zstring ptr, byval query as zstring ptr, byval nParams as integer, byval paramTypes as Oid ptr) as PGresult ptr
declare function PQexecPrepared cdecl alias "PQexecPrepared" (byval conn as PGconn ptr, byval stmtName as zstring ptr, byval nParams as integer, byval paramValues as byte ptr ptr, byval paramLengths as integer ptr, byval paramFormats as integer ptr, byval resultFormat as integer) as PGresult ptr
declare function PQsendQuery cdecl alias "PQsendQuery" (byval conn as PGconn ptr, byval query as zstring ptr) as integer
declare function PQsendQueryParams cdecl alias "PQsendQueryParams" (byval conn as PGconn ptr, byval command as zstring ptr, byval nParams as integer, byval paramTypes as Oid ptr, byval paramValues as byte ptr ptr, byval paramLengths as integer ptr, byval paramFormats as integer ptr, byval resultFormat as integer) as integer
declare function PQsendPrepare cdecl alias "PQsendPrepare" (byval conn as PGconn ptr, byval stmtName as zstring ptr, byval query as zstring ptr, byval nParams as integer, byval paramTypes as Oid ptr) as integer
declare function PQsendQueryPrepared cdecl alias "PQsendQueryPrepared" (byval conn as PGconn ptr, byval stmtName as zstring ptr, byval nParams as integer, byval paramValues as byte ptr ptr, byval paramLengths as integer ptr, byval paramFormats as integer ptr, byval resultFormat as integer) as integer
declare function PQgetResult cdecl alias "PQgetResult" (byval conn as PGconn ptr) as PGresult ptr
declare function PQisBusy cdecl alias "PQisBusy" (byval conn as PGconn ptr) as integer
declare function PQconsumeInput cdecl alias "PQconsumeInput" (byval conn as PGconn ptr) as integer
declare function PQnotifies cdecl alias "PQnotifies" (byval conn as PGconn ptr) as PGnotify ptr
declare function PQputCopyData cdecl alias "PQputCopyData" (byval conn as PGconn ptr, byval buffer as zstring ptr, byval nbytes as integer) as integer
declare function PQputCopyEnd cdecl alias "PQputCopyEnd" (byval conn as PGconn ptr, byval errormsg as zstring ptr) as integer
declare function PQgetCopyData cdecl alias "PQgetCopyData" (byval conn as PGconn ptr, byval buffer as byte ptr ptr, byval async as integer) as integer
declare function PQgetline cdecl alias "PQgetline" (byval conn as PGconn ptr, byval string as zstring ptr, byval length as integer) as integer
declare function PQputline cdecl alias "PQputline" (byval conn as PGconn ptr, byval string as zstring ptr) as integer
declare function PQgetlineAsync cdecl alias "PQgetlineAsync" (byval conn as PGconn ptr, byval buffer as zstring ptr, byval bufsize as integer) as integer
declare function PQputnbytes cdecl alias "PQputnbytes" (byval conn as PGconn ptr, byval buffer as zstring ptr, byval nbytes as integer) as integer
declare function PQendcopy cdecl alias "PQendcopy" (byval conn as PGconn ptr) as integer
declare function PQsetnonblocking cdecl alias "PQsetnonblocking" (byval conn as PGconn ptr, byval arg as integer) as integer
declare function PQisnonblocking cdecl alias "PQisnonblocking" (byval conn as PGconn ptr) as integer
declare function PQflush cdecl alias "PQflush" (byval conn as PGconn ptr) as integer
declare function PQfn cdecl alias "PQfn" (byval conn as PGconn ptr, byval fnid as integer, byval result_buf as integer ptr, byval result_len as integer ptr, byval result_is_int as integer, byval args as PQArgBlock ptr, byval nargs as integer) as PGresult ptr
declare function PQresultStatus cdecl alias "PQresultStatus" (byval res as PGresult ptr) as ExecStatusType
declare function PQresStatus cdecl alias "PQresStatus" (byval status as ExecStatusType) as zstring ptr
declare function PQresultErrorMessage cdecl alias "PQresultErrorMessage" (byval res as PGresult ptr) as zstring ptr
declare function PQresultErrorField cdecl alias "PQresultErrorField" (byval res as PGresult ptr, byval fieldcode as integer) as zstring ptr
declare function PQntuples cdecl alias "PQntuples" (byval res as PGresult ptr) as integer
declare function PQnfields cdecl alias "PQnfields" (byval res as PGresult ptr) as integer
declare function PQbinaryTuples cdecl alias "PQbinaryTuples" (byval res as PGresult ptr) as integer
declare function PQfname cdecl alias "PQfname" (byval res as PGresult ptr, byval field_num as integer) as zstring ptr
declare function PQfnumber cdecl alias "PQfnumber" (byval res as PGresult ptr, byval field_name as zstring ptr) as integer
declare function PQftable cdecl alias "PQftable" (byval res as PGresult ptr, byval field_num as integer) as Oid
declare function PQftablecol cdecl alias "PQftablecol" (byval res as PGresult ptr, byval field_num as integer) as integer
declare function PQfformat cdecl alias "PQfformat" (byval res as PGresult ptr, byval field_num as integer) as integer
declare function PQftype cdecl alias "PQftype" (byval res as PGresult ptr, byval field_num as integer) as Oid
declare function PQfsize cdecl alias "PQfsize" (byval res as PGresult ptr, byval field_num as integer) as integer
declare function PQfmod cdecl alias "PQfmod" (byval res as PGresult ptr, byval field_num as integer) as integer
declare function PQcmdStatus cdecl alias "PQcmdStatus" (byval res as PGresult ptr) as zstring ptr
declare function PQoidStatus cdecl alias "PQoidStatus" (byval res as PGresult ptr) as zstring ptr
declare function PQoidValue cdecl alias "PQoidValue" (byval res as PGresult ptr) as Oid
declare function PQcmdTuples cdecl alias "PQcmdTuples" (byval res as PGresult ptr) as zstring ptr
declare function PQgetvalue cdecl alias "PQgetvalue" (byval res as PGresult ptr, byval tup_num as integer, byval field_num as integer) as zstring ptr
declare function PQgetlength cdecl alias "PQgetlength" (byval res as PGresult ptr, byval tup_num as integer, byval field_num as integer) as integer
declare function PQgetisnull cdecl alias "PQgetisnull" (byval res as PGresult ptr, byval tup_num as integer, byval field_num as integer) as integer
declare sub PQclear cdecl alias "PQclear" (byval res as PGresult ptr)
declare sub PQfreemem cdecl alias "PQfreemem" (byval ptr as any ptr)

#define PQnoPasswordSupplied !"fe_sendauth: no password supplied\n"

declare function PQmakeEmptyPGresult cdecl alias "PQmakeEmptyPGresult" (byval conn as PGconn ptr, byval status as ExecStatusType) as PGresult ptr
declare function PQescapeStringConn cdecl alias "PQescapeStringConn" (byval conn as PGconn ptr, byval to as zstring ptr, byval from as zstring ptr, byval length as size_t, byval error as integer ptr) as size_t
declare function PQescapeByteaConn cdecl alias "PQescapeByteaConn" (byval conn as PGconn ptr, byval from as ubyte ptr, byval from_length as size_t, byval to_length as size_t ptr) as ubyte ptr
declare function PQunescapeBytea cdecl alias "PQunescapeBytea" (byval strtext as ubyte ptr, byval retbuflen as size_t ptr) as ubyte ptr
declare function PQescapeString cdecl alias "PQescapeString" (byval to as zstring ptr, byval from as zstring ptr, byval length as size_t) as size_t
declare function PQescapeBytea cdecl alias "PQescapeBytea" (byval from as ubyte ptr, byval from_length as size_t, byval to_length as size_t ptr) as ubyte ptr
declare sub PQprint cdecl alias "PQprint" (byval fout as FILE ptr, byval res as PGresult ptr, byval ps as PQprintOpt ptr)
declare sub PQdisplayTuples cdecl alias "PQdisplayTuples" (byval res as PGresult ptr, byval fp as FILE ptr, byval fillAlign as integer, byval fieldSep as zstring ptr, byval printHeader as integer, byval quiet as integer)
declare sub PQprintTuples cdecl alias "PQprintTuples" (byval res as PGresult ptr, byval fout as FILE ptr, byval printAttName as integer, byval terseOutput as integer, byval width as integer)
declare function lo_open cdecl alias "lo_open" (byval conn as PGconn ptr, byval lobjId as Oid, byval mode as integer) as integer
declare function lo_close cdecl alias "lo_close" (byval conn as PGconn ptr, byval fd as integer) as integer
declare function lo_read cdecl alias "lo_read" (byval conn as PGconn ptr, byval fd as integer, byval buf as zstring ptr, byval len as size_t) as integer
declare function lo_write cdecl alias "lo_write" (byval conn as PGconn ptr, byval fd as integer, byval buf as zstring ptr, byval len as size_t) as integer
declare function lo_lseek cdecl alias "lo_lseek" (byval conn as PGconn ptr, byval fd as integer, byval offset as integer, byval whence as integer) as integer
declare function lo_creat cdecl alias "lo_creat" (byval conn as PGconn ptr, byval mode as integer) as Oid
declare function lo_create cdecl alias "lo_create" (byval conn as PGconn ptr, byval lobjId as Oid) as Oid
declare function lo_tell cdecl alias "lo_tell" (byval conn as PGconn ptr, byval fd as integer) as integer
declare function lo_unlink cdecl alias "lo_unlink" (byval conn as PGconn ptr, byval lobjId as Oid) as integer
declare function lo_import cdecl alias "lo_import" (byval conn as PGconn ptr, byval filename as zstring ptr) as Oid
declare function lo_export cdecl alias "lo_export" (byval conn as PGconn ptr, byval lobjId as Oid, byval filename as zstring ptr) as integer
declare function PQmblen cdecl alias "PQmblen" (byval s as zstring ptr, byval encoding as integer) as integer
declare function PQdsplen cdecl alias "PQdsplen" (byval s as zstring ptr, byval encoding as integer) as integer
declare function PQenv2encoding cdecl alias "PQenv2encoding" () as integer

#endif
