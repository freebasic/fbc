<div class="page">
<?php
if ($this->HasAccess("read")) {
	// load revisions for this page
	if ($pages = $this->LoadRevisions($this->tag))
	{
		if ($user = $this->GetUser()) {
			$max = $user["revisioncount"];
		} else {
			$max = 20;
		}
		$output = "";
		$c = 0;
		foreach ($pages as $page)
		{
			$c++;
			if (($c <= $max) || !$max)
			{
				$pageB = $this->LoadPageById($page["id"]);
				$bodyB = explode("\n", $pageB["body"]);

				if (isset($pageA))
				{
					// show by default. We'll do security checks next.
					$allowed = 1;

					// check if the loaded pages are actually revisions of the current page! (fixes #0000046)
					//print_r($pageA); print_r($this->page); exit;
					if (($pageA['tag'] != $this->page['tag']) || ($pageB['tag'] != $this->page['tag'])) {
						$allowed = 0;
					}
					// show if we're still allowed to see the diff
					if ($allowed) {

						// prepare bodies
						$bodyA = explode("\n", $pageA["body"]);
						// $bodyB = explode("\n", $pageB["body"]);

						$added = array_diff($bodyA, $bodyB);
						$deleted = array_diff($bodyB, $bodyA);

						if (strlen($pageA["note"]) == 0) $note = ""; else $note = "[".$pageA["note"]."]";

						if ($c == 2) {
							$output .= "<strong>Most recent edit on <a href=\"".$this->Href("", "", "time=".urlencode($pageA["time"]))."\">".$pageA["time"]."</a> by ".$EditedByUser."</strong> <span style=\"color:#888;font-size:smaller;\">".$note."</span><br />\n";
						}
						else {
							$output .= "<strong>Edited on <a href=\"".$this->Href("", "", "time=".urlencode($pageA["time"]))."\">".$pageA["time"]."</a> by ".$EditedByUser."</strong> <span style=\"color:#888;font-size:smaller;\">".$note."</span><br />\n";
						}

						if ($added)
						{
							// remove blank lines
							$output .= "<br />\n<strong>Additions:</strong><br />\n";
							$output .= "<span class=\"additions\">".$this->Format(implode("\n", $added))."</span><br />";
						}

						if ($deleted)
						{
							$output .= "<br />\n<strong>Deletions:</strong><br />\n";
							$output .= "<span class=\"deletions\">".$this->Format(implode("\n", $deleted))."</span><br />";
						}

						if (!$added && !$deleted)
						{
							$output .= "<br />\nNo differences.";
						}
						$output .= "<br />\n<HR><br />\n";
					}
				}
				else {
					// $output .= "<DIV class=\"revisioninfo\">Current page:</div>".$this->Format($pageB["body"])."<br />\n<HR><br />\n";
				}
				$pageA = $this->LoadPageById($page["id"]);
				$EditedByUser = $this->Format($page["user"]);
			}
		}
		$output .= "<strong>Oldest known version of this page was edited on <a href=\"".$this->href("", "", "time=".urlencode($pageB["time"]))."\">".$pageB["time"]."</a> by ".$EditedByUser."</strong> <span style=\"color:#888;font-size:smaller;\">[".$page["note"]."]</span></strong><br />\n";
		$output .= "<DIV class=\"revisioninfo\">Page view:</div>".$this->Format(implode("\n", $bodyB));
		print($output);
	}
} else {
	print("<em>You aren't allowed to read this page.</em>");
}
?>
</div>