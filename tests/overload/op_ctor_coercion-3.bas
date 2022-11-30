' TEST_MODE : COMPILE_ONLY_FAIL

type T
	public:
		dim as integer result
		declare constructor(byref s as const string)
		declare constructor()
	private:
		declare operator cast() as string
end type

dim x1 as T
dim x2 as T = str(type<T>(x1))

