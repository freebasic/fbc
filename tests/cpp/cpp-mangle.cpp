namespace cpp_mangle 
{
	// boolean

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

	// byte = 8 bit

	unsigned char cpp_byval_u8( unsigned char a )
	{
		return a;
	}

	signed char cpp_byval_s8( signed char a )
	{
		return a;
	}
	
	unsigned char cpp_byref_u8( unsigned char &a )
	{
		return a;
	} 

   	signed char cpp_byref_s8( signed char &a )
	{
		return a;
	} 

	// short = 16 bit

	unsigned short cpp_byval_u16( unsigned short a )
	{
		return a;
	}
	
	signed short cpp_byval_s16( signed short a )
	{
		return a;
	}
	
	unsigned short cpp_byref_u16( unsigned short &a )
	{
		return a;
	} 

	signed short cpp_byref_s16( signed short &a )
	{
		return a;
	} 

	// long = 32 bit

	unsigned long cpp_byval_u32( unsigned long a )
	{
		return a;
	}
	
	signed long cpp_byval_s32( signed long a )
	{
		return a;
	}
	
	unsigned long cpp_byref_u32( unsigned long &a )
	{
		return a;
	} 

	signed long cpp_byref_s32( signed long &a )
	{
		return a;
	} 

	// long long = 64 bit

	unsigned long long cpp_byval_u64( unsigned long long a )
	{
		return a;
	}
	
	signed long long cpp_byval_s64( signed long long a )
	{
		return a;
	}
	
	unsigned long long cpp_byref_u64( unsigned long long &a )
	{
		return a;
	} 

	signed long long cpp_byref_s64( signed long long &a )
	{
		return a;
	} 

}
