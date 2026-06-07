<?php

namespace App\Controllers;

use CodeIgniter\Controller;
use App\Models\AnalyticsModel;

class AnalyticsController extends Controller
{
    public function getActiveUsers()
    {
        $model = new AnalyticsModel();
        $data = $model->getActiveUsers();
        return $this->response->setJSON($data);
    }

    public function getPopularStops()
    {
        $model = new AnalyticsModel();
        $data = $model->getPopularStops();
        return $this->response->setJSON($data);
    }

    public function getPeakTrafficTimes()
    {
        $model = new AnalyticsModel();
        $data = $model->getTrafficTimes();
        return $this->response->setJSON($data);
    }
}
