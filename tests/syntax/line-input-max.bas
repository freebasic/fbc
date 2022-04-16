#macro t ? ( n, stmt... )
#print stmt
stmt
#if( n = 0 )
#print OK
#endif
#endmacro



'' -------------------

dim z as zstring ptr
dim w as wstring ptr
dim s as string
dim fz as zstring * 20
dim fw as wstring * 20

t( 0, line input #1, *z
t( 0, line input #1, *w

t( 0, line input #1, *z, 10
t( 0, line input #1, *w, 10

t( 0, line input #1, s
t( 0, line input #1, fz
t( 0, line input #1, fw

t( 1, line input #1, s, 10
t( 1, line input #1, fz, 10
t( 1, line input #1, fw, 10

t( 0, line input "", *z
t( 0, line input "", *w

t( 0, line input "", *z, 10
t( 0, line input "", *w, 10

t( 0, line input "", s
t( 0, line input "", fz
t( 0, line input "", fw

t( 1, line input "", s, 10
t( 1, line input "", fz, 10
t( 1, line input "", fw, 10
