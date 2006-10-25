<?php



class ErrorMessageDictionary {
	
	var $ErrorMessages = array();

	
	function getMessage($Group, $Id) {
		if (!isset($this->ErrorMessages[$Group])) {
			$this->ErrorMessages[$Group] = importVarFile("/errormessages/$Group.vars");
		}
	
		return $this->ErrorMessages[$Group][$Id];
	}
}

?>