import 'package:flutter/material.dart';
import '../dashboard/dashboard.dart'; // Import the DashboardScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of widgets for each bottom navigation tab
  final List<Widget> _widgetOptions = <Widget>[
    const DashboardPage(), // Use the DashboardPage widget here
    const PlaceholderWidget(title: 'Expenses'),
    const PlaceholderWidget(title: 'Team'),
    const PlaceholderWidget(title: 'Profile'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), // Use the custom AppBar here
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the content
        child: IndexedStack(
          index: _selectedIndex,
          children: _widgetOptions, // Display selected widget
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 0 ? Icons.dashboard : Icons.dashboard_outlined,
              color: _selectedIndex == 0 ? Colors.purple : Colors.grey, // Icon color change
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 1 ? Icons.money : Icons.money_outlined,
              color: _selectedIndex == 1 ? Colors.purple : Colors.grey,
            ),
            label: 'Expenses',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 2 ? Icons.group : Icons.group_outlined,
              color: _selectedIndex == 2 ? Colors.purple : Colors.grey,
            ),
            label: 'Team',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 3 ? Icons.account_circle : Icons.account_circle_outlined,
              color: _selectedIndex == 3 ? Colors.purple : Colors.grey,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple, // Color for selected item
        unselectedItemColor: Colors.grey, // Color for unselected items
        showUnselectedLabels: true, // Show unselected labels
        onTap: _onItemTapped,
      ),
    );
  }
}

// Custom AppBar widget with notification and menu dropdown
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.purple, // Purple app bar
      title: const Text('MoneyMaster', style: TextStyle(color: Colors.white)),
      actions: <Widget>[
        // Notification Icon Button
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.white),
          onPressed: () {
            // Add your notification action here
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('You clicked the Notification icon')),
            );
          },
        ),
        // Menu Icon Button (Hamburger menu)
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            // Show the dropdown menu when menu button is clicked
            showMenu(
              context: context,
              position: RelativeRect.fromLTRB(100.0, 50.0, 0.0, 0.0),
              items: [
                PopupMenuItem<String>( 
                  value: 'logout',
                  child: Row(
                    children: const [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 10),
                      Text('Logout'),
                    ],
                  ),
                ),
                PopupMenuItem<String>( 
                  value: 'other',
                  child: Row(
                    children: const [
                      Icon(Icons.settings),
                      SizedBox(width: 10),
                      Text('Settings'),
                    ],
                  ),
                ),
              ],
              elevation: 8.0,
            ).then((value) {
              if (value == 'logout') {
                // Handle logout action
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('You clicked Logout')),
                );
              } else if (value == 'other') {
                // Handle other action
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('You clicked Settings')),
                );
              }
            });
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// Placeholder Widget for all tabs (just for navigation)
class PlaceholderWidget extends StatelessWidget {
  final String title;
  const PlaceholderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$title Screen',
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
}
