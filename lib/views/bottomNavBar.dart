import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/bottomNavBarProvider.dart';
import 'dataListScreen.dart';
import 'profileScreen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
   int currentIndex = 0;
   static List<Widget> screens = [
    ProfileScreen(),
    DataListScreen()
  ];
  
  
  @override
  Widget build(BuildContext context) {
    

    return Consumer<BottomNavigationBarProvider>(
      builder: (context,provider,child) {
        return Scaffold(
            bottomNavigationBar: Container(
                child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              currentIndex: provider.currentIndex,
              unselectedItemColor: Colors.grey,
              unselectedLabelStyle: TextStyle(),
              selectedItemColor: Colors.blue,
              unselectedFontSize: 12,
              selectedFontSize: 12,
              selectedLabelStyle: TextStyle(color: Colors.blue,),
              onTap: (index) {
                setState(() {});
                provider.currentIndex = index;
              },
              backgroundColor: Colors.white,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle_outlined),
                    label: "Profile",
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(Icons.list_alt_rounded),
                    label: "Data List",
                    backgroundColor: Colors.white),
               
              ],
            )),
            body: Container(child: screens[provider.currentIndex]),);
      }
    );
  }
}