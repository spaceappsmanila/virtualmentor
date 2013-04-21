<?php

/**
 * Feedback filter form base class.
 *
 * @package    virtualmentor
 * @subpackage filter
 * @author     Your name here
 * @version    SVN: $Id: sfDoctrineFormFilterGeneratedTemplate.php 29570 2010-05-21 14:49:47Z Kris.Wallsmith $
 */
abstract class BaseFeedbackFormFilter extends BaseFormFilterDoctrine
{
  public function setup()
  {
    $this->setWidgets(array(
      'question'        => new sfWidgetFormDoctrineChoice(array('model' => $this->getRelatedModelName('Question'), 'add_empty' => true)),
      'videochat'       => new sfWidgetFormFilterInput(array('with_empty' => false)),
      'website'         => new sfWidgetFormFilterInput(array('with_empty' => false)),
      'questionability' => new sfWidgetFormFilterInput(array('with_empty' => false)),
      'interest'        => new sfWidgetFormFilterInput(array('with_empty' => false)),
      'created_at'      => new sfWidgetFormFilterDate(array('from_date' => new sfWidgetFormDate(), 'to_date' => new sfWidgetFormDate(), 'with_empty' => false)),
      'updated_at'      => new sfWidgetFormFilterDate(array('from_date' => new sfWidgetFormDate(), 'to_date' => new sfWidgetFormDate(), 'with_empty' => false)),
    ));

    $this->setValidators(array(
      'question'        => new sfValidatorDoctrineChoice(array('required' => false, 'model' => $this->getRelatedModelName('Question'), 'column' => 'id')),
      'videochat'       => new sfValidatorSchemaFilter('text', new sfValidatorInteger(array('required' => false))),
      'website'         => new sfValidatorSchemaFilter('text', new sfValidatorInteger(array('required' => false))),
      'questionability' => new sfValidatorSchemaFilter('text', new sfValidatorInteger(array('required' => false))),
      'interest'        => new sfValidatorSchemaFilter('text', new sfValidatorInteger(array('required' => false))),
      'created_at'      => new sfValidatorDateRange(array('required' => false, 'from_date' => new sfValidatorDateTime(array('required' => false, 'datetime_output' => 'Y-m-d 00:00:00')), 'to_date' => new sfValidatorDateTime(array('required' => false, 'datetime_output' => 'Y-m-d 23:59:59')))),
      'updated_at'      => new sfValidatorDateRange(array('required' => false, 'from_date' => new sfValidatorDateTime(array('required' => false, 'datetime_output' => 'Y-m-d 00:00:00')), 'to_date' => new sfValidatorDateTime(array('required' => false, 'datetime_output' => 'Y-m-d 23:59:59')))),
    ));

    $this->widgetSchema->setNameFormat('feedback_filters[%s]');

    $this->errorSchema = new sfValidatorErrorSchema($this->validatorSchema);

    $this->setupInheritance();

    parent::setup();
  }

  public function getModelName()
  {
    return 'Feedback';
  }

  public function getFields()
  {
    return array(
      'id'              => 'Number',
      'question'        => 'ForeignKey',
      'videochat'       => 'Number',
      'website'         => 'Number',
      'questionability' => 'Number',
      'interest'        => 'Number',
      'created_at'      => 'Date',
      'updated_at'      => 'Date',
    );
  }
}
