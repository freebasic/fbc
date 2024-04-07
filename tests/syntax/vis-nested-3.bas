'' Test visibility declaring (DIM) a tydef from outside
'' a type containing nested (inner scoped) types 3 levels deep
'' within a local scope
''
''
''
''
''
''
''

#define msg(lineno,arg) "Expect error to follow @" lineno,arg
#macro t( iserror, arg, statement )
	#if( iserror <> 0 )
		#print msg(__LINE__,arg)
	#endif
	statement
#endmacro

#macro decl_T( basename, scope1, scope2, scope3 )
	type basename##0
		scope1:
			type basename##D1 as integer
			i1 as integer
			type basename##1
				scope2:
					type basename##D2 as integer
					i2 as integer
					type basename##2
						scope3:
							type basename##D3 as integer
							i3 as integer
							type basename##3
								d as integer
							end type
							m3 as basename##3
					end type
					m2 as basename##2
			end type
			m1 as basename##1
	end type
#endmacro

#macro test_X( basename, r1, r2, r3 )
	t( 0 , 0, dim x0 as basename##0 )
	t( r1, 1, dim x1 as basename##0.basename##D1 )
	t( r2, 2, dim x2 as basename##0.basename##1.basename##D2 )
	t( r3, 3, dim x3 as basename##0.basename##1.basename##2.basename##D3 )
#endmacro

#print "---------- public/public/public"
scope
	decl_T( UDT01, public, public, public )
	test_X( UDT01, 0, 0, 0 )
end scope

#print "---------- public/public/protected"
scope
	decl_T( UDT02, public, public, protected )
	test_X( UDT02, 0, 0, 1 )
end scope

#print "---------- public/public/private"
scope
	decl_T( UDT03, public, public, private )
	test_X( UDT03, 0, 0, 1 )
end scope

#print "---------- public/protected/public"
scope
	decl_T( UDT04, public, protected, public )
	test_X( UDT04, 0, 1, 1 )
end scope

#print "---------- public/protected/protected"
scope
	decl_T( UDT05, public, protected, protected )
	test_X( UDT05, 0, 1, 1 )
end scope

#print "---------- public/protected/private"
scope
	decl_T( UDT06, public, protected, private )
	test_X( UDT06, 0, 1, 1 )
end scope

#print "---------- public/private/public"
scope
	decl_T( UDT07, public, private, public )
	test_X( UDT07, 0, 1, 1 )
end scope

#print "---------- public/private/protected"
scope
	decl_T( UDT08, public, private, protected )
	test_X( UDT08, 0, 1, 1 )
end scope

#print "---------- public/private/private"
scope
	decl_T( UDT09, public, private, private )
	test_X( UDT09, 0, 1, 1 )
end scope

#print "---------- protected/public/public"
scope
	decl_T( UDT10, protected, public, public )
	test_X( UDT10, 1, 1, 1 )
end scope

#print "---------- protected/public/protected"
scope
	decl_T( UDT11, protected, public, protected )
	test_X( UDT11, 1, 1, 1 )
end scope

#print "---------- protected/public/private"
scope
	decl_T( UDT12, protected, public, private )
	test_X( UDT12, 1, 1, 1 )
end scope

#print "---------- protected/protected/public"
scope
	decl_T( UDT13, protected, protected, public )
	test_X( UDT13, 1, 1, 1 )
end scope

#print "---------- protected/protected/protected"
scope
	decl_T( UDT14, protected, protected, protected )
	test_X( UDT14, 1, 1, 1 )
end scope

#print "---------- protected/protected/private"
scope
	decl_T( UDT15, protected, protected, private )
	test_X( UDT15, 1, 1, 1 )
end scope

#print "---------- protected/private/public"
scope
	decl_T( UDT16, protected, private, public )
	test_X( UDT16, 1, 1, 1 )
end scope

#print "---------- protected/private/protected"
scope
	decl_T( UDT17, protected, private, protected )
	test_X( UDT17, 1, 1, 1 )
end scope

#print "---------- protected/private/private"
scope
	decl_T( UDT18, protected, private, private )
	test_X( UDT18, 1, 1, 1 )
end scope

#print "---------- private/public/public"
scope
	decl_T( UDT19, private, public, public )
	test_X( UDT19, 1, 1, 1 )
end scope

#print "---------- private/public/protected"
scope
	decl_T( UDT20, private, public, protected )
	test_X( UDT20, 1, 1, 1 )
end scope

#print "---------- private/public/private"
scope
	decl_T( UDT21, private, public, private )
	test_X( UDT21, 1, 1, 1 )
end scope

#print "---------- private/protected/public"
scope
	decl_T( UDT22, private, protected, public )
	test_X( UDT22, 1, 1, 1 )
end scope

#print "---------- private/protected/protected"
scope
	decl_T( UDT23, private, protected, protected )
	test_X( UDT23, 1, 1, 1 )
end scope

#print "---------- private/protected/private"
scope
	decl_T( UDT24, private, protected, private )
	test_X( UDT24, 1, 1, 1 )
end scope

#print "---------- private/private/public"
scope
	decl_T( UDT25, private, private, public )
	test_X( UDT25, 1, 1, 1 )
end scope

#print "---------- private/private/protected"
scope
	decl_T( UDT26, private, private, protected )
	test_X( UDT26, 1, 1, 1 )
end scope

#print "---------- private/private/private"
scope
	decl_T( UDT27, private, private, private )
	test_X( UDT27, 1, 1, 1 )
end scope
