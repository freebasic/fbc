#print "T1 -- fields only"
type T1
	value as integer
end type

#if defined( T1.value )
	#print "T1.value defined"
#else
	#print "T1.value not defined - NOK"
#endif

#if defined( T1.constructor )
	#print "T1.constructor defined - NOK"
#else
	#print "T1.constructor not defined"
#endif

#if defined( T1.destructor )
	#print "T1.constructor defined - NOK"
#else
	#print "T1.constructor not defined"
#endif

#if defined( T1.let )
	#print "T1.let defined - NOK"
#else
	#print "T1.let not defined"
#endif

#if defined( T1.cast )
	#print "T1.cast defined - NOK"
#else
	#print "T1.cast not defined"
#endif

#print "T2 -- fields and procedures"
type T2
	value as integer
	static svalue as integer
	declare sub proc()
	declare static sub sproc()
end type

sub T2.proc()

	#if defined( value )
		#print "value defined"
	#else
		#print "value not defined - NOK"
	#endif

	#if defined( proc )
		#print "proc defined"
	#else
		#print "proc not defined - NOK"
	#endif

	#if defined( svalue )
		#print "svalue defined"
	#else
		#print "svalue not defined - NOK"
	#endif

	#if defined( sproc )
		#print "sproc defined"
	#else
		#print "sproc not defined - NOK"
	#endif

	#if defined( T2.value )
		#print "T2.value defined"
	#else
		#print "T2.value not defined - NOK"
	#endif

	#if defined( T2.proc )
		#print "T2.proc defined"
	#else
		#print "T2.proc not defined - NOK"
	#endif

	#if defined( T2.svalue )
		#print "T2.svalue defined"
	#else
		#print "T2.svalue not defined - NOK"
	#endif

	#if defined( T2.sproc )
		#print "T2.sproc defined"
	#else
		#print "T2.sproc not defined - NOK"
	#endif

	#if defined( T2.constructor )
		#print "T2.constructor defined - NOK"
	#else
		#print "T2.constructor not defined"
	#endif
	
	#if defined( T2.destructor )
		#print "T2.constructor defined - NOK"
	#else
		#print "T2.constructor not defined"
	#endif
	
	#if defined( T2.let )
		#print "T2.let defined - NOK"
	#else
		#print "T2.let not defined"
	#endif
	
	#if defined( T2.cast )
		#print "T2.cast defined - NOK"
	#else
		#print "T2.cast not defined"
	#endif

#if ENABLE_CHECK_BUGS

	#if defined( this.svalue )
		#print "this.svalue defined"
	#else
		#print "this.svalue not defined - NOK"
	#endif

	#if defined( this.sproc )
		#print "this.sproc defined"
	#else
		#print "this.sproc not defined - NOK"
	#endif

	#if defined( this.svalue )
		#print "this.svalue defined"
	#else
		#print "this.svalue not defined - NOK"
	#endif

	#if defined( this.sproc )
		#print "this.sproc defined"
	#else
		#print "this.sproc not defined - NOK"
	#endif
#endif

end sub
