<?php

/**
 * LessonPlan form base class.
 *
 * @method LessonPlan getObject() Returns the current form's model object
 *
 * @package    virtualmentor
 * @subpackage form
 * @author     Your name here
 * @version    SVN: $Id: sfDoctrineFormGeneratedTemplate.php 29553 2010-05-20 14:33:00Z Kris.Wallsmith $
 */
abstract class BaseLessonPlanForm extends BaseFormDoctrine
{
  public function setup()
  {
    $this->setWidgets(array(
      'id'             => new sfWidgetFormInputHidden(),
      'name'           => new sfWidgetFormInputText(),
      'description'    => new sfWidgetFormTextarea(),
      'durationindays' => new sfWidgetFormInputText(),
      'owner'          => new sfWidgetFormDoctrineChoice(array('model' => $this->getRelatedModelName('Member'), 'add_empty' => false)),
      'course'         => new sfWidgetFormDoctrineChoice(array('model' => $this->getRelatedModelName('Course'), 'add_empty' => false)),
      'created_at'     => new sfWidgetFormDateTime(),
      'updated_at'     => new sfWidgetFormDateTime(),
    ));

    $this->setValidators(array(
      'id'             => new sfValidatorChoice(array('choices' => array($this->getObject()->get('id')), 'empty_value' => $this->getObject()->get('id'), 'required' => false)),
      'name'           => new sfValidatorPass(),
      'description'    => new sfValidatorString(),
      'durationindays' => new sfValidatorInteger(),
      'owner'          => new sfValidatorDoctrineChoice(array('model' => $this->getRelatedModelName('Member'))),
      'course'         => new sfValidatorDoctrineChoice(array('model' => $this->getRelatedModelName('Course'))),
      'created_at'     => new sfValidatorDateTime(),
      'updated_at'     => new sfValidatorDateTime(),
    ));

    $this->widgetSchema->setNameFormat('lesson_plan[%s]');

    $this->errorSchema = new sfValidatorErrorSchema($this->validatorSchema);

    $this->setupInheritance();

    parent::setup();
  }

  public function getModelName()
  {
    return 'LessonPlan';
  }

}
