<?php

namespace App\Controllers;

use CodeIgniter\Controller;
use App\Models\DashboardModel;

class DashboardController extends BaseController
{
    public function index()
    {
        $dashboardModel = new DashboardModel();

        // Fetch counts from the model
        $data = [
            'active_section' => 'Dashboard',
            'totalUsers' => $dashboardModel->getUserCount(),
            'totalVolunteers' => $dashboardModel->getVolunteerCount(),
            'totalSchedules' => $dashboardModel->getEventCount(),
            'totalPalkhis' => $dashboardModel->getPalkhiCount(),
        ];

        // Comment out traffic and analytics parts for now
        /*
        $data['activeUsers'] = $dashboardModel->getActiveUsers();
        $data['popularStops'] = $dashboardModel->getPopularStops();
        $data['trafficData'] = $dashboardModel->getTrafficTimes();
        */

        return view('dashboard', $data); // Pass the data to the view
    }
}