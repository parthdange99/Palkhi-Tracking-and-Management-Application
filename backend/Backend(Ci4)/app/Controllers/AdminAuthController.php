<?php

namespace App\Controllers;

use App\Models\AdminModel;
use CodeIgniter\Controller;
use CodeIgniter\Session\Session;

class AdminAuthController extends Controller
{
    protected $helpers = ['url', 'form', 'session']; // Load helpers for forms, URLs, and session handling

    // Admin Signup View
    public function signup()
    {
        $validation = null; // Initialize validation for signup form

        if ($this->request->getMethod() === 'post') {
            $rules = [
                'name' => 'required',
                'email' => 'required|valid_email|is_unique[admins.email]',
                'password' => 'required|min_length[8]|regex_match[/^(?=.*[A-Z])(?=.*\d).+$/]',
            ];

            if (!$this->validate($rules)) {
                $validation = $this->validator;
            } else {
                // Perform signup logic if validation passes
                $this->saveSignup();
                return; // Redirect handled in saveSignup()
            }
        }

        return view('admin/signup', ['validation' => $validation]);
    }

    // Handle Signup Logic
    private function saveSignup()
    {
        $session = session();
        $data = [
            'name' => $this->request->getPost('name'),
            'email' => $this->request->getPost('email'),
            'password' => password_hash($this->request->getPost('password'), PASSWORD_BCRYPT),
        ];

        $adminModel = new AdminModel();

        if ($adminModel->insert($data)) {
            $session->setFlashdata('success', 'Admin registered successfully. Please log in.');
            return redirect()->to('/admin/login');
        } else {
            $session->setFlashdata('error', 'Failed to register admin. Please try again.');
            return redirect()->back()->withInput();
        }
    }

    // Admin Login View
    public function login()
    {
        return view('admin/login');
    }

    // Handle Login Logic
    public function authenticate()
{
    $session = session();
    $request = $this->request;

    $email = $request->getPost('email');
    $password = $request->getPost('password');

    $adminModel = new AdminModel();
    $admin = $adminModel->where('email', $email)->first();

    if ($admin) {
        // Verify the password
        if (password_verify($password, $admin['password'])) {
            // Set session data for the logged-in admin
            $session->set([
                'admin_id'    => $admin['id'],
                'admin_name'  => $admin['name'],
                'admin_email' => $admin['email'],
                'logged_in'   => true,
            ]);
            // Redirect to the dashboard
            return redirect()->to('/admin/dashboard');
        } else {
            // Invalid password
            $session->setFlashdata('error', 'Invalid password.');
            return redirect()->back();
        }
    } else {
        // Email not found
        $session->setFlashdata('error', 'Email not found.');
        return redirect()->back();
    }
}


    // Admin Profile View
    public function profile()
    {
        $session = session();

        // Check if admin is logged in before accessing profile
        if (!$session->has('logged_in')) 
        {
        $adminData = [
            'id' => $session->get('admin_id'),
            'name' => $session->get('admin_name'),
            'email' => $session->get('admin_email'),
        ];

        return view('admin/profile', ['admin' => $adminData]);
    }}

    // Logout Admin
    public function logout()
    {
        $session = session();
        $session->destroy(); // Destroy all session data
        $session->setFlashdata('success', 'Logged out successfully.');
        return redirect()->to('/admin/login');
    }
}