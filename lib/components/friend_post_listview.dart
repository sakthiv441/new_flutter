import 'package:flutter/material.dart';

import 'package:new_flutter/components/friend_post_tile.dart';

import '../models/post.dart';

class FriendPostListView extends StatelessWidget {
  const FriendPostListView({Key? key, required this.friendsPosts})
      : super(key: key);
  final List<Post> friendsPosts;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Social Chefs',
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(
            height: 16,
          ),
          ListView.separated(
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: friendsPosts.length,
              itemBuilder: (context, index) {
                final post = friendsPosts[index];
                return FriendPostTile(post: post);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 16,
                );
              }),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
