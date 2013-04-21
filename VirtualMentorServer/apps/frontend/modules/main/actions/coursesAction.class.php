<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of coursesAction
 *
 * @author markbadiola
 */
class coursesAction extends sfAction {

    public function execute($request) {
        try {
            if ($request->isMethod('get')) {
                $id = $request->getParameter('id');
                $cid = $request->getParameter('cid');
                if ($this->getUser()->hasCredential($id)) {
                    if (empty($cid) or is_nan($cid)) {
                        if ($this->getUser()->hasCredential('mentor')) {
                            $courses = Doctrine_Query::create()
                                    ->select('*')
                                    ->from('Course c')
                                    ->where("c.owner = $id")
                                    ->fetchArray();
                            return $this->renderText(json_encode($courses));
                        } else if ($this->getUser()->hasCredential('mentee')) {
                            /*$courseids = Doctrine_Query::create()
                                    ->select('r.course')
                                    ->from('CourseRegistration r')
                                    ->where("r.mentee = $id")
                                    ->fetchArray();
                            $cidsArr = array();
                            for ($i = 0; $i < count($courseids); $i++) {
                                $cidsArr[$i] = $courseids[$i]['course'];
                            }
                            $courses = Doctrine_Query::create()
                                    ->select('*')
                                    ->from('Course c')
                                    ->whereIn('c.id', $cidsArr)
                                    ->fetchArray();
                            return $this->renderText(json_encode($courses));*/
                            $courses = Doctrine_Query::create()
                                    ->select('r.*, c.*')
                                    ->from('CourseRegistration r')
                                    ->leftJoin('r.Course c')
                                    ->where("r.mentee = $id")
                                    ->fetchArray();
                            return $this->renderText(json_encode($courses));
                        }
                    } else if($cid == 0) {
                      $courses = Doctrine_Query::create()
                              ->select('*')
                              ->from('Course c')
                              ->fetchArray();
                      return $this->renderText(json_encode($courses));
                    } else {
                        //get course details
                        $courses = Doctrine_Query::create()->select('*')
                                ->from('Course c')
                                ->where("c.id = $cid")
                                ->fetchArray();
                        $course = new Course();
                        $course->fromArray($courses[0]);

                        //get lessons under course
                        $lessons = Doctrine_Query::create()->select('*')
                                ->from('LessonPlan l')
                                ->where("l.course = $cid")
                                ->fetchArray();
                        foreach ($lessons as $l) {
                            $lesson = new LessonPlan();
                            $lesson->fromArray($l);
                            $questions = Doctrine_Query::create()->select('*')
                                    ->from('Question q')
                                    ->where("q.lessonplan = $lesson->id")
                                    ->fetchArray();
                            foreach ($questions as $q) {
                                $question = new Question();
                                $question->fromArray($q);
                                $lesson->Questions->add($question);
                            }
                            $course->Lessons->add($lesson);
                        }
                        return $this->renderText($course->exportTo('json'));
                    }
                } else {
                    throw new Exception('Action forbidden.');
                }
            }
        } catch (Exception $e) {
            echo json_encode($e->getMessage());
            return sfView::NONE;
        }
    }

}

?>
