// implementation for bop-fbc.bas

// each operation records call information
// in static variables, and we use getters
// to retrieve it back to fbc side

#define NULL 0
static const void * ptr1 = NULL;
static const void * ptr2 = NULL;
static char msg1[100];  // check message
static int    val1 = 0; // current/lhs value
static int    val2 = 0; // rhs value
static int    val3 = 0; // result value

void setMsg( const char* msg ) {
	char *s = msg1;
	while( *msg )
		*s++ = *msg++;
	*s = *msg;
}

void resetChecks() {
	ptr1 = NULL;
	ptr2 = NULL;
	setMsg( "" );
}

const void* getPtr1() {
	return ptr1;
}

const void* getPtr2() {
	return ptr2;
}

char* getMsg1() {
	return msg1;
}

int getVal1() {
	return val1;
}

int getVal2() {
	return val2;
}

int getVal3() {
	return val3;
}

class UDT_DEFAULT
{
	public:
		int value;
};

// by default fbc will be stdcall on windows and cdecl on linux
#ifdef __MINGW32__
// warning !!! mingw specific
#define FBCALL __attribute__((stdcall))
#else
#define FBCALL
#endif

UDT_DEFAULT operator+( UDT_DEFAULT const& lhs, UDT_DEFAULT const& rhs ) FBCALL;
UDT_DEFAULT operator-( UDT_DEFAULT const& lhs, UDT_DEFAULT const& rhs ) FBCALL;
UDT_DEFAULT operator*( UDT_DEFAULT const& lhs, UDT_DEFAULT const& rhs ) FBCALL;
UDT_DEFAULT operator/( UDT_DEFAULT const& lhs, UDT_DEFAULT const& rhs ) FBCALL;
UDT_DEFAULT operator%( UDT_DEFAULT const& lhs, UDT_DEFAULT const& rhs ) FBCALL;
UDT_DEFAULT operator<<( UDT_DEFAULT const& lhs, UDT_DEFAULT const& rhs ) FBCALL;
UDT_DEFAULT operator>>( UDT_DEFAULT const& lhs, UDT_DEFAULT const& rhs ) FBCALL;
UDT_DEFAULT operator&( UDT_DEFAULT const& lhs, UDT_DEFAULT const& rhs ) FBCALL;
UDT_DEFAULT operator|( UDT_DEFAULT const& lhs, UDT_DEFAULT const& rhs ) FBCALL;
UDT_DEFAULT operator^( UDT_DEFAULT const& lhs, UDT_DEFAULT const& rhs ) FBCALL;

class UDT_C_DEFAULT
{
	public:
		int value;
};

extern "C" {
UDT_C_DEFAULT operator+( UDT_C_DEFAULT const& lhs, UDT_C_DEFAULT const& rhs );
UDT_C_DEFAULT operator-( UDT_C_DEFAULT const& lhs, UDT_C_DEFAULT const& rhs );
UDT_C_DEFAULT operator*( UDT_C_DEFAULT const& lhs, UDT_C_DEFAULT const& rhs );
UDT_C_DEFAULT operator/( UDT_C_DEFAULT const& lhs, UDT_C_DEFAULT const& rhs );
UDT_C_DEFAULT operator%( UDT_C_DEFAULT const& lhs, UDT_C_DEFAULT const& rhs );
UDT_C_DEFAULT operator<<( UDT_C_DEFAULT const& lhs, UDT_C_DEFAULT const& rhs );
UDT_C_DEFAULT operator>>( UDT_C_DEFAULT const& lhs, UDT_C_DEFAULT const& rhs );
UDT_C_DEFAULT operator&( UDT_C_DEFAULT const& lhs, UDT_C_DEFAULT const& rhs );
UDT_C_DEFAULT operator|( UDT_C_DEFAULT const& lhs, UDT_C_DEFAULT const& rhs );
UDT_C_DEFAULT operator^( UDT_C_DEFAULT const& lhs, UDT_C_DEFAULT const& rhs );
}

