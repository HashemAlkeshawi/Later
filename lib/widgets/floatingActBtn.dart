import 'package:expendable_fab/expendable_fab.dart';
import 'package:flutter/material.dart';

import '../screens/Facebook/Facebook_create.dart';
import '../screens/Home.dart';
import '../screens/Instagram/Instagram_create.dart';
import '../screens/Twitter/Twitter_create.dart';
import 'Widgets_Util.dart/AppRouter.dart';

floatingActBtn() {
  return ExpendableFab(
    distance: 100.0,
    children: [
      ActionButton(
        onPressed: () => AppRouter.navigateToWidget(FaceCreate()),
        icon: Image.asset('assets/icons/facebook_actionButton.png'),
      ),
      ActionButton(
        onPressed: () => AppRouter.navigateToWidget(InstaCreate()),
        icon: Image.asset('assets/icons/instagram_actionButton.png'),
      ),
      ActionButton(
        onPressed: () => AppRouter.navigateToWidget(TwitterCreate()),
        icon: CircleAvatar(
          child: Image.asset('assets/icons/twitter_actionButton.png'),
        ),
      ),
    ],
  );
}
