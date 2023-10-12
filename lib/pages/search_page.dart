import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_clone_app/utils/colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: searchController,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isShowUsers = false;
                  searchController.text = "";
                });
              },
              icon: const Icon(FluentIcons.dismiss_12_regular),
            ),
            border: InputBorder.none,
            hintText: "Ara",
            icon: const Icon(FluentIcons.search_12_filled),
          ),
          onChanged: (value) {
            setState(() {
              isShowUsers = true;
            });
          },
        ),
      ),
      body: isShowUsers
          ? FutureBuilder(
              future: firestore
                  .collection("users")
                  .where(
                    "username",
                    isGreaterThanOrEqualTo: searchController.text,
                  )
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var snap = snapshot.data!.docs[index];

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          snap["photoUrl"],
                        ),
                      ),
                      title: Text(
                        snap["username"],
                      ),
                    );
                  },
                );
              },
            )
          : FutureBuilder(
              future: firestore.collection("posts").get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                var snap = snapshot.data!.docs;
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 3,
                  itemCount: snap.length,
                  itemBuilder: (context, index) => Image.network(
                    snap[index]["postUrl"],
                  ),
                  staggeredTileBuilder: (index) => StaggeredTile.count(
                      (index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                );
              },
            ),
    );
  }
}
