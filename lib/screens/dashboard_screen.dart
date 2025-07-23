import 'package:flutter/material.dart';
import 'bookings_screen.dart';
import 'courts_screen.dart';
import 'users_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  bool _sidebarExpanded = true;

  static const List<String> _titles = [
    'Dashboard',
    'Bookings',
    'Courts',
    'Users',
  ];
  static const List<IconData> _icons = [
    Icons.dashboard,
    Icons.calendar_today,
    Icons.sports_tennis,
    Icons.people,
  ];

  void _onSelect(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onCardTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getMainContent() {
    switch (_selectedIndex) {
      case 0:
        return _DashboardCards(onCardTap: _onCardTap);
      case 1:
        return const BookingsScreen();
      case 2:
        return const CourtsScreen();
      case 3:
        return const UsersScreen();
      default:
        return const Center(child: Text('Page not found'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: _sidebarExpanded ? 220 : 64,
            height: double.infinity,
            color: const Color(0xFF607D8B),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: _sidebarExpanded ? 24.0 : 8.0,
                  ),
                  child: _sidebarExpanded
                      ? const Text(
                          'Courtly Admin',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : const Icon(
                          Icons.admin_panel_settings,
                          color: Colors.white,
                          size: 32,
                        ),
                ),
                const SizedBox(height: 32),
                ...List.generate(_titles.length, (index) {
                  return ListTile(
                    leading: Icon(_icons[index], color: Colors.white),
                    title: _sidebarExpanded
                        ? Text(
                            _titles[index],
                            style: TextStyle(
                              color: _selectedIndex == index
                                  ? Colors.blue[200]
                                  : Colors.white,
                              fontWeight: _selectedIndex == index
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          )
                        : null,
                    selected: _selectedIndex == index,
                    selectedTileColor: Colors.white24,
                    onTap: () => _onSelect(index),
                    minLeadingWidth: 0,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: _sidebarExpanded ? 16 : 8,
                    ),
                  );
                }),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white),
                  tooltip: 'Logout',
                  onPressed: () {
                    // TODO: Implement logout
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 64,
                  width: double.infinity,
                  color: Colors.white,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          _sidebarExpanded ? Icons.menu_open : Icons.menu,
                        ),
                        tooltip: _sidebarExpanded
                            ? 'Hide sidebar'
                            : 'Show sidebar',
                        onPressed: () {
                          setState(() {
                            _sidebarExpanded = !_sidebarExpanded;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _titles[_selectedIndex],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Expanded(child: _getMainContent()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardCards extends StatelessWidget {
  final void Function(int index) onCardTap;
  const _DashboardCards({required this.onCardTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 600,
        child: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          mainAxisSpacing: 32,
          crossAxisSpacing: 32,
          children: [
            _DashboardCard(
              title: 'Bookings',
              icon: Icons.calendar_today,
              onTap: () => onCardTap(1),
            ),
            _DashboardCard(
              title: 'Courts',
              icon: Icons.sports_tennis,
              onTap: () => onCardTap(2),
            ),
            _DashboardCard(
              title: 'Users',
              icon: Icons.people,
              onTap: () => onCardTap(3),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _DashboardCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: Colors.blue),
              const SizedBox(height: 24),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
