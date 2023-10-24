import 'package:HackathonApp/Screens/FavoritesScreen.dart';
import 'package:HackathonApp/Screens/HomeScreen.dart';
import 'package:HackathonApp/conStants/colors.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';


class Curvebar extends StatefulWidget {
  const Curvebar({super.key});

  @override
  State<Curvebar> createState() => _CurvebarState();
}

class _CurvebarState extends State<Curvebar> {

int index = 0;
  final screen =  [
    HomeScreen(),
    FavoritesScreen(),
   // CartScreen(),
  
  ];


  @override
  Widget build(BuildContext context) {


   

  final items = [
      ColorFiltered(
        colorFilter: index == 0
            ? ColorFilter.mode(Colors.white, BlendMode.srcIn)
            : ColorFilter.mode(Colors.black, BlendMode.srcIn),
        child: const Icon(Icons.home, size: 26),
      ),
      ColorFiltered(
        colorFilter: index == 1
            ? ColorFilter.mode(Colors.white, BlendMode.srcIn)
            : ColorFilter.mode(Colors.black, BlendMode.srcIn),
        child: const Icon(Icons.category, size: 26),
      ),
      ColorFiltered(
        colorFilter: index == 2
            ? ColorFilter.mode(Colors.white, BlendMode.srcIn)
            : ColorFilter.mode(Colors.black, BlendMode.srcIn),
        child: const Icon(Icons.favorite, size: 26),
      ),
      
    ];

    return Scaffold(
      extendBody: false,
      body: screen[index],
      bottomNavigationBar: index == 3 ? null : CurvedNavigationBar(
        color: Colors.white,
        buttonBackgroundColor: AppColors.darkthemecolor,
        backgroundColor: Colors.white,
        items: items,
        height: 50,
        index: index,
        onTap: (index) => setState(() => this.index = index),
      ),
    );

    
  }
}