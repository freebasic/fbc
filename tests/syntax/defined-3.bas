type T
	value as integer
	static svalue as integer
	declare sub proc()
	declare static sub sproc()
end type

sub T.proc()

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

#if ENABLE_CHECK_BUGS

	#if defined( T.value )
		#print "T.value defined"
	#else
		#print "T.value not defined - NOK"
	#endif

	#if defined( T.proc )
		#print "T.proc defined"
	#else
		#print "T.proc not defined - NOK"
	#endif

	#if defined( T.svalue )
		#print "T.svalue defined"
	#else
		#print "T.svalue not defined - NOK"
	#endif

	#if defined( T.sproc )
		#print "T.sproc defined"
	#else
		#print "T.sproc not defined - NOK"
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
