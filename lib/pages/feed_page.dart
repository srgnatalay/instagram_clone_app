import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/utils/colors.dart';
import 'package:instagram_clone_app/widget/post_card.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: Image.asset(
          "assets/instagram_text_logo.png",
          color: Colors.white,
          height: 64,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                FluentIcons.chat_12_regular,
                size: 28,
              ))
        ],
      ),
      body: const PostCard(),
    );
  }
}
