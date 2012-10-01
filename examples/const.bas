''
'' CONST can be used to declare constants. Constants can be integers,
'' floating point numbers or strings.
''

const PI = 3.14159
const HELLOWORLD = "Hello, world!"
const N = 5 * 10

print PI, HELLOWORLD, N

'' The compiler can automatically determine the data type from the given
'' expression as seen above, but it can also be specified explicitly:
const M as integer = N * 10


''
'' As an alternative, it's also possible to use preprocessor macros for
'' compile-time text replacement:
''

#define MESSAGE "Hello from FB!"
print MESSAGE


''
'' CONST can also show up in another context:
''
'' The CONST qualifier may be used on types to mark them as read-only,
'' for more compile-time type safety ("constness"). The compiler will not
'' allow assignments to a variable marked as CONST.
''

dim variable as const integer const ptr = 0

function foo( param as const integer ) as const integer
	function = param
end function

type MyType
	as integer i
	declare const sub foo( ) '' CONST method: the This reference will be CONST
end type
