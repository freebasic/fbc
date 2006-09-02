
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
