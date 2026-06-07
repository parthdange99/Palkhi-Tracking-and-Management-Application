<?php

namespace App\Controllers;

use App\Models\YatraStopModel;
use CodeIgniter\RESTful\ResourceController;

class YatraProgress extends ResourceController
{
    protected $format = 'json';

    public function listStops()
    {
        $model = new YatraStopModel();
        $stops = $model->getStopsWithRoutes();

        return $this->respond([
            'status' => true,
            'data' => $stops
        ]);
    }
}
