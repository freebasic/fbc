<?php

if ($q) {
	$q = $this->ReturnSafeHTML($q);
}
else { 
	if ($wikka_vars) $q = $this->ReturnSafeHTML($wikka_vars);
	else $q = $this->GetPageTag();
}

?>

<form action='http://www.google.com/search' method='get' name='f' target='_blank'>
	<input type='text' value='<?php echo $q; ?>' name='q' size='30' /> <input name='btnG' type='submit' value='Google' />
</form>