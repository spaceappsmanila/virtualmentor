<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of createAction
 *
 * @author markbadiola
 */
class createAction extends sfAction {

    public function execute($request) {
        try {
            if ($request->isMethod('get')) {
                $type = $request->getParameter('type');
                $credentials = $this->getUser()->getCredentials();

                switch ($type) {
                    case 'course':
                        //sets up temporary course json string
                        $course = new Course();
                        $course->owner = $credentials[1];
                        $course->name = 'Course';
                        $course->description = 'Course description';

                        for ($i = 0; $i < 3; $i++) {
                            $lessonplan = new LessonPlan();
                            $lessonplan->name = 'Lesson' . $i;
                            $lessonplan->owner = $credentials[1];
                            $lessonplan->description = 'Description' . $i;
                            $lessonplan->durationindays = 5;
                            for ($j = 0; $j < 10; $j++) {
                                $q = new Question();
                                $q->name = 'Name' . $j;
                                $q->question = 'Question' . $j;
                                $lessonplan->Questions->add($q);
                            }
                            $course->Lessons->add($lessonplan);
                        }

                        $this->json = $course->exportTo('json');
                        $this->type = $type;

                        return sfView::INPUT;
                        break;
                    case 'lesson':
                        $courseid = $request->getParameter('courseid');
                        break;
                }
            } else if ($request->isMethod('post')) {
                $data = $request->getParameter('json');
                $course = new Course();
                $course->importFrom('json', $data);

                $parser = new Doctrine_Parser_Json();
                $obj = $parser->loadData($data, 'json');

                if ($obj->Lessons) {
                    foreach ($obj->Lessons as $l) {
                        $lesson = new LessonPlan();
                        $lesson->importFrom('json', json_encode($l));
                        if ($l->Questions) {
                            foreach ($l->Questions as $q) {
                                $question = new Question();
                                $question->importFrom('json', json_encode($q));
                                $lesson->Questions->add($question);
                            }
                        }
                        $course->Lessons->add($lesson);
                    }
                }

                $course->save();
                echo json_encode(true);
                return sfView::NONE;
            }
        } catch (Exception $e) {
            echo json_encode($e->getMessage());
            return sfView::NONE;
        }
    }

}

?>
