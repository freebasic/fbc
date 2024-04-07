#include "fbcunit.bi"

'' test combinations of variable shadowing on
'' m = module
'' p = parent
'' c = child (extends parent)
'' v = variable

dim shared as integer m___ = 401
dim shared as integer mp__ = 403
dim shared as integer m_c_ = 405
dim shared as integer mpc_ = 407
dim shared as integer m__v = 409
dim shared as integer mp_v = 411
dim shared as integer m_cv = 413
dim shared as integer mpcv = 415

type Parent extends object
	as integer _p__ = 302
	as integer mp__ = 303
	as integer _pc_ = 306
	as integer mpc_ = 307
	as integer _p_v = 310
	as integer mp_v = 311
	as integer _pcv = 314
	as integer mpcv = 315

	declare virtual sub test_proc()
end type

sub Parent.test_proc()
	dim as integer ___v = 108
	dim as integer m__v = 109
	dim as integer _p_v = 110
	dim as integer mp_v = 111
	dim as integer __cv = 112
	dim as integer m_cv = 113
	dim as integer _pcv = 114
	dim as integer mpcv = 115

	CU_ASSERT_EQUAL( m___ , 401 ) '' module only
	CU_ASSERT_EQUAL( _p__ , 302 ) '' parent only
	CU_ASSERT_EQUAL( mp__ , 303 ) '' parent shadows module
''	CU_ASSERT_EQUAL( __c_ , 000 ) '' invalid (no child)
	CU_ASSERT_EQUAL( m_c_ , 405 ) '' module (no child)
	CU_ASSERT_EQUAL( _pc_ , 306 ) '' parent (no child)
	CU_ASSERT_EQUAL( mpc_ , 307 ) '' parent shadows module
	CU_ASSERT_EQUAL( ___v , 108 ) '' variable only
	CU_ASSERT_EQUAL( m__v , 109 ) '' variable shadows module
	CU_ASSERT_EQUAL( _p_v , 110 ) '' variable (no parent)
	CU_ASSERT_EQUAL( mp_v , 111 ) '' variable shadows module/parent
	CU_ASSERT_EQUAL( __cv , 112 ) '' variable (no parent)
	CU_ASSERT_EQUAL( m_cv , 113 ) '' variable shadows parent/child
	CU_ASSERT_EQUAL( _pcv , 114 ) '' variable (no parent/child)
	CU_ASSERT_EQUAL( mpcv , 115 ) '' variable shadows module/parent/child

	CU_ASSERT_EQUAL( this._p__ , 302 ) '' parent
	CU_ASSERT_EQUAL( this.mp__ , 303 ) '' parent
	CU_ASSERT_EQUAL( this._pc_ , 306 ) '' parent
	CU_ASSERT_EQUAL( this.mpc_ , 307 ) '' parent
	CU_ASSERT_EQUAL( this._p_v , 310 ) '' parent
	CU_ASSERT_EQUAL( this.mp_v , 311 ) '' parent
	CU_ASSERT_EQUAL( this._pcv , 314 ) '' parent
	CU_ASSERT_EQUAL( this.mpcv , 315 ) '' parent

	CU_ASSERT_EQUAL( .m___ , 401 ) '' module
	CU_ASSERT_EQUAL( .mp__ , 403 ) '' module
	CU_ASSERT_EQUAL( .m_c_ , 405 ) '' module
	CU_ASSERT_EQUAL( .mpc_ , 407 ) '' module
	CU_ASSERT_EQUAL( .m__v , 409 ) '' module
	CU_ASSERT_EQUAL( .mp_v , 411 ) '' module
	CU_ASSERT_EQUAL( .m_cv , 413 ) '' module
	CU_ASSERT_EQUAL( .mpcv , 415 ) '' module

	CU_ASSERT_EQUAL( ..m___ , 401 ) '' module
	CU_ASSERT_EQUAL( ..mp__ , 403 ) '' module
	CU_ASSERT_EQUAL( ..m_c_ , 405 ) '' module
	CU_ASSERT_EQUAL( ..mpc_ , 407 ) '' module
	CU_ASSERT_EQUAL( ..m__v , 409 ) '' module
	CU_ASSERT_EQUAL( ..mp_v , 411 ) '' module
	CU_ASSERT_EQUAL( ..m_cv , 413 ) '' module
	CU_ASSERT_EQUAL( ..mpcv , 415 ) '' module
