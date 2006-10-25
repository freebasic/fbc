<?php


require_once WACT_ROOT . 'template/compiler/compilercomponent.inc.php';

class ServerComponentTag extends CompilerComponent {
	
	function getComponentRefCode() {
		$path = $this->parent->getComponentRefCode();
		return $path . '->children[\'' . $this->getServerId() . '\']';
	}

	
	function generateConstructor(&$code) {
		if (isset($this->runtimeIncludeFile)) {
			$code->registerInclude(WACT_ROOT . $this->runtimeIncludeFile);
		}
		$code->writePHP($this->parent->getComponentRefCode() .
			'->addChild(new ' . $this->runtimeComponentName . 
			'(), \'' . $this->getServerId() . '\');');
		parent::generateConstructor($code);
	}
}
?>