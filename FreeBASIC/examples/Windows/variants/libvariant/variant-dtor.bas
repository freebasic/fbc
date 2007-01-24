

#include once "variant.bi"
#include once "intern.bi"

'':::::
destructor CVariant _
	( _
		_
	) 
	
	VariantClear( @this.var_ )
		
end destructor

