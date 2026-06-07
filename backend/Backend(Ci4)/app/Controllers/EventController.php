<?php 

namespace App\Controllers;

use App\Models\ScheduleModel;
use App\Models\PalkhiModel;

class EventController extends BaseController {
    public function schedule()
    {
        $scheduleModel = new ScheduleModel();
        $data['schedules'] = $scheduleModel->findAll();
        return view('schedule', $data); // Load the view displaying all schedules
    }

    // Load the form to add a new schedule
    public function addScheduleForm()
    {
        return view('add-schedule'); // Load the add_schedule view
    }

    // Save a new schedule to the database
    public function saveSchedule()
    {
        $data = [
            'Date' => $this->request->getPost('date'),
            'event' => $this->request->getPost('event'),
            'created_at' => date('Y-m-d H:i:s'),
            'updated_at' => date('Y-m-d H:i:s'),
        ];

        $scheduleModel = new ScheduleModel();
        if ($scheduleModel->insert($data)) {
            return $this->response->setJSON(['success' => true, 'message' => 'Schedule added successfully']);
        } else {
            return $this->response->setJSON(['success' => false, 'message' => 'Failed to add schedule']);
        }
    }

    // Delete a schedule
    public function deleteSchedule($id)
    {
        $scheduleModel = new ScheduleModel();

        if ($scheduleModel->delete($id)) {
            return redirect()->to('/admin/schedule')->with('success', 'Schedule deleted successfully!');
        } else {
            return redirect()->to('/admin/schedule')->with('error', 'Failed to delete schedule.');
        }
    }


    // Display Palkhi information page
    public function palkhi()
    {
        $palkhiModel = new PalkhiModel();
        $data['palkhis'] = $palkhiModel->findAll();
        return view('palkhi', $data);
    }

    // Add Palkhi information
    public function addPalkhiForm()
    {
        return view('add-palkhi'); // Load the add_palkhi view
    }

    // Save Palkhi to the Database
    public function savePalkhi()
    {
        $data = [
            'title' => $this->request->getPost('title'),
            'description' => $this->request->getPost('description'),
            'created_at' => date('Y-m-d H:i:s'),
            'updated_at' => date('Y-m-d H:i:s'),
        ];
    
        $model = new \App\Models\PalkhiModel();
        if ($model->insert($data)) {
            return $this->response->setJSON(['success' => true, 'message' => 'Data inserted successfully']);
        } else {
            return $this->response->setJSON(['success' => false, 'message' => 'Failed to insert data']);
        }
    }
    

    public function deletePalkhi($id)
    {
        // Load the model
        $palkhiModel = new PalkhiModel();

        // Delete the record
        if ($palkhiModel->delete($id)) {
            return redirect()->to('/admin/palkhi')->with('success', 'Palkhi deleted successfully!');
        } else {
            return redirect()->to('/admin/palkhi')->with('error', 'Failed to delete Palkhi.');
        }
    }
}