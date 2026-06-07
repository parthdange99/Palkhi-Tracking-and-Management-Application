<?php

namespace App\Models;

use CodeIgniter\Model;

class YatraStopModel extends Model
{
    protected $table = 'yatra_stops';
    protected $primaryKey = 'id';

    protected $allowedFields = ['name', 'status', 'eta', 'date', 'latitude', 'longitude'];

    public function getStopsWithRoutes()
    {
        $builder = $this->db->table('yatra_stops');
        $builder->orderBy('date', 'ASC');
        $stops = $builder->get()->getResultArray();

        foreach ($stops as &$stop) {
            $routes = $this->db->table('yatra_route_stops')
                ->where('yatra_stop_id', $stop['id'])
                ->get()
                ->getResultArray();

            $stop['coordinates'] = [
                'latitude' => $stop['latitude'],
                'longitude' => $stop['longitude']
            ];
            unset($stop['latitude'], $stop['longitude']);
            $stop['route_stops'] = array_map(function ($route) {
                return [
                    'name' => $route['name'],
                    'eta' => $route['eta'],
                    'coordinates' => [
                        'latitude' => $route['latitude'],
                        'longitude' => $route['longitude']
                    ],
                    'passed' => (bool) $route['passed']
                ];
            }, $routes);
        }

        return $stops;
    }
}
