''
''
'' postgresql -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __postgresql_postgres_ext_bi__
#define __postgresql_postgres_ext_bi__

type Oid as uinteger

#define NAMEDATALEN 64
#define PG_DIAG_SEVERITY asc("S")
#define PG_DIAG_SQLSTATE asc("C")
#define PG_DIAG_MESSAGE_PRIMARY asc("M")
#define PG_DIAG_MESSAGE_DETAIL asc("D")
#define PG_DIAG_MESSAGE_HINT asc("H")
#define PG_DIAG_STATEMENT_POSITION asc("P")
#define PG_DIAG_INTERNAL_POSITION asc("p")
#define PG_DIAG_INTERNAL_QUERY asc("q")
#define PG_DIAG_CONTEXT asc("W")
#define PG_DIAG_SOURCE_FILE asc("F")
#define PG_DIAG_SOURCE_LINE asc("L")
#define PG_DIAG_SOURCE_FUNCTION asc("R")

#endif
