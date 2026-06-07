<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->get('/', 'Home::index'); // Define the root route

//  $routes->get('/admin', 'Auth::Signup'); // Define the root route

$routes->group('auth', ['namespace' => 'App\Controllers'], function($routes) {
    $routes->post('Signup', 'AuthController::Signup');
    $routes->post('login', 'AuthController::login');
});

$routes->group('api/profile', function($routes) {
    // Route to get user profile 
    $routes->get('getProfile', 'ProfileController::getProfile');

    // Route to update user profile
    $routes->put('update', 'ProfileController::updateProfile');
});

$routes->get('location/(:num)', 'LocationController::index');

// Route for updating the user's location
$routes->put('location/update', 'LocationController::update');

$routes->get('/admin/users', 'AdminController::users');
$routes->post('/admin/update', 'AdminController::update');
$routes->get('/admin/delete/(:num)', 'AdminController::delete/$1');


$routes->get('/admin/schedule', 'EventController::schedule');
$routes->get('/events/add-schedule', 'EventController::addScheduleForm');
$routes->post('/events/add-schedule', 'EventController::saveSchedule');
$routes->get('/events/delete-schedule/(:num)', 'EventController::deleteSchedule/$1');

$routes->get('/admin/palkhi', 'EventController::palkhi');                 // List Palkhis
$routes->get('events/add-palkhi', 'EventController::addPalkhiForm'); // Show Add Palkhi Form
$routes->post('events/add-palkhi', 'EventController::savePalkhi');   // Save Palkhi
$routes->get('events/delete-palkhi/(:num)', 'EventController::deletePalkhi/$1'); // Delete Palkhi

$routes->get('admin/signup', 'AdminAuthController::signup'); // Display signup form
$routes->post('admin/saveSignup', 'AdminAuthController::saveSignup'); // Handle signup logic

$routes->get('admin/login', 'AdminAuthController::login');
// Display login form
$routes->post('admin/authenticate', 'AdminAuthController::authenticate'); // Handle login logic

$routes->get('admin/logout', 'AdminAuthController::logout'); // Logout admin

$routes->get('admin/dashboard', to: 'DashboardController::index');


// Volunteer Management Routes
// $routes->get('/admin/volunteers', 'VolunteerController::index');
// $routes->post('/admin/volunteers/add', 'VolunteerController::addVolunteer');
// $routes->post('/volunteer/register', 'VolunteerController::registerVolunteer');
// $routes->post('/admin/volunteers/assign/(:num)', 'VolunteerController::assignTask/$1');
// $routes->delete('/admin/volunteers/delete/(:num)', 'VolunteerController::deleteVolunteer/$1');

$routes->get('/volunteers', 'VolunteerController::index');
$routes->get('/volunteers/add', 'VolunteerController::addVolunteerForm');
$routes->post('/volunteers/add', 'VolunteerController::saveVolunteer');
$routes->post('/volunteer/assign-task/(:num)', 'VolunteerController::assignTask/$1');
$routes->get('/volunteer/assign-task/(:num)', 'VolunteerController::assignTask/$1');
$routes->get('/volunteers/delete/(:num)', 'VolunteerController::deleteVolunteer/$1');
$routes->get('/volunteers/edit/(:num)', 'VolunteerController::editVolunteerForm/$1');
$routes->post('/volunteers/edit/(:num)', 'VolunteerController::updateVolunteer/$1');

$routes->get('/admin/media', 'MediaController::viewMediaManagement');
$routes->post('media/addMedia', 'MediaController::addMedia');
$routes->delete('media/delete/(:num)', 'MediaController::deleteMedia/$1');
$routes->get('media/list', 'MediaController::getAllMedia');
$routes->post('registerVolunteer', 'UserVolunteerController::registerVolunteer');

$routes->get('admin/settings', 'SettingsController::index');
$routes->post('/settings/update', 'SettingsController::update');

$routes->post('admin/login', to: 'DashboardController::index');

$routes->get('/admin/profile', 'AdminAuthController::profile');

$routes->group('admin', ['filter' => 'auth'], function ($routes) {
    $routes->get('dashboard', 'AdminDashboardController::index');
    $routes->get('profile', 'AdminAuthController::profile');
    $routes->get('settings', 'AdminSettingsController::index');
});


// Admin Authentication Routes
$routes->get('/admin/login', 'AdminAuthController::login'); // Login page
$routes->post('/admin/authenticate', 'AdminAuthController::authenticate'); // Login form submission
$routes->get('/admin/logout', 'AdminAuthController::logout'); // Logout functionality

// Admin Signup Routes
$routes->get('/admin/signup', 'AdminAuthController::signup'); // Signup page
$routes->post('/admin/saveSignup', 'AdminAuthController::saveSignup'); // Signup form submission

// Admin Dashboard
$routes->get('/admin/dashboard', 'AdminDashboardController::index'); // Admin dashboard

// Admin Profile
$routes->get('/admin/profile', 'AdminAuthController::profile'); // Profile page for logged-in admin

// Admin Settings
$routes->get('/admin/settings', 'AdminSettingsController::index'); // Settings page
$routes->post('/admin/settings/update', 'AdminSettingsController::update'); // Save settings changes

// Additional Routes
$routes->get('/admin/users', 'AdminUserController::index'); // Manage users
$routes->get('/admin/volunteers', 'AdminVolunteerController::index'); // Manage volunteers
$routes->get('/admin/schedule', 'AdminScheduleController::index'); // Manage schedule
$routes->get('/admin/media', 'AdminMediaController::index'); // Manage media
$routes->get('/admin/palkhi', 'AdminPalkhiController::index'); // Palkhi info

$routes->get('/status', 'PalkhiStatusController::index');
$routes->post('/fetch-status', 'PalkhiStatusController::fetchStatus');


$routes->group('instructions', function ($routes) {
    $routes->get('/', 'InstructionController::index');     // Get all
    $routes->post('/', 'InstructionController::create');   // Add new
    $routes->get('(:num)', 'InstructionController::show/$1'); // Get single
    $routes->put('(:num)', 'InstructionController::update/$1'); // Update
    $routes->delete('(:num)', 'InstructionController::delete/$1'); // Delete
    
});

$routes->get('instructions-view', 'InstructionPageController::index1');


$routes->get('contact', 'ContactController::index');
$routes->post('contact/submit', 'ContactController::submit');
$routes->get('contact/list', 'ContactController::list');

$routes->get('/login', 'Auth::login');
$routes->post('/auth/processLogin', 'Auth::processLogin');
$routes->get('/logout', 'Auth::logout');


    $routes->get('yatra/stops', 'YatraProgress::listStops');

