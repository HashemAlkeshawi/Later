import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Data/classes/post.dart';
import '../Data/postsProvider.dart';
import 'Widgets_Util.dart/AppRouter.dart';

appBarActions(Post post) {
  Widget widget = PopupMenuButton(
    icon: const Icon(Icons.more_vert),
    itemBuilder: (BuildContext context) {
      return [
        PopupMenuItem(
          onTap: () async {
            print("editeing on ${post.type}");
            AppRouter.navigateWithReplacemtnToWidget(
                await Post.widgetByTypeToUpdate(post));
          },
          child: ListTile(
            minLeadingWidth: 5,
            leading: const Icon(
              Icons.edit,
            ),
            title: Text(
              'Edite'.tr(),
            ),
          ),
        ),
        PopupMenuItem(
          onTap: () async {
            await Provider.of<postsProvider>(context, listen: false)
                .deleteOnePost(post.id!);
            AppRouter.popFromWidget();
          },
          child: ListTile(
            minLeadingWidth: 5,
            leading: const Icon(
              Icons.delete,
            ),
            title: Text(
              'Delete'.tr(),
            ),
          ),
        ),
      ];
    },
  );

  return widget;
}
