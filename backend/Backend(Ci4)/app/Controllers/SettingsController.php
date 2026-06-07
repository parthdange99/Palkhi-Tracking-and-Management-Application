<?php

namespace App\Controllers;

use App\Models\SettingsModel;

class SettingsController extends BaseController
{
    protected $settingsModel;

    public function __construct()
    {
        $this->settingsModel = new SettingsModel();
    }

    /**
     * Display the settings page.
     */
    public function index()
    {
        // Fetch settings from the database
        $data['settings'] = $this->settingsModel->getSettings();

        // Load the settings view with data
        return view('settings/index', $data);
    }

    /**
     * Update the settings.
     */
    public function update()
    {
        $postData = $this->request->getPost();

        // Validate the submitted settings data
        if (!$this->validate([
            'site_name' => 'required|string',
            'timezone' => 'required|string',
            'email_from' => 'required|valid_email',
        ])) {
            // Return with errors
            return redirect()->back()->with('errors', $this->validator->getErrors());
        }

        // Update the settings in the database
        $this->settingsModel->updateSettings($postData);

        // Set a success message and redirect
        session()->setFlashdata('success', 'Settings updated successfully!');
        return redirect()->to('/settings');
    }
}
