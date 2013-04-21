<?php

/**
 * Feedback form base class.
 *
 * @method Feedback getObject() Returns the current form's model object
 *
 * @package    virtualmentor
 * @subpackage form
 * @author     Your name here
 * @version    SVN: $Id: sfDoctrineFormGeneratedTemplate.php 29553 2010-05-20 14:33:00Z Kris.Wallsmith $
 */
abstract class BaseFeedbackForm extends BaseFormDoctrine
{
  public function setup()
  {
    $this->setWidgets(array(
      'id'              => new sfWidgetFormInputHidden(),
      'question'        => new sfWidgetFormDoctrineChoice(array('model' => $this->getRelatedModelName('Question'), 'add_empty' => false)),
      'videochat'       => new sfWidgetFormInputText(),
      'website'         => new sfWidgetFormInputText(),
      'questionability' => new sfWidgetFormInputText(),
      'interest'        => new sfWidgetFormInputText(),
      'created_at'      => new sfWidgetFormDateTime(),
      'updated_at'      => new sfWidgetFormDateTime(),
    ));

    $this->setValidators(array(
      'id'              => new sfValidatorChoice(array('choices' => array($this->getObject()->get('id')), 'empty_value' => $this->getObject()->get('id'), 'required' => false)),
      'question'        => new sfValidatorDoctrineChoice(array('model' => $this->getRelatedModelName('Question'))),
      'videochat'       => new sfValidatorInteger(),
      'website'         => new sfValidatorInteger(),
      'questionability' => new sfValidatorInteger(),
      'interest'        => new sfValidatorInteger(),
      'created_at'      => new sfValidatorDateTime(),
      'updated_at'      => new sfValidatorDateTime(),
    ));

    $this->widgetSchema->setNameFormat('feedback[%s]');

    $this->errorSchema = new sfValidatorErrorSchema($this->validatorSchema);

    $this->setupInheritance();

    parent::setup();
  }

  public function getModelName()
  {
    return 'Feedback';
  }

}
