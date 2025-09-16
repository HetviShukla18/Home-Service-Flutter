import 'package:flutter/material.dart';
import 'package:mad_mini_project/MyScreens/BookingPage.dart';

class NextPage3 extends StatefulWidget {
  const NextPage3({Key? key}) : super(key: key);

  @override
  _NextPage3State createState() => _NextPage3State();
}

class _NextPage3State extends State<NextPage3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Services',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xff51a3e5),
        elevation: 4,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xfff8fbff), Color(0xffe8f4fd)],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.home_repair_service,
                          color: Color(0xff51a3e5),
                          size: 28,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Welcome to Services!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff2c3e50),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Find professional indoor and outdoor services at your fingertips',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff7f8c8d),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.85,
                  children: [
                    _buildGridItem(
                      'Carpenter',
                      'assets/carpenter.png',
                      '\$50',
                      Icons.carpenter,
                    ),
                    _buildGridItem(
                      'Gutterman',
                      'assets/Gutterman1.png',
                      '\$60',
                      Icons.roofing,
                    ),
                    _buildGridItem(
                      'Plumber',
                      'assets/Plumber.png',
                      '\$70',
                      Icons.plumbing,
                    ),
                    _buildGridItem(
                      'Electrician',
                      'assets/electrician.png',
                      '\$80',
                      Icons.electrical_services,
                    ),
                    _buildGridItem(
                      'Gardener',
                      'assets/gardener.png',
                      '\$90',
                      Icons.grass,
                    ),
                    _buildGridItem(
                      'Chef',
                      'assets/cheif.png',
                      '\$100',
                      Icons.restaurant,
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

  Widget _buildGridItem(
    String roleName,
    String imagePath,
    String price,
    IconData icon,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NextPage4()),
        );
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Color(0xfff8fbff)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Color(0xff51a3e5).withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 0,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: Color(0xff51a3e5).withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            splashColor: Color(0xff51a3e5).withOpacity(0.1),
            highlightColor: Color(0xff51a3e5).withOpacity(0.05),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NextPage4()),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xff51a3e5).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      imagePath,
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(icon, size: 50, color: Color(0xff51a3e5));
                      },
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    roleName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff2c3e50),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color(0xff51a3e5).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'From $price',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff51a3e5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
