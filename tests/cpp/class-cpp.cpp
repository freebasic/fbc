// implementation for class-fbc.bas

// each operation records call information
// in static variables, and we use getters
// to retrieve it back to fbc side

#define NULL 0
static const void * ptr1 = NULL; // this/lhs address
static const void * ptr2 = NULL; // rhs address
static char msg1[100];  // check message
static int    val1 = 0; // current/lhs value
static int    val2 = 0; // rhs value
static int    val3 = 0; // result value
static int initial = 1; // 1 = enable ctor/copy-ctor/dtor/let

void setMsg( const char* msg ) {
	char *s = msg1;
	while( *msg )
		*s++ = *msg++;
	*s = *msg;
}

void setInitial( int flag ) {
	initial = flag;
}

void resetChecks() {
	ptr1 = NULL;
	ptr2 = NULL;
	setMsg( "" );
	val1 = 0;
	val2 = 0;
	val3 = 0;
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

// simple UDT class to test with and
// we declare same on fbc side

class UDT
{
	public:

	int value;

	UDT();
	UDT( UDT const& rhs );
	UDT( int const& rhs );
	~UDT();
	void method( int const& rhs );

	// assignment
	UDT& operator=( UDT const& rhs );

	// !!! TODO !!! non-static member bops
	UDT& operator+( int const& rhs );
	UDT& operator-( int const& rhs );
};

UDT operator+( UDT const& lhs, UDT const& rhs );
UDT operator-( UDT const& lhs, UDT const& rhs );

UDT operator+( int const& lhs, UDT const& rhs );
UDT operator-( int const& lhs, UDT const& rhs );

// constructor UDT()
UDT::UDT()
{
	if( initial ) {
		ptr1 = this;
		ptr2 = NULL;
		setMsg( "UDT::UDT()" );
		val1 = -1;
		val2 = -1;
		val3 = 0;
	}
	value = 0;
}

// constructor UDT( byref rhs as const UDT )
UDT::UDT( UDT const& rhs )
{
	if( initial ) {
		ptr1 = this;
		ptr2 = &rhs;
		setMsg( "UDT::UDT( UDT const& rhs )" );
		val1 = -1;
		val2 = rhs.value;
		val3 = rhs.value;
	}
	value = rhs.value;
}

// constructor UDT( byref rhs as const long )
UDT::UDT( int const& rhs )
{
	if( initial ) {
		ptr1 = this;
		ptr2 = &rhs;
		setMsg( "UDT::UDT( int const& rhs )" );
		val1 = -1;
		val2 = rhs;
		val3 = rhs;
	}
	value = rhs;
}

// destructor UDT()
UDT::~UDT()
{
	if( initial ) {
		ptr1 = this;
		ptr2 = NULL;
		setMsg( "UDT::~UDT()" );
		val1 = value;
		val2 = -1;
		val3 = -1;
	}
}

// sub UDT.method( byref rhs as const long )
void UDT::method( int const& rhs )
{
	if( initial ) {
		ptr1 = this;
		ptr2 = &rhs;
		setMsg( "void UDT::method( int const& rhs )" );
		val1 = value;
		val2 = rhs;
		val3 = rhs;
	}
	value = rhs;
}

// operator UDT.let( byref rhs as const UDT )
UDT& UDT::operator=( UDT const& rhs )
{
	if( initial ) {
		ptr1 = this;
		ptr2 = &rhs;
		setMsg( "UDT& UDT::operator=( UDT const& rhs )" );
		val1 = value;
		val2 = rhs.value;
		val3 = rhs.value;
	}
	value = rhs.value;
	return *this;
}

/*
// !!! TODO !!!: operator UDT.+( byref rhs as const long )
UDT& UDT::operator+( int const& rhs )
{
	ptr1 = this;
	ptr2 = &rhs;
	setMsg( "UDT& UDT::operator+( int const& rhs )" );
	val1 = value;
	val2 = rhs;
	val3 = value + rhs;

	value += rhs;
	return *this;
}

// !!! TODO !!!: operator UDT.+( byref rhs as const long )
UDT& UDT::operator-( int const& rhs )
{
	ptr1 = this;
	ptr2 = &rhs;
	setMsg( "UDT& UDT::operator-( int const& rhs )" );
	val1 = value;
	val2 = rhs;
	val3 = value - rhs;

	value -= rhs;
	return *this;
}
*/

// operator +( byref lhs as const UDT, byref rhs as const UDT ) as UDT
UDT operator+( UDT const& lhs, UDT const& rhs )
{
	ptr1 = &lhs;
	ptr2 = &rhs;
	setMsg( "UDT operator+( UDT const& lhs, UDT const& rhs )" );
	val1 = lhs.value;
	val2 = rhs.value;
	val3 = lhs.value + rhs.value;

	return UDT(lhs.value + rhs.value);
}

// operator -( byref lhs as const UDT, byref rhs as const UDT ) as UDT
UDT operator-( UDT const& lhs, UDT const& rhs )
{
	ptr1 = &lhs;
	ptr2 = &rhs;
	setMsg( "UDT operator-( UDT const& lhs, UDT const& rhs )" );
	val1 = lhs.value;
	val2 = rhs.value;
	val3 = lhs.value - rhs.value;

	return UDT(lhs.value - rhs.value);
}

// operator +( byref lhs as const long, byref rhs as const UDT ) as UDT
UDT operator+( int const& lhs, UDT const& rhs )
{
	ptr1 = &lhs;
	ptr2 = &rhs;
	setMsg( "UDT operator+( int const& lhs, UDT const& rhs )" );
	val1 = lhs;
	val2 = rhs.value;
	val3 = lhs + rhs.value;

	return UDT(lhs + rhs.value);
}

// operator -( byref lhs as const long, byref rhs as const UDT ) as UDT
UDT operator-( int const& lhs, UDT const& rhs )
{
	ptr1 = &lhs;
	ptr2 = &rhs;
	setMsg( "UDT operator-( int const& lhs, UDT const& rhs )" );
	val1 = lhs;
	val2 = rhs.value;
	val3 = lhs - rhs.value;

	return UDT(lhs - rhs.value);
}
