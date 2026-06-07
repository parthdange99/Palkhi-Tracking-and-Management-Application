<?php

namespace App\Controllers;

use CodeIgniter\Exceptions\PageNotFoundException; // <-- Add this line

class Pages extends BaseController
{
    public function index()
    {
        
        return view('welcome_message');
    }

    public function view(string $page = 'home')
    {
        
        $path = APPPATH . 'Views/pages/' . $page . '.php';
        if (! is_file($path)) {
            // Log or debug the file path to ensure the correct one is being checked
            echo "Looking for file at: " . $path;
            throw new PageNotFoundException($page);
        }
    
        $data['title'] = ucfirst($page); // Capitalize first letter of the page title
    
        return view('templates/header', $data)
            . view('pages/' . $page)
            . view('templates/footer');
    }
    
}