class UDT_CPP_DEFAULT
{
	public:
		int value;
};

UDT_CPP_DEFAULT operator+( UDT_CPP_DEFAULT const& lhs, UDT_CPP_DEFAULT const& rhs );
UDT_CPP_DEFAULT operator-( UDT_CPP_DEFAULT const& lhs, UDT_CPP_DEFAULT const& rhs );
UDT_CPP_DEFAULT operator*( UDT_CPP_DEFAULT const& lhs, UDT_CPP_DEFAULT const& rhs );
UDT_CPP_DEFAULT operator/( UDT_CPP_DEFAULT const& lhs, UDT_CPP_DEFAULT const& rhs );
UDT_CPP_DEFAULT operator%( UDT_CPP_DEFAULT const& lhs, UDT_CPP_DEFAULT const& rhs );
UDT_CPP_DEFAULT operator<<( UDT_CPP_DEFAULT const& lhs, UDT_CPP_DEFAULT const& rhs );
UDT_CPP_DEFAULT operator>>( UDT_CPP_DEFAULT const& lhs, UDT_CPP_DEFAULT const& rhs );
UDT_CPP_DEFAULT operator&( UDT_CPP_DEFAULT const& lhs, UDT_CPP_DEFAULT const& rhs );
UDT_CPP_DEFAULT operator|( UDT_CPP_DEFAULT const& lhs, UDT_CPP_DEFAULT const& rhs );
UDT_CPP_DEFAULT operator^( UDT_CPP_DEFAULT const& lhs, UDT_CPP_DEFAULT const& rhs );

