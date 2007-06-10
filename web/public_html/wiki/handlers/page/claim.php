<?php

// only claim ownership if this page has no owner, and if user is logged in.
if ($this->page && !$this->GetPageOwner() && $this->GetUser())
{
	$this->SetPageOwner($this->GetPageTag(), $this->GetUserName());
	$this->SetRedirectMessage("You are now the owner of this page.");
}

$this->Redirect($this->Href());

?>