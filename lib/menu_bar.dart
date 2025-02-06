import 'package:flutter/material.dart';
import 'package:tolist_app/setting.dart';
import 'package:tolist_app/todo_list.dart';

class MenuLeft extends StatefulWidget {
  const MenuLeft({super.key});
  @override
  State<MenuLeft> createState() => _MenuLeftState();
}

class _MenuLeftState extends State<MenuLeft> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed( Duration(seconds: 2), (){
      if(mounted){
        Navigator.pop(context);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: ListView(

        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  "https://m.media-amazon.com/images/S/pv-target-images/16627900db04b76fae3b64266ca161511422059cd24062fb5d900971003a0b70.jpg",
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            accountName: Text("NguyenVV6@fe.edu.vn"),
            accountEmail: Text("NguyenVV6"),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    "https://cdnmedia.baotintuc.vn/Upload/DmtgOUlHWBO5POIHzIwr1A/files/2022/12/26/review-avatar-2-26122022.jpg",

                  ),
                  fit: BoxFit.cover),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Trang chủ"),
            onTap: () {
              final router =
              MaterialPageRoute(builder: (context) => TodoListPage());
              Navigator.push(context, router);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Cài đặt"),
            onTap: () {
              final router =
              MaterialPageRoute(builder: (context) => Setting());
              Navigator.push(context, router);
            },
          ),
        ],
      ),
    );
  }
}