#define exec_bop( t, bop ) \
	t ret = {0}; \
	ptr1 = &lhs; \
	ptr2 = &rhs; \
	setMsg( #t " operator" #bop ); \
	val1 = lhs.value; \
	val2 = rhs.value; \
	val3 = lhs.value bop rhs.value; \
	ret.value = lhs.value bop rhs.value; \
	return ret;

// default mangling (on fbc side), default calling convention

UDT_DEFAULT operator+( UDT_DEFAULT const& lhs, UDT_DEFAULT const& rhs ) { exec_bop( UDT_DEFAULT, + ) }
UDT_DEFAULT operator-( UDT_DEFAULT const& lhs, UDT_DEFAULT const& rhs ) { exec_bop( UDT_DEFAULT, - ) }
UDT_DEFAULT operator*( UDT_DEFAULT const& lhs, UDT_DEFAULT const& rhs ) { exec_bop( UDT_DEFAULT, * ) }
UDT_DEFAULT operator/( UDT_DEFAULT const& lhs, UDT_DEFAULT const& rhs ) { exec_bop( UDT_DEFAULT, / ) }
UDT_DEFAULT operator%( UDT_DEFAULT const& lhs, UDT_DEFAULT const& rhs ) { exec_bop( UDT_DEFAULT, % ) }
UDT_DEFAULT operator<<( UDT_DEFAULT const& lhs, UDT_DEFAULT const& rhs ) { exec_bop( UDT_DEFAULT, << ) }
UDT_DEFAULT operator>>( UDT_DEFAULT const& lhs, UDT_DEFAULT const& rhs ) { exec_bop( UDT_DEFAULT, >> ) }
UDT_DEFAULT operator&( UDT_DEFAULT const& lhs, UDT_DEFAULT const& rhs ) { exec_bop( UDT_DEFAULT, & ) }
UDT_DEFAULT operator|( UDT_DEFAULT const& lhs, UDT_DEFAULT const& rhs ) { exec_bop( UDT_DEFAULT, | ) }
UDT_DEFAULT operator^( UDT_DEFAULT const& lhs, UDT_DEFAULT const& rhs ) { exec_bop( UDT_DEFAULT, ^ ) }

// C mangling (on fbc side), default calling convention
extern "C" {
UDT_C_DEFAULT operator+( UDT_C_DEFAULT const& lhs, UDT_C_DEFAULT const& rhs ){exec_bop( UDT_C_DEFAULT, + ) }
UDT_C_DEFAULT operator-( UDT_C_DEFAULT const& lhs, UDT_C_DEFAULT const& rhs ) { exec_bop( UDT_C_DEFAULT, - ) }
UDT_C_DEFAULT operator*( UDT_C_DEFAULT const& lhs, UDT_C_DEFAULT const& rhs ) { exec_bop( UDT_C_DEFAULT, * ) }
UDT_C_DEFAULT operator/( UDT_C_DEFAULT const& lhs, UDT_C_DEFAULT const& rhs ) { exec_bop( UDT_C_DEFAULT, / ) }
UDT_C_DEFAULT operator%( UDT_C_DEFAULT const& lhs, UDT_C_DEFAULT const& rhs ) { exec_bop( UDT_C_DEFAULT, % ) }
UDT_C_DEFAULT operator<<( UDT_C_DEFAULT const& lhs, UDT_C_DEFAULT const& rhs ) { exec_bop( UDT_C_DEFAULT, << ) }
UDT_C_DEFAULT operator>>( UDT_C_DEFAULT const& lhs, UDT_C_DEFAULT const& rhs ) { exec_bop( UDT_C_DEFAULT, >> ) }
UDT_C_DEFAULT operator&( UDT_C_DEFAULT const& lhs, UDT_C_DEFAULT const& rhs ) { exec_bop( UDT_C_DEFAULT, & ) }
UDT_C_DEFAULT operator|( UDT_C_DEFAULT const& lhs, UDT_C_DEFAULT const& rhs ) { exec_bop( UDT_C_DEFAULT, | ) }
UDT_C_DEFAULT operator^( UDT_C_DEFAULT const& lhs, UDT_C_DEFAULT const& rhs ) { exec_bop( UDT_C_DEFAULT, ^ ) }
} // extern "C"

// c++ mangling (on fbc side), default calling convention

UDT_CPP_DEFAULT operator+( UDT_CPP_DEFAULT const& lhs, UDT_CPP_DEFAULT const& rhs ) { exec_bop( UDT_CPP_DEFAULT, + ) }
UDT_CPP_DEFAULT operator-( UDT_CPP_DEFAULT const& lhs, UDT_CPP_DEFAULT const& rhs ) { exec_bop( UDT_CPP_DEFAULT, - ) }
UDT_CPP_DEFAULT operator*( UDT_CPP_DEFAULT const& lhs, UDT_CPP_DEFAULT const& rhs ) { exec_bop( UDT_CPP_DEFAULT, * ) }
UDT_CPP_DEFAULT operator/( UDT_CPP_DEFAULT const& lhs, UDT_CPP_DEFAULT const& rhs ) { exec_bop( UDT_CPP_DEFAULT, / ) }
UDT_CPP_DEFAULT operator%( UDT_CPP_DEFAULT const& lhs, UDT_CPP_DEFAULT const& rhs ) { exec_bop( UDT_CPP_DEFAULT, % ) }
UDT_CPP_DEFAULT operator<<( UDT_CPP_DEFAULT const& lhs, UDT_CPP_DEFAULT const& rhs ) { exec_bop( UDT_CPP_DEFAULT, << ) }
UDT_CPP_DEFAULT operator>>( UDT_CPP_DEFAULT const& lhs, UDT_CPP_DEFAULT const& rhs ) { exec_bop( UDT_CPP_DEFAULT, >> ) }
UDT_CPP_DEFAULT operator&( UDT_CPP_DEFAULT const& lhs, UDT_CPP_DEFAULT const& rhs ) { exec_bop( UDT_CPP_DEFAULT, & ) }
UDT_CPP_DEFAULT operator|( UDT_CPP_DEFAULT const& lhs, UDT_CPP_DEFAULT const& rhs ) { exec_bop( UDT_CPP_DEFAULT, | ) }
UDT_CPP_DEFAULT operator^( UDT_CPP_DEFAULT const& lhs, UDT_CPP_DEFAULT const& rhs ) { exec_bop( UDT_CPP_DEFAULT, ^ ) }
