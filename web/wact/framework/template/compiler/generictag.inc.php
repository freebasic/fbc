<?php 


class GenericTag extends ServerTagComponentTag {
	
	var $runtimeIncludeFile;
	
	var $runtimeComponentName = 'TagComponent';
}


class GenericContainerTag extends ServerTagComponentTag {
	
	var $runtimeIncludeFile;
	
	var $runtimeComponentName = 'TagComponent';
	
	function generateConstructor(&$code) {
		parent::generateConstructor($code);
        $code->writePHP($this->getComponentRefCode() . 
            '->IsDynamicallyRendered = TRUE;');
	}
	
	function postGenerate(& $code) {
		$code->writePHP($this->getComponentRefCode() . '->render();');
		parent::postGenerate($code);
	}
}
?>