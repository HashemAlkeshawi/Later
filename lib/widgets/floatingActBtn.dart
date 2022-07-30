import 'package:expendable_fab/expendable_fab.dart';
import 'package:flutter/material.dart';

import '../screens/Home.dart';
import 'Widgets_Util.dart/AppRouter.dart';

floatingActBtn() {
  return ExpendableFab(
    distance: 100.0,
    children: [
      ActionButton(
        onPressed: () => AppRouter.navigateToWidget(Home()),
        icon: Image.asset('assets/icons/facebook_actionButton.png'),
      ),
      ActionButton(
        onPressed: () => AppRouter.navigateToWidget(Home()),
        icon: Image.asset('assets/icons/instagram_actionButton.png'),
      ),
      ActionButton(
        onPressed: () => AppRouter.navigateToWidget(Home()),
        icon: CircleAvatar(
          child: Image.asset('assets/icons/twitter_actionButton.png'),
        ),
      ),
    ],
  );
}
