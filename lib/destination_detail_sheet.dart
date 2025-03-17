import 'package:flutter/material.dart';
import 'package:flutter_gridview_practise/destination.dart';

class DestinationDetailSheet extends StatelessWidget {
  final Destination destination;

  const DestinationDetailSheet({
    Key? key,
    required this.destination,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get gallery images for this destination
    final List<String> galleryImages =
        _getDestinationGalleryImages(destination.name);

    return DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 16),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(20),
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  destination.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.grey,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      destination.location,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF3D7FFF).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Color(0xFF3D7FFF),
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  destination.rating.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF3D7FFF),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          destination.image,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'About',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        destination.description,
                        style: const TextStyle(
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Photos',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: galleryImages.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 100,
                              height: 100,
                              margin: const EdgeInsets.only(right: 12),
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Image.network(
                                galleryImages[index],
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[200],
                                    child: const Icon(
                                      Icons.image_not_supported,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Price',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '\$${destination.price}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF3D7FFF),
                                ),
                              ),
                              const Text(
                                'per person',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3D7FFF),
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                'Book Now',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  // Helper method to get gallery images for a destination
  List<String> _getDestinationGalleryImages(String destinationName) {
    // Base name (remove country/region part)
    final baseName = destinationName.split(',')[0].trim().toLowerCase();

    // Map of destination names to their specific image galleries
    final Map<String, List<String>> destinationGalleries = {
      'bali': [
        'https://images.unsplash.com/photo-1558005530-a7958896ec60',
        'https://images.unsplash.com/photo-1573790387438-4da905039392',
        'https://images.unsplash.com/photo-1577717903315-1691ae25ab3f',
        'https://images.unsplash.com/photo-1520454974749-611b7248ffdb',
        'https://images.unsplash.com/photo-1558005530-a7958896ec60',
      ],
      'santorini': [
        'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8c2FudG9yaW5pfGVufDB8fDB8fHww',
        'https://images.unsplash.com/photo-1601581875309-fafbf2d3ed3a',
        'https://images.unsplash.com/photo-1613395877344-13d4a8e0d49e',
        'https://images.unsplash.com/photo-1555400038-63f5ba517a47',
        'https://images.unsplash.com/photo-1696519669474-3001c0e2b548?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8c2FudG9yaW5pfGVufDB8fDB8fHww',
      ],
      'kyoto': [
        'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e',
        'https://images.unsplash.com/photo-1493997181344-712f2f19d87a',
        'https://images.unsplash.com/photo-1528360983277-13d401cdc186',
        'https://images.unsplash.com/photo-1524413840807-0c3cb6fa808d',
        'https://images.unsplash.com/photo-1578469645742-46cae010e5d4?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8a3lvdG98ZW58MHx8MHx8fDA%3D',
      ],
      'swiss alps': [
        'https://images.unsplash.com/photo-1508964942454-1a56651d54ac',
        'https://images.unsplash.com/photo-1605540436563-5bca919ae766',
        'https://images.unsplash.com/photo-1502786129293-79981df4e689',
        'https://images.unsplash.com/photo-1605540436563-5bca919ae766',
        'https://images.unsplash.com/photo-1502786129293-79981df4e689',
      ],
      'marrakech': [
        'https://images.unsplash.com/photo-1618423205267-e95744f57edf?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8bWFycmFrZWNofGVufDB8fDB8fHww',
        'https://images.unsplash.com/photo-1553102674-af685bb5fe40',
        'https://images.unsplash.com/photo-1618423205267-e95744f57edf?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8bWFycmFrZWNofGVufDB8fDB8fHww',
        'https://images.unsplash.com/photo-1719084198651-5ac167cb3e6e?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fG1hcnJha2VjaHxlbnwwfHwwfHx8MA%3D%3D',
        'https://images.unsplash.com/photo-1569440703456-29b9c31765ca?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fG1hcnJha2VjaHxlbnwwfHwwfHx8MA%3D%3D',
      ],
      'machu picchu': [
        'https://images.unsplash.com/photo-1587595431973-160d0d94add1',
        'https://images.unsplash.com/photo-1526392060635-9d6019884377',
        'https://images.unsplash.com/photo-1693926891485-b1ae0002c040?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bWFjaHUlMjBwaWNjaHUnfGVufDB8fDB8fHww',
        'https://images.unsplash.com/photo-1587595431973-160d0d94add1',
        'https://images.unsplash.com/photo-1693926891485-b1ae0002c040?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bWFjaHUlMjBwaWNjaHUnfGVufDB8fDB8fHww',
      ],
      'tokyo': [
        'https://images.unsplash.com/photo-1503899036084-c55cdd92da26',
        'https://images.unsplash.com/photo-1536098561742-ca998e48cbcc',
        'https://images.unsplash.com/photo-1490806843957-31f4c9a91c65',
        'https://images.unsplash.com/photo-1542051841857-5f90071e7989',
        'https://images.unsplash.com/photo-1533050487297-09b450131914',
      ],
      'barcelona': [
        'https://images.unsplash.com/photo-1539037116277-4db20889f2d4',
        'https://images.unsplash.com/photo-1511527661048-7fe73d85e9a4',
        'https://images.unsplash.com/photo-1583422409516-2895a77efded',
        'https://images.unsplash.com/photo-1579282240050-352db0a14c21',
        'https://images.unsplash.com/photo-1562883676-8c7feb83f09b',
      ],
      'cape town': [
        'https://plus.unsplash.com/premium_photo-1697730061063-ad499e343f26?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Y2FwZSUyMHRvd258ZW58MHx8MHx8fDA%3D',
        'https://images.unsplash.com/photo-1576485290814-1c72aa4bbb8e?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y2FwZSUyMHRvd258ZW58MHx8MHx8fDA%3D',
        'https://images.unsplash.com/photo-1580060839134-75a5edca2e99',
        'https://plus.unsplash.com/premium_photo-1697730061063-ad499e343f26?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Y2FwZSUyMHRvd258ZW58MHx8MHx8fDA%3D',
        'https://images.unsplash.com/photo-1576485290814-1c72aa4bbb8e?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y2FwZSUyMHRvd258ZW58MHx8MHx8fDA%3D',
      ],
      'queenstown': [
        'https://images.unsplash.com/photo-1506146332389-18140dc7b2fb',
        'https://images.unsplash.com/photo-1593755673003-8ca8dbf906c2?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cXVlZW5zdG93bnxlbnwwfHwwfHx8MA%3D%3D',
        'https://images.unsplash.com/photo-1682452826083-f3756de524f8',
        'https://plus.unsplash.com/premium_photo-1661882021629-2b0888d93c94?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8cXVlZW5zdG93bnxlbnwwfHwwfHx8MA%3D%3D',
        'https://images.unsplash.com/photo-1565690482729-9290df702689?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fHF1ZWVuc3Rvd258ZW58MHx8MHx8fDA%3D',
      ],
      'paris': [
        'https://images.unsplash.com/photo-1511739001486-6bfe10ce785f',
        'https://images.unsplash.com/photo-1502602898657-3e91760cbb34',
        'https://images.unsplash.com/photo-1485081669829-bacb8c7bb1f3',
        'https://images.unsplash.com/photo-1597982087634-9884f03198ce',
        'https://images.unsplash.com/photo-1485081669829-bacb8c7bb1f3',
      ],
      'new york city': [
        'https://images.unsplash.com/photo-1522083165195-3424ed129620',
        'https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9',
        'https://images.unsplash.com/photo-1500916434205-0c77489c6cf7',
        'https://images.unsplash.com/photo-1485871981521-5b1fd3805eee',
        'https://images.unsplash.com/photo-1490644658840-3f2e3f8c5625',
      ],
      'great barrier reef': [
        'https://images.unsplash.com/photo-1620121692029-d088224ddc74',
        'https://images.unsplash.com/photo-1582967788606-a171c1080cb0',
        'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b',
        'https://images.unsplash.com/photo-1582967788606-a171c1080cb0',
        'https://images.unsplash.com/photo-1620121692029-d088224ddc74',
      ],
      'rome': [
        'https://images.unsplash.com/photo-1552832230-c0197dd311b5',
        'https://images.unsplash.com/photo-1542820229-081e0c12af0b',
        'https://images.unsplash.com/photo-1555992828-ca4dbe41d294',
        'https://images.unsplash.com/photo-1552832230-c0197dd311b5',
        'https://images.unsplash.com/photo-1529154691717-3306083d869e',
      ],
      'rio de janeiro': [
        'https://images.unsplash.com/photo-1483729558449-99ef09a8c325',
        'https://images.unsplash.com/photo-1483729558449-99ef09a8c325?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cmlvJTIwZGUlMjBqYW5laXJvfGVufDB8fDB8fHww',
        'https://plus.unsplash.com/premium_photo-1679865372673-8d1655a73b50?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8cmlvJTIwZGUlMjBqYW5laXJvfGVufDB8fDB8fHww',
        'https://images.unsplash.com/photo-1561577553-674ce32847a4?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8cmlvJTIwZGUlMjBqYW5laXJvfGVufDB8fDB8fHww',
        'https://images.unsplash.com/photo-1619546952812-520e98064a52',
      ],
      'dubai': [
        'https://images.unsplash.com/photo-1512453979798-5ea266f8880c',
        'https://images.unsplash.com/photo-1518684079-3c830dcef090',
        'https://plus.unsplash.com/premium_photo-1661943659036-aa040d92ee64?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZHViYWl8ZW58MHx8MHx8fDA%3D',
        'https://images.unsplash.com/photo-1582672060674-bc2bd808a8b5',
        'https://images.unsplash.com/photo-1512453979798-5ea266f8880c?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8ZHViYWl8ZW58MHx8MHx8fDA%3D',
      ],
      'maldives': [
        'https://images.unsplash.com/photo-1573843981267-be1999ff37cd',
        'https://images.unsplash.com/photo-1514282401047-d79a71a590e8',
        'https://images.unsplash.com/photo-1573843981267-be1999ff37cd',
        'https://images.unsplash.com/photo-1544550581-5f7ceaf7f992',
        'https://images.unsplash.com/photo-1590523277543-a94d2e4eb00b',
      ],
      'prague': [
        'https://images.unsplash.com/photo-1592906209472-a36b1f3782ef',
        'https://images.unsplash.com/photo-1519677100203-a0e668c92439',
        'https://images.unsplash.com/photo-1541849546-216549ae216d',
        'https://images.unsplash.com/photo-1592906209472-a36b1f3782ef',
        'https://images.unsplash.com/photo-1519677100203-a0e668c92439'
      ],
      'petra': [
        'https://images.unsplash.com/photo-1615811648503-479d06197ff3',
        'https://images.unsplash.com/photo-1562979314-bee7453e911c',
        'https://images.unsplash.com/photo-1591122947157-26bad3a117d2',
        'https://images.unsplash.com/photo-1562979314-bee7453e911c',
        'https://images.unsplash.com/photo-1591122947157-26bad3a117d2',
      ],
      'banff national park': [
        'https://images.unsplash.com/photo-1561134643-668f9057cce4',
        'https://plus.unsplash.com/premium_photo-1669741908329-ac6760970866?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8YmFuZmYlMjBuYXRpb25hbCUyMHBhcmt8ZW58MHx8MHx8fDA%3D',
        'https://images.unsplash.com/photo-1722267816704-37e57f36dc2a?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fGJhbmZmJTIwbmF0aW9uYWwlMjBwYXJrfGVufDB8fDB8fHww',
        'https://images.unsplash.com/photo-1561134643-668f9057cce4',
        'https://plus.unsplash.com/premium_photo-1669741908329-ac6760970866?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8YmFuZmYlMjBuYXRpb25hbCUyMHBhcmt8ZW58MHx8MHx8fDA%3D',
      ],
    };

    // Try to find images for this destination
    for (final key in destinationGalleries.keys) {
      if (baseName.contains(key) || key.contains(baseName)) {
        return destinationGalleries[key]!;
      }
    }

    return [
      'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1',
      'https://images.unsplash.com/photo-1486299267070-83823f5448dd',
      'https://images.unsplash.com/photo-1527631746610-bca00a040d60',
      'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4',
      'https://images.unsplash.com/photo-1530789253388-582c481c54b0',
    ];
  }
}
