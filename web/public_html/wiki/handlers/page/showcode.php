<?php
if ($this->HasAccess("read") && $this->page) {
	// display raw page, slightly formatted for viewing
	print(nl2br($this->htmlspecialchars_ent($this->page["body"], ENT_QUOTES)));
}
?>