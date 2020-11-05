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

#define POSTGRES_EXT_H
type Oid as ulong
const InvalidOid = cast(Oid, 0)
#define OID_MAX UINT_MAX
#define atooid(x) cast(Oid, strtoul((x), NULL, 10))
type pg_int64 as longint
#define PG_DIAG_SEVERITY asc("S")
#define PG_DIAG_SEVERITY_NONLOCALIZED asc("V")
#define PG_DIAG_SQLSTATE asc("C")
#define PG_DIAG_MESSAGE_PRIMARY asc("M")
#define PG_DIAG_MESSAGE_DETAIL asc("D")
#define PG_DIAG_MESSAGE_HINT asc("H")
#define PG_DIAG_STATEMENT_POSITION asc("P")
#define PG_DIAG_INTERNAL_POSITION asc("p")
#define PG_DIAG_INTERNAL_QUERY asc("q")
#define PG_DIAG_CONTEXT asc("W")
#define PG_DIAG_SCHEMA_NAME asc("s")
#define PG_DIAG_TABLE_NAME asc("t")
#define PG_DIAG_COLUMN_NAME asc("c")
#define PG_DIAG_DATATYPE_NAME asc("d")
#define PG_DIAG_CONSTRAINT_NAME asc("n")
#define PG_DIAG_SOURCE_FILE asc("F")
#define PG_DIAG_SOURCE_LINE asc("L")
#define PG_DIAG_SOURCE_FUNCTION asc("R")
