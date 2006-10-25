<?php

if ($this->HasAccess("comment") || $this->IsAdmin())
{
	$redirectmessage = "";

	$body = nl2br($this->htmlspecialchars_ent(trim($_POST["body"])));

	if (!$body)
	{
		$redirectmessage = "Comment body was empty -- not saved!";
	}
	else
	{
		// store new comment
		$this->SaveComment($this->tag, $body);
	}
	
	// redirect to page
	$this->redirect($this->Href(), $redirectmessage);
}
else
{
	print("<div class=\"page\"><em>Sorry, you're not allowed to post comments to this page.</em></div>\n");
}

?>