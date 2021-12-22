import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../../components/components.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late TabController _tabController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  void handleSelectedTab(int index) {
    setState(() {
      _tabController.animateTo(
        index,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Hi, ',
                        style: GoogleFonts.poppins(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      TextSpan(
                        text: 'Gabriel Scotá',
                        style: GoogleFonts.poppins(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  IconlyLight.search,
                  size: 28.0,
                  color: Colors.grey.shade900,
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.grey.shade200,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 24.0),
            padding: const EdgeInsets.all(6.0),
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.green,
              tabs: const [
                Tab(
                  text: "Notes",
                ),
                Tab(
                  text: "Favorites",
                ),
              ],
              onTap: handleSelectedTab,
              labelColor: const Color(0xFFFCFCFC),
              labelStyle: GoogleFonts.poppins(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
              unselectedLabelColor: Colors.grey.shade900,
              indicator: RectangularIndicator(
                bottomLeftRadius: 10.0,
                bottomRightRadius: 10.0,
                topLeftRadius: 10.0,
                topRightRadius: 10.0,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'List notes',
                    style: GoogleFonts.poppins(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade900,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showBarModalBottomSheet(
                      context: context,
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text('Filters'),
                          ],
                        ),
                      ),
                      expand: false,
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        'All notes',
                        style: GoogleFonts.poppins(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Icon(
                        IconlyLight.filter,
                        size: 20.0,
                        color: Colors.grey.shade900,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 32.0),
          sliver: LiveSliverGrid(
            controller: _scrollController,
            itemBuilder: (context, index, animation) => FadeTransition(
              opacity: Tween<double>(
                begin: 0,
                end: 1,
              ).animate(animation),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -0.1),
                  end: Offset.zero,
                ).animate(animation),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: _tabController.index == 0 ? AppColors.pastelLightBlue : AppColors.pastelLightRed,
                  ),
                ),
              ),
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              childAspectRatio: 0.8,
            ),
            itemCount: _tabController.index == 0 ? 5 : 8,
            showItemDuration: const Duration(milliseconds: 300),
            showItemInterval: const Duration(milliseconds: 100),
          ),
        )
      ],
    );
  }
}