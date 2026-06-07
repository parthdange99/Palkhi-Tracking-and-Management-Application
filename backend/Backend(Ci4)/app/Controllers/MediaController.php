<?php

namespace App\Controllers;

use CodeIgniter\Controller;
use CodeIgniter\RESTful\ResourceController;

class MediaController extends ResourceController
{
    protected $modelName = 'App\Models\MediaModel';
    protected $format    = 'json';

    public function __construct()
    {
        // Set CORS headers
        header('Access-Control-Allow-Origin: *');
        header('Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE');
        header('Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With');
    }

    private function getServerIp()
{
    return $_SERVER['SERVER_ADDR'] ?? '127.0.0.1'; // fallback to localhost
}

    // API: Add Media
    public function viewManagement()
    {
        return view('media_management');
    }
    public function addMedia()
    {
        try {
            $data = $this->request->getPost();
            $file = $this->request->getFile('file');

            if (!$file->isValid()) {
                return $this->fail('Invalid file upload.');
            }

            // Ensure directories exist
            $uploadPath = WRITEPATH . '../public/uploads/';
            $photoDir = $uploadPath . 'photo/';
            $videoDir = $uploadPath . 'video/';

            if (!is_dir($photoDir)) {
                mkdir($photoDir, 0777, true);
            }
            if (!is_dir($videoDir)) {
                mkdir($videoDir, 0777, true);
            }

            // Determine upload destination
            $type = $data['type'];
            $targetDir = ($type === 'photo') ? $photoDir : $videoDir;

            // Generate unique file name
            $extension = $file->getClientExtension();
            $newName = uniqid() . '.' . $extension;

            // Move file to target directory
            $file->move($targetDir, $newName);

            $filePath = 'uploads/' . $type . '/' . $newName;
$url = base_url($filePath);

            // Save data to the database
            $dataToInsert = [
                'type'        => $type,
                'description' => $data['description'],
                'url'         => $url,
            ];

            if ($this->model->insert($dataToInsert)) {
                return $this->respondCreated(['status' => 'success', 'message' => 'Media added successfully.', 'url' => $url]);
            }

            return $this->failServerError('Failed to add media.');
        } catch (\Exception $e) {
            return $this->failServerError('Error occurred: ' . $e->getMessage());
        }
    }

    // API: Fetch All Media with Updated IP Address
    public function getAllMedia()
    {
        try {
            $media = $this->model->findAll();

            if (!$media) {
                return $this->respond(['status' => 'success', 'message' => 'No media found.', 'data' => []], 200);
            }

            $serverIp = $this->getServerIp();

            // Update URLs dynamically with the current IP
            foreach ($media as &$item) {
                $parsedUrl = parse_url($item['url']);
                $path = $parsedUrl['path'] ?? '';
                $item['url'] = 'http://' . $serverIp . $path;
            }

            return $this->respond(['status' => 'success', 'message' => 'Media fetched successfully.', 'data' => $media], 200);
        } catch (\Exception $e) {
            return $this->failServerError('Error occurred: ' . $e->getMessage());
        }
    }

    // API: Delete Media
    public function deleteMedia($id)
    {
        try {
            $media = $this->model->find($id);

            if (!$media) {
                return $this->failNotFound('Media not found.');
            }

            // Remove physical file
            $filePath = WRITEPATH . '../public/' . parse_url($media['url'], PHP_URL_PATH);
            if (file_exists($filePath)) {
                unlink($filePath);
            }

            // Remove from database
            if ($this->model->delete($id)) {
                return $this->respondDeleted(['status' => 'success', 'message' => 'Media deleted successfully.']);
            }

            return $this->failServerError('Failed to delete media.');
        } catch (\Exception $e) {
            return $this->failServerError('Error occurred: ' . $e->getMessage());
        }
    }
}