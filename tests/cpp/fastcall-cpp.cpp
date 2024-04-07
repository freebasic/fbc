#ifndef __fastcall
#define __fastcall __attribute__((fastcall))
#endif

namespace cpp_fastcall
{
	__fastcall bool cpp_byval_bool1( bool a );
	__fastcall bool cpp_byval_bool2( bool a, bool b );
	__fastcall bool cpp_byval_bool3( bool a, bool b, bool c );
	__fastcall bool cpp_byref_bool1( bool &a );
	__fastcall bool cpp_byref_bool2( bool &a, bool &b );
	__fastcall bool cpp_byref_bool3( bool &a, bool &b, bool &c );

	__fastcall float cpp_byval_float( float a );
	__fastcall float cpp_byref_float( float &a );
	__fastcall double cpp_byval_double( double a );
	__fastcall double cpp_byref_double( double &a );

	__fastcall char cpp_byval_char_b( char a );
	__fastcall char cpp_byval_char_u( char a );
	__fastcall char cpp_byval_char_ub( char a );
	__fastcall char cpp_byref_char_b( char &a );
	__fastcall char cpp_byref_char_u( char &a );
	__fastcall char cpp_byref_char_ub( char &a );
	__fastcall unsigned char cpp_byval_uchar( unsigned char a );
	__fastcall signed char cpp_byval_schar( signed char a );
	__fastcall unsigned char cpp_byref_uchar( unsigned char &a );
	__fastcall signed char cpp_byref_schar( signed char &a );
	__fastcall unsigned short cpp_byval_ushort( unsigned short int a );
	__fastcall signed short cpp_byval_sshort( signed short int a );
	__fastcall unsigned short cpp_byref_ushort( unsigned short int &a );
	__fastcall signed short cpp_byref_sshort( signed short int &a );

	__fastcall unsigned int cpp_byval_uint( unsigned int a );
	__fastcall signed int cpp_byval_sint( signed int a );
	__fastcall unsigned int cpp_byref_uint( unsigned int &a );
	__fastcall signed int cpp_byref_sint( signed int &a );

	__fastcall unsigned long int cpp_byval_ulongint( unsigned long int a );
	__fastcall signed long int cpp_byval_slongint( signed long int a );
	__fastcall unsigned long int cpp_byref_ulongint( unsigned long int &a );
	__fastcall signed long int cpp_byref_slongint( signed long int &a );
	__fastcall unsigned long long int cpp_byval_ulonglongint( unsigned long long int a );
	__fastcall signed long long int cpp_byval_slonglongint( signed long long int a );
	__fastcall unsigned long long int cpp_byref_ulonglongint( unsigned long long int &a );
	__fastcall signed long long int cpp_byref_slonglongint( signed long long int &a );
	__fastcall int cpp__byval_int__byref_int__byref_int(int a, int &b, int &c);
	__fastcall int cpp__byval_const_int__byref_int__byref_int(const int a, int &b, int &c);
	__fastcall int cpp__byval_const_int_ptr__byref_int__byref_int(const int *a, int &b, int &c);
	__fastcall int cpp__byval_const_int_const_ptr__byref_int__byref_int(const int *const a, int &b, int &c);


	// bool

	bool cpp_byval_bool1( bool a )
	{
		return a;
	}

	bool cpp_byval_bool2( bool a, bool b )
	{
		return b;
	}

	bool cpp_byval_bool3( bool a, bool b, bool c )
	{
		return c;
	}

	bool cpp_byref_bool1( bool &a )
	{
		return a;
	}

	bool cpp_byref_bool2( bool &a, bool &b )
	{
		return b;
	}

	bool cpp_byref_bool3( bool &a, bool &b, bool &c )
	{
		return c;
	}

	// float

	float cpp_byval_float( float a )
	{
		return a;
	}

	float cpp_byref_float( float &a )
	{
		return a;
	}

	// double

	double cpp_byval_double( double a )
	{
		return a;
	}

	double cpp_byref_double( double &a )
	{
		return a;
	}

	// char = 8 bit

	char cpp_byval_char_b( char a )
	{
		return a;
	}

	char cpp_byval_char_u( char a )
	{
		return a;
	}

	char cpp_byval_char_ub( char a )
	{
		return a;
	}

	char cpp_byref_char_b( char &a )
	{
		return a;
	}

	char cpp_byref_char_u( char &a )
	{
		return a;
	}

	char cpp_byref_char_ub( char &a )
	{
		return a;
	}

	// signed | unsigned char = 8 bit

	unsigned char cpp_byval_uchar( unsigned char a )
	{
		return a;
	}

	signed char cpp_byval_schar( signed char a )
	{
		return a;
	}

	unsigned char cpp_byref_uchar( unsigned char &a )
	{
		return a;
	}

	signed char cpp_byref_schar( signed char &a )
	{
		return a;
	}

	// short int = 16 bit

	unsigned short cpp_byval_ushort( unsigned short int a )
	{
		return a;
	}

	signed short cpp_byval_sshort( signed short int a )
	{
		return a;
	}

	unsigned short cpp_byref_ushort( unsigned short int &a )
	{
		return a;
	}

	signed short cpp_byref_sshort( signed short int &a )
	{
		return a;
	}

	// int

	unsigned int cpp_byval_uint( unsigned int a )
	{
		return a;
	}

	signed int cpp_byval_sint( signed int a )
	{
		return a;
	}

	unsigned int cpp_byref_uint( unsigned int &a )
	{
		return a;
	}

	signed int cpp_byref_sint( signed int &a )
	{
		return a;
	}

	// long int

	unsigned long int cpp_byval_ulongint( unsigned long int a )
	{
		return a;
	}

	signed long int cpp_byval_slongint( signed long int a )
	{
		return a;
	}

	unsigned long int cpp_byref_ulongint( unsigned long int &a )
	{
		return a;
	}

	signed long int cpp_byref_slongint( signed long int &a )
	{
		return a;
	}

	// long long int = 64 bit

	unsigned long long int cpp_byval_ulonglongint( unsigned long long int a )
	{
		return a;
	}

	signed long long int cpp_byval_slonglongint( signed long long int a )
	{
		return a;
	}

	unsigned long long int cpp_byref_ulonglongint( unsigned long long int &a )
	{
		return a;
	}

	signed long long int cpp_byref_slonglongint( signed long long int &a )
	{
		return a;
	}

	// multiple non-trivial parameters, triggering the use of abbreviations

	// These 2 functions should have the same mangling (for parameters, not the name of course),
	// the CONST on the BYVAL parameter "a" should not make a difference.
	int cpp__byval_int__byref_int__byref_int(int a, int &b, int &c)
	{
		return a;
	}
	int cpp__byval_const_int__byref_int__byref_int(const int a, int &b, int &c)
	{
		return a;
	}

	int cpp__byval_const_int_ptr__byref_int__byref_int(const int *a, int &b, int &c)
	{
		return *a;
	}
	int cpp__byval_const_int_const_ptr__byref_int__byref_int(const int *const a, int &b, int &c)
	{
		return *a;
	}
}
