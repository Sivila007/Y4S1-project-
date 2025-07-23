// import 'package:flutter/material.dart';

// class BottomNavigation extends StatelessWidget {
//   final int currentIndex;
//   final ValueChanged<int> onTap;

//   const BottomNavigation(
//       {super.key, required this.currentIndex, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: currentIndex,
//       onTap: onTap,
//       type: BottomNavigationBarType.fixed,
//       selectedItemColor: Colors.indigo.shade700,
//       unselectedItemColor: Colors.grey,
//       showUnselectedLabels: true,
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home_rounded),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.search_rounded),
//           label: 'Search',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.bookmark_rounded),
//           label: 'Watchlist',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person_rounded),
//           label: 'Profile',
//         ),
//       ],
//     );
//   }
// }
