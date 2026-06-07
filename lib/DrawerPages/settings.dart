import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Settings Page',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const SettingsPage(), // SettingsPage as the home page
  ));
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),

          // Theme Settings
          ListTile(
            leading: const Icon(Icons.palette),
            title: const Text('App Theme'),
            subtitle: const Text('Light or Dark Mode'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Choose Theme'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RadioListTile(
                          value: 'Light',
                          groupValue: 'theme',
                          onChanged: (value) {
                            // Handle light theme logic here
                            Navigator.pop(context);
                          },
                          title: const Text('Light Theme'),
                        ),
                        RadioListTile(
                          value: 'Dark',
                          groupValue: 'theme',
                          onChanged: (value) {
                            // Handle dark theme logic here
                            Navigator.pop(context);
                          },
                          title: const Text('Dark Theme'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          const Divider(),

          // Location Permission
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Location Permission'),
            subtitle: const Text('Enable GPS for Dindi tracking'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AlertDialog(
                    title: Text('Permission Required'),
                    content: Text('Please enable location services for accurate tracking.'),
                  );
                },
              );
            },
          ),
          const Divider(),

          // Notification Permission
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notification Permission'),
            subtitle: const Text('Receive updates about Dindi'),
            onTap: () {
              // Placeholder for notification permission logic
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AlertDialog(
                    title: Text('Notification Settings'),
                    content: Text('Enable or disable notifications for Dindi updates.'),
                  );
                },
              );
            },
          ),
          const Divider(),

          // Language Settings
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            subtitle: const Text('Switch between Marathi and English'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Choose Language'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RadioListTile(
                          value: 'Marathi',
                          groupValue: 'language',
                          onChanged: (value) {
                            // Handle Marathi language selection
                            Navigator.pop(context);
                          },
                          title: const Text('Marathi'),
                        ),
                        RadioListTile(
                          value: 'English',
                          groupValue: 'language',
                          onChanged: (value) {
                            // Handle English language selection
                            Navigator.pop(context);
                          },
                          title: const Text('English'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          const Divider(),

          // Logout
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            subtitle: const Text('Sign out from your account'),
            onTap: () {
              // Clear user session and navigate to the login screen
              // Add your logout logic here
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
          const Divider(),

          // Delete Account
          ListTile(
            leading: const Icon(Icons.delete_forever),
            title: const Text('Delete Account'),
            subtitle: const Text('Permanently delete your account'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirm Delete'),
                    content: const Text('Are you sure you want to delete your account?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Add account deletion logic here
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
