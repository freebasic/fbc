<?php

if ($comments = $this->LoadRecentComments())
{
	$curday = "";
	foreach ($comments as $comment)
	{
		// day header
		list($day, $time) = explode(" ", $comment["time"]);
		if ($day != $curday)
		{
			$dateformatted = date("D, d M Y", strtotime($day));

			if ($curday) print("<br />\n");
			print("<strong>$dateformatted:</strong><br />\n");
			$curday = $day;
		}

		$timeformatted = date("H:i T", strtotime($comment["time"]));
		$comment_preview = str_replace("<br />", "", $comment["comment"]);
		$comment_preview = substr($comment_preview, 0, 125);
		if (strlen($comment["comment"]) > 120) $comment_preview = $comment_preview.".... ";

		// print entry
		print("&nbsp;&nbsp;&nbsp;($timeformatted) <a href=\"".$this->href("", $comment["page_tag"], "show_comments=1")."#comment_".$comment["id"]."\">".$comment["page_tag"]."</a> . . . . ".$this->Format($comment["user"])."<br />\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<em>$comment_preview</em><br />\n");
	}
}
else
{
	print("<em>No recent comments.</em>");
}
?>