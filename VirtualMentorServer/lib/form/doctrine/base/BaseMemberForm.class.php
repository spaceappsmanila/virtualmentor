<?php

/**
 * Member form base class.
 *
 * @method Member getObject() Returns the current form's model object
 *
 * @package    virtualmentor
 * @subpackage form
 * @author     Your name here
 * @version    SVN: $Id: sfDoctrineFormGeneratedTemplate.php 29553 2010-05-20 14:33:00Z Kris.Wallsmith $
 */
abstract class BaseMemberForm extends BaseFormDoctrine
{
  public function setup()
  {
    $this->setWidgets(array(
      'id'         => new sfWidgetFormInputHidden(),
      'firstname'  => new sfWidgetFormInputText(),
      'lastname'   => new sfWidgetFormInputText(),
      'email'      => new sfWidgetFormInputText(),
      'password'   => new sfWidgetFormInputText(),
      'membership' => new sfWidgetFormDoctrineChoice(array('model' => $this->getRelatedModelName('Membership'), 'add_empty' => false)),
      'created_at' => new sfWidgetFormDateTime(),
      'updated_at' => new sfWidgetFormDateTime(),
    ));

    $this->setValidators(array(
      'id'         => new sfValidatorChoice(array('choices' => array($this->getObject()->get('id')), 'empty_value' => $this->getObject()->get('id'), 'required' => false)),
      'firstname'  => new sfValidatorPass(),
      'lastname'   => new sfValidatorPass(),
      'email'      => new sfValidatorPass(),
      'password'   => new sfValidatorPass(),
      'membership' => new sfValidatorDoctrineChoice(array('model' => $this->getRelatedModelName('Membership'))),
      'created_at' => new sfValidatorDateTime(),
      'updated_at' => new sfValidatorDateTime(),
    ));

    $this->widgetSchema->setNameFormat('member[%s]');

    $this->errorSchema = new sfValidatorErrorSchema($this->validatorSchema);

    $this->setupInheritance();

    parent::setup();
  }

  public function getModelName()
  {
    return 'Member';
  }

}
