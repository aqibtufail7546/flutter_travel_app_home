import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gridview_practise/destination.dart';
import 'package:flutter_gridview_practise/destination_card.dart';
import 'package:flutter_gridview_practise/destination_detail_sheet.dart';

class TravelExploreApp extends StatefulWidget {
  const TravelExploreApp({Key? key}) : super(key: key);

  @override
  State<TravelExploreApp> createState() => _TravelExploreAppState();
}

class _TravelExploreAppState extends State<TravelExploreApp>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;
  int _currentCarouselIndex = 0;
  final ScrollController _scrollController = ScrollController();
  bool _showAppBarTitle = false;

  // Carousel images
  final List<Map<String, String>> carouselItems = [
    {
      'image':
          'https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dHJhdmVsJTIwbGFuZHNjYXBlfGVufDB8fDB8fHww',
      'title': 'Discover',
      'subtitle': 'Explore the world\'s most beautiful places'
    },
    {
      'image':
          'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fHRyYXZlbCUyMGxhbmRzY2FwZXxlbnwwfHwwfHx8MA%3D%3D',
      'title': 'Experience',
      'subtitle': 'Create unforgettable memories'
    },
    {
      'image':
          'https://images.unsplash.com/photo-1502680390469-be75c86b636f?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dHJhdmVsJTIwbW91bnRhaW58ZW58MHx8MHx8fDA%3D',
      'title': 'Adventure',
      'subtitle': 'Find your next thrilling journey'
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset > 140 && !_showAppBarTitle) {
      setState(() {
        _showAppBarTitle = true;
      });
    } else if (_scrollController.offset <= 140 && _showAppBarTitle) {
      setState(() {
        _showAppBarTitle = false;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: _showAppBarTitle
            ? Colors.white.withOpacity(0.95)
            : Colors.transparent,
        elevation: 0,
        title: AnimatedOpacity(
          opacity: _showAppBarTitle ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 250),
          child: const Text(
            'Wanderlust',
            style: TextStyle(
              color: Color(0xFF3D7FFF),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: _showAppBarTitle
                  ? Colors.grey.withOpacity(0.1)
                  : Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.notifications_outlined),
              color: _showAppBarTitle ? Colors.black : Colors.white,
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: ListView(
        controller: _scrollController,
        padding: EdgeInsets.zero,
        children: [
          // Carousel Header Section
          SizedBox(
            height: 300,
            child: Stack(
              children: [
                // Carousel Slider
                CarouselSlider(
                  options: CarouselOptions(
                    height: 300,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    autoPlay: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentCarouselIndex = index;
                      });
                    },
                  ),
                  items: carouselItems.map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Stack(
                          children: [
                            // Background image
                            SizedBox(
                              height: 300,
                              width: double.infinity,
                              child: Image.network(
                                item['image']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // Gradient overlay
                            Container(
                              height: 300,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }).toList(),
                ),

                // Content overlay (Title, subtitle and search)
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        carouselItems[_currentCarouselIndex]['title']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        carouselItems[_currentCarouselIndex]['subtitle']!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search destinations',
                                      hintStyle:
                                          TextStyle(color: Colors.white70),
                                    ),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Icon(
                                  Icons.tune,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Carousel indicator
                Positioned(
                  bottom: 120,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: carouselItems.asMap().entries.map((entry) {
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(
                            _currentCarouselIndex == entry.key ? 0.9 : 0.4,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          // Tab Bar Section
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: const Color(0xFF3D7FFF),
              unselectedLabelColor: Colors.grey,
              indicatorColor: const Color(0xFF3D7FFF),
              indicatorSize: TabBarIndicatorSize.label,
              tabs: const [
                Tab(text: 'Popular'),
                Tab(text: 'Recommended'),
                Tab(text: 'New Places'),
                Tab(text: 'Hidden Gems'),
              ],
            ),
          ),

          //const SizedBox(height: 10),

          // Destinations Grid Section - Now with more items
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemCount: 20, // Increased from 6 to 10
              itemBuilder: (context, index) {
                final destination = _getDestination(index);
                return DestinationCard(
                  destination: destination,
                  onTap: () {
                    _showDestinationDetail(context, destination);
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 20), // Added padding at the bottom
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            selectedItemColor: const Color(0xFF3D7FFF),
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.explore_outlined),
                activeIcon: Icon(Icons.explore),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map_outlined),
                activeIcon: Icon(Icons.map),
                label: 'Map',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                activeIcon: Icon(Icons.favorite),
                label: 'Saved',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF3D7FFF),
        child: const Icon(
          Icons.camera_alt,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _showDestinationDetail(BuildContext context, Destination destination) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DestinationDetailSheet(destination: destination),
    );
  }

  Destination _getDestination(int index) {
    final destinations = [
      Destination(
        name: 'Bali, Indonesia',
        location: 'South East Asia',
        rating: 4.8,
        image: 'https://images.unsplash.com/photo-1537996194471-e657df975ab4',
        price: 1200,
        description:
            'Tropical paradise with beautiful beaches, vibrant culture, and stunning landscapes.',
      ),
      Destination(
        name: 'Santorini, Greece',
        location: 'Mediterranean',
        rating: 4.9,
        image: 'https://images.unsplash.com/photo-1507501336603-6e31db2be093',
        price: 1800,
        description:
            'Famous for its white-washed buildings, blue domes, and breathtaking sunsets over the Aegean Sea.',
      ),
      Destination(
        name: 'Kyoto, Japan',
        location: 'East Asia',
        rating: 4.7,
        image: 'https://images.unsplash.com/photo-1545569341-9eb8b30979d9',
        price: 1500,
        description:
            'Ancient temples, traditional gardens, and authentic cultural experiences in Japan\'s former capital.',
      ),
      Destination(
        name: 'Swiss Alps',
        location: 'Central Europe',
        rating: 4.9,
        image: 'https://images.unsplash.com/photo-1491555103944-7c647fd857e6',
        price: 2200,
        description:
            'Majestic mountain peaks, picturesque villages, and world-class skiing and hiking opportunities.',
      ),
      Destination(
        name: 'Marrakech, Morocco',
        location: 'North Africa',
        rating: 4.6,
        image: 'https://images.unsplash.com/photo-1597211833712-5e41faa202ea',
        price: 950,
        description:
            'Vibrant markets, colorful architecture, and rich cultural heritage in this historic imperial city.',
      ),
      Destination(
        name: 'Machu Picchu, Peru',
        location: 'South America',
        rating: 4.9,
        image: 'https://images.unsplash.com/photo-1526392060635-9d6019884377',
        price: 1650,
        description:
            'Ancient Incan citadel set high in the Andes Mountains, surrounded by breathtaking natural beauty.',
      ),
      Destination(
        name: 'Tokyo, Japan',
        location: 'East Asia',
        rating: 4.8,
        image: 'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf',
        price: 1700,
        description:
            'Ultramodern metropolis with a perfect blend of traditional culture and cutting-edge technology.',
      ),
      Destination(
        name: 'Barcelona, Spain',
        location: 'Europe',
        rating: 4.7,
        image: 'https://images.unsplash.com/photo-1583422409516-2895a77efded',
        price: 1400,
        description:
            'Vibrant city famous for stunning architecture, Mediterranean beaches, and world-class cuisine.',
      ),
      Destination(
        name: 'Cape Town, South Africa',
        location: 'Africa',
        rating: 4.6,
        image: 'https://images.unsplash.com/photo-1580060839134-75a5edca2e99',
        price: 1200,
        description:
            'Breathtaking coastal city with iconic Table Mountain, diverse wildlife, and beautiful beaches.',
      ),
      Destination(
        name: 'Queenstown, New Zealand',
        location: 'Oceania',
        rating: 4.9,
        image:
            'https://plus.unsplash.com/premium_photo-1661882021629-2b0888d93c94?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        price: 1900,
        description:
            'Adventure capital nestled between dramatic mountains and pristine lakes, perfect for thrill-seekers.',
      ),
      Destination(
        name: 'Paris, France',
        location: 'Europe',
        rating: 4.8,
        image: 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34',
        price: 1600,
        description:
            'The City of Light famous for its iconic architecture, world-class museums, and romantic ambiance.',
      ),
      Destination(
        name: 'New York City, USA',
        location: 'North America',
        rating: 4.7,
        image: 'https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9',
        price: 2100,
        description:
            'The Big Apple offers world-famous landmarks, diverse neighborhoods, and endless entertainment options.',
      ),
      Destination(
        name: 'Great Barrier Reef',
        location: 'Australia',
        rating: 4.9,
        image: 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b',
        price: 2300,
        description:
            'World\'s largest coral reef system with incredible marine biodiversity and stunning underwater experiences.',
      ),
      Destination(
        name: 'Rome, Italy',
        location: 'Europe',
        rating: 4.7,
        image: 'https://images.unsplash.com/photo-1552832230-c0197dd311b5',
        price: 1500,
        description:
            'Eternal City with ancient ruins, magnificent Renaissance art, and delicious Italian cuisine.',
      ),
      Destination(
        name: 'Rio de Janeiro, Brazil',
        location: 'South America',
        rating: 4.5,
        image: 'https://images.unsplash.com/photo-1483729558449-99ef09a8c325',
        price: 1450,
        description:
            'Vibrant coastal city with iconic landmarks, samba culture, and beautiful beaches like Copacabana.',
      ),
      Destination(
        name: 'Dubai, UAE',
        location: 'Middle East',
        rating: 4.8,
        image: 'https://images.unsplash.com/photo-1512453979798-5ea266f8880c',
        price: 2200,
        description:
            'Futuristic metropolis with record-breaking skyscrapers, luxury shopping, and desert adventures.',
      ),
      Destination(
        name: 'Maldives',
        location: 'Indian Ocean',
        rating: 4.9,
        image: 'https://images.unsplash.com/photo-1573843981267-be1999ff37cd',
        price: 2800,
        description:
            'Paradise archipelago with overwater bungalows, crystal clear waters, and pristine white sand beaches.',
      ),
      Destination(
        name: 'Prague, Czech Republic',
        location: 'Europe',
        rating: 4.6,
        image: 'https://images.unsplash.com/photo-1592906209472-a36b1f3782ef',
        price: 1200,
        description:
            'Fairytale city with medieval architecture, cobblestone streets, and atmospheric Christmas markets.',
      ),
      Destination(
        name: 'Petra, Jordan',
        location: 'Middle East',
        rating: 4.8,
        image:
            'https://images.unsplash.com/photo-1615811648503-479d06197ff3?q=80&w=2076&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        price: 1400,
        description:
            'Ancient archaeological wonder with stunning rock-cut architecture dating back to around 300 B.C.',
      ),
      Destination(
        name: 'Banff National Park',
        location: 'Canada',
        rating: 4.9,
        image:
            'https://images.unsplash.com/photo-1561134643-668f9057cce4?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        price: 1700,
        description:
            'Breathtaking mountain scenery with emerald lakes, dense forests, and abundant wildlife.',
      ),
    ];
    return destinations[index % destinations.length];
  }
}
