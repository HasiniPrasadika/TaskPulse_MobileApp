import 'package:TaskPulse/const/colors.dart';
import 'package:TaskPulse/data/auth_data.dart';
import 'package:TaskPulse/screen/education.dart';
import 'package:TaskPulse/screen/office.dart';
import 'package:TaskPulse/screen/personal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  final List _pages = [
    const PersonalPage(),
    const EducationPage(),
    const OfficePage(),
  ];

  int _selectedTab = 0;
  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height * 0.09),
          child: AppBar(
            title: Text(
              'TaskPulse',
              style: TextStyle(
                color: const Color.fromARGB(255, 26, 26, 26),
                fontWeight: FontWeight.bold,
                fontSize: width * 0.055,
              ),
            ),
            leading: Builder(
              builder: (context) => IconButton(
                icon: Padding(
                  padding: EdgeInsets.fromLTRB(width * 0.02, 0, 0, 0),
                  child: Icon(
                    Boxicons.bx_menu_alt_left,
                    color: const Color.fromARGB(255, 128, 128, 128),
                    size: width * 0.1,
                  ),
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
          ),
        ),
        drawer: _buildDrawer(context),
        body: _pages[_selectedTab],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.white,
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedTab,
            onTap: (index) => _changeTab(index),
            items: [
              BottomNavigationBarItem(
                icon: _buildIcon(FontAwesomeIcons.calendarCheck, 0),
                label: 'Personal',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon(FontAwesomeIcons.bookOpenReader, 1),
                label: 'Education',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon(FontAwesomeIcons.briefcase, 2),
                label: 'Office',
              ),
            ],
            unselectedItemColor: Colors.grey,
            selectedItemColor: custom_purple,
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(IconData iconData, int index) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
      ),
      padding: EdgeInsets.all(height * 0.0025),
      child: Icon(
        iconData,
        color: _selectedTab == index ? custom_purple : Colors.grey,
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: custom_purple,
            ),
            child: Text(
              'TaskPulse',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: width * 0.06,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              _showLogoutConfirmationDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Are you sure you want to exit the app?'),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: custom_purple,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Logout',
                style: TextStyle(
                  color: custom_purple,
                ),
              ),
              onPressed: () {
                AuthenticationRemote().logout();
                Navigator.of(context).pop();
                // Optionally, you can also exit the app
                // exit(0);
              },
            ),
          ],
        );
      },
    );
  }
}
