<?php
if ($this->HasAccess("read"))
{
	if (!$this->page)
	{
		return;
	}
	else
	{
		// display mind map xml
		$pagebody = $this->page["body"];
		if (preg_match("/(<map.*<\/map>)/s", $pagebody, $matches))
		{
			echo $matches[1];
		}
	}
}
else
{
	return;
}
?>