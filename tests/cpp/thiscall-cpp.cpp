#ifndef __thiscall
#define __thiscall __attribute__((thiscall))
#endif

namespace cpp_thiscall
{
	__thiscall bool cpp_byval_bool( bool a );
	__thiscall bool cpp_byref_bool( bool &a );
	__thiscall float cpp_byval_float( float a );
	__thiscall float cpp_byref_float( float &a );
	__thiscall double cpp_byval_double( double a );
	__thiscall double cpp_byref_double( double &a );
	__thiscall char cpp_byval_char_b( char a );
	__thiscall char cpp_byval_char_u( char a );
	__thiscall char cpp_byval_char_ub( char a );
	__thiscall char cpp_byref_char_b( char &a );
	__thiscall char cpp_byref_char_u( char &a );
	__thiscall char cpp_byref_char_ub( char &a );
	__thiscall unsigned char cpp_byval_uchar( unsigned char a );
	__thiscall signed char cpp_byval_schar( signed char a );
	__thiscall unsigned char cpp_byref_uchar( unsigned char &a );
	__thiscall signed char cpp_byref_schar( signed char &a );
	__thiscall unsigned short cpp_byval_ushort( unsigned short int a );
	__thiscall signed short cpp_byval_sshort( signed short int a );
	__thiscall unsigned short cpp_byref_ushort( unsigned short int &a );
	__thiscall signed short cpp_byref_sshort( signed short int &a );
	__thiscall unsigned int cpp_byval_uint( unsigned int a );
	__thiscall signed int cpp_byval_sint( signed int a );
	__thiscall unsigned int cpp_byref_uint( unsigned int &a );
	__thiscall signed int cpp_byref_sint( signed int &a );
	__thiscall unsigned long int cpp_byval_ulongint( unsigned long int a );
	__thiscall signed long int cpp_byval_slongint( signed long int a );
	__thiscall unsigned long int cpp_byref_ulongint( unsigned long int &a );
	__thiscall signed long int cpp_byref_slongint( signed long int &a );
	__thiscall unsigned long long int cpp_byval_ulonglongint( unsigned long long int a );
	__thiscall signed long long int cpp_byval_slonglongint( signed long long int a );
	__thiscall unsigned long long int cpp_byref_ulonglongint( unsigned long long int &a );
	__thiscall signed long long int cpp_byref_slonglongint( signed long long int &a );
	__thiscall double cpp_byval_const_double( const double a );
	__thiscall double cpp_byval_double_ptr( double* a );
	__thiscall double cpp_byval_const_double_ptr( double const* a );
	__thiscall double cpp_byval_double_const_ptr( double* const a );
	__thiscall double cpp_byval_const_double_const_ptr( double const* const a );
	__thiscall double cpp_byval_double_ptr_ptr( double** a );
	__thiscall double cpp_byval_const_double_ptr_ptr( double const** a );
	__thiscall double cpp_byval_double_const_ptr_ptr( double* const* a );
	__thiscall double cpp_byval_double_ptr_const_ptr( double** const a );
	__thiscall double cpp_byref_const_double( double const& a );
	__thiscall double cpp_byref_double_ptr( double*& a );
	__thiscall double cpp_byref_const_double_ptr( double const*& a );
	__thiscall double cpp_byref_double_const_ptr( double* const& a );
	__thiscall double cpp_byref_const_double_const_ptr( double const* const& a );
	__thiscall double cpp_byref_double_ptr_ptr( double**& a );
	__thiscall double cpp_byref_const_double_ptr_ptr( double const**& a );
	__thiscall double cpp_byref_double_const_ptr_ptr( double* const*& a );
	__thiscall double cpp_byref_double_ptr_const_ptr( double** const& a );
	__thiscall int cpp__byval_int__byref_int__byref_int(int a, int &b, int &c);
	__thiscall int cpp__byval_const_int__byref_int__byref_int(const int a, int &b, int &c);
	__thiscall int cpp__byval_const_int_ptr__byref_int__byref_int(const int *a, int &b, int &c);
	__thiscall int cpp__byval_const_int_const_ptr__byref_int__byref_int(const int *const a, int &b, int &c);


	// bool

	bool cpp_byval_bool( bool a )
	{
		return a;
	}

	bool cpp_byref_bool( bool &a )
	{
		return a;
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

	/* byval const, pointer, reference */

	double cpp_byval_const_double( const double a )
	{
		return a;
	}

	double cpp_byval_double_ptr( double* a )
	{
		return *a;
	}

	double cpp_byval_const_double_ptr( double const* a )
	{
		return *a;
	}

	double cpp_byval_double_const_ptr( double* const a )
	{
		return *a;
	}

	double cpp_byval_const_double_const_ptr( double const* const a )
	{
		return *a;
	}

	double cpp_byval_double_ptr_ptr( double** a )
	{
		return **a;
	}

	double cpp_byval_const_double_ptr_ptr( double const** a )
	{
		return **a;
	}

	double cpp_byval_double_const_ptr_ptr( double* const* a )
	{
		return **a;
	}

	double cpp_byval_double_ptr_const_ptr( double** const a )
	{
		return **a;
	}

	/* byref const, pointer, reference */

	double cpp_byref_const_double( double const& a )
	{
		return a;
	}

	double cpp_byref_double_ptr( double*& a )
	{
		return *a;
	}

	double cpp_byref_const_double_ptr( double const*& a )
	{
		return *a;
	}

	double cpp_byref_double_const_ptr( double* const& a )
	{
		return *a;
	}

	double cpp_byref_const_double_const_ptr( double const* const& a )
	{
		return *a;
	}

	double cpp_byref_double_ptr_ptr( double**& a )
	{
		return **a;
	}

	double cpp_byref_const_double_ptr_ptr( double const**& a )
	{
		return **a;
	}

	double cpp_byref_double_const_ptr_ptr( double* const*& a )
	{
		return **a;
	}

	double cpp_byref_double_ptr_const_ptr( double** const& a )
	{
		return **a;
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
