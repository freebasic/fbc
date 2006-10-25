<?php
if ($this->HasAccess("read") && $this->page)
{
	// display raw page
	print($this->page["body"]);
}
?>