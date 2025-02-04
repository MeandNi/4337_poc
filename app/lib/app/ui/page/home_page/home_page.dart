import 'package:app/app/base/get/get_common_view.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/ui/page/activities_page/activities_page.dart';
import 'package:app/app/ui/page/assets_page/assets_page.dart';
import 'package:app/app/ui/page/guardians_page/guardians_page.dart';
import 'package:app/app/ui/page/home_page/home_controller.dart';
import 'package:app/app/ui/page/home_page/widget/home_tab.dart';
import 'package:flutter/material.dart';

class HomePage extends GetCommonView<HomeController> {
  HomePage({super.key});

  final List<Widget> _pageList = [
    const AssetsPage(),
    ActivitiesPage(),
    GuardiansPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: controller.tabIndex,
        children: _pageList,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 1,
              color: ColorStyle.color_80979797,
            ),
          ),
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.tabIndex,
          selectedFontSize: 12,
          selectedItemColor: Colors.black,
          unselectedFontSize: 12,
          unselectedItemColor: ColorStyle.color_000000_50,
          onTap: (index) => controller.changeTab(index),
          items: [
            tab('Assets'),
            tab('Activities'),
            tab('Guardians'),
          ],
        ),
      ),
    );
  }
}
