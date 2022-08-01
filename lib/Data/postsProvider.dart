import 'package:flutter/cupertino.dart';
import 'package:later/Data/classes/categories.dart';
import 'package:later/Data/database/db_helper.dart';

import 'classes/post.dart';

class postsProvider extends ChangeNotifier {
  postsProvider() {
    selectAllPosts();
  }

  Category? selectedCategory = Category.catigories.first;

  void setSelectedCategory({Category? category}) {
    selectedCategory = category;
    refreshLists(posts!);
  }

  List<Post> selectedList = [];
  List<Post>? posts = [];
  List<Post>? postsDueSoon = [];
  List<Post>? facebookPosts = [];
  List<Post>? instagramPosts = [];
  List<Post>? twitterPosts = [];

  selectSelectedList(List<Post> postsList) {
    List<Post> listSelected = [];

    switch (selectedCategory!.catigoryCode) {
      case 0:
        listSelected = posts!;
        break;
      case 1:
        listSelected = facebookPosts!;
        break;
      case 2:
        listSelected = instagramPosts!;
        break;
      case 3:
        listSelected = twitterPosts!;
        break;
    }
    return listSelected;
  }

  refreshLists(List<Post> postsList) {
    posts = postsList;
    postsDueSoon = selectDueSoonPosts(posts!);
    facebookPosts = selectFacebookPosts(posts!);
    instagramPosts = selectInstagramPosts(posts!);
    twitterPosts = selectTwitterPosts(posts!);
    selectedList = selectSelectedList(posts!);
    notifyListeners();
  }

  selectAllPosts() async {
    List<Post> postsList = await DbHelper.db.selectAllPosts();
    refreshLists(postsList);
  }

  selectDueSoonPosts(List<Post> postsList) {
    List<Post> listOfPosts_ = postsList.where((element) {
      return element.isTimed;
    }).toList();

    listOfPosts_.sort(((a, b) {
      return a.dueOn!.compareTo(b.dueOn!);
    }));

    listOfPosts_.length > 4
        ? listOfPosts_ = listOfPosts_.sublist(0, 4)
        : listOfPosts_ = listOfPosts_;

    return listOfPosts_;
  }

  selectFacebookPosts(List<Post> postsList) {
    List<Post> listOfPosts_ = postsList.where((element) {
      return element.type == 1;
    }).toList();
    return listOfPosts_;
  }

  selectInstagramPosts(List<Post> postsList) {
    List<Post> listOfPosts_ = postsList.where((element) {
      return element.type == 2;
    }).toList();
    return listOfPosts_;
  }

  selectTwitterPosts(List<Post> postsList) {
    List<Post> listOfPosts_ = postsList.where((element) {
      return element.type == 3;
    }).toList();
    return listOfPosts_;
  }

  deleteOnePost(int id) async {
    await DbHelper.db.deleteOnePost(id);
    selectAllPosts();
  }

  addNewPost(Post post) async {
    await DbHelper.db.insertNewPost(post);
    selectAllPosts();
  }

  updateOnePost({required Post post, required int oldPostId}) async {
    await DbHelper.db.updateOnePost(post: post, oldPostId: oldPostId);
    selectAllPosts();
  }
}
