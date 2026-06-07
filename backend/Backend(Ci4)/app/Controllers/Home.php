<?php

namespace App\Controllers;

class Home extends BaseController
{
    public function index()
    {
        $data['title'] = 'Welcome to CodeIgniter';
        return view('welcome_message', $data);
    }
}
