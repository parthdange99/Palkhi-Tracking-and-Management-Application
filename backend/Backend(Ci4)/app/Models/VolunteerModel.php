<?php

namespace App\Models;

use CodeIgniter\Model;

class VolunteerModel extends Model
{
    protected $table = 'volunteers';
    protected $primaryKey = 'id';
    protected $allowedFields = ['name', 'email', 'mobile', 'state', 'city', 'skills', 'availability', 'additional_info', 'assigned_task'];
    protected $useTimestamps = true;

    public function searchVolunteers($filters = [])
    {
        if (!empty($filters['search'])) {
            $this->like('name', $filters['search'])
                 ->orLike('email', $filters['search']);
        }

        if (!empty($filters['state'])) {
            $this->where('state', $filters['state']);
        }

        if (!empty($filters['city'])) {
            $this->where('city', $filters['city']);
        }

        if (!empty($filters['preference'])) {
            $this->where('preference', $filters['preference']);
        }

        if (!empty($filters['availability'])) {
            $this->where('availability', $filters['availability']);
        }

        return $this->findAll();
    }

    public function getTotalVolunteers()
    {
        return $this->countAll();
    }

    public function assignTask($volunteerId, $task)
    {
        return $this->update($volunteerId, ['assigned_task' => $task]);
    }
}
