import 'package:budy_buddy/screens/home_profile_tab.dart';
import 'package:budy_buddy/screens/home_screen_tab.dart';
import 'package:budy_buddy/screens/stat_screen_tab.dart';
import 'package:budy_buddy/utils/constant.dart';
import 'package:budy_buddy/widgets/add_transaction.dart';
import 'package:flutter/material.dart';

class MainScreenHost extends StatefulWidget {
  const MainScreenHost({super.key});

  @override
  State<MainScreenHost> createState() => _MainScreenHostState();
}

class _MainScreenHostState extends State<MainScreenHost> {
  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: const AddTransaction(),
              ),
            ));
  }

  var currentIndex = 0;

  Widget buildTabContent(int index) {
    switch (index) {
      case 0:
        return const HomeScreenTab();
      case 1:
        return const StatScreenTab();
      // return Container();
      case 2:
        return Container();
      case 3:
        return const HomeProfileTab();
      default:
        return const HomeScreenTab();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildTabContent(currentIndex),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 60,
              child: IconButton(
                icon: const Icon(
                  Icons.home,
                ),
                color: currentIndex == 0 ? secondaryDark : Colors.black,
                onPressed: () {
                  setState(() {
                    currentIndex = 0;
                  });
                },
              ),
            ),
            SizedBox(
              height: 60,
              child: IconButton(
                icon: const Icon(Icons.bar_chart_rounded),
                color: currentIndex == 1 ? secondaryDark : Colors.black,
                onPressed: () {
                  setState(() {
                    currentIndex = 1;
                  });
                },
              ),
            ),
            const SizedBox(width: 48.0), // Add some space between buttons.
            SizedBox(
              height: 60,
              child: IconButton(
                icon: const Icon(Icons.wallet_outlined),
                color: currentIndex == 2 ? secondaryDark : Colors.black,
                onPressed: () {
                  setState(() {
                    currentIndex = 2;
                  });
                },
              ),
            ),
            SizedBox(
              height: 60,
              child: IconButton(
                icon: const Icon(Icons.person),
                color: currentIndex == 3 ? secondaryDark : Colors.black,
                onPressed: () {
                  setState(() {
                    currentIndex = 3;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTask(context);
        },
        backgroundColor: secondaryDark,
        child: const Icon(Icons.add), // Change this to your desired color.
      ),
    );
  }
}
