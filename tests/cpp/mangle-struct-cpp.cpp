namespace cpp_mangle_struct
{

	/* ***********************************
	** Simple
	*********************************** */
	struct Simple
	{
		int a;
	};

	int cpp_struct0_byval_1( int size, struct Simple udt )
	{
		if( size == sizeof( udt ) )
		{
			return 01;
		}
		return 0;
	}

	int cpp_struct0_byref_2( int size, struct Simple &udt )
	{
		if( size == sizeof( udt ) )
		{
			return 02;
		}
		return 0;
	}

	/* ***********************************
	** Outer1 + Outer1::Inner
	*********************************** */

	struct Outer1
	{
		int a;
		int b;
		struct Inner
		{
			int c;
		};
		struct Inner z;
	};

	int cpp_struct1_byval_1( int size, struct Outer1 udt )
	{
		if( size == sizeof( udt ) )
		{
			return 11;
		}
		return 0;
	}

	int cpp_struct1_byref_2( int size, struct Outer1 &udt )
	{
		if( size == sizeof( udt ) )
		{
			return 12;
		}
		return 0;
	}

	int cpp_struct1_byval_3( int size, struct Outer1::Inner udt )
	{
		if( size == sizeof( udt ) )
		{
			return 13;
		}
		return 0;
	}

	int cpp_struct1_byref_4( int size, struct Outer1::Inner &udt )
	{
		if( size == sizeof( udt ) )
		{
			return 14;
		}
		return 0;
	}

	/* ***********************************
	** Outer2 + Outer2::Inner
	*********************************** */

	struct Outer2
	{
		int a;
		int b;
		int c;
		struct Inner
		{
			int c;
			int d;
		};
		struct Inner z;
	};

	int cpp_struct2_byval_1( int size, struct Outer2 udt )
	{
		if( size == sizeof( udt ) )
		{
			return 21;
		}
		return 0;
	}

	int cpp_struct2_byref_2( int size, struct Outer2 &udt )
	{
		if( size == sizeof( udt ) )
		{
			return 22;
		}
		return 0;
	}

	int cpp_struct2_byval_3( int size, struct Outer2::Inner udt )
	{
		if( size == sizeof( udt ) )
		{
			return 23;
		}
		return 0;
	}

	int cpp_struct2_byref_4( int size, struct Outer2::Inner &udt )
	{
		if( size == sizeof( udt ) )
		{
			return 24;
		}
		return 0;
	}

	/* ***********************************
	** Outer3 + Outer3::Inner2 + Outer3::Inner2::Inner1
	*********************************** */

	struct Outer3
	{
		int a;
		int b;
		int c;
		struct Inner2
		{
			int d;
			int e;
			struct Inner1
			{
				int f;
			} g;
		} h;
	};

	int cpp_struct3_byval_1( int size, struct Outer3 udt )
	{
		if( size == sizeof( udt ) )
		{
			return 31;
		}
		return 0;
	}

	int cpp_struct3_byref_2( int size, struct Outer3 &udt )
	{
		if( size == sizeof( udt ) )
		{
			return 32;
		}
		return 0;
	}

	int cpp_struct3_byval_3( int size, struct Outer3::Inner2 udt )
	{
		if( size == sizeof( udt ) )
		{
			return 33;
		}
		return 0;
	}

	int cpp_struct3_byref_4( int size, struct Outer3::Inner2 &udt )
	{
		if( size == sizeof( udt ) )
		{
			return 34;
		}
		return 0;
	}

	int cpp_struct3_byval_5( int size, struct Outer3::Inner2::Inner1 udt )
	{
		if( size == sizeof( udt ) )
		{
			return 35;
		}
		return 0;
	}

	int cpp_struct3_byref_6( int size, struct Outer3::Inner2::Inner1 &udt )
	{
		if( size == sizeof( udt ) )
		{
			return 36;
		}
		return 0;
	}

}
