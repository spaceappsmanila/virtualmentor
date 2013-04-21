<?php

/**
 * CourseRegistration form base class.
 *
 * @method CourseRegistration getObject() Returns the current form's model object
 *
 * @package    virtualmentor
 * @subpackage form
 * @author     Your name here
 * @version    SVN: $Id: sfDoctrineFormGeneratedTemplate.php 29553 2010-05-20 14:33:00Z Kris.Wallsmith $
 */
abstract class BaseCourseRegistrationForm extends BaseFormDoctrine
{
  public function setup()
  {
    $this->setWidgets(array(
      'id'         => new sfWidgetFormInputHidden(),
      'course'     => new sfWidgetFormDoctrineChoice(array('model' => $this->getRelatedModelName('Course'), 'add_empty' => false)),
      'mentee'     => new sfWidgetFormDoctrineChoice(array('model' => $this->getRelatedModelName('Member'), 'add_empty' => false)),
      'status'     => new sfWidgetFormDoctrineChoice(array('model' => $this->getRelatedModelName('RegistrationStatus'), 'add_empty' => false)),
      'created_at' => new sfWidgetFormDateTime(),
      'updated_at' => new sfWidgetFormDateTime(),
    ));

    $this->setValidators(array(
      'id'         => new sfValidatorChoice(array('choices' => array($this->getObject()->get('id')), 'empty_value' => $this->getObject()->get('id'), 'required' => false)),
      'course'     => new sfValidatorDoctrineChoice(array('model' => $this->getRelatedModelName('Course'))),
      'mentee'     => new sfValidatorDoctrineChoice(array('model' => $this->getRelatedModelName('Member'))),
      'status'     => new sfValidatorDoctrineChoice(array('model' => $this->getRelatedModelName('RegistrationStatus'))),
      'created_at' => new sfValidatorDateTime(),
      'updated_at' => new sfValidatorDateTime(),
    ));

    $this->widgetSchema->setNameFormat('course_registration[%s]');

    $this->errorSchema = new sfValidatorErrorSchema($this->validatorSchema);

    $this->setupInheritance();

    parent::setup();
  }

  public function getModelName()
  {
    return 'CourseRegistration';
  }

}
