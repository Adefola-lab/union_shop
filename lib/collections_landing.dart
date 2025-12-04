import 'package:flutter/material.dart';

class CollectionsLandingPage extends StatelessWidget {
  const CollectionsLandingPage({super.key});

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void placeholderCallbackForButtons() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header (same as main)
            _buildHeader(context),

            // Collections Grid
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1400),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: MediaQuery.of(context).size.width > 900
                        ? 3
                        : MediaQuery.of(context).size.width > 600
                            ? 2
                            : 1,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: 1.2,
                    children: [
                      _CollectionCard(
                        title: 'Autumn Favourites',
                        imageUrl:
                            'https://images.unsplash.com/photo-1572635196237-14b3f281503f?auto=format&fit=crop&w=800&q=60',
                        onTap: () => Navigator.pushNamed(context, '/collection',
                            arguments: 'Autumn Favourites'),
                      ),
                      _CollectionCard(
                        title: 'Black Friday',
                        imageUrl:
                            'https://images.unsplash.com/photo-1607083206968-13611e3d76db?auto=format&fit=crop&w=800&q=60',
                        onTap: () => Navigator.pushNamed(context, '/collection',
                            arguments: 'Black Friday'),
                      ),
                      _CollectionCard(
                        title: 'Clothing',
                        imageUrl:
                            'https://images.unsplash.com/photo-1556821840-3a63f95609a7?auto=format&fit=crop&w=800&q=60',
                        onTap: () => Navigator.pushNamed(context, '/collection',
                            arguments: 'Clothing'),
                      ),
                      _CollectionCard(
                        title: 'Signature Range',
                        imageUrl:
                            'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?auto=format&fit=crop&w=800&q=60',
                        onTap: () => Navigator.pushNamed(context, '/collection',
                            arguments: 'Signature Range'),
                      ),
                      _CollectionCard(
                        title: 'Elections Discounts',
                        imageUrl:
                            'https://images.unsplash.com/photo-1607083206968-13611e3d76db?auto=format&fit=crop&w=800&q=60',
                        onTap: () => Navigator.pushNamed(context, '/collection',
                            arguments: 'Elections Discounts'),
                      ),
                      _CollectionCard(
                        title: 'Essential Range',
                        imageUrl:
                            'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?auto=format&fit=crop&w=800&q=60',
                        onTap: () => Navigator.pushNamed(context, '/collection',
                            arguments: 'Essential Range'),
                      ),
                      _CollectionCard(
                        title: 'Winter Collection',
                        imageUrl:
                            'https://images.unsplash.com/photo-1482192596544-9eb780fc7f66?auto=format&fit=crop&w=800&q=60',
                        onTap: () => Navigator.pushNamed(context, '/collection',
                            arguments: 'Winter Collection'),
                      ),
                      _CollectionCard(
                        title: 'Spring Collection',
                        imageUrl:
                            'https://images.unsplash.com/photo-1490750967868-88aa4486c946?auto=format&fit=crop&w=800&q=60',
                        onTap: () => Navigator.pushNamed(context, '/collection',
                            arguments: 'Spring Collection'),
                      ),
                      _CollectionCard(
                        title: 'Summer Essentials',
                        imageUrl:
                            'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=800&q=60',
                        onTap: () => Navigator.pushNamed(context, '/collection',
                            arguments: 'Summer Essentials'),
                      ),
                      _CollectionCard(
                        title: 'Merchandise',
                        imageUrl:
                            'https://images.unsplash.com/photo-1656360088907-5109c245851d?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bWVyY2hhbmRpc2V8ZW58MHx8MHx8fDA%3D',
                        onTap: () => Navigator.pushNamed(context, '/collection',
                            arguments: 'Merchandise'),
                      ),
                      _CollectionCard(
                        title: 'Pride Collection',
                        imageUrl:
                            'https://plus.unsplash.com/premium_photo-1687261407696-7eac96c9e8fd?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJpZGUlMjBjbG90aGluZ3xlbnwwfHwwfHx8MA%3D%3D',
                        onTap: () => Navigator.pushNamed(context, '/collection',
                            arguments: 'Pride Collection'),
                      ),
                      _CollectionCard(
                        title: 'Graduation',
                        imageUrl:
                            'https://images.unsplash.com/photo-1559443065-db5f9290a1a7?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8Z3JhZHVhdGlvbiUyMGdvd258ZW58MHx8MHx8fDA%3D',
                        onTap: () => Navigator.pushNamed(context, '/collection',
                            arguments: 'Graduation'),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Footer
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: const Color(0xFF4d2963),
            child: const Text(
              'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => navigateToHome(context),
                    child: Image.network(
                      'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                      height: 18,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          width: 18,
                          height: 18,
                          child: const Center(
                              child: Icon(Icons.image_not_supported,
                                  color: Colors.grey)),
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                          onPressed: () => navigateToHome(context),
                          child: const Text('Home',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 14))),
                      const SizedBox(width: 8),
                      PopupMenuButton<String>(
                        offset: const Offset(0, 40),
                        child: const TextButton(
                          onPressed: null,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Shop',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                      decoration: TextDecoration.underline)),
                              SizedBox(width: 4),
                              Icon(Icons.keyboard_arrow_down,
                                  size: 16, color: Colors.black87),
                            ],
                          ),
                        ),
                        itemBuilder: (BuildContext context) => const [
                          PopupMenuItem<String>(
                              value: 'clothing', child: Text('Clothing')),
                          PopupMenuItem<String>(
                              value: 'merchandise', child: Text('Merchandise')),
                          PopupMenuItem<String>(
                              value: 'halloween',
                              child: Row(
                                  children: [Text('Halloween '), Text('🎃')])),
                          PopupMenuItem<String>(
                              value: 'signature',
                              child: Text('Signature & Essential Range')),
                          PopupMenuItem<String>(
                              value: 'portsmouth',
                              child: Text('Portsmouth City Collection')),
                          PopupMenuItem<String>(
                              value: 'pride',
                              child: Row(children: [
                                Text('Pride Collection '),
                                Text('🏳️‍🌈')
                              ])),
                          PopupMenuItem<String>(
                              value: 'graduation',
                              child: Row(
                                  children: [Text('Graduation '), Text('🎓')])),
                        ],
                        onSelected: (String value) =>
                            placeholderCallbackForButtons(),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: placeholderCallbackForButtons,
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('The Print Shack',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 14)),
                            SizedBox(width: 4),
                            Icon(Icons.keyboard_arrow_down,
                                size: 16, color: Colors.black87),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                          onPressed: placeholderCallbackForButtons,
                          child: const Text('SALE!',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 14))),
                      const SizedBox(width: 8),
                      TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/about'),
                          child: const Text('About',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 14))),
                      const SizedBox(width: 8),
                      TextButton(
                          onPressed: placeholderCallbackForButtons,
                          child: const Text('UPSU.net',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 14))),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          icon: const Icon(Icons.search,
                              size: 18, color: Colors.grey),
                          onPressed: () => Navigator.pushNamed(context, '/search'),),
                      IconButton(
                          icon: const Icon(Icons.person_outline,
                              size: 18, color: Colors.grey),
                          onPressed: () =>
                              Navigator.pushNamed(context, '/sign-in')),
                      IconButton(
                          icon: const Icon(Icons.shopping_bag_outlined,
                              size: 18, color: Colors.grey),
                          onPressed: placeholderCallbackForButtons),
                      IconButton(
                          icon: const Icon(Icons.menu,
                              size: 18, color: Colors.grey),
                          onPressed: placeholderCallbackForButtons),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      color: Colors.grey[50],
      padding: const EdgeInsets.all(40),
      child: const Center(
        child: Text('© 2025, upsu-store    Powered by Shopify',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black54)),
      ),
    );
  }
}

class _CollectionCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  const _CollectionCard({
    required this.title,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  State<_CollectionCard> createState() => _CollectionCardState();
}

class _CollectionCardState extends State<_CollectionCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: _isHovering
                ? [
                    BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4))
                  ]
                : [],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Center(
                            child: Icon(Icons.image_not_supported,
                                size: 64, color: Colors.grey)),
                      );
                    },
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.7),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 24,
                  left: 24,
                  right: 24,
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
