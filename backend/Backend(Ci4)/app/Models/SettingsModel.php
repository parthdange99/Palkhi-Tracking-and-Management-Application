<?php

namespace App\Models;

use CodeIgniter\Model;

class SettingsModel extends Model
{
    protected $table = 'settings';
    protected $primaryKey = 'id';
    protected $allowedFields = ['key', 'value'];

    /**
     * Fetch all settings as key-value pairs.
     */
    public function getSettings()
    {
        $results = $this->findAll();
        $settings = [];

        foreach ($results as $row) {
            $settings[$row['key']] = $row['value'];
        }

        return $settings;
    }

    /**
     * Update multiple settings in the database.
     */
    public function updateSettings($data)
    {
        foreach ($data as $key => $value) {
            $this->where('key', $key)->set(['value' => $value])->update();
        }
    }
}
