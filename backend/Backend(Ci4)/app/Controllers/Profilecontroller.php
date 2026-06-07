<?php 

namespace App\Controllers;

use CodeIgniter\RESTful\ResourceController;
use App\Models\UserModel; // Import your user model

class ProfileController extends ResourceController
{
    protected $userModel;

    public function __construct()
    {
        // Initialize the UserModel
        $this->userModel = new UserModel(); // Ensure your model is properly set
    }

    public function getProfile()
    {
        // Assume you are retrieving user data from session
        $userData = session()->get('userData'); // Adjust this line according to how you store user data
    
        // Debugging: Log the contents of userData
        log_message('info', 'User Data: ' . print_r($userData, true)); // Logs user data for troubleshooting
    
        // Check if userData is available and contains 'role'
        if (!$userData || !isset($userData['role'])) {
            return $this->fail('User data is not available or role is undefined.');
        }
    
        // Now you can safely access the role
        $role = $userData['role'];
    
        // Example of using the role
        if ($this->isAdmin($role)) {
            // Handle admin logic
        } else {
            // Handle non-admin logic
        }
    
        return $this->respond(['role' => $role, 'userData' => $userData]);
    }
    
    public function updateProfile() 
    {
        $userId = $this->request->getGet('user_id');
        $loggedInUserId = $this->getLoggedInUserId(); // Retrieve the logged-in user's ID

        // Check if the logged-in user is authorized to update the profile
        if ($userId != $loggedInUserId && !$this->isAdmin($loggedInUserId)) {
            return $this->respond([
                'status' => 'error',
                'message' => 'Unauthorized access'
            ], 403);
        }

        // Collect data for update
        $updatedData = [
            'full_name' => $this->request->getPost('full_name'),
            'mobile' => $this->request->getPost('mobile'),
            'email' => $this->request->getPost('email'),
            'address' => $this->request->getPost('address'),
            'pincode' => $this->request->getPost('pincode'),
        ];

        // Use the model to update the user data
        if ($this->userModel->update($userId, $updatedData)) {
            return $this->respond([
                'status' => 'success',
                'message' => 'Profile updated successfully'
            ], 200);
        } else {
            return $this->respond([
                'status' => 'error',
                'message' => 'Failed to update profile'
            ], 400);
        }
    }

    // Check if the user is an admin
    private function isAdmin($role) 
    {
        return $role === 'admin'; // Check if the provided role matches 'admin'
    }

    // Method to retrieve the logged-in user's ID
    private function getLoggedInUserId() 
    {
        return session()->get('user_id'); // Adjust this if you're using a different mechanism to store the user ID
    }
}
