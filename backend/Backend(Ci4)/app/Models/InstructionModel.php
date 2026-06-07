<?php

namespace App\Models;

use CodeIgniter\Model;

class InstructionModel extends Model
{
    protected $table = 'instructions';
    protected $primaryKey = 'id';
    protected $allowedFields = ['title', 'description', 'created_at', 'updated_at'];
    protected $useTimestamps = true;
}
