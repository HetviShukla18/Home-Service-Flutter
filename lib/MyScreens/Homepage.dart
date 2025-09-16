import 'package:mad_mini_project/MyScreens/BookingDetails.dart';
import 'package:flutter/material.dart';
import 'package:mad_mini_project/MyScreens/LandingPage.dart';
import 'package:mad_mini_project/MyScreens/ServicePage.dart';
import 'package:mad_mini_project/MyScreens/MechanicalWork.dart';
import 'package:mad_mini_project/MyScreens/OtherService.dart';

class NextPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Enhanced color palette
    final Color primaryColor = Color(0xFF2C3E50);
    final Color accentColor = Color(0xFF3498DB);
    final Color successColor = Color(0xFF2ECC71);
    final Color warningColor = Color(0xFFE74C3C);
    final Color backgroundColor = Color(0xFFF8F9FA);
    final Color cardColor = Colors.white;
    final Color textPrimary = Color(0xFF2C3E50);
    final Color textSecondary = Color(0xFF7F8C8D);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.build_circle, color: Colors.white, size: 24),
            ),
            SizedBox(width: 12),
            Text(
              'HomeService',
              style: TextStyle(
                color: textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 24,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        iconTheme: IconThemeData(color: textPrimary),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: textSecondary),
            onPressed: () {},
          ),
          SizedBox(width: 8),
        ],
      ),
      drawer: _buildEnhancedDrawer(
        context,
        primaryColor,
        accentColor,
        successColor,
        textPrimary,
        textSecondary,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [accentColor, Color(0xFF5DADE2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: accentColor.withOpacity(0.3),
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back, Hetvi! 👋',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Find the perfect service for your needs',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            // Stats Cards
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.account_balance_wallet,
                      title: 'Wallet Balance',
                      value: '₹100',
                      color: successColor,
                      backgroundColor: successColor.withOpacity(0.1),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.stars,
                      title: 'Reward Points',
                      value: '0 Coins',
                      color: warningColor,
                      backgroundColor: warningColor.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32),

            // Services Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Our Services',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Service Cards
            _buildServiceCard(
              context: context,
              icon: Icons.home_work,
              title: 'Home Services',
              subtitle: 'Professional home maintenance & repair',
              color: accentColor,
              buttons: [
                _ServiceButton(
                  text: 'Residential',
                  color: accentColor,
                  onPressed:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NextPage3()),
                      ),
                ),
                _ServiceButton(
                  text: 'Commercial',
                  color: accentColor,
                  onPressed:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NextPage3()),
                      ),
                ),
              ],
            ),

            _buildServiceCard(
              context: context,
              icon: Icons.car_repair,
              title: 'Automotive Services',
              subtitle: 'Expert car maintenance & repair',
              color: successColor,
              buttons: [
                _ServiceButton(
                  text: 'Car Services',
                  color: successColor,
                  onPressed:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NextPage13()),
                      ),
                ),
              ],
            ),

            _buildServiceCard(
              context: context,
              icon: Icons.miscellaneous_services,
              title: 'Other Services',
              subtitle: 'Additional professional services',
              color: warningColor,
              buttons: [
                _ServiceButton(
                  text: 'Explore More',
                  color: warningColor,
                  onPressed:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtherServices(),
                        ),
                      ),
                ),
              ],
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required Color backgroundColor,
  }) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: Color(0xFF7F8C8D)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required List<_ServiceButton> buttons,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: color, size: 32),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF7F8C8D),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children:
                  buttons.map((button) => _buildActionButton(button)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(_ServiceButton button) {
    return ElevatedButton(
      onPressed: button.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: button.color,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        button.text,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildEnhancedDrawer(
    BuildContext context,
    Color primaryColor,
    Color accentColor,
    Color successColor,
    Color textPrimary,
    Color textSecondary,
  ) {
    return Drawer(
      elevation: 16,
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [accentColor, Color(0xFF5DADE2)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: Text(
                        "HS",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: accentColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Hetvi Shukla",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "IV-C",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 8),
              children: [
                _buildDrawerItem(Icons.inbox, "Inbox", textPrimary, null),
                _buildDrawerItem(
                  Icons.book_online,
                  "My Bookings",
                  textPrimary,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingDetailsPage(),
                    ),
                  ),
                ),
                _buildDrawerItem(Icons.person, "Profile", textPrimary, null),
                _buildDrawerItem(Icons.settings, "Settings", textPrimary, null),
                _buildDrawerItem(
                  Icons.help,
                  "Help & Support",
                  textPrimary,
                  null,
                ),
                Divider(height: 32),
                _buildDrawerItem(
                  Icons.star_rate,
                  "Rate App",
                  textSecondary,
                  null,
                ),
                _buildDrawerItem(Icons.share, "Share App", textSecondary, null),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => LandingPage(title: 'Welcome Screen'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE74C3C),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    IconData icon,
    String title,
    Color textColor,
    VoidCallback? onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: textColor),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    );
  }
}

class _ServiceButton {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  _ServiceButton({
    required this.text,
    required this.color,
    required this.onPressed,
  });
}
