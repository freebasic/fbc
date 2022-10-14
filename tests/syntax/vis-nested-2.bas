'' Test visibility of CONST from outside
'' a type containing nested (inner scoped) types 3 levels deep
'' within a local scope
''
'' each combination of public, protected, private is checked for
'' each nested level requiring 3*3*3=27 cases
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
	type basename##0 extends object
		scope1:
			const c0 = 1
			type basename##1 extends object
				scope2:
					const c1 = 2
					type basename##2 extends object
						scope3:
							const c2 = 3
							type basename##3 extends object
								const c3 = 4
							end type
					end type
			end type
	end type
#endmacro

#macro test_X0( basename, rt, r0, r1, r2, r3 )
	t( r0, 1, var i00 = basename##0.c0 )
	t( r1, 2, var i01 = basename##0.basename##1.c1 )
	t( r2, 3, var i02 = basename##0.basename##1.basename##2.c2 )
	t( r3, 4, var i03 = basename##0.basename##1.basename##2.basename##3.c3 )
#endmacro
#macro test_X1( basename, r0, r1, r2, r3 )
	t( r1, 1, var i11 = basename##0.basename##1.c1 )
	t( r2, 2, var i12 = basename##0.basename##1.basename##2.c2 )
	t( r3, 3, var i13 = basename##0.basename##1.basename##2.basename##3.c3 )
#endmacro
#macro test_X2( basename, r0, r2, r3 )
	t( r2, 1, var i22 = basename##0.basename##1.basename##2.c2 )
	t( r3, 2, var i23 = basename##0.basename##1.basename##2.basename##3.c3 )
#endmacro
#macro test_X3( basename, r0, r3 )
	t( r3, 1, var i33 = basename##0.basename##1.basename##2.basename##3.c3 )
#endmacro

#print "---------- public/public/public"
decl_T( UDT01, public, public, public )
scope
	test_X0( UDT01, 0, 0, 0, 0, 0 )
	test_X1( UDT01,    0, 0, 0, 0 )
	test_X2( UDT01,       0, 0, 0 )
	test_X3( UDT01,          0, 0 )
end scope


#print "---------- public/public/protected"
decl_T( UDT02, public, public, protected )
scope
	test_X0( UDT02, 0, 0, 0, 1, 1 )
	test_X1( UDT02,    0, 0, 1, 1 )
	test_X2( UDT02,       0, 1, 1 )
	test_X3( UDT02,          1, 1 )
end scope

#print "---------- public/public/private"
decl_T( UDT03, public, public, private )
scope
	test_X0( UDT03, 0, 0, 0, 1, 1 )
	test_X1( UDT03,    0, 0, 1, 1 )
	test_X2( UDT03,       0, 1, 1 )
	test_X3( UDT03,          1, 1 )
end scope

#print "---------- public/protected/public"
decl_T( UDT04, public, protected, public )
scope
	test_X0( UDT04, 0, 0, 1, 1, 1 )
	test_X1( UDT04,    0, 1, 1, 1 )
	test_X2( UDT04,       1, 1, 1 )
	test_X3( UDT04,          1, 1 )
end scope

#print "---------- public/protected/protected"
decl_T( UDT05, public, protected, protected )
scope
	test_X0( UDT05, 0, 0, 1, 1, 1 )
	test_X1( UDT05,    0, 1, 1, 1 )
	test_X2( UDT05,       1, 1, 1 )
	test_X3( UDT05,          1, 1 )
end scope

#print "---------- public/protected/private"
decl_T( UDT06, public, protected, private )
scope
	test_X0( UDT06, 0, 0, 1, 1, 1 )
	test_X1( UDT06,    0, 1, 1, 1 )
	test_X2( UDT06,       1, 1, 1 )
	test_X3( UDT06,          1, 1 )
end scope

#print "---------- public/private/public"
decl_T( UDT07, public, private, public )
scope
	test_X0( UDT07, 0, 0, 1, 1, 1 )
	test_X1( UDT07,    0, 1, 1, 1 )
	test_X2( UDT07,       1, 1, 1 )
	test_X3( UDT07,          1, 1 )
end scope

#print "---------- public/private/protected"
decl_T( UDT08, public, private, protected )
scope
	test_X0( UDT08, 0, 0, 1, 1, 1 )
	test_X1( UDT08,    0, 1, 1, 1 )
	test_X2( UDT08,       1, 1, 1 )
	test_X3( UDT08,          1, 1 )
end scope

#print "---------- public/private/private"
decl_T( UDT09, public, private, private )
scope
	test_X0( UDT09, 0, 0, 1, 1, 1 )
	test_X1( UDT09,    0, 1, 1, 1 )
	test_X2( UDT09,       1, 1, 1 )
	test_X3( UDT09,          1, 1 )
end scope

#print "---------- protected/public/public"
decl_T( UDT10, protected, public, public )
scope
	test_X0( UDT10, 0, 1, 1, 1, 1 )
	test_X1( UDT10,    1, 1, 1, 1 )
	test_X2( UDT10,       1, 1, 1 )
	test_X3( UDT10,          1, 1 )
end scope

#print "---------- protected/public/protected"
decl_T( UDT11, protected, public, protected )
scope
	test_X0( UDT11, 0, 1, 1, 1, 1 )
	test_X1( UDT11,    1, 1, 1, 1 )
	test_X2( UDT11,       1, 1, 1 )
	test_X3( UDT11,          1, 1 )
end scope

#print "---------- protected/public/private"
decl_T( UDT12, protected, public, private )
scope
	test_X0( UDT12, 0, 1, 1, 1, 1 )
	test_X1( UDT12,    1, 1, 1, 1 )
	test_X2( UDT12,       1, 1, 1 )
	test_X3( UDT12,          1, 1 )
end scope

#print "---------- protected/protected/public"
decl_T( UDT13, protected, protected, public )
scope
	test_X0( UDT13, 0, 1, 1, 1, 1 )
	test_X1( UDT13,    1, 1, 1, 1 )
	test_X2( UDT13,       1, 1, 1 )
	test_X3( UDT13,          1, 1 )
end scope

#print "---------- protected/protected/protected"
decl_T( UDT14, protected, protected, protected )
scope
	test_X0( UDT14, 0, 1, 1, 1, 1 )
	test_X1( UDT14,    1, 1, 1, 1 )
	test_X2( UDT14,       1, 1, 1 )
	test_X3( UDT14,          1, 1 )
end scope

#print "---------- protected/protected/private"
decl_T( UDT15, protected, protected, private )
scope
	test_X0( UDT15, 0, 1, 1, 1, 1 )
	test_X1( UDT15,    1, 1, 1, 1 )
	test_X2( UDT15,       1, 1, 1 )
	test_X3( UDT15,          1, 1 )
end scope

#print "---------- protected/private/public"
decl_T( UDT16, protected, private, public )
scope
	test_X0( UDT16, 0, 1, 1, 1, 1 )
	test_X1( UDT16,    1, 1, 1, 1 )
	test_X2( UDT16,       1, 1, 1 )
	test_X3( UDT16,          1, 1 )
end scope

#print "---------- protected/private/protected"
decl_T( UDT17, protected, private, protected )
scope
	test_X0( UDT17, 0, 1, 1, 1, 1 )
	test_X1( UDT17,    1, 1, 1, 1 )
	test_X2( UDT17,       1, 1, 1 )
	test_X3( UDT17,          1, 1 )
end scope

#print "---------- protected/private/private"
decl_T( UDT18, protected, private, private )
scope
	test_X0( UDT18, 0, 1, 1, 1, 1 )
	test_X1( UDT18,    1, 1, 1, 1 )
	test_X2( UDT18,       1, 1, 1 )
	test_X3( UDT18,          1, 1 )
end scope

#print "---------- private/public/public"
decl_T( UDT19, private, public, public )
scope
	test_X0( UDT19, 0, 1, 1, 1, 1 )
	test_X1( UDT19,    1, 1, 1, 1 )
	test_X2( UDT19,       1, 1, 1 )
	test_X3( UDT19,          1, 1 )
end scope

#print "---------- private/public/protected"
decl_T( UDT20, private, public, protected )
scope
	test_X0( UDT20, 0, 1, 1, 1, 1 )
	test_X1( UDT20,    1, 1, 1, 1 )
	test_X2( UDT20,       1, 1, 1 )
	test_X3( UDT20,          1, 1 )
end scope

#print "---------- private/public/private"
decl_T( UDT21, private, public, private )
scope
	test_X0( UDT21, 0, 1, 1, 1, 1 )
	test_X1( UDT21,    1, 1, 1, 1 )
	test_X2( UDT21,       1, 1, 1 )
	test_X3( UDT21,          1, 1 )
end scope

#print "---------- private/protected/public"
decl_T( UDT22, private, protected, public )
scope
	test_X0( UDT22, 0, 1, 1, 1, 1 )
	test_X1( UDT22,    1, 1, 1, 1 )
	test_X2( UDT22,       1, 1, 1 )
	test_X3( UDT22,          1, 1 )
end scope

#print "---------- private/protected/protected"
decl_T( UDT23, private, protected, protected )
scope
	test_X0( UDT23, 0, 1, 1, 1, 1 )
	test_X1( UDT23,    1, 1, 1, 1 )
	test_X2( UDT23,       1, 1, 1 )
	test_X3( UDT23,          1, 1 )
end scope

#print "---------- private/protected/private"
decl_T( UDT24, private, protected, private )
scope
	test_X0( UDT24, 0, 1, 1, 1, 1 )
	test_X1( UDT24,    1, 1, 1, 1 )
	test_X2( UDT24,       1, 1, 1 )
	test_X3( UDT24,          1, 1 )
end scope

#print "---------- private/private/public"
decl_T( UDT25, private, private, public )
scope
	test_X0( UDT25, 0, 1, 1, 1, 1 )
	test_X1( UDT25,    1, 1, 1, 1 )
	test_X2( UDT25,       1, 1, 1 )
	test_X3( UDT25,          1, 1 )
end scope

#print "---------- private/private/protected"
decl_T( UDT26, private, private, protected )
scope
	test_X0( UDT26, 0, 1, 1, 1, 1 )
	test_X1( UDT26,    1, 1, 1, 1 )
	test_X2( UDT26,       1, 1, 1 )
	test_X3( UDT26,          1, 1 )
end scope

#print "---------- private/private/private"
decl_T( UDT27, private, private, private )
scope
	test_X0( UDT27, 0, 1, 1, 1, 1 )
	test_X1( UDT27,    1, 1, 1, 1 )
	test_X2( UDT27,       1, 1, 1 )
	test_X3( UDT27,          1, 1 )
end scope
