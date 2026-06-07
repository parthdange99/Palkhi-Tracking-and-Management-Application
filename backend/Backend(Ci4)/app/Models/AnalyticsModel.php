<?php

namespace App\Models;

use CodeIgniter\Model;

class AnalyticsModel extends Model
{
    protected $DBGroup = 'default';

    public function logTrackingEvent($userId, $processionId)
    {
        $builder = $this->db->table('tracking_events');
        $result = $builder->insert([
            'user_id' => $userId,
            'procession_id' => $processionId,
        ]);

        if (!$result) {
            log_message('error', 'Error inserting tracking event: ' . $this->db->error());
        }
    }

    public function logStopInteraction($userId, $stopName)
    {
        $builder = $this->db->table('stop_interactions');
        $result = $builder->insert([
            'user_id' => $userId,
            'stop_name' => $stopName,
        ]);

        if (!$result) {
            log_message('error', 'Error inserting stop interaction: ' . $this->db->error());
        }
    }

    public function updateActiveUsers($userId)
    {
        $builder = $this->db->table('active_users');
        $result = $builder->replace([
            'user_id' => $userId,
            'last_active' => date('Y-m-d H:i:s'),
        ]);

        if (!$result) {
            log_message('error', 'Error updating active user: ' . $this->db->error());
        }
    }

    public function updateTrafficData()
    {
        $hour = date('G'); // 24-hour format without leading zeros
        $date = date('Y-m-d');

        $result = $this->db->query("
            INSERT INTO traffic_data (hour, interaction_count, date)
            VALUES (?, 1, ?)
            ON DUPLICATE KEY UPDATE interaction_count = interaction_count + 1
        ", [$hour, $date]);

        if (!$result) {
            log_message('error', 'Error updating traffic data: ' . $this->db->error());
        }
    }

    public function testConnection()
    {
        $query = $this->db->query('SELECT 1');
        if ($query) {
            echo "Connection is working!";
        } else {
            log_message('error', 'Database connection failed.');
        }
    }
}