import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:later/Data/database/db_helper.dart';
import 'package:later/widgets/bottomNavBar.dart';
import 'package:later/widgets/postSummary.dart';
import 'package:provider/provider.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

import '../Data/classes/categories.dart';
import '../Data/classes/post.dart';
import '../widgets/Widgets_Util.dart/AppRouter.dart';
import '../widgets/floatingActBtn.dart';

class PostsScreen extends StatefulWidget {
  static const String screenName = "PostsScreen";

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  Category? selectedCategorie;

  // List<Post> list = [];

  // posts() async {
  //   list = await Provider.of<DbHelper>(context).selectAllPosts();
  // }

  List<Category> categories = [
    Category('All'),
    Category('facebook'),
    Category('instagram'),
    Category('twitter'),
  ];

  @override
  Widget build(BuildContext context) {
    double screnHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        // floatingActionButton: floatingActBtn(),
        appBar: AppBar(
          backgroundColor: const Color(0xff1F97CF),
          title: Text(
            "Posts".tr(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              // padding: EdgeInsets.all(8.r),
              height: screnHeight - 110.h,
              child: Column(
                children: [
                  SizedBox(
                    height: 100.h,
                    child: DropdownButton<Category>(
                        hint: ListTile(
                          title: Text(categories.first.categoryName!),
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Image.asset(
                                'assets/images/${categories.first.categoryName}.png'),
                          ),
                        ),
                        isExpanded: true,
                        underline: const SizedBox(),
                        value: selectedCategorie,
                        items: categories.map((e) {
                          return DropdownMenuItem<Category>(
                            value: e,
                            child: ListTile(
                              title: Text(e.categoryName!),
                              leading: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Image.asset(
                                    'assets/images/${e.categoryName}.png'),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (v) {
                          selectedCategorie = v;
                          // posts = categorize(listOfPosts_, posts!, selectedCatigory!);

                          // setState(() {});
                        }),
                  ),
                  Container(
                    height: screnHeight - 220.h,
                    padding: EdgeInsets.only(bottom: 60.h),
                    child: ListView.builder(
                      // reverse: true,
                      controller: ScrollController(keepScrollOffset: false),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Post post =
                            Provider.of<DbHelper>(context).posts![index];
                        return InkWell(
                            onTap: () {
                              print(post.content ?? "nothing");
                              // AppRouter.navigateToWidget(selectType(post));
                            },
                            child: SwipeableTile.swipeToTrigger(
                              color: Colors.white,
                              swipeThreshold: 0.5,
                              direction: SwipeDirection.horizontal,
                              onSwiped: (direction) {
                                if (direction == SwipeDirection.endToStart) {
                                  Provider.of<DbHelper>(context, listen: false)
                                      .deleteOnePost(post.id!);
                                  print('delete');
                                } else {
                                  print('edit');
                                }
                              },
                              backgroundBuilder:
                                  (context, direction, progress) {
                                if (direction == SwipeDirection.endToStart) {
                                  return Container(
                                    padding: EdgeInsets.only(left: 260.w),
                                    height: screnHeight - 210.h,
                                    color: Colors.red,
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 80.r,
                                    ),
                                  );
                                } else if (direction ==
                                    SwipeDirection.startToEnd) {
                                  return Container(
                                    padding: EdgeInsets.only(right: 260.w),
                                    height: screnHeight - 210.h,
                                    color: Colors.greenAccent,
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 80.r,
                                    ),
                                  );
                                }

                                return Container();
                              },
                              key: UniqueKey(),
                              child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: 20.h, left: 15.w, right: 15.w),
                                  width: screenWidth,
                                  child: postSummary(
                                      post: post, topBorderRadios: true)),
                            ));
                      },
                      itemCount: Provider.of<DbHelper>(context).posts!.length,
                    ),
                  ),
                ],
              ),
            ),
            BottomNavBar(screenWidth, PostsScreen.screenName),
          ],
        ));
    // bottomNavigationBar: BottomNavBar(screenWidth, screenName));
  }
}
