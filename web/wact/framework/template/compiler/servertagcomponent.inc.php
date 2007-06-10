<?php


class ServerTagComponentTag extends ServerComponentTag {

	
	function getRenderedTag() {
		return $this->tag;
	}

	
	function generateExtraAttributes(&$code) {
	    $this->generateDynamicAttributeList($code);
	}

	
	function preGenerate(&$code) {
		parent::preGenerate($code);
		$code->writeHTML('<' . $this->getRenderedTag());
		$code->writePHP($this->getComponentRefCode() . '->renderAttributes();');
		if ( $this->emptyClosedTag ) {
			$code->writeHTML(' /');
		}
		$this->generateExtraAttributes($code);
		$code->writeHTML('>');
	}

	
	function postGenerate(&$code) {
		if ($this->hasClosingTag) {
			$code->writeHTML('</' . $this->getRenderedTag() .  '>');
		}
		parent::postGenerate($code);
	}

	
	function generateConstructor(&$code) {
		parent::generateConstructor($code);

        		$CompileTimeAttributes = $this->TagInfo->CompilerAttributes;

				$CompileTimeAttributes[] = PARSER_TRIGGER_ATTR_NAME;

		$code->writePHP($this->getComponentRefCode() . '->attributes = unserialize(');
		$code->writePHPLiteral(serialize($this->getAttributesAsArray($CompileTimeAttributes)));
        $code->writePHP(');');

	}
}
?>