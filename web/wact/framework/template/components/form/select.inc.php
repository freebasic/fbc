<?php


require_once WACT_ROOT . 'template/components/form/form.inc.php';


class SelectMultipleComponent extends FormElement {
	
	var $choiceList = array();
	
	var $optionHandler;

	
	function getValue() {
		$FormComponent =& $this->findParentByClass('FormComponent');
		$name = str_replace('[]', '', $this->getAttribute('name'));
		return $FormComponent->_getValue($name);
	}

	
	function setChoices($choiceList) {
		$this->choiceList = $choiceList;
	}

	
	function setSelection($selection) {
		$FormComponent =& $this->findParentByClass('FormComponent');
		$name = str_replace('[]', '', $this->getAttribute('name'));
		$FormComponent->_setValue($name, $selection);
	}

	
	function setOptionRenderer($optionHandler) {
		$this->optionHandler = $optionHandler;
	}

	
	function renderContents() {
		$values = $this->getValue();

		if ( !is_array($values) ) {
			$values = array(reset($this->choiceList));
		} else {
			$found = false;
			foreach ( $values as $value ) {
				if ( array_key_exists($value,$this->choiceList) ) {
					$found = true;
					break;
				}
			}
			if ( !$found )
				$values = array(reset($this->choiceList));
		}

		if (empty($this->optionHandler)) {
			$this->optionHandler = new OptionRenderer();
		}

		foreach($this->choiceList as $key => $contents) {
			if ( $key === 0 ) {
				$key = '0';
			}
			$this->optionHandler->renderOption($key, $contents, in_array($key,$values));
		}
	}
}


class OptionRenderer {

	
	function renderOption($key, $contents, $selected) {
		echo '<option value="';
		echo htmlspecialchars($key, ENT_QUOTES);
		echo '"';
		if ($selected) {
			echo " selected";
		}
		echo '>';
		if (empty($contents)) {
			echo htmlspecialchars($key, ENT_QUOTES);
		} else {
			echo htmlspecialchars($contents, ENT_QUOTES);
		}
		echo '</option>';
	}
}


class SelectSingleComponent extends FormElement {

	
	var $choiceList = array();
	
	
	var $optionHandler;

	
	function setChoices($choiceList) {
		$this->choiceList = $choiceList;
	}

	
	function setSelection($selection) {
		$FormComponent =& $this->findParentByClass('FormComponent');
		$FormComponent->_setValue($this->getAttribute('name'), $selection);
	}

	
	function setOptionRenderer($optionHandler) {
		$this->optionHandler = $optionHandler;
	}

	
	function renderContents() {
		$value = $this->getValue();
		
		if (empty($value) || !array_key_exists($value, $this->choiceList)) {
			$value = reset($this->choiceList);
		}

		if (empty($this->optionHandler)) {
			$this->optionHandler = new OptionRenderer();
		}

		foreach($this->choiceList as $key => $contents) {
			if ( $key === 0 ) {
				$key = '0';
			}
			$this->optionHandler->renderOption($key, $contents, $key == $value);
		}
	}
}

?>