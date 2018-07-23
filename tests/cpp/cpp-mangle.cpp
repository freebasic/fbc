namespace cpp_mangle 
{
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

}
