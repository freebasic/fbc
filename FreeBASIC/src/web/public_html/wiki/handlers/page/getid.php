<?php
if ($this->HasAccess("read") && $this->page)
{
	print( '<!-- <wiki-response>' . $this->page['id'] . '</wiki-response> -->' );
}
?>