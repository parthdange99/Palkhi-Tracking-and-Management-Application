<?php

namespace App\Controllers;

use CodeIgniter\Controller;
use CodeIgniter\HTTP\CLIRequest;
use CodeIgniter\HTTP\IncomingRequest;
use CodeIgniter\HTTP\RequestInterface;
use CodeIgniter\HTTP\ResponseInterface;
use Psr\Log\LoggerInterface;

/**
 * Class BaseController
 *
 * BaseController provides a convenient place for loading components
 * and performing functions that are needed by all your controllers.
 */
abstract class BaseController extends Controller
{
    /**
     * Instance of the main Request object.
     *
     * @var CLIRequest|IncomingRequest
     */
    protected $request;

    /**
     * An array of helpers to be loaded automatically upon
     * class instantiation. These helpers will be available
     * to all other controllers that extend BaseController.
     *
     * @var list<string>
     */
    protected $helpers = [];

    /**
     * Data shared across all views.
     *
     * @var array
     */
    protected $data = [];

    /**
     * Initialize the controller.
     *
     * @param RequestInterface $request
     * @param ResponseInterface $response
     * @param LoggerInterface $logger
     * @return void
     */
    public function initController(RequestInterface $request, ResponseInterface $response, LoggerInterface $logger)
    {
        // Do Not Edit This Line
        parent::initController($request, $response, $logger);

        // Load any helpers required
        helper('url');

        // Set default user data (Example: replace with real user session data)
        $this->data['user'] = [
            'name' => 'Admin User',  // Replace with session data
            'email' => 'admin@example.com',  // Replace with session data
            'avatar' => base_url('assets/images/avatar.png'), // Replace with session data
        ];

        // Default active section
        $this->data['active_section'] = '';
    }

    /**
     * Renders a view with the main layout.
     *
     * @param string $view The view file to render.
     * @param array $data Data to pass to the view.
     * @return void
     */
    protected function render($view, $data = [])
    {
        // Merge passed data with base data
        $data = array_merge($this->data, $data);

        // Load the main layout and inject the specific view content
        echo view('main', array_merge($data, [
            'content' => view($view, $data), // Inject the specific page content
        ]));
    }
}