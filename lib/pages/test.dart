import 'package:flutter/material.dart';
import 'package:e_lijuk/pages/beranda_screen.dart';
import 'package:e_lijuk/pages/riwayat_screen.dart';
import 'package:e_lijuk/pages/profile_screen.dart';
import 'package:e_lijuk/pages/pemesanan.dart'; // Import halaman pemesanan
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class TestPage extends StatefulWidget {
  final int initialIndex;
  const TestPage({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late PersistentTabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PersistentTabController(initialIndex: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1,
    );
  }

  List<Widget> _buildScreens() {
    return [
      BerandaPage(),
      RiwayatPemesanan(),
      PemesananPage(),
      Profile(), // Tambahkan halaman pemesanan ke dalam screens
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Beranda"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.history),
        title: ("Riwayat"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.shopping_cart), // Ubah ikon untuk pemesanan
        title: ("Pemesanan"), // Ganti judul dengan "Pemesanan"
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.account_circle_outlined),
        title: ("Profil"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.black,
      ),
    ];
  }
}
