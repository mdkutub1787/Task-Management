
import 'dart:async';
import 'package:flutter/material.dart';



class User extends StatefulWidget {
  const User({super.key});

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> with SingleTickerProviderStateMixin {
  int _carouselIndex = 0;
  late PageController _pageController;
  Timer? _timer;
  int _hoverIndex = -1;
  late AnimationController _animationController;

  static const List<String> _images = [
    'https://www.shutterstock.com/image-photo/family-house-car-protected-by-260nw-1502368643.jpg',
    'https://www.shutterstock.com/image-photo/insurer-protecting-family-house-car-260nw-1295560780.jpg',
    'https://png.pngtree.com/template/20220516/ourmid/pngtree-insurance-policy-banner-template-flat-design-illustration-editable-of-square-background-image_1571396.jpg',
  ];

  static const List<String> _texts = [
    'সবার চোখের সামনেই তাদের ভবিষ্যত থাকে',
    'এটাকে শুধু পরিকল্পনা অনুযায়ী সাজিয়ে নিতে হয়',
    'জীবনে অনেক কাজে আসতে পারে ',
  ];

  static const List<Color> _colors = [
    Colors.purple,
    Colors.green,
    Colors.lime,
  ];

  final List<Map<String, String>> myItems = [
    {
      "img": "https://cdn-icons-png.flaticon.com/128/1973/1973100.png",
      "title": "Fire Policy"
    },
    {
      "img": "https://cdn-icons-png.flaticon.com/128/1861/1861925.png",
      "title": "Fire Bill"
    },
    {
      "img": "https://cdn-icons-png.flaticon.com/128/3705/3705833.png",
      "title": "Fire Money\nReceipt"
    },
    {
      "img": "https://cdn-icons-png.flaticon.com/128/2485/2485104.png",
      "title": "Marine Policy"
    },
    {
      "img": "https://cdn-icons-png.flaticon.com/128/14173/14173808.png",
      "title": "Marine Bill"
    },
    {
      "img": "https://cdn-icons-png.flaticon.com/128/9721/9721335.png",
      "title": "Marine Money\nReceipt"
    },
    {
      "img": "https://cdn-icons-png.flaticon.com/128/12245/12245214.png",
      "title": "Fire Policy\nReports"
    },
    {
      "img": "https://cdn-icons-png.flaticon.com/128/9621/9621072.png",
      "title": "Fire Bill\nReports"
    },
    {
      "img": "https://cdn-icons-png.flaticon.com/128/1055/1055644.png",
      "title": "Fire Money\nReceipt Reports"
    },
    {
      "img": "https://cdn-icons-png.flaticon.com/128/438/438036.png",
      "title": "Marine Policy\nReports"
    },
    {
      "img": "https://cdn-icons-png.flaticon.com/128/2783/2783924.png",
      "title": "Marine Bill\nReports"
    },
    {
      "img": "https://cdn-icons-png.flaticon.com/128/3270/3270753.png",
      "title": "Marine Money\nReceipt Reports"
    },
  ];


  final List<String> cardRoutes = [
    '/viewfirepolicy',
    '/viewfirebill',
    '/viewfiremoneyreceipt',
    '/viewmarinepolicy',
    '/viewmarinebill',
    '/viewmarinemoneyreceipt',
    '/viewpolicyreport',
    '/viewfirereports',
    '/viewfiremoneyreceiptreports',
    '/viewmarinereport',
    '/viewmarinereports',
    '/viewmarinemoneyreceiptreports',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoPageChange();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0.95,
      upperBound: 1.05,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _startAutoPageChange() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _carouselIndex = (_carouselIndex + 1) % _images.length;
      });
      _pageController.animateToPage(
        _carouselIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      body: _buildBody(),

    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'ইসলামী ইন্স্যুরেন্স কোম্পানী বাংলাদেশ লিমিটেড',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
          ),
          Text('mdkutub150@gmail.com, +8801763001787',
              style: TextStyle(fontSize: 12 ,fontWeight: FontWeight.bold,color: Colors.white)),
        ],
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.blue, Colors.lightGreen, Colors.teal],
          ),
        ),
      ),
      leading: Builder(
        builder: (context) => IconButton(
          icon: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQntUidjT9ib73xOZ_LYOvhZg9bSvlU9hOGjaWbTALttUeqeEjJUWKJHbT4r1UqjFM3caQ&usqp=CAU',
            ),
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
    );

  }

  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.greenAccent, Colors.orangeAccent],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage('https://avatars.githubusercontent.com/u/158472932?v=4&size=64'),
                ),
                const SizedBox(height: 10),
                const Text('Welcome, Head Office!', style: TextStyle(color: Colors.white, fontSize: 20)),
                const Text('mdkutub150@example.com', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          _buildDrawerItem(context, Icons.person, 'Profile', '/profile'),
          _buildDrawerItem(context, Icons.contact_mail, 'Contact Us', '/contact'),
          _buildDrawerItem(context, Icons.business, 'Head Office', '/headOffice'),
          _buildDrawerItem(context, Icons.location_city, 'Local Office', '/localOffice'),
          const Divider(),
          _buildDrawerItem(context, Icons.login, 'Login', '/login'),
          _buildDrawerItem(context, Icons.logout, 'Logout', '/login'),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, IconData icon, String label, String route) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }

  Widget _buildBody() {
    return Container(
      color: Colors.green.withOpacity(0.1), // Background color
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align items to the start
            children: [
              _buildCarousel(),
              const SizedBox(height: 15),
              _buildGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: SizedBox(
        height: 160,
        child: PageView.builder(
          controller: _pageController,
          itemCount: _images.length,
          onPageChanged: (index) {
            setState(() {
              _carouselIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return Container(
              color: _colors[index],
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(_images[index], fit: BoxFit.cover),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: Text(
                      _texts[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        backgroundColor: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // Disable scrolling within GridView
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.2, // Adjust as needed for card size
      ),
      itemCount: myItems.length,
      itemBuilder: (context, index) {
        final item = myItems[index];
        return GestureDetector(
          onTap: () {
            if (index < cardRoutes.length) {
              Navigator.pushNamed(context, cardRoutes[index]);
            }
          },
          child: MouseRegion(
            onEnter: (_) => setState(() {
              _hoverIndex = index;
            }),
            onExit: (_) => setState(() {
              _hoverIndex = -1;
            }),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: Matrix4.identity()
                ..scale(_hoverIndex == index ? 1.1 : 1.0),
              decoration: BoxDecoration(
                boxShadow: [
                  if (_hoverIndex == index)
                    BoxShadow(
                      color: Colors.amber.withOpacity(0.4),
                      spreadRadius: 3,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  BoxShadow(
                    color: Colors.green.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        item["img"]!,
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item["title"]!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}





