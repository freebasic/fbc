'' check for defintions of some types
'' #if / #ifndef / defined()
'' - #define gSymbol
'' - shared variable
'' - const gConst
'' - enum gEnum
'' - gEnum.eValue
'' - gEnum.novalue
'' - namespace ns
'' - ns.value / ns.novalue
'' - sub proc() and local variable

#if gSymbol
	#print "gSymbol has const value - NOK"
#else
	#print "gSymbol not defined"
#endif

#if defined( gSymbol )
	#print "gSymbol defined - NOK"
#else
	#print "gSymbol not defined"
#endif

#ifdef gSymbol
	#print "gSymbol defined - NOK"
#else
	#print "gSymbol not defined"
#endif

#ifndef gSymbol
	#print "gSymbol not defined"
#else
	#print "gSymbol defined = NOK"
#endif

#define gSymbol 1

#if gSymbol
	#print "gSymbol has const value"
#else
	#print "gSymbol not defined - NOK"
#endif

#if defined( gSymbol )
	#print "gSymbol defined"
#else
	#print "gSymbol not defined - NOK"
#endif

#ifdef gSymbol
	#print "gSymbol defined"
#else
	#print "gSymbol not defined - NOK"
#endif

#ifndef gSymbol
	#print "gSymbol not defined - NOK"
#else
	#print "gSymbol defined"
#endif

#print -------------------

const gConst = 1

#if gConst
	#print "gConst has const value"
#else
	#print "gConst not defined - NOK"
#endif

#if defined( gConst )
	#print "gConst defined"
#else
	#print "gConst not defined - NOK"
#endif

#ifdef gConst
	#print "gConst defined"
#else
	#print "gConst not defined - NOK"
#endif

#ifndef gConst
	#print "gConst not defined - NOK"
#else
	#print "gConst defined"
#endif

#print -------------------

var shared variable = 1

#if defined( variable )
	#print "variable defined"
#else
	#print "variable not defined - NOK"
#endif

#ifdef variable
	#print "variable defined"
#else
	#print "variable not defined - NOK"
#endif

#ifndef variable
	#print "variable not defined - NOK"
#else
	#print "variable defined"
#endif

#print -------------------

namespace ns
end namespace

#if defined( ns )
	#print "ns defined"
#else
	#print "ns not defined - NOK"
#endif

#ifdef ns
	#print "ns defined"
#else
	#print "ns not defined - NOK"
#endif

#ifndef ns
	#print "ns not defined - NOK"
#else
	#print "ns defined"
#endif

#if defined( ns.novalue )
	#print "ns.novalue defined - NOK"
#else
	#print "ns.novalue not defined"
#endif

#ifdef ns.novalue
	#print "ns.novalue defined - NOK"
#else
	#print "ns.novalue not defined"
#endif

#ifndef ns.novalue
	#print "ns.novalue not defined"
#else
	#print "ns.novalue defined - NOK"
#endif

namespace ns
	const value = 2
end namespace

#if defined( ns.value )
	#print "ns.value defined"
#else
	#print "ns.value not defined - NOK"
#endif

#ifdef ns.value
	#print "ns.value defined"
#else
	#print "ns.value not defined - NOK"
#endif

#ifndef ns.value
	#print "ns.value not defined - NOK"
#else
	#print "ns.value defined"
#endif


#print -------------------

enum gEnum
	eValue
end enum

#if defined( gEnum )
	#print "gEnum defined"
#else
	#print "gEnum not defined - NOK"
#endif

#ifdef gEnum
	#print "gEnum defined"
#else
	#print "gEnum not defined - NOK"
#endif

#ifndef gEnum
	#print "gEnum not defined - NOK"
#else
	#print "gEnum defined"
#endif

#if defined( gEnum.novalue )
	#print "gEnum.novalue defined - NOK"
#else
	#print "gEnum.novalue not defined"
#endif

#ifdef gEnum.novalue
	#print "gEnum.novalue defined - NOK"
#else
	#print "gEnum.novalue not defined"
#endif

#ifndef gEnum.novalue
	#print "gEnum.novalue not defined"
#else
	#print "gEnum.novalue defined - NOK"
#endif

#if defined( gEnum.eValue )
	#print "gEnum.eValue defined"
#else
	#print "gEnum.eValue not defined - NOK"
#endif

#ifdef gEnum.eValue
	#print "gEnum.eValue defined"
#else
	#print "gEnum.eValue not defined - NOK"
#endif

#ifndef gEnum.eValue
	#print "gEnum.eValue not defined - NOK"
#else
	#print "gEnum.eValue defined"
#endif

#print -------------------

sub __PROC1__
	dim as integer localvar

	#if defined( localvar )
		#print "localvar defined"
	#else
		#print "localvar not defined - NOK"
	#endif

	#ifdef localvar
		#print "localvar defined"
	#else
		#print "localvar not defined - NOK"
	#endif

	#ifndef localvar
		#print "localvar not defined - NOK"
	#else
		#print "localvar defined"
	#endif

	#if defined( .noglobal )
		#print ".noglobal defined - NOK"
	#else
		#print ".noglobal not defined"
	#endif

	#ifdef .noglobal
		#print ".noglobal defined - NOK"
	#else
		#print ".noglobal not defined"
	#endif

	#ifndef .noglobal
		#print ".noglobal not defined"
	#else
		#print ".noglobal defined - NOK"
	#endif

	#if defined( ..noglobal )
		#print "..noglobal defined - NOK"
	#else
		#print "..noglobal not defined"
	#endif

	#ifdef ..noglobal
		#print "..noglobal defined - NOK"
	#else
		#print "..noglobal not defined"
	#endif

	#ifndef ..noglobal
		#print "..noglobal not defined"
	#else
		#print "..noglobal defined - NOK"
	#endif

	#if defined( .localvar )
		#print ".localvar defined - NOK"
	#else
		#print ".localvar not defined"
	#endif

	#ifdef .localvar
		#print ".localvar defined - NOK"
	#else
		#print ".localvar not defined"
	#endif

	#ifndef .localvar
		#print ".localvar not defined"
	#else
		#print ".localvar defined - NOK"
	#endif

	#if defined( ..localvar )
		#print "..localvar defined - NOK"
	#else
		#print "..localvar not defined"
	#endif

	#ifdef ..localvar
		#print "..localvar defined - NOK"
	#else
		#print "..localvar not defined"
	#endif

	#ifndef ..localvar
		#print "..localvar not defined"
	#else
		#print "..localvar defined - NOK"
	#endif
end sub

#print -------------------

#print "EXPECT ERROR TO FOLLOW"
#if variable
	#print "variable has const value - NOK"
#else
	#print "variable not defined or has no value"
#endif

#print "EXPECT ERROR TO FOLLOW"
#if ns
	#print "ns has const value - NOK"
#else
	#print "ns not defined or has no value"
#endif

#print "EXPECT ERROR TO FOLLOW"
#if ns.novalue
	#print "ns.novalue has const value - NOK"
#else
	#print "ns.novalue not defined or has no value"
#endif

#print "EXPECT ERROR TO FOLLOW (but we don't get one)"
#if gEnum
	#print "gEnum defined has const value - NOK"
#else
	#print "gEnum not defined or has no value"
#endif

#print "EXPECT ERROR TO FOLLOW (but we don't get one)"
#if gEnum.novalue
	#print "gEnum.novalue has const value - NOK"
#else
	#print "gEnum.novalue not defined with value"
#endif
