' TEST_MODE : COMPILE_ONLY_FAIL

namespace ns
	extern array() as integer
end namespace

'' This defines the namespaced EXTERN
redim ns.array() as integer

'' This should trigger an error (declaration outside original namespace or at
'' least duplicate definition).
'' There is no ns.array symbol to define anymore, only the already-defined
'' ns.array, and we don't allow duplicate definitions with non-arrays either.
'' Furthermore, it cannot be a REDIM of the existing ns.array variable, because
'' no array bounds are specified here.
redim ns.array() as integer
