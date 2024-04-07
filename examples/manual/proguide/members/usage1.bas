'' examples/manual/proguide/members/usage1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Member Procedures'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMemberProcedures
'' --------

'' ... foo with non-static members as before ...
#include Once "foo1.bi"

Dim bar As foo
bar.f(bar.g())
