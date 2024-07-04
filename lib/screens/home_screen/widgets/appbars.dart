import 'package:flutter/material.dart';

class ChatsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatsAppBar(
      {super.key,
      required this.width,
      required this.height,
      required this.searchNotifer,
      required this.searchController});

  final double width;
  final double height;
  final ValueNotifier<bool> searchNotifer;
  final TextEditingController searchController;

//Search App bar function -> returns appbar with search text field
  AppBar getSearchAppBar(
    double width,
    double height,
    ValueNotifier<bool> searchNotifier,
  ) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      //Search-TextField-Container
      title: Container(
        padding: EdgeInsets.only(left: width * 0.02),
        width: width,
        height: height * 0.045,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: const Color.fromARGB(255, 60, 38, 111)),
        //Search-TextField
        child: TextField(
          controller: searchController,
          onChanged: (_) => searchNotifier.notifyListeners(),
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: const TextStyle(
                  color: Colors.white54, fontWeight: FontWeight.w200),
              hintText: 'Search Users',
              prefixIcon: IconButton(
                  onPressed: () {
                    searchNotifier.value = false;
                  },
                  icon: const Icon(
                    Icons.arrow_back_outlined,
                    color: Colors.white54,
                  )),
              suffixIcon: IconButton(
                  onPressed: () {
                    searchController.text = "";
                    searchNotifier.notifyListeners();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white54,
                  ))),
        ),
      ),
    );
  }

//Chats app bar function -> returns app bar for chat screen
  AppBar getchatsAppBar(
      double width, double height, ValueNotifier<bool> searchNotifier) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Padding(
        padding: EdgeInsets.only(left: width * 0.03),
        child: const Text(
          'Chats',
          style: TextStyle(
              fontSize: 25.0,
              color: Colors.white70,
              fontWeight: FontWeight.w500),
        ),
      ),
      actions: [
        //Search-Button
        GestureDetector(
          onTap: () {
            searchNotifier.value = true;
          },
          child: Container(
            height: height * 0.04,
            width: width * 0.08,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 60, 38, 111),
                borderRadius: BorderRadius.circular(30.0)),
            child: const Center(
                child: Icon(
              Icons.search_outlined,
              color: Colors.white70,
            )),
          ),
        ),
        SizedBox(
          width: width * 0.04,
        ),

        //Sign-Out-Button
        Padding(
          padding: EdgeInsets.only(right: width * 0.02),
          child: GestureDetector(
            onTap: () {},
            child: Center(
                child: Icon(
              Icons.logout_outlined,
              color: Colors.red[100],
            )),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: searchNotifer,
        builder: (ctx, searchVal, _) {
          return (searchVal)
              ? getSearchAppBar(width, height, searchNotifer)
              : getchatsAppBar(width, height, searchNotifer);
        });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
