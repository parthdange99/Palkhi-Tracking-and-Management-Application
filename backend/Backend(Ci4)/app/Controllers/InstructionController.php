<?php

namespace App\Controllers;

use CodeIgniter\RESTful\ResourceController;
use App\Models\InstructionModel;

class InstructionController extends ResourceController
{
    protected $modelName = 'App\Models\InstructionModel';
    protected $format    = 'json';


    // Get all instructions
    public function index()
    {
        return $this->respond($this->model->findAll());
    }

    // Create a new instruction
    public function create()
    {
        $data = $this->request->getJSON();

        if (!$data->title || !$data->description) {
            return $this->failValidationErrors('Title and Description are required.');
        }

        $this->model->insert([
            'title'       => $data->title,
            'description' => $data->description,
        ]);

        return $this->respondCreated(['message' => 'Instruction added successfully']);
    }

    // Get a single instruction
    public function show($id = null)
    {
        $instruction = $this->model->find($id);
        return $instruction ? $this->respond($instruction) : $this->failNotFound('Instruction not found');
    }

    // Update an instruction
    public function update($id = null)
    {
        $data = $this->request->getJSON();
        $instruction = $this->model->find($id);

        if (!$instruction) {
            return $this->failNotFound('Instruction not found');
        }

        $this->model->update($id, [
            'title'       => $data->title ?? $instruction['title'],
            'description' => $data->description ?? $instruction['description'],
        ]);

        return $this->respondUpdated(['message' => 'Instruction updated successfully']);
    }

    // Delete an instruction
    public function delete($id = null)
    {
        $instruction = $this->model->find($id);
        if (!$instruction) {
            return $this->failNotFound('Instruction not found');
        }

        $this->model->delete($id);
        return $this->respondDeleted(['message' => 'Instruction deleted successfully']);
    }

  
}
