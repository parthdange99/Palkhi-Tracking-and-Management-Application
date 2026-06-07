<?php namespace App\Models;

use CodeIgniter\Model;

class PalkhiModel extends Model {
    protected $table = 'palkhis';
    protected $primaryKey = 'id';
    protected $allowedFields = ['title', 'description'];
    protected $returnType = 'array';
    protected $useTimestamps = true;

    public function getTotalPalkhis()
    {
        return $this->countAll();
    }
}
