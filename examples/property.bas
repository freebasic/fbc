'' Property example (setter & getter using the same identifier)

type Rectangle
	as integer left, top, right, bottom

	declare property width( as integer )    '' setter
	declare property width( ) as integer    '' getter
end type

'' Set width
property Rectangle.width( w as integer )
	this.right = this.left + w
end property

'' Retrieve width
property Rectangle.width( ) as integer
	return this.right - this.left
end property


dim as Rectangle rc = ( 10, 10, 50, 50 )

print rc.left, rc.top, rc.right, rc.bottom, "width: ";rc.width
rc.width = 100
print rc.left, rc.top, rc.right, rc.bottom, "width: ";rc.width
