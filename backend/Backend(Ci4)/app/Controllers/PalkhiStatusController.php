<?php

namespace App\Controllers;

use CodeIgniter\RESTful\ResourceController;
use App\Models\PalkhiModel1;

class PalkhiStatusController extends ResourceController
{
    protected $modelName = 'App\Models\PalkhiModel';
    protected $format    = 'json';

    // Load the palkhi tracking page
    public function index()
    {
        return view('palkhi_status');
    }

    // Fetch palkhi status from the database
    public function fetchStatus()
    {
        $palkhiNumber = $this->request->getPost('palkhi_number');

        $palkhiData = $this->model->where('palkhi_number', $palkhiNumber)->findAll();

        if (!$palkhiData) {
            return $this->respond([
                'status'  => 404,
                'message' => 'Palkhi not found!',
            ]);
        }

        return $this->respond([
            'status'  => 200,
            'palkhi'   => $palkhiData
        ]);
    }
}
