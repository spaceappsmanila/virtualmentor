<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of RegistrationForm
 *
 * @author markbadiola
 */
class RegistrationForm extends sfForm {

    public function setup() {
        parent::setup();
        $this->setWidgets(array(
            'firstname' => new sfWidgetFormInputText(),
            'lastname' => new sfWidgetFormInputText(),
            'email' => new sfWidgetFormInputText(),
            'password' => new sfWidgetFormInputPassword(),
            'cpassword' => new sfWidgetFormInputPassword(),
            'membership' => new sfWidgetFormInputHidden()
        ));

        $this->setValidators(array(
            'firstname' => new sfValidatorString(array('required' => true)),
            'lastname' => new sfValidatorString(array('required' => true)),
            'email' => new sfValidatorEmail(array('required' => true)),
            'password' => new sfValidatorString(array('required' => true, 'min_length' => 5)
                    ,array('min_length' => 'Password too short (min. 5 chars).')),
            'cpassword' => new sfValidatorString(array('required' => true)),
            'membership' => new sfValidatorInteger(array('required' => true))
        ));
        
        $this->mergePostValidator(new sfValidatorSchemaCompare('password'
                , sfValidatorSchemaCompare::EQUAL, 'cpassword', array(), array('invalid' => 'Passwords do not match.')));
        
        $this->widgetSchema->setLabels(array(
            'firstname' => 'First Name',
            'lastname' => 'Last Name',
            'email' => 'Email Address',
            'password' => 'Password',
            'cpassword' => 'Confirm Password',
            'membership' => 'Membership'
        ));

        $this->widgetSchema->setNameFormat('member[%s]');
        $this->disableCSRFProtection();
    }
}

?>
