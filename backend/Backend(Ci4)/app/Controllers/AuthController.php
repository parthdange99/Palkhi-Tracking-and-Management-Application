<?php 

namespace App\Controllers;

use App\Models\UserModel;
use App\Models\LocationModel; // Import the LocationModel
use CodeIgniter\RESTful\ResourceController;

class AuthController extends ResourceController
{
    protected $format = 'json';

    // Register API
    public function Signup()
    {
        // Define validation rules
        $rules = [
            'name'       => 'required',
            'mobile'     => 'required|numeric|min_length[10]|max_length[15]',
            'email'      => 'required|valid_email|is_unique[users.email]',
            'gender'     => 'required',
            'address'    => 'required',
            'pincode'    => 'required|numeric|min_length[6]|max_length[6]',
            'password'   => 'required|min_length[8]|regex_match[/^(?=.*[A-Z])(?=.*\d).+$/]',
            // 'role'       => 'required|in_list[user,admin,volunteer]' // Ensuring role is one of the allowed types
        ];

        // Validate input
        if (!$this->validate($rules)) {
            return $this->fail($this->validator->getErrors());
        }

        $userModel = new UserModel();
        $locationModel = new LocationModel(); // Create an instance of LocationModel

        // Gather the input data
        $data = [
            'name'        => $this->request->getVar('name'),
            'mobile'      => $this->request->getVar('mobile'),
            'email'       => $this->request->getVar('email'),
            'gender'      => $this->request->getVar('gender'),
            'address'     => $this->request->getVar('address'),
            'pincode'     => $this->request->getVar('pincode'),
            'password'    => password_hash($this->request->getVar('password'), PASSWORD_BCRYPT),
            // 'role'        => $this->request->getVar('role') // Allow role to be passed in
        ];

        // Save user data
        $userModel->save($data);
        $userId = $userModel->insertID(); // Get the newly created user's ID

        // Insert initial location entry for the new user
        $locationModel->insert([
            'user_id' => $userId,
            'latitude' => null,  // Initialize with null or a default value
            'longitude' => null, // Initialize with null or a default value
            'place' => null      // Initialize with null or a default value
        ]);

        return $this->respondCreated(['message' => 'User registered successfully.']);
    }

    // Login API
    public function login()
    {
        // Define validation rules
        $rules = [
            'email'    => 'required',
            'password' => 'required',
        ];

        // Validate input
        if (!$this->validate($rules)) {
            return $this->fail($this->validator->getErrors());
        }

        $userModel = new UserModel();
        $user = $userModel->where('email', $this->request->getVar('email'))->first();

        // Verify password
        if (!$user || !password_verify($this->request->getVar('password'), $user['password'])) {
            return $this->fail('Invalid email or password.');
        }

        // Set session data upon successful login
        session()->set('user_id', $user['id']);
        // session()->set('role', $user['role']); // Store role in session

        // Check if there's an existing location entry for the user
        $locationModel = new LocationModel();
        $locationData = $locationModel->where('user_id', $user['id'])->first();

        if (!$locationData) {
            // If no location entry exists, create a new one
            $locationModel->insert([
                'user_id' => $user['id'],
                'latitude' => null,  // Initialize with null or a default value
                'longitude' => null, // Initialize with null or a default value
                'place' => null      // Initialize with null or a default value
            ]);
        }

        return $this->respond(['message' => 'Login successful.']);
    }
}
