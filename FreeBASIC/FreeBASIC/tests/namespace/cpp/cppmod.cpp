// simple
namespace cpp 
{
	int sum( int a, int b ) 
	{ 
		return a + b;
	}

	int dec( int a, int b ) 
	{ 
		return a - b;
	}
}

// nested
namespace cpp 
{
	namespace foo
	{
		namespace bar
		{
			int sum( int a, int b ) 
			{ 
				return a + b;
			}
		
			int dec( int a, int b ) 
			{ 
				return a - b;
			}
		}
	}
}

// nested + udt
namespace cpp 
{
	namespace foo
	{
		namespace bar
		{
			struct udt {
				int v;
			};
			
			int sum_udt( udt *a, udt *b ) 
			{ 
				return a->v + b->v;
			}
		
			int dec_udt( udt *a, udt *b ) 
			{ 
				return a->v - b->v;
			}
		}
	}
}

// nested + function ptr
namespace cpp 
{
	namespace foo
	{
		namespace bar
		{
			struct baz {
				int v1, v2;
			};
			
			int sum_fn( baz *z, int (*a)(baz *v), int (*b)(baz *v) ) 
			{ 
				return a(z) + b(z);
			}
		
			int dec_fn( baz *z, int (*a)(baz *v), int (*b)(baz *v) ) 
			{ 
				return a(z) - b(z);
			}
		}
	}
}
