import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OpenSourceHomePage extends StatelessWidget {
  const OpenSourceHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3A8A),
        title: Image.asset('assets/logo.png', height: 40), // Replace with your logo
        actions: [
          IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
          IconButton(icon: const Icon(Icons.notifications, color: Colors.white), onPressed: () {}),
          IconButton(icon: const Icon(Icons.person, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFFF9FAFB),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/profile.jpg'), // Replace with user image
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back, Sujit 👋',
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: const Color(0xFF111827)),
                        ),
                        Text(
                          'You earned the Curious Learner Badge! 🎉',
                          style: GoogleFonts.roboto(fontSize: 14, color: const Color(0xFF111827)),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF59E0B),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Text('View Profile', style: GoogleFonts.roboto(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Q&A Highlights
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Top Questions', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: const Color(0xFF111827))),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.question_answer, color: Color(0xFF10B981)),
                  title: Text('How to prepare for tech interviews?', style: GoogleFonts.roboto(fontSize: 16, color: const Color(0xFF111827))),
                  subtitle: Text('12 upvotes • 5 answers', style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey)),
                  onTap: () {},
                );
              },
            ),
            // Quick Action Cards
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Quick Actions', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: const Color(0xFF111827))),
            ),
            GridView.count(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildActionCard(context, 'Ask a Question', Icons.question_answer, () {}),
                _buildActionCard(context, 'Find Jobs', Icons.work, () {}),
                _buildActionCard(context, 'Join Events', Icons.event, () {}),
                _buildActionCard(context, 'Find Mentors', Icons.school, () {}),
              ],
            ),
            // Job Snippets
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Latest Jobs', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: const Color(0xFF111827))),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.work, color: Color(0xFF10B981)),
                  title: Text('Software Engineer Intern', style: GoogleFonts.roboto(fontSize: 16, color: const Color(0xFF111827))),
                  subtitle: Text('Google • Bangalore', style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey)),
                  onTap: () {},
                );
              },
            ),
            // Upcoming Events
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Upcoming Events', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: const Color(0xFF111827))),
            ),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildEventCard(context, 'Career Webinar', 'Jan 20, 2025', 'Online', '5 days left'),
                  _buildEventCard(context, 'AMA with Alumni', 'Feb 15, 2025', 'Mumbai', '30 days left'),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF10B981),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(leading: const Icon(Icons.question_answer), title: const Text('Ask a Question'), onTap: () {}),
                ListTile(leading: const Icon(Icons.forum), title: const Text('Start Discussion'), onTap: () {}),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: const Color(0xFF1E3A8A)),
            const SizedBox(height: 8),
            Text(title, style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xFF111827)), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, String title, String date, String location, String countdown) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xFF111827))),
            const SizedBox(height: 8),
            Text('$date | $location', style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(countdown, style: GoogleFonts.roboto(fontSize: 14, color: const Color(0xFFF59E0B))),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text('RSVP', style: GoogleFonts.roboto(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}