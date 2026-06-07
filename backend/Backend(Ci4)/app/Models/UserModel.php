<?php

namespace App\Models;

use CodeIgniter\Model;

class UserModel extends Model
{
    protected $table = 'users';
    protected $primaryKey = 'id';
    protected $allowedFields = [
        'name', 'mobile', 'email', 'gender', 'address', 
        'pincode', 'password', 'created_at', 'updated_at'
    ];
    protected $returnType = 'array';
    protected $useTimestamps = true;
    public function getTotalUsers()
    {
        return $this->countAll();
    }
}
