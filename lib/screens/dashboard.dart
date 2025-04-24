import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;
  final User? user = FirebaseAuth.instance.currentUser;

  final List<Widget> _pages = [
    HomeTab(),
    EventsTab(),
    NetworkTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alumni Connect'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(user?.displayName ?? 'Alumni User'),
              accountEmail: Text(user?.email ?? 'user@alumni.edu'),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade800, Colors.blue.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                setState(() => _currentIndex = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.event),
              title: const Text('Events'),
              onTap: () {
                setState(() => _currentIndex = 1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Network'),
              onTap: () {
                setState(() => _currentIndex = 2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                setState(() => _currentIndex = 3);
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue.shade800,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Network',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome back!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Stay connected with your alumni community',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          _buildStatsRow(),
          const SizedBox(height: 25),
          const Text(
            'Upcoming Events',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildEventCard(
            'Annual Alumni Meet',
            'June 15, 2023',
            'College Campus',
            Colors.blue.shade100,
          ),
          _buildEventCard(
            'Career Workshop',
            'July 5, 2023',
            'Online',
            Colors.green.shade100,
          ),
          const SizedBox(height: 25),
          const Text(
            'Recent Alumni',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildAlumniGrid(),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatCard('125', 'Connections', Icons.people),
        _buildStatCard('8', 'Events', Icons.event),
        _buildStatCard('24', 'Messages', Icons.message),
        _buildStatCard('5', 'Jobs', Icons.work),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Expanded(
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Icon(icon, size: 30, color: Colors.blue.shade800),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard(String title, String date, String location, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.event, color: Colors.blue.shade800, size: 30),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 14, color: Colors.grey.shade700),
                      const SizedBox(width: 5),
                      Text(date, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 14, color: Colors.grey.shade700),
                      const SizedBox(width: 5),
                      Text(location, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.blue.shade800),
          ],
        ),
      ),
    );
  }

  Widget _buildAlumniGrid() {
    List<String> names = ['Alex Johnson', 'Sarah Miller', 'David Wilson', 'Emma Davis', 'Michael Brown', 'Lisa Taylor'];
    List<String> roles = ['Software Engineer', 'Marketing Director', 'Product Manager', 'UX Designer', 'Data Scientist', 'Financial Analyst'];
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue.shade100,
                  child: Text(
                    names[index].substring(0, 1),
                    style: TextStyle(fontSize: 24, color: Colors.blue.shade800),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  names[index],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                Text(
                  roles[index],
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                
              ],
            ),
          ),
        );
      },
    );
  }
}

class EventsTab extends StatelessWidget {
  const EventsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Events Tab Content'));
  }
}

class NetworkTab extends StatelessWidget {
  const NetworkTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Network Tab Content'));
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue.shade100,
                    child: Icon(Icons.person, size: 50, color: Colors.blue.shade800),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    user?.displayName ?? 'Alumni User',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    user?.email ?? 'user@alumni.edu',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 15),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text('125', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Connections', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('24', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Events', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('2015', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Batch', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildProfileSection('About', 'Computer Science graduate with specialization in AI. Currently working as a Senior Software Engineer at TechCorp.'),
          _buildProfileSection('Education', 'B.Tech in Computer Science\nUniversity of Alumni\n2011-2015'),
          _buildProfileSection('Work Experience', 'Senior Software Engineer\nTechCorp (2019-Present)\n\nSoftware Developer\nInnovate Solutions (2015-2019)'),
          _buildProfileSection('Skills', 'Python, Dart/Flutter, Machine Learning, Cloud Computing'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text('Edit Profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          content,
          style: TextStyle(color: Colors.grey.shade700),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}