end sub

type Child extends Parent
	as integer __c_ = 204
	as integer m_c_ = 205
	as integer _pc_ = 206
	as integer mpc_ = 207
	as integer __cv = 212
	as integer m_cv = 213
	as integer _pcv = 214
	as integer mpcv = 215

	declare virtual sub test_proc()
end type

sub Child.test_proc()
	dim as integer ___v = 108
	dim as integer m__v = 109
	dim as integer _p_v = 110
	dim as integer mp_v = 111
	dim as integer __cv = 112
	dim as integer m_cv = 113
	dim as integer _pcv = 114
	dim as integer mpcv = 115

	CU_ASSERT_EQUAL( m___ , 401 ) '' module only
	CU_ASSERT_EQUAL( _p__ , 302 ) '' parent only
	CU_ASSERT_EQUAL( mp__ , 303 ) '' parent shadows module
	CU_ASSERT_EQUAL( __c_ , 204 ) '' child only
	CU_ASSERT_EQUAL( m_c_ , 205 ) '' child shadows module
	CU_ASSERT_EQUAL( _pc_ , 206 ) '' child shadows parent
	CU_ASSERT_EQUAL( mpc_ , 207 ) '' child shadows module/parent
	CU_ASSERT_EQUAL( ___v , 108 ) '' variable only
	CU_ASSERT_EQUAL( m__v , 109 ) '' variable shadows module
	CU_ASSERT_EQUAL( _p_v , 110 ) '' variable shadows parent
	CU_ASSERT_EQUAL( mp_v , 111 ) '' variable shadows module/parent
	CU_ASSERT_EQUAL( __cv , 112 ) '' variable shadows child
	CU_ASSERT_EQUAL( m_cv , 113 ) '' variable shadows module/child
	CU_ASSERT_EQUAL( _pcv , 114 ) '' variable shadows parent/child
	CU_ASSERT_EQUAL( mpcv , 115 ) '' variable shadows module/parent/child

	CU_ASSERT_EQUAL( this._p__ , 302 ) '' parent
	CU_ASSERT_EQUAL( this.mp__ , 303 ) '' parent
	CU_ASSERT_EQUAL( this.__c_ , 204 ) '' child
	CU_ASSERT_EQUAL( this.m_c_ , 205 ) '' child
	CU_ASSERT_EQUAL( this._pc_ , 206 ) '' child
	CU_ASSERT_EQUAL( this.mpc_ , 207 ) '' child
	CU_ASSERT_EQUAL( this._p_v , 310 ) '' parent
	CU_ASSERT_EQUAL( this.mp_v , 311 ) '' parent
	CU_ASSERT_EQUAL( this.__cv , 212 ) '' child
	CU_ASSERT_EQUAL( this.m_cv , 213 ) '' child
	CU_ASSERT_EQUAL( this._pcv , 214 ) '' child
	CU_ASSERT_EQUAL( this.mpcv , 215 ) '' child

	CU_ASSERT_EQUAL( base._p__ , 302 ) '' parent
	CU_ASSERT_EQUAL( base.mp__ , 303 ) '' parent
	CU_ASSERT_EQUAL( base._pc_ , 306 ) '' parent
	CU_ASSERT_EQUAL( base.mpc_ , 307 ) '' parent
	CU_ASSERT_EQUAL( base._p_v , 310 ) '' parent
	CU_ASSERT_EQUAL( base.mp_v , 311 ) '' parent
	CU_ASSERT_EQUAL( base._pcv , 314 ) '' parent
	CU_ASSERT_EQUAL( base.mpcv , 315 ) '' parent

	CU_ASSERT_EQUAL( .m___ , 401 ) '' module
	CU_ASSERT_EQUAL( .mp__ , 403 ) '' module
	CU_ASSERT_EQUAL( .m_c_ , 405 ) '' module
	CU_ASSERT_EQUAL( .mpc_ , 407 ) '' module
	CU_ASSERT_EQUAL( .m__v , 409 ) '' module
	CU_ASSERT_EQUAL( .mp_v , 411 ) '' module
	CU_ASSERT_EQUAL( .m_cv , 413 ) '' module
	CU_ASSERT_EQUAL( .mpcv , 415 ) '' module

	CU_ASSERT_EQUAL( ..m___ , 401 ) '' module
	CU_ASSERT_EQUAL( ..mp__ , 403 ) '' module
	CU_ASSERT_EQUAL( ..m_c_ , 405 ) '' module
	CU_ASSERT_EQUAL( ..mpc_ , 407 ) '' module
	CU_ASSERT_EQUAL( ..m__v , 409 ) '' module
	CU_ASSERT_EQUAL( ..mp_v , 411 ) '' module
	CU_ASSERT_EQUAL( ..m_cv , 413 ) '' module
	CU_ASSERT_EQUAL( ..mpcv , 415 ) '' module
