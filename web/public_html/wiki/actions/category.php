<?php
if ($cattag = $_REQUEST["wakka"])
{
	$str ="";
	if (!isset($col)) $col=1;
	if (!isset($compact)) $compact=0;
	if (!isset($page)) $page=$this->getPageTag(); 
	if ($page=="/") $page="CategoryCategory"; 

//	$page= preg_replace( "/(\w+)\s(\w+)/", "$1$2",$page);
	if (isset($class)) {
		$class="class=\"$class\"";
	} else {
		$class="";
	}
	if (!$page) {$page=$cattag;}

	if ($this->CheckMySQLVersion(4,0,1))
	{
    		$results = $this->FullCategoryTextSearch($page); 
	}
	else
	{
    		$results = $this->FullTextSearch($page); 
	}

	if ($results)
	{
		if (!$compact) $str .= ' pages belong to ' . $page . ': <br /><br /><table '.$class.' width="100%"><tr>';
		else $str .= '<div '.$class.'><ul>';
		
		$count = 0; 
		$pagecount = 0;
		$list = array();
		
		foreach ($results as $i => $cpage) if($cpage['tag'] != $page) { array_push($list,$cpage['tag']);}
		sort($list);
		while (list($key, $val) = each($list)) {
			if ($count == $col & !$compact)  { $str .= "</tr><tr>"; $count=0; }
			if (!$compact) $str .= '<td>'.$this->Format('[['.$val.']]').'</td>';
			else $str .= '<li>'.$this->Format('[['.$val.' '.preg_replace( "/Category/", "",$val).']]').'</li>';
			$count++;
			$pagecount++;
		}
		$str = 'The following '.$pagecount.$str;
		if (!$compact)  $str .= '</tr></table>'; else $str .= '</ul></div>';
	}
	else $str .= 'Sorry, no items found for ' . $page .'.';
	print($str);
}
?>