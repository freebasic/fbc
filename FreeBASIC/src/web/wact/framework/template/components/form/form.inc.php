<?php



class FormComponent extends TagComponent
{
	var $ErrorList;
	var $IsValid = TRUE;
	var $StateVars = array();
	var $_datasource;

	function ensureDataSourceAvailable() {
		if (!isset($this->_datasource)) {
			$this->registerDataSource(new DataSpace());
		}
	}


	function _getValue($name) {
		$this->ensureDataSourceAvailable();
		return $this->_datasource->get($name);
	}


	function _setValue($name, $value) {
		$this->ensureDataSourceAvailable();
		$this->_datasource->set($name, $value);
	}


	function prepare() {
		$this->ensureDataSourceAvailable();
		$this->_datasource->prepare();
	}


	function registerDataSource(&$datasource) {
		$this->_datasource =& $datasource;
	}


	function &getDataSource() {
		return $this->_datasource;
	}


	function &findLabel($FieldId, &$Component) {
		foreach( array_keys($Component->children) as $key) {
			$Child =& $Component->children[$key];
			if (is_a($Child, 'LabelComponent') && $Child->getAttribute('for') == $FieldId) {
				return $Child;
			} else {
				$result =& $this->findLabel($FieldId, $Child);
				if ($result) {
					return $result;
				}
			}
		}
		return FALSE;
	}


	function setErrors(&$ErrorList) {

						$ErrorList->setFieldNameDictionary(new FormFieldNameDictionary($this));

		$ErrorList->reset();

		while ($ErrorList->next()) {
			$this->IsValid = FALSE;

			$Error =& $ErrorList->getError();

												foreach ($Error->FieldList as $tokenName => $fieldName) {
				$Field =& $this->findChild($fieldName);
				if (is_object($Field)) {
					$Field->setError();
					if ($Field->hasAttribute('id')) {
						$Label =& $this->findLabel($Field->getAttribute('id'), $this);
						if ($Label) {
							$Label->setError();
						}
					}
				}
			}

		}

		$this->ErrorList =& $ErrorList;
	}


	function hasErrors() {
		return !$this->IsValid;
	}


	function &getErrorDataSet() {
		if (!isset($this->ErrorList)) {
			require_once WACT_ROOT . 'validation/emptyerrorlist.inc.php';
			$this->ErrorList =& new EmptyErrorList();
		}
		return $this->ErrorList;
	}


	function preserveState($variable) {
		$this->StateVars[] = $variable;
	}


	function renderState() {
		foreach ($this->StateVars as $var) {
			echo '<input type="hidden" name="';
			echo $var;
			echo '" value="';
			echo htmlspecialchars($this->_getValue($var), ENT_QUOTES);
			echo '">';
		}
	}

}


class FormFieldNameDictionary {


	var $form;


	function FormFieldNameDictionary(&$form) {
		$this->form =& $form;
	}


	function getFieldName($fieldName) {
		$Field =& $this->form->findChild($fieldName);
		if (is_object($Field)) {
			return $Field->getDisplayName();
		} else {
			return $fieldName;
		}
	}
}



class FormElement extends TagComponent {


	var $IsValid = TRUE;


	var $displayname;


	var $errorclass;


	var $errorstyle;


	function getDisplayName() {
		if (isset($this->displayname)) {
			return $this->displayname;
		} else if ($this->hasAttribute('title')) {
			return $this->getAttribute('title');
		} else if ($this->hasAttribute('alt')) {
			return $this->getAttribute('alt');
		} else {
			return str_replace("_", " ", $this->getAttribute('name'));
		}
	}


	function hasErrors() {
		return !$this->IsValid;
	}


	function setError() {
		$this->IsValid = FALSE;
		if (isset($this->errorclass)) {
			$this->setAttribute('class', $this->errorclass);
		}
		if (isset($this->errorstyle)) {
			$this->setAttribute('style', $this->errorstyle);
		}
	}


	function getValue() {
		$FormComponent =& $this->findParentByClass('FormComponent');
		return $FormComponent->_getValue($this->getAttribute('name'));
	}


	function setValue($value) {
		$FormComponent =& $this->findParentByClass('FormComponent');
		return $FormComponent->_setValue($this->getAttribute('name'),$value);
	}


	function getAttribute($name) {
		if ( strcasecmp($name,'value') == 0 ) {
			if ( !is_null($value = $this->getValue()) ) {
				return $value;
			}
		}
		return parent::getAttribute($name);
	}


	function setAttribute($name,$value) {
		if ( strcasecmp($name,'value') == 0 ) {
			$this->setValue($value);
		}
		parent::setAttribute($name,$value);
	}

}


class InputFormElement extends FormElement {


	function renderAttributes() {
		$value = $this->getValue();
		if (!is_null($value)) {
			$this->setAttribute('value', $value);
		} else {
			$this->setAttribute('value', '');
		}
		parent::renderAttributes();
	}

}


class LabelComponent extends TagComponent {


	var $errorclass;


	var $errorstyle;


	function setError() {
		if (isset($this->errorclass)) {
			$this->setAttribute('class', $this->errorclass);
		}
		if (isset($this->errorstyle)) {
			$this->setAttribute('style', $this->errorstyle);
		}
	}

}


class CheckableFormElement extends FormElement {


	function getAttribute($name) {
						return TagComponent::getAttribute($name);
	}


	function setAttribute($name,$value) {
		TagComponent::setAttribute($name,$value);
	}


	function renderAttributes() {
		$value = $this->getValue();
		if ($value == $this->getAttribute('value')) {
			$this->setAttribute('checked', NULL);
		} else {
			$this->removeAttribute('checked');
		}
		parent::renderAttributes();
	}

}


class TextAreaComponent extends FormElement {


	function renderContents() {
		echo htmlspecialchars($this->getValue(), ENT_QUOTES);
	}

}
?>
