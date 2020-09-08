#macro list ? (T)
	__fb_join__(list_,__fb_arg_rightof__(T,OF))
#endmacro

#macro list_of ? (T)
	list_##T
#endmacro

#macro imp_list_of ? (T)
#if not defined(list_##T)	
	type list_item_##T
		value as T
		next_ as list_item_##T ptr
	end type

	type list_##T
		declare constructor(initial as integer = 0)
		declare destructor()
		declare sub add(v as T)
		declare operator[](idx as integer) as T
	private:
		head as list_item_##T ptr
		tail as list_item_##T ptr
	end type

	constructor list_##T(initial as integer)
		this.head = 0
		this.tail = 0
	end constructor
	
	destructor list_##T()
		do while head <> 0
			var next_ = head->next_
			deallocate(head)
			head = next_
		loop
	end destructor
	
	sub list_##T.add(v as T)
		dim as list_item_##T ptr node = allocate(len(list_item_##T))
		node->value = v
		if tail <> 0 then
			tail->next_ = node
		else
			head = node
		end if
		node->next_ = 0
		tail = node
	end sub
	
	operator list_##T.[](idx as integer) as T
		var i = 0
		var node = head
		do while node <> 0
			if i = idx then
				return node->value
			end if
			node = node->next_
			i += 1
		loop
		'return default(T)
	end operator
#endif
#endmacro
