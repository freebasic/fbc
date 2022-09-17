namespace cpp_mangle_enum
{
	enum E1
	{
		A, B
	};

	struct T1
	{
		enum E2
		{
			A, B
		};
		int a;
	};

	int cpp_enum_byval_1( enum E1 e )
	{
		return 1;
	}

	int cpp_enum_byref_2( enum E1 &e )
	{
		return 2;
	}

	int cpp_enum_byval_3( enum T1::E2 e )
	{
		return 3;
	}

	int cpp_enum_byref_4( enum T1::E2 &e )
	{
		return 4;
	}

}
