<?php

namespace App\Models;

use CodeIgniter\Model;

class PalkhiModel extends Model
{
    protected $table      = 'palkhi';
    protected $primaryKey = 'id';
    protected $allowedFields = ['palkhi_number', 'palkhi_name', 'source_name', 'arrival_time', 'departure_time', 'distance_km'];
}
