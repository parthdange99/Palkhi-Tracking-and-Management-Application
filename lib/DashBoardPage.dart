import 'package:flutter/material.dart';
import 'package:pragatiproject/DrawerPages/VolunteeringRegistrationPage.dart';
import 'package:pragatiproject/DrawerPages/home_page.dart';
import 'package:pragatiproject/DrawerPages/settings.dart';
import 'package:pragatiproject/NotificationPage.dart';
import 'package:pragatiproject/PhotoGallary.dart';
import 'package:pragatiproject/Provider/Userdata_provider.dart';
import 'package:pragatiproject/palkhiInformation.dart';
import 'package:provider/provider.dart';
import 'package:pragatiproject/DrawerPages/VolunteeringRegistrationPage.dart';
import 'package:pragatiproject/InbuiltChatBot.dart';
import 'notificationServices.dart';
import 'package:share_plus/share_plus.dart';
import 'HelplineServices.dart';
import 'DashBoardPage.dart';
import 'DrawerPages/DindiTimeTable.dart';
import 'package:pragatiproject/LiveStreamgOfPalkhi.dart';
import 'Pages/ProfilePage.dart';
import 'LatAndLongFetch.dart';
class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}
class _DashboardPageState extends State<DashboardPage> {
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.getDeviceToken().then((value) {
      print('Device Token: $value');
    });
    notificationServices.isTokenRefresh();
  }
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserdataProvider>(context).user;
    String fullName = user?.fullName ?? 'Guest'; // Fallback to 'Guest' if null
    String email = user?.email ?? 'No email available'; // Fallback to default message if null
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Provider.of<UserdataProvider>(context, listen: false).logout();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(

              decoration: const BoxDecoration(

                color: Colors.orangeAccent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fullName,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    email,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('Schedule/TimeTable'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DindiSchedulePage()),
                );
              },
            ),
            const Divider(color: Colors.grey, thickness: 1, indent: 20, endIndent: 20),
            ListTile(
              leading: const Icon(Icons.medical_services_outlined),
              title: const Text('NearBy Services'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/nearByServices');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Palkhi Information'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/palkhiInformation');
              },
            ),
            ListTile(
              leading: const Icon(Icons.volunteer_activism_sharp),
              title: const Text('Volunteering Registration'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VolunteeringRegistrationPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.money),
              title: const Text('Donation'),
              onTap: (
                  ) {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/donation');
              },
            ),
            const Divider(color: Colors.grey, thickness: 1, indent: 20, endIndent: 20),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share'),
              onTap: () {
                Share.share(
                  'Check out the "Where is my Dindi" app for real-time Palkhi tracking! Download it now: https://example.com',
                  subject: 'Where is my Dindi App',
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        child:

         Padding(
          padding: const EdgeInsets.all(16.0),

          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 13,
            mainAxisSpacing: 13,
            children: [

              _buildDashboardCard(
                context,
                icon: Icons.live_tv,
                title: 'Live Streaming',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>PalkhiListScreen())
                  );
                },
              ),
              _buildDashboardCard(
                context,
                icon: Icons.local_hospital,
                title: 'Medical Services',
                onTap: () {

                },
              ),
              _buildDashboardCard(
                context,
                icon: Icons.phone,
                title: 'Helpline Numbers',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HelplineCategoriesPage()),
                  );
                },
              ),

              _buildDashboardCard(
                context,
                icon: Icons.info,
                title: "Palkhi's Information",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DindiListPage()),
                  );
                },
              ),
              _buildDashboardCard(
                context,
                icon: Icons.photo,
                title: 'Gallery',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MediaPage()),
                  );
                },
              ),
              _buildDashboardCard(
                context,
                icon: Icons.video_camera_front,
                title: 'Live Video'+
                    ' Streaming',
                onTap: () {},
              ),],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
        ],
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0: // Home
              break;
            case 1: // Notifications
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InstructionsPage()),
              );

              break;
            case 2: // Chat
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FAQPage()),
              );
              break;
          }
        },
      ),
    );
  }

  Widget _buildDashboardCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required VoidCallback onTap,
      })
  {
    return GestureDetector(
      onTap: onTap,

      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 4,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48, color: Colors.orange),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
