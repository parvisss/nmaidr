import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:retsept_cherno/ui/widgets/bottom_navigation_bar.dart';
import 'package:retsept_cherno/ui/widgets/build_chef_list_widget.dart';
import 'package:retsept_cherno/ui/widgets/build_griw_view_widget.dart';
import 'package:retsept_cherno/ui/widgets/build_tag_list_widget.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue,
                Colors.white,
              ],
            ),
          ),
          child: Column(
            children: [
              // Search bar and filter button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        padding: const EdgeInsets.all(12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: SvgPicture.asset(
                        "assets/svg/filter.svg",
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ],
                ),
              ),

              // Tab bar
              const TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: 'Recipes'),
                  Tab(text: 'Chefs'),
                  Tab(text: 'Tags'),
                ],
              ),

              // Expanded grid view for the images
              Expanded(
                child: TabBarView(
                  children: [
                    BuildGridViewWidget(),
                    BuildChefListWidget(),
                    BuildTagListWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar:
            CustomBottomNavigationBar(), // Updated with custom bottom navigation
      ),
    );
  }
}
