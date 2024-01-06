import 'package:flutter/material.dart';
import 'package:habibi_kitchen/screens/uesr_authentication/signup.dart';
import 'authentication_screen.dart';
import 'login_tab.dart';

class AuthenticationTab extends StatefulWidget {
  const AuthenticationTab({Key? key}) : super(key: key);

  @override
  State<AuthenticationTab> createState() => _AuthenticationTabState();
}

class _AuthenticationTabState extends State<AuthenticationTab>
    with SingleTickerProviderStateMixin {
  static List<Widget> myTabs = <Widget>[
    const Tab(
      child: Padding(
        padding: EdgeInsets.only(
          right: 10,
          left: 10,
        ),
        child: Text('Login'),
      ),
    ),
    const Tab(
      child: Padding(
        padding: EdgeInsets.only(
          right: 10,
          left: 10,
        ),
        child: Text('Signup'),
      ),
    ),
  ];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes the position of the shadow
          ),
        ],
      ),
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          IntrinsicWidth(
            child: getTabBar(
              myTabs,
              _tabController,
            ),
          ),
          getTabViewContainer(
            context,
            TabBarView(
              controller: _tabController,
              // physics: const NeverScrollableScrollPhysics(),
              children: const [
                LoginTabView(),
                SignUpTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

//a method which will return tab bar which show login and signup tabs
TabBar getTabBar(List<Widget> myTabs, TabController tabController) {
  return TabBar(
    automaticIndicatorColorAdjustment: true,
    unselectedLabelColor: Colors.black.withOpacity(0.6),
    indicatorPadding: const EdgeInsets.all(0),
    labelPadding: const EdgeInsets.all(0),
    tabs: myTabs,
    labelColor: secondaryColor,
    indicatorColor: secondaryColor,
    indicatorSize: TabBarIndicatorSize.label,
    isScrollable: false,
    controller: tabController,
  );
}

//a method which will show tabview for each tab
Container getTabViewContainer(BuildContext buildContext, tabBarView) {
  return Container(
    height: MediaQuery.of(buildContext).size.height *
        0.55, // Remove the fixed height
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(10),
        topLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(
            0,
            3,
          ), // changes the position of the shadow
        ),
      ],
    ),
    child: tabBarView,
  );
}
