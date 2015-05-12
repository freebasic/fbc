

#include once "variant.bi"
#include once "intern.bi"

'':::::
destructor VARIANT _
	( _
		_
	) 
	
	VariantClear( @this.var_ )
		
end destructor

