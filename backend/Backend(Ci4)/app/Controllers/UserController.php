<?php

namespace App\Controllers;

use App\Models\AdminModel;
use CodeIgniter\Controller;

class UserController extends Controller
{

    // In your controller (e.g., UserController.php)

public function profile()
{
    // Fetch user data from session
    $userData = session()->get('user');
    
    // Pass user data to the profile view
    return view('profile', ['user' => $userData]);
}

}