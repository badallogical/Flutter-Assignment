import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Profile(),
    );
  }
}

final List<String> postUrls = [
  'image/post1.jpg',
  'image/post2.jpg',
  'image/post3.jpg',
];

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 270,
                ),
                ClipPath(
                  clipper: CustomClipPath(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    color: Colors.blue,
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 20, // Adjust the position as needed
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      'Following',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 260,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        CircleAvatar(
                          radius: 80,
                          backgroundImage: AssetImage('image/photo.jpg'),
                        ),
                        Text(
                          'Badal',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text('Co-Founder',
                            style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Row(children: [
              SizedBox(width: 20),
              Highlight(imgPath: "image/cat1.jpg", name: "Sandy"),
              SizedBox(width: 20),
              Highlight(imgPath: "image/cat2.jpg", name: "Snowy"),
            ]),

            // Countes
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProfileCountItem(label: 'Posts', count: '12'),
                ProfileCountItem(label: 'Followers', count: '15K'),
                ProfileCountItem(label: 'Following', count: '16K'),
              ],
            ),

            // Tabs
            DefaultTabController(
              length: 3,
              initialIndex: 0,
              child: Column(
                children: [
                  const TabBar(
                    unselectedLabelColor: Colors.black,
                    labelColor: Colors.blue,
                    tabs: [
                      Tab(text: 'Posts'),
                      Tab(text: 'Stamp Book'),
                      Tab(text: 'Community'),
                    ],
                  ),
                  Container(
                    height: 300, // Adjust the height as needed
                    child: TabBarView(
                      children: [
                        // Posts Tab Content
                        Center(
                          child: ImageGrid(imageUrls: postUrls),
                        ),
                        // Stamp Book Tab Content
                        Center(
                          child: Text('Stamp Book Content'),
                        ),
                        // Community Tab Content
                        Center(
                          child: Text('Community Content'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileCountItem extends StatelessWidget {
  final String label;
  final String count;

  const ProfileCountItem({super.key, required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class Highlight extends StatelessWidget {
  final String imgPath;
  final String name;

  const Highlight({super.key, required this.imgPath, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(radius: 30, backgroundImage: AssetImage(imgPath)),
        Text(name,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ))
      ],
    );
  }
}

class ImageGrid extends StatelessWidget {
  final List<String> imageUrls;

  ImageGrid({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns in the grid
      ),
      itemCount: imageUrls.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            // Handle image tap (e.g., open full-screen view)
          },
          child: Card(
            elevation: 3, // Add elevation for a shadow effect
            child: Image.asset(
              imageUrls[index],
              fit: BoxFit.cover, // Adjust how the image is displayed
            ),
          ),
        );
      },
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();

    // define point for the path
    path.lineTo(0, 0);
    path.lineTo(0, h);
    path.quadraticBezierTo(w * 0.5, h - 100, w, h);
    path.lineTo(w, h);
    path.lineTo(w, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
