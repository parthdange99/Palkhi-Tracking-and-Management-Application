<?php

namespace App\Models;

use CodeIgniter\Model;

class AdminModel extends Model
{
    protected $table = 'admins';
    protected $primaryKey = 'id';
    protected $allowedFields = ['name', 'email', 'password', 'created_at', 'updated_at']; // Include avatar field
    protected $returnType = 'array';
    protected $useTimestamps = true;

}
