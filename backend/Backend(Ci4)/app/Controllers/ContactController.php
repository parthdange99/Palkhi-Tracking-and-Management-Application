<?php

namespace App\Controllers;

use App\Models\ContactModel;
use CodeIgniter\Controller;

class ContactController extends Controller
{
    public function list()
{
    // Load the ContactModel
    $contactModel = new ContactModel();

    // Fetch all contact queries from the database
    $data['contacts'] = $contactModel->findAll();

    // Load the view and pass the data
    return view('contact_list', $data);
}
    public function index()
    {
        // Load the form view
        return view('contact_form');
    }

    public function submit()
    {
        // Validate the form input
        $validation = \Config\Services::validation();
        $validation->setRules([
            'name' => 'required',
            'email' => 'required|valid_email',
            'query' => 'required',
        ]);

        if (!$validation->withRequest($this->request)->run()) {
            // If validation fails, return to the form with errors
            return redirect()->back()->withInput()->with('errors', $validation->getErrors());
        }

        // Get the form data
        $data = [
            'name' => $this->request->getPost('name'),
            'email' => $this->request->getPost('email'),
            'query' => $this->request->getPost('query'),
        ];

        // Save the data to the database
        $contactModel = new ContactModel();
        $contactModel->insert($data);

        // Redirect with a success message
        return redirect()->to('/contact')->with('message', 'Your query has been submitted successfully!');
    }
}