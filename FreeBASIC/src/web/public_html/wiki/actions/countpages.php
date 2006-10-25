<?php
/** 
 * Print the total number of pages in this wiki.
 */
$pagedata = $this->LoadSingle("SELECT count(*) as num FROM ".$this->config["table_prefix"]."pages WHERE latest = 'Y'");
echo $this->Link('PageIndex', '', $pagedata['num'],'','','Display an alphabetical page index');

?>