<?php

namespace App\Controllers;

use App\Models\UserModel;

class AdminController extends BaseController
{
    protected $userModel;

    public function __construct()
    {
        $this->userModel = new UserModel();
    }

    // Display user management page
    public function users()
    {
        $data['users'] = $this->userModel->findAll();
        return view('users', $data);
    }

    // Update user information
    public function update($id)
    {
        $user = $this->userModel->find($id);
        if (!$user) {
            return redirect()->to('/admin/users')->with('error', 'User not found');
        }

        if ($this->request->getMethod() === 'post') {
            $validationRules = [
                'name' => 'required|min_length[3]|max_length[255]',
                'email' => 'required|valid_email',
                // 'role' => 'required'
            ];

            if (!$this->validate($validationRules)) {
                return redirect()->back()->withInput()->with('errors', $this->validator->getErrors());
            }

            $this->userModel->update($id, [
                'name' => $this->request->getPost('name'),
                'email' => $this->request->getPost('email'),
                // 'role' => $this->request->getPost('role')
            ]);

            return redirect()->to('/admin/users')->with('success', 'User updated successfully');
        }

        return redirect()->to('/admin/users');
    }

    // Delete user
    public function delete($id)
    {
        $user = $this->userModel->find($id);
        if (!$user) {
            return redirect()->to('/admin/users')->with('error', 'User not found');
        }

        $this->userModel->delete($id);

        return redirect()->to('/admin/users')->with('success', 'User deleted successfully');
    }
}
