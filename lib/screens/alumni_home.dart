import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AlumniHomePage extends StatefulWidget {
  const AlumniHomePage({super.key});

  @override
  _AlumniHomePageState createState() => _AlumniHomePageState();
}

class _AlumniHomePageState extends State<AlumniHomePage> {
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
          // Add Your Contributions section
          const Text(
            'Your Contributions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildYourContributions(),
          const SizedBox(height: 25),
          // Leaderboard moved before Events
          const Text(
            'Leaderboard',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildLeaderboard(),
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
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

  Widget _buildEventCard(
      String title, String date, String location, Color color) {
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
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.calendar_today,
                          size: 14, color: Colors.grey.shade700),
                      const SizedBox(width: 5),
                      Text(date, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          size: 14, color: Colors.grey.shade700),
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

  Widget _buildYourContributions() {
    Map<String, dynamic> yourContributions = {
      'events': 5,
      'posts': 12,
      'referrals': 3,
      'points': 750,
    };

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.blue.shade200),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  radius: 20,
                  child: Icon(Icons.star, color: Colors.blue.shade800),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${yourContributions['points']} Points",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    Text(
                      "Rising Star",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Details",
                    style: TextStyle(
                      color: Colors.blue.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _contributionStat(
                  Icons.event_note,
                  "Events Attended",
                  "${yourContributions['events']}",
                ),
                _contributionStat(
                  Icons.article,
                  "Posts Created",
                  "${yourContributions['posts']}",
                ),
                _contributionStat(
                  Icons.person_add,
                  "Referrals",
                  "${yourContributions['referrals']}",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _contributionStat(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue.shade800),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  Widget _buildAlumniGrid() {
    List<String> names = [
      'Alex Johnson',
      'Sarah Miller',
      'David Wilson',
      'Emma Davis',
      'Michael Brown',
      'Lisa Taylor'
    ];
    List<String> roles = [
      'Software Engineer',
      'Marketing Director',
      'Product Manager',
      'UX Designer',
      'Data Scientist',
      'Financial Analyst'
    ];

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

  Widget _buildLeaderboard() {
    List<Map<String, dynamic>> leaderboardData = [
      {
        'name': 'Alex Johnson',
        'score': 1500,
        'contributions': {'events': 12, 'posts': 45, 'referrals': 8},
        'growth': 15,
        'badge': 'Gold Contributor'
      },
      {
        'name': 'Sarah Miller',
        'score': 1200,
        'contributions': {'events': 10, 'posts': 32, 'referrals': 5},
        'growth': 8,
        'badge': 'Silver Contributor'
      },
      {
        'name': 'David Wilson',
        'score': 1000,
        'contributions': {'events': 8, 'posts': 28, 'referrals': 4},
        'growth': 12,
        'badge': 'Bronze Contributor'
      },
      {
        'name': 'Emma Davis',
        'score': 800,
        'contributions': {'events': 6, 'posts': 25, 'referrals': 2},
        'growth': 5,
        'badge': 'Active Member'
      },
      {
        'name': 'Michael Brown',
        'score': 600,
        'contributions': {'events': 5, 'posts': 18, 'referrals': 1},
        'growth': 3,
        'badge': 'Rising Star'
      },
    ];

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue.shade800, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Points earned by attending events, creating posts, and referrals',
                  style: TextStyle(fontSize: 11, color: Colors.blue.shade800),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 180, // Reduced height to fix overflow
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: leaderboardData.length,
            itemBuilder: (context, index) {
              final entry = leaderboardData[index];
              final rank = index + 1;
              final isTopThree = rank <= 3;
              final contributions =
                  entry['contributions'] as Map<String, dynamic>;

              // Define gradient colors based on rank
              List<Color> gradientColors;
              Color borderColor;

              if (rank == 1) {
                // Gold theme
                gradientColors = [Color(0xFFFFF9C4), Color(0xFFFFC107)];
                borderColor = Color(0xFFFFD700);
              } else if (rank == 2) {
                // Silver theme
                gradientColors = [Color(0xFFE0E0E0), Color(0xFFBDBDBD)];
                borderColor = Color(0xFFC0C0C0);
              } else if (rank == 3) {
                // Bronze theme
                gradientColors = [Color(0xFFD7CCC8), Color(0xFFBCAAA4)];
                borderColor = Color(0xFFCD7F32);
              } else {
                // Default blue theme
                gradientColors = [Colors.blue.shade50, Colors.blue.shade100];
                borderColor = Colors.blue.shade200;
              }

              return Container(
                width: 145, // Reduced width
                margin: const EdgeInsets.only(right: 10),
                child: Card(
                  elevation: isTopThree ? 5 : 3,
                  shadowColor: isTopThree
                      ? Colors.black.withOpacity(0.5)
                      : Colors.black.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                        color: borderColor, width: isTopThree ? 2 : 1),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: gradientColors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(10), // Reduced padding
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Rank badge
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (isTopThree)
                              Icon(
                                Icons.emoji_events,
                                color: rank == 1
                                    ? const Color(0xFFFFD700) // Gold
                                    : rank == 2
                                        ? const Color(0xFFC0C0C0) // Silver
                                        : const Color(0xFFCD7F32), // Bronze
                                size: 18, // Smaller icon
                              ),
                            const SizedBox(width: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 1),
                              decoration: BoxDecoration(
                                color: isTopThree
                                    ? Colors.white.withOpacity(0.7)
                                    : Colors.blue.shade800.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '#$rank',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12, // Smaller text
                                  color: isTopThree
                                      ? Colors.black.withOpacity(0.7)
                                      : Colors.blue.shade800,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        // Profile and name section
                        Row(
                          children: [
                            // Profile picture
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  radius: 18, // Smaller avatar
                                  backgroundColor: Colors.white,
                                  child: Text(
                                    entry['name'].substring(0, 1),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: isTopThree
                                          ? borderColor
                                          : Colors.blue.shade800,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                // Growth indicator
                                Container(
                                  padding: const EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 1),
                                  ),
                                  child: Text(
                                    '+${entry['growth']}%',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 6,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 6),
                            // Name and badge
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    entry['name'],
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: isTopThree
                                          ? Colors.black.withOpacity(0.8)
                                          : Colors.blue.shade900,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 1),
                                    decoration: BoxDecoration(
                                      color: isTopThree
                                          ? Colors.white.withOpacity(0.5)
                                          : Colors.blue.shade50,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          color: borderColor.withOpacity(0.5),
                                          width: 0.5),
                                    ),
                                    child: Text(
                                      entry['badge'],
                                      style: TextStyle(
                                        fontSize: 7,
                                        fontWeight: FontWeight.w500,
                                        color: isTopThree
                                            ? Colors.black.withOpacity(0.7)
                                            : Colors.blue.shade800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        // Points
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${entry['score']} Points',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: isTopThree
                                  ? borderColor
                                  : Colors.blue.shade800,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        // Contributions
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Contributions:',
                                  style: TextStyle(
                                    fontSize: 7,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      _contributionItem(
                                        Icons.event_note,
                                        '${contributions['events']}',
                                        'Events',
                                        isTopThree
                                            ? borderColor
                                            : Colors.blue.shade800,
                                      ),
                                      _contributionItem(
                                        Icons.article,
                                        '${contributions['posts']}',
                                        'Posts',
                                        isTopThree
                                            ? borderColor
                                            : Colors.blue.shade800,
                                      ),
                                      _contributionItem(
                                        Icons.person_add,
                                        '${contributions['referrals']}',
                                        'Refs',
                                        isTopThree
                                            ? borderColor
                                            : Colors.blue.shade800,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () {},
          child: Text(
            'View Full Leaderboard',
            style: TextStyle(
              color: Colors.blue.shade800,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _contributionItem(
      IconData icon, String count, String label, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Important to prevent overflow
      children: [
        Icon(icon, size: 10, color: color),
        const SizedBox(height: 2),
        Text(
          count,
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 6,
            color: Colors.grey.shade700,
          ),
        ),
      ],
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
                    child: Icon(Icons.person,
                        size: 50, color: Colors.blue.shade800),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    user?.displayName ?? 'Alumni User',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
                          Text('125',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Connections', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('24',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Events', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('2015',
                              style: TextStyle(fontWeight: FontWeight.bold)),
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
          _buildProfileSection('About',
              'Computer Science graduate with specialization in AI. Currently working as a Senior Software Engineer at TechCorp.'),
          _buildProfileSection('Education',
              'B.Tech in Computer Science\nUniversity of Alumni\n2011-2015'),
          _buildProfileSection('Work Experience',
              'Senior Software Engineer\nTechCorp (2019-Present)\n\nSoftware Developer\nInnovate Solutions (2015-2019)'),
          _buildProfileSection('Skills',
              'Python, Dart/Flutter, Machine Learning, Cloud Computing'),
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
