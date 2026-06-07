<?php

namespace App\Models;

use CodeIgniter\Model;

class MediaModel extends Model
{
    protected $table = 'media';
    protected $primaryKey = 'id';
    protected $allowedFields = ['type', 'url', 'description', 'created_at', 'updated_at'];

protected $returnType = 'array';
protected $useTimestamps = true;
}