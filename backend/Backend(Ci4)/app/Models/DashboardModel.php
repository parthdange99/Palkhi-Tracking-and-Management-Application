<?php

namespace App\Models;

use CodeIgniter\Model;

class DashboardModel extends Model
{
    public function getUserCount()
    {
        return $this->db->table('users')->countAllResults();
    }

    public function getVolunteerCount()
    {
        return $this->db->table('volunteers')->countAllResults();
    }

    public function getEventCount()
    {
        return $this->db->table('schedules')->countAllResults();
    }

    public function getPalkhiCount()
    {
        return $this->db->table('palkhis')->countAllResults();
    }

    // Commenting out additional methods for traffic analytics and charts
    /*
    public function getActiveUsers()
    {
        // Example query to fetch active users (dummy implementation)
        return $this->db->table('users')->where('status', 'active')->countAllResults();
    }

    public function getPopularStops()
    {
        // Example query to fetch popular stops (dummy implementation)
        return $this->db->table('stops')->orderBy('visit_count', 'DESC')->get()->getResult();
    }

    public function getTrafficTimes()
    {
        // Example query to fetch traffic data (dummy implementation)
        return $this->db->table('traffic')->get()->getResult();
    }
    */
}