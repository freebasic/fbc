<?php

if ($pages = $this->LoadPagesLinkingTo($this->getPageTag())) {
	foreach ($pages as $page) {
		$links[] = $this->Link($page["tag"]);
	}
	print(implode("<br />\n", $links));
}

?>