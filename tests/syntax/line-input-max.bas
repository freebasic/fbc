#macro t ? ( n, stmt... )
#print stmt
stmt
#if( n = 0 )
#print OK
#endif
#endmacro



'' -------------------

dim z as zstring ptr, pz as zstring ptr
dim w as wstring ptr, pw as wstring ptr
dim s as string, ps as string
dim fz as zstring * 20, pfz as zstring * 20
dim fw as wstring * 20, pfw as wstring * 20

t( 0, line input #1, s )
t( 0, line input #1, fz )
t( 0, line input #1, fw )

t( 0, line input #1, *z, 10 )
t( 0, line input #1, *w, 10 )

t( 0, line input "", s )
t( 0, line input "", fz )
t( 0, line input "", fw )

t( 0, line input "", *z, 10 )
t( 0, line input "", *w, 10 )

t( 0, line input ps, s )
t( 0, line input ps, fz )
t( 0, line input ps, fw )

t( 0, line input ps, *z, 10 )
t( 0, line input ps, *w, 10 )

t( 0, line input pfz, s )
t( 0, line input pfz, fz )
t( 0, line input pfz, fw )

t( 0, line input pfz, *z, 10 )
t( 0, line input pfz, *w, 10 )

t( 0, line input pfw, s )
t( 0, line input pfw, fz )
t( 0, line input pfw, fw )

t( 0, line input pfw, *z, 10 )
t( 0, line input pfw, *w, 10 )

t( 0, line input *pz, s )
t( 0, line input *pz, fz )
t( 0, line input *pz, fw )

t( 0, line input *pz, *z, 10 )
t( 0, line input *pz, *w, 10 )

t( 0, line input *pw, s )
t( 0, line input *pw, fz )
t( 0, line input *pw, fw )

t( 0, line input *pw, *z, 10 )
t( 0, line input *pw, *w, 10 )


t( 1, line input #1, s, 10 )
t( 1, line input #1, fz, 10 )
t( 1, line input #1, fw, 10 )

t( 1, line input #1, *z )
t( 1, line input #1, *w )

t( 1, line input p, s, 10 )
t( 1, line input p, fz, 10 )
t( 1, line input p, fw, 10 )

t( 1, line input "", *z )
t( 1, line input "", *w )

t( 1, line input p, s, 10 )
t( 1, line input p, fz, 10 )
t( 1, line input p, fw, 10 )

t( 1, line input p, *z )
t( 1, line input p, *w )

t( 1, line input ps, s, 10 )
t( 1, line input ps, fz, 10 )
t( 1, line input ps, fw, 10 )

t( 1, line input ps, *z )
t( 1, line input ps, *w )

t( 1, line input pfz, s, 10 )
t( 1, line input pfz, fz, 10 )
t( 1, line input pfz, fw, 10 )

t( 1, line input pfz, *z )
t( 1, line input pfz, *w )

t( 1, line input pfw, s, 10 )
t( 1, line input pfw, fz, 10 )
t( 1, line input pfw, fw, 10 )

t( 1, line input pfw, *z )
t( 1, line input pfw, *w )

t( 1, line input *pz, s, 10 )
t( 1, line input *pz, fz, 10 )
t( 1, line input *pz, fw, 10 )

t( 1, line input *pz, *z )
t( 1, line input *pz, *w )

t( 1, line input *pw, s, 10 )
t( 1, line input *pw, fz, 10 )
t( 1, line input *pw, fw, 10 )

t( 1, line input *pw, *z )
t( 1, line input *pw, *w )
