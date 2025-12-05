// lib/print_shack_about.dart

import 'package:flutter/material.dart';

class PrintShackAboutPage extends StatelessWidget {
  const PrintShackAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'The UNION Shop',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo
                  Center(
                    child: Image.network(
                      'https://shop.upsu.net/cdn/shop/files/The_Union_Print_Shack_Logo_-_smaller_1024x1024@2x.png?v=1760532830',
                      height: 200,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          color: Colors.grey[200],
                          child: const Center(
                            child: Icon(Icons.print, size: 80, color: Colors.grey),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Title
                  const Text(
                    'The Union Print Shack',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4d2963),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Content
                  const Text(
                    'Welcome to The Union Print Shack - your one-stop destination for custom personalisation services at the University of Portsmouth Students\' Union!',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Services Section
                  const Text(
                    'Our Services',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildServiceCard(
                    icon: Icons.text_fields,
                    title: 'Text Personalisation',
                    description: 'Add your name, nickname, or custom text to any garment. Perfect for hoodies, t-shirts, and more!',
                    price: 'From £3',
                  ),
                  const SizedBox(height: 16),
                  
                  _buildServiceCard(
                    icon: Icons.print,
                    title: 'Custom Printing',
                    description: 'High-quality screen printing and heat transfer services for societies, sports teams, and events.',
                    price: 'Custom Quote',
                  ),
                  const SizedBox(height: 16),
                  
                  _buildServiceCard(
                    icon: Icons.design_services,
                    title: 'Design Services',
                    description: 'Need help with your design? Our team can help bring your vision to life.',
                    price: 'Contact Us',
                  ),
                  const SizedBox(height: 32),

                  // Pricing
                  const Text(
                    'Pricing',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPricingRow('One line of text (10 characters)', '£3.00'),
                        const SizedBox(height: 12),
                        _buildPricingRow('Two lines of text (10 characters each)', '£5.00'),
                        const SizedBox(height: 12),
                        const Divider(),
                        const SizedBox(height: 12),
                        const Text(
                          'Note: Personalised items do not qualify for refunds. Please ensure all spellings are correct before placing your order.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.red,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // How It Works
                  const Text(
                    'How It Works',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildStepCard(1, 'Add Item to Cart', 'First, add your clothing item to your shopping cart.'),
                  const SizedBox(height: 12),
                  _buildStepCard(2, 'Add Personalisation', 'Click the "Add a Personal Touch" button to add your custom text.'),
                  const SizedBox(height: 12),
                  _buildStepCard(3, 'Enter Your Text', 'Type your desired text (up to 10 characters per line).'),
                  const SizedBox(height: 12),
                  _buildStepCard(4, 'Complete Purchase', 'Check out and we\'ll print your personalised item!'),
                  const SizedBox(height: 32),

                  // CTA Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/personalisation');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4d2963),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text(
                        'START PERSONALISING NOW',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required String description,
    required String price,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF4d2963).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 32, color: const Color(0xFF4d2963)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4d2963),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingRow(String item, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            item,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
        Text(
          price,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4d2963),
          ),
        ),
      ],
    );
  }

  Widget _buildStepCard(int step, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF4d2963),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              '$step',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}