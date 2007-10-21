if( top.frames.length != 0 ) top.location=self.document.location

window.onload = focusForm;
		
function focusForm()
{
	if( document.getElementById( "username" ).value == "" )
	{
		document.getElementById( "username" ).focus();
	}
	else
	{
		document.getElementById( "password" ).focus();
	}
}