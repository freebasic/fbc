'' to compile: fbc -dll

#include "jni.bi"

'' notice the mangling, it must be "windows-ms" or the JRE won't find any function
extern "windows-ms"

	''
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