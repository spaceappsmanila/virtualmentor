<?php

/**
 * BaseCourseRegistration
 * 
 * This class has been auto-generated by the Doctrine ORM Framework
 * 
 * @property integer $id
 * @property integer $course
 * @property integer $mentee
 * @property integer $status
 * @property Course $Course
 * @property Member $Member
 * @property RegistrationStatus $RegistrationStatus
 * 
 * @method integer            getId()                 Returns the current record's "id" value
 * @method integer            getCourse()             Returns the current record's "course" value
 * @method integer            getMentee()             Returns the current record's "mentee" value
 * @method integer            getStatus()             Returns the current record's "status" value
 * @method Course             getCourse()             Returns the current record's "Course" value
 * @method Member             getMember()             Returns the current record's "Member" value
 * @method RegistrationStatus getRegistrationStatus() Returns the current record's "RegistrationStatus" value
 * @method CourseRegistration setId()                 Sets the current record's "id" value
 * @method CourseRegistration setCourse()             Sets the current record's "course" value
 * @method CourseRegistration setMentee()             Sets the current record's "mentee" value
 * @method CourseRegistration setStatus()             Sets the current record's "status" value
 * @method CourseRegistration setCourse()             Sets the current record's "Course" value
 * @method CourseRegistration setMember()             Sets the current record's "Member" value
 * @method CourseRegistration setRegistrationStatus() Sets the current record's "RegistrationStatus" value
 * 
 * @package    virtualmentor
 * @subpackage model
 * @author     Your name here
 * @version    SVN: $Id: Builder.php 7490 2010-03-29 19:53:27Z jwage $
 */
abstract class BaseCourseRegistration extends sfDoctrineRecord
{
    public function setTableDefinition()
    {
        $this->setTableName('course_registration');
        $this->hasColumn('id', 'integer', null, array(
             'type' => 'integer',
             'primary' => true,
             'autoincrement' => true,
             ));
        $this->hasColumn('course', 'integer', null, array(
             'type' => 'integer',
             'notnull' => true,
             ));
        $this->hasColumn('mentee', 'integer', null, array(
             'type' => 'integer',
             'notnull' => true,
             ));
        $this->hasColumn('status', 'integer', null, array(
             'type' => 'integer',
             'notnull' => true,
             ));
    }

    public function setUp()
    {
        parent::setUp();
        $this->hasOne('Course', array(
             'local' => 'course',
             'foreign' => 'id',
             'onDelete' => 'CASCADE',
             'onUpdate' => 'CASCADE'));

        $this->hasOne('Member', array(
             'local' => 'mentee',
             'foreign' => 'id',
             'onDelete' => 'CASCADE',
             'onUpdate' => 'CASCADE'));

        $this->hasOne('RegistrationStatus', array(
             'local' => 'status',
             'foreign' => 'id',
             'onDelete' => 'CASCADE',
             'onUpdate' => 'CASCADE'));

        $timestampable0 = new Doctrine_Template_Timestampable();
        $this->actAs($timestampable0);
    }
}