<?php

namespace App\Models;
use CodeIgniter\Model;

class Tracker_UserModel extends Model {
    protected $table = 'Tracker_Users';
    protected $primaryKey = 'id';
    protected $allowedFields = ['name', 'email', 'password', 'created_at'];
}
