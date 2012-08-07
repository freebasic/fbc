//
// compile with:
//    g++ -c complex.cxx
//    ar rcs libcomplex.a complex.o 
//

namespace cpp
{

struct complex {
	double re;
	double im;

	complex();
	complex( double r, double i = 0.0 );

	double abs2();
};

complex operator+( complex &, complex &);
complex operator-( complex &, complex &);
complex operator*( complex &, complex &);
complex operator/( complex &, complex &);

complex::complex()
{
	re = 0; im = 0;
}

complex::complex( double r, double i )
{
	re = r; im = i;
}

double complex::abs2()
{
	return( re*re + im*im );
}

complex operator+( complex &z1, complex &z2)
{
	return complex(z1.re + z2.re, z1.im + z2.im);
}

complex operator-( complex &z1, complex &z2)
{
	return complex(z1.re - z2.re, z1.im - z2.im);
}

complex operator*( complex &z1, complex &z2)
{
	return complex(z1.re*z2.re - z1.im*z2.im,
	               z1.re*z2.im + z1.im*z2.re);
}

complex operator/( complex &z1, complex &z2)
{
	double d = z2.re*z2.re + z2.im*z2.im;

	return complex( ( z1.re*z2.re + z1.im*z2.im)/d,
	                (-z1.re*z2.im + z1.im*z2.re)/d );
}

}