end sub

sub test_proc()
	dim as integer ___v = 108
	dim as integer m__v = 109
	dim as integer _p_v = 110
	dim as integer mp_v = 111
	dim as integer __cv = 112
	dim as integer m_cv = 113
	dim as integer _pcv = 114
	dim as integer mpcv = 115

	CU_ASSERT_EQUAL( m___ , 401 ) '' module only
''	CU_ASSERT_EQUAL( _p__ , 000 ) '' invalid (no parent)
	CU_ASSERT_EQUAL( mp__ , 403 ) '' module (no parent)
''	CU_ASSERT_EQUAL( __c_ , 000 ) '' invalid (no child)
	CU_ASSERT_EQUAL( m_c_ , 405 ) '' module (no child)
''	CU_ASSERT_EQUAL( _pc_ , 000 ) '' invalid (no parent/child)
	CU_ASSERT_EQUAL( mpc_ , 407 ) '' module (no parent/child)
	CU_ASSERT_EQUAL( ___v , 108 ) '' variable only
	CU_ASSERT_EQUAL( m__v , 109 ) '' variable shadows module
	CU_ASSERT_EQUAL( _p_v , 110 ) '' variable only
	CU_ASSERT_EQUAL( mp_v , 111 ) '' variable shadows module
	CU_ASSERT_EQUAL( __cv , 112 ) '' variable only
	CU_ASSERT_EQUAL( m_cv , 113 ) '' variable shadows module
	CU_ASSERT_EQUAL( _pcv , 114 ) '' variable only
	CU_ASSERT_EQUAL( mpcv , 115 ) '' variable shadows module

	CU_ASSERT_EQUAL( .m___ , 401 ) '' module
	CU_ASSERT_EQUAL( .mp__ , 403 ) '' module
	CU_ASSERT_EQUAL( .m_c_ , 405 ) '' module
	CU_ASSERT_EQUAL( .mpc_ , 407 ) '' module
	CU_ASSERT_EQUAL( .m__v , 409 ) '' module
	CU_ASSERT_EQUAL( .mp_v , 411 ) '' module
	CU_ASSERT_EQUAL( .m_cv , 413 ) '' module
	CU_ASSERT_EQUAL( .mpcv , 415 ) '' module

	CU_ASSERT_EQUAL( ..m___ , 401 ) '' module
	CU_ASSERT_EQUAL( ..mp__ , 403 ) '' module
	CU_ASSERT_EQUAL( ..m_c_ , 405 ) '' module
	CU_ASSERT_EQUAL( ..mpc_ , 407 ) '' module
	CU_ASSERT_EQUAL( ..m__v , 409 ) '' module
	CU_ASSERT_EQUAL( ..mp_v , 411 ) '' module
	CU_ASSERT_EQUAL( ..m_cv , 413 ) '' module
	CU_ASSERT_EQUAL( ..mpcv , 415 ) '' module
end sub

SUITE( fbc_tests.structs.member_var_shadow )
	TEST( test_module )
		test_proc()
	END_TEST
	TEST( test_parent )
		dim x as Parent
		x.test_proc()
	END_TEST
	TEST( test_child )
		dim x as Child
		x.test_proc()
	END_TEST
END_SUITE
