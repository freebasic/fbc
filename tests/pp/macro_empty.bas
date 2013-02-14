
' TEST_MODE : COMPILE_ONLY_OK

#ifdef  empty1
#error  empty1 should not be defined
#endif

'' create an empty macro
#macro  empty1()
#endmacro

#ifndef empty1
#error  empty1 should be defined
#endif

#undef  empty1

#ifdef  empty1
#error  empty1 should not be defined
#endif


#macro empty2( a )
#endmacro

#ifndef empty2
#error  empty1 should be defined
#endif



#macro empty3( a, b )
#endmacro

#ifndef empty3
#error  empty1 should be defined
#endif

#define f1(a)
f1()

#define f2(a) a
f2()

#define f3(a,b,c)
f3(,,)

#define f4(a,b,c) a b c
f4(,,)

#define m( s ) "a" + #s + "b"
scope
	dim s1 as string = m()
	dim s2 as string = m( )
	dim s3 as string = m(  /'foo'/    )
end scope
