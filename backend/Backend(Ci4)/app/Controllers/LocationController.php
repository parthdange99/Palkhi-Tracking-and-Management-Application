<?php

namespace App\Controllers;

use App\Models\LocationModel;
use CodeIgniter\RESTful\ResourceController;

class LocationController extends ResourceController
{
    protected $format = 'json';

    // Fetch location data for a specific user
    public function index()
    {
        $userId = session()->get('user_id'); // Get user ID from session

        if (!$userId) {
            return $this->fail('User not logged in.');
        }

        $locationModel = new LocationModel();
        $locationData = $locationModel->where('user_id', $userId)->first();

        if (!$locationData) {
            return $this->failNotFound('Location data not found.');
        }

        return $this->respond(['data' => $locationData]);
    }

    public function update($id = null) // Include the $id parameter
{
    $userId = session()->get('user_id'); // Get user ID from session

    if (!$userId) {
        return $this->fail('User not logged in.');
    }

    $rules = [
        'latitude'  => 'required|decimal',
        'longitude' => 'required|decimal',
        'place'     => 'required|string'
    ];

    // Validate input
    if (!$this->validate($rules)) {
        return $this->fail($this->validator->getErrors());
    }

    $locationModel = new LocationModel();
    $locationData = $locationModel->where('user_id', $userId)->first();

    // Update or create location data
    if ($locationData) {
        $locationModel->update($locationData['id'], [
            'latitude'  => $this->request->getVar('latitude'),
            'longitude' => $this->request->getVar('longitude'),
            'place'     => $this->request->getVar('place')
        ]);
    } else {
        // Create new entry if it doesn't exist
        $locationModel->insert([
            'user_id'   => $userId,
            'latitude'  => $this->request->getVar('latitude'),
            'longitude' => $this->request->getVar('longitude'),
            'place'     => $this->request->getVar('place')
        ]);
    }

    return $this->respond(['message' => 'Location updated successfully.']);
}
}