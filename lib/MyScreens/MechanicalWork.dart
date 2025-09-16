import 'package:flutter/material.dart';
import 'package:mad_mini_project/MyScreens/BookingPage.dart';

class NextPage13 extends StatelessWidget {
  const NextPage13({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> enginePrices = const [
    {'type': 'Engine Work', 'price': '\$1000', 'icon': Icons.engineering},
    {'type': 'Service', 'price': '\$1500', 'icon': Icons.car_repair},
    {'type': 'Body Work', 'price': '\$2000', 'icon': Icons.car_crash},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xfff3f7fc), Color(0xffe8f2ff)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderCard(),
              const SizedBox(height: 30),
              Expanded(
                child: Column(
                  children: [
                    ServiceCard(
                      title: enginePrices[0]['type'],
                      price: enginePrices[0]['price'],
                      icon: enginePrices[0]['icon'],
                      layout: CardLayout.horizontal,
                      onTap: () => _navigateToBooking(context),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ServiceCard(
                            title: enginePrices[1]['type'],
                            price: enginePrices[1]['price'],
                            icon: enginePrices[1]['icon'],
                            layout: CardLayout.vertical,
                            onTap: () => _navigateToBooking(context),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: ServiceCard(
                            title: enginePrices[2]['type'],
                            price: enginePrices[2]['price'],
                            icon: enginePrices[2]['icon'],
                            layout: CardLayout.vertical,
                            onTap: () => _navigateToBooking(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'Mechanical Work',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color(0xff1976d2),
      elevation: 4,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1976d2), Color(0xff1565c0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.white, Color(0xfff8fbff)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xff1976d2).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.build, color: Color(0xff1976d2), size: 28),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Mechanical!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1a1a1a),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Get the best car working staff in town",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff666666),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToBooking(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => NextPage4()));
  }
}

enum CardLayout { horizontal, vertical }

class ServiceCard extends StatelessWidget {
  final String title;
  final String price;
  final IconData icon;
  final CardLayout layout;
  final VoidCallback onTap;

  const ServiceCard({
    Key? key,
    required this.title,
    required this.price,
    required this.icon,
    required this.layout,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      splashColor: const Color(0xff1976d2).withOpacity(0.1),
      highlightColor: const Color(0xff1976d2).withOpacity(0.05),
      onTap: onTap,
      child: Container(
        height: layout == CardLayout.vertical ? 180 : null,
        decoration: _boxDecoration(),
        padding: const EdgeInsets.all(20),
        child:
            layout == CardLayout.horizontal
                ? _buildHorizontalContent()
                : _buildVerticalContent(),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      gradient: const LinearGradient(
        colors: [Colors.white, Color(0xfff8fbff)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: const Color(0xff1976d2).withOpacity(0.12),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
      border: Border.all(
        color: const Color(0xff1976d2).withOpacity(0.1),
        width: 1,
      ),
    );
  }

  Widget _iconBox(double size) {
    return Container(
      padding: EdgeInsets.all(size / 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xff1976d2).withOpacity(0.1),
            const Color(0xff1565c0).withOpacity(0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff1976d2).withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, size: size, color: const Color(0xff1976d2)),
    );
  }

  Widget _buildHorizontalContent() {
    return Row(
      children: [
        _iconBox(50),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1a1a1a),
                ),
              ),
              const SizedBox(height: 8),
              _priceTag('Starting from $price'),
            ],
          ),
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: const Color(0xff1976d2).withOpacity(0.6),
          size: 20,
        ),
      ],
    );
  }

  Widget _buildVerticalContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _iconBox(32),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xff1a1a1a),
          ),
        ),
        const SizedBox(height: 8),
        _priceTag('From $price'),
        const Spacer(),
        Align(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.arrow_forward_ios,
            color: const Color(0xff1976d2).withOpacity(0.6),
            size: 16,
          ),
        ),
      ],
    );
  }

  Widget _priceTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xff1976d2).withOpacity(0.1),
            const Color(0xff1565c0).withOpacity(0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xff1976d2),
        ),
      ),
    );
  }
}
