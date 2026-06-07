<?php

namespace App\Controllers;

use CodeIgniter\RESTful\ResourceController;

class UserVolunteerController extends ResourceController
{
    protected $modelName = 'App\Models\VolunteerModel';
    protected $format    = 'json';

    // Volunteer Registration
    public function registerVolunteer()
    {
        $validation = \Config\Services::validation();

        // Check if the request body contains JSON data
        $data = $this->request->getJSON(true); // true will convert it to an array

        if (!$data) {
            return $this->failValidationError('Invalid JSON data');
        }

        // Define validation rules
        $rules = [
            'name'            => 'required|min_length[3]|max_length[100]',
            'email'           => 'required|valid_email|max_length[100]',
            'mobile'          => 'required|numeric|exact_length[10]',
            'address'         => 'required|min_length[10]|max_length[255]',
            'city'            => 'required|max_length[50]',
            'state'           => 'required|max_length[50]',
            'skills'          => 'required|in_list[First Aid,Crowd Management,Cooking]', // Validate against ENUM
            'availability'    => 'required|max_length[50]',
            'additional_info' => 'permit_empty|max_length[255]'
        ];

        // Validate input
        if (!$this->validate($rules)) {
            return $this->failValidationErrors($validation->getErrors());
        }

        // Collect input data
        $dataToInsert = [
            'name'            => $data['name'],
            'email'           => $data['email'],
            'mobile'          => $data['mobile'],
            'address'         => $data['address'],
            'city'            => $data['city'],
            'state'           => $data['state'],
            'skills'          => $data['skills'], // Store as plain string (ENUM values)
            'availability'    => $data['availability'],
            'additional_info' => $data['additional_info'],
        ];

        // Insert data into database
        if ($this->model->insert($dataToInsert)) {
            return $this->respondCreated([
                'status' => 'success',
                'message' => 'Volunteer registration successful',
            ]);
        } else {
            return $this->failServerError('Failed to register volunteer');
        }
    }

    // Fetch States and Cities
    public function getStatesAndCities()
    {
        $data = [
            'states' => ['Maharashtra'], // Add more states if needed
            'cities' => [
                'Mumbai', 'Pune', 'Nagpur', 'Nashik', 'Thane', 'Aurangabad', 'Solapur',
                'Amravati', 'Kolhapur', 'Latur', 'Akola', 'Sangli', 'Jalgaon', 'Nanded',
                'Dhule', 'Ahmednagar', 'Chandrapur', 'Parbhani', 'Bhiwandi', 'Malegaon',
                'Satara', 'Alibag', 'Beed', 'Ratnagiri', 'Wardha', 'Yavatmal', 'Osmanabad',
                'Panvel', 'Kalyan-Dombivli', 'Vasai-Virar', 'Ulhasnagar'
            ]
        ];

        return $this->respond($data);
    }
}