<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\VolunteerModel;

class VolunteerController extends BaseController
{
    protected $volunteerModel;

    protected $states = [
        "Maharashtra", "Gujarat", "Karnataka", "Rajasthan", "Tamil Nadu", "Uttar Pradesh", "West Bengal", "Punjab"
    ];

    protected $cities = [
        "Maharashtra" => [
            "Mumbai", "Pune", "Nagpur", "Thane", "Nashik", "Aurangabad", "Solapur", "Kolhapur"
        ],
        "Gujarat" => ["Ahmedabad", "Surat", "Vadodara", "Rajkot"],
        "Karnataka" => ["Bengaluru", "Mysuru", "Mangalore"],
        "Rajasthan" => ["Jaipur", "Udaipur", "Jodhpur"],
        "Tamil Nadu" => ["Chennai", "Coimbatore", "Madurai"],
        "Uttar Pradesh" => ["Lucknow", "Kanpur", "Varanasi"],
        "West Bengal" => ["Kolkata", "Darjeeling", "Howrah"],
        "Punjab" => ["Amritsar", "Ludhiana", "Patiala"],
    ];

    public function __construct()
    {
        $this->volunteerModel = new VolunteerModel();
    }

    // Display volunteers list
    public function index()
    {
        $volunteers = $this->volunteerModel->findAll();
        return view('volunteer_list', [
            'volunteers' => $volunteers
        ]);
    }

    // Add a new volunteer (view)
    public function addVolunteerForm()
    {
        return view('add_volunteer', [
            'states' => $this->states,
            'cities' => $this->cities
        ]);
    }

    // Save volunteer data to the database
    public function saveVolunteer()
    {
        $data = [
            'active_section' => 'volunteers',
            'name' => $this->request->getPost('name'),
            'email' => $this->request->getPost('email'),
            'state' => $this->request->getPost('state'),
            'city' => $this->request->getPost('city'),
            'preference' => $this->request->getPost('preference'),
            'availability' => $this->request->getPost('availability'),
        ];

        if ($this->volunteerModel->insert($data)) {
            return redirect()->to('/volunteers')->with('success', 'Volunteer added successfully.');
        }

        return redirect()->back()->with('error', 'Failed to add volunteer.');
    }

    // Assign a task to a volunteer
   // Assign a task to a volunteer
public function assignTask($id)
{
    $task = $this->request->getPost('task');

    if ($this->volunteerModel->update($id, ['assigned_task' => $task])) {
        return redirect()->to('/volunteers')->with('success', 'Task assigned successfully.');
    }

    return redirect()->to('/volunteers')->with('error', 'Failed to assign task.');
}

    // Delete a volunteer
    public function deleteVolunteer($id)
    {
        if ($this->volunteerModel->delete($id)) {
            return redirect()->to('/volunteers')->with('success', 'Volunteer deleted successfully.');
        }

        return redirect()->to('/volunteers')->with('error', 'Failed to delete volunteer.');
    }
}
