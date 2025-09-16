import 'package:flutter/material.dart';
import 'package:mad_mini_project/MyScreens/BookingPage.dart';

class OtherServices extends StatefulWidget {
  const OtherServices({Key? key}) : super(key: key);

  @override
  _NextPage3State createState() => _NextPage3State();
}

class _NextPage3State extends State<OtherServices> {
  final List<Map<String, String>> services = [
    {
      'name': 'Salon',
      'image':
          'https://www.shutterstock.com/shutterstock/photos/1765757552/display_1500/stock-vector-beautiful-redhead-girl-hairdresser-holds-hair-dye-and-brush-cute-woman-barber-in-protective-mask-1765757552.jpg',
    },
    {
      'name': 'Event Service',
      'image':
          'https://i.pinimg.com/736x/6a/f8/6d/6af86d89203f4c93efb8c2e372f42d4a.jpg',
    },
    {
      'name': 'Painter',
      'image':
          'https://www.shutterstock.com/shutterstock/photos/2417049341/display_1500/stock-vector-flat-design-of-painting-worker-construction-workers-painter-worker-vector-illustration-2417049341.jpg',
    },
    {
      'name': 'Cleaner',
      'image':
          'https://img.freepik.com/premium-vector/cleaning-service-worker-with-cleaning-tools-vector-illustration-cartoon-style_1142-64478.jpg',
    },
    {
      'name': 'Driver',
      'image':
          'https://thumbs.dreamstime.com/z/excited-oversized-smiling-taxi-driver-clipart-yellow-car-funny-transportation-service-385103930.jpg',
    },
    {
      'name': 'Tutor',
      'image':
          'https://thumbs.dreamstime.com/z/homework-help-club-isolated-cartoon-vector-illustration-older-student-explaining-helps-child-meetup-tutoring-study-together-268655683.jpg',
    },
    {
      'name': 'Technician',
      'image':
          'https://cdn.vectorstock.com/i/1000x1000/78/30/hvac-technician-cartoon-character-vector-50017830.webp',
    },
    {
      'name': 'Babysitter',
      'image':
          'https://cdn.vectorstock.com/i/1000v/07/03/woman-professional-nanny-walking-with-children-vector-55820703.avif',
    },
    {
      'name': 'Laundry',
      'image':
          'https://cdn.vectorstock.com/i/1000v/32/80/cheerful-laundry-mascot-vector-24883280.avif',
    },
    {
      'name': 'Security Guard',
      'image':
          'https://cdn.vectorstock.com/i/1000v/18/56/police-mascot-cartoon-vector-56721856.avif',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Other Services',
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
                  children:
                      services
                          .map(
                            (service) => _buildGridItem(
                              service['name']!,
                              service['image']!,
                            ),
                          )
                          .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(String roleName, String imageUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NextPage4()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
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
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xff51a3e5).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.network(
                imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, size: 50, color: Color(0xff51a3e5));
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
          ],
        ),
      ),
    );
  }
}
