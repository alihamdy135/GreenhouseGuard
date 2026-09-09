import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFF2C6975);
const Color kSecondaryColor = Color(0xFF68B2A0);
const Color kAccentColor = Color(0xFFCDE0C9);
const Color kLightAccentColor = Color(0xFFE0ECDE);
const Color kBackgroundColor = Color(0xFFFFFFFF);

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: kBackgroundColor, // Set the background color to kBackgroundColor
      selectedItemColor: kPrimaryColor, // Use kPrimaryColor for the selected item
      unselectedItemColor: kSecondaryColor, // Use kSecondaryColor for unselected items
      type: BottomNavigationBarType.fixed, // Ensures all items are shown
      showSelectedLabels: true,
      showUnselectedLabels: true, // Show unselected labels for a cleaner look
      elevation: 8, // Reduced shadow elevation for a modern feel
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w600, // Slightly thinner font for modern style
        fontSize: 14, // Adjust font size for readability
        letterSpacing: 1.2, // Adding spacing for a more sleek look
        color: kPrimaryColor, // Use kPrimaryColor for the selected label
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12, // Slightly smaller font for unselected items
        color: kAccentColor, // Use kAccentColor for unselected label color
      ),
      iconSize: 30, // Larger icons for better visibility
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.auto_graph_outlined),
          activeIcon: Icon(Icons.auto_graph),
          label: 'Chart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dataset),
          activeIcon: Icon(Icons.dataset),
          label: 'Data Index',
        ),
      ],
    );
  }
}
