'' To compile: fbc -dll mylib.bas

#include "jni.bi"

'' Enable STDCALL with case-preserving name mangling but without the @N function
'' symbol name decoration. This is the convention expected by the JRE, in
'' addition to the specific function name and parameters.
extern "windows-ms"

	function Java_MyLib_add _
		( _
			env as JNIEnv ptr, _
			obj as jobject, _
			l as jint, _
			r as jint _
		) as jint export

		function = l + r

	end function

end extern
