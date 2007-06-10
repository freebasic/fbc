<?php


require_once WACT_ROOT . 'template/compiler/servercomponent.inc.php';

class ServerDataComponentTag extends ServerComponentTag {

    var $DataSourceReferenceVariable;

	
	function preGenerate(&$code) {
		parent::preGenerate($code);
		
		if ($this->hasAttribute('from')) {
            $code->writePHP($this->getComponentRefCode() . '->registerDataSource(');
		    $parent_datasource =& $this->getParentDataSource();
            $code->writePHP('Template::_dereference(' . $parent_datasource->getDataSourceRefCode() . ',');
            $code->writePHPLIteral($this->getAttribute('from'));
            $code->writePHP('));');
		}
		
        $code->writePHP($this->getComponentRefCode() . '->prepare();');

		$this->DataSourceReferenceVariable = $code->getTempVariable();
        $code->writePHP('$' . $this->DataSourceReferenceVariable . '=&' . $this->getComponentRefCode() . '->_datasource;');
	}

	
	function &getDataSource() {
		return $this;
	}

	
	function getDataSourceRefCode() {
	    return '$' . $this->DataSourceReferenceVariable;
	}

	
	function isDataSource() {
	    return TRUE;
	}

}
?>