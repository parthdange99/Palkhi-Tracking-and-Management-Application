<?php
namespace App\Models;

use CodeIgniter\Model;

class LocationModel extends Model
{
    protected $table = 'locations';
    protected $primaryKey = 'id';
    protected $allowedFields = ['user_id', 'latitude', 'longitude', 'place', 'created_at', 'updated_at'];

    // Enable timestamps
    protected $useTimestamps = true;
    protected $createdField = 'created_at';
    protected $updatedField = 'updated_at';
}
