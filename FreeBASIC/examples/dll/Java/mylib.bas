'' to compile: fbc -dll -Wl --kill-at mylib.bas

#include "jni.bi"

function Java_MyLib_add alias "Java_MyLib_add" _
	( _
		env as JNIEnv ptr, _
		obj as jobject, _
		l as jint, _
		r as jint _
	) as jint export
	
	function = l + r

end function