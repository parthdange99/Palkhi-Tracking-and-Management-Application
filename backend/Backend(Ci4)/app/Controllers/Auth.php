<?php

namespace App\Controllers;
use App\Models\Tracker_UserModel;
use CodeIgniter\Controller;

class Auth extends Controller {
    public function login() {
        return view('login');  // Load the login form view
    }

    public function processLogin() {
        $session = session();
        $model = new Tracker_UserModel();
    
        // Detect if request is JSON
        $isJson = $this->request->getHeaderLine('Content-Type') === 'application/json';
    
        if ($isJson) {
            $json = $this->request->getJSON();
            $email = $json->email ?? '';
            $password = $json->password ?? '';
        } else {
            // Handle form data (HTML form)
            $email = $this->request->getPost('email');
            $password = $this->request->getPost('password');
        }
    
        $user = $model->where('email', $email)->first();
    
        // Directly set session without password verification
        if ($user) {
            $session->set([
                'user_id' => $user['id'],
                'user_name' => $user['name'],
                'user_email' => $user['email'],
                'logged_in' => true
            ]);
    
            return $this->response->setJSON(["message" => "Login successful"])->setStatusCode(200);
        } else {
            return $this->response->setJSON(["error" => "User not found"])->setStatusCode(404);
        }
    }
    

    public function logout() {
        session()->destroy();
        return redirect()->to('/login');
    }
}
