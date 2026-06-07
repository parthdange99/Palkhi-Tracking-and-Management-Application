<?php

namespace App\Models;

use CodeIgniter\Model;

class ContactModel extends Model
{
    protected $table = 'contact_queries'; // Table name
    protected $primaryKey = 'id'; // Primary key
    protected $allowedFields = ['name', 'email', 'query']; // Fields that can be inserted/updated
    protected $useTimestamps = true; // Automatically manage created_at and updated_at fields
}