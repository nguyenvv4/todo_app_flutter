import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tolist_app/add_todo.dart';
import 'package:http/http.dart' as http;
import 'package:tolist_app/menu_bar.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTodoList();
  }

  bool isReload = true;

  List items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Todo App', style: TextStyle(fontSize: 17, color: Colors.red)),
      ),
      drawer: MenuLeft(),
      body: Visibility(
        visible: isReload,
        child: Center(
          child: CircularProgressIndicator(),
        ),
        replacement: RefreshIndicator(
          onRefresh: fetchTodoList,
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final id = item['id'];
                return Card(
                  child: ListTile(
                      leading: CircleAvatar(child: Text('${index + 1}')),
                      title: Text(item['title']),
                      subtitle: Text(item['description']),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              child: Text('edit'),
                              value: 'edit',
                            ),
                            PopupMenuItem(
                              child: Text('delete'),
                              value: 'delete',
                            )
                          ];
                        },
                        onSelected: (value) {
                          if (value == 'edit') {
                            // edit
                          } else if (value == 'delete') {
                            deleteById(id);
                          }
                        },
                      )),
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addTodoList,
        label: Text("Add new todo"),
      ),
    );
  }

  void addTodoList() {
    // Khởi tạo route với AddTodoList
    final route = MaterialPageRoute(builder: (context) => AddTodoList());
    //Chuyển đến màn hình AddTodoList
    Navigator.push(context, route);
  }

  Future<void> fetchTodoList() async {
    final url = "http://10.0.2.2:3000/todos";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      setState(() {
        items = json;
      });
      print(json);
      setState(() {
        isReload = false;
      });
    }
  }

  Future<void> deleteById(String id) async {
    final url = "http://10.0.2.2:3000/todos/$id";
    final uri = Uri.parse(url);
    setState(() {
      isReload = false;
    });
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      showSuccessMessage('Delete Succsess !!');
      final itemsDeleted = items.where((item) => item['id'] != id).toList();
      setState(() {
        items = itemsDeleted;
      });
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(
          top: 50, left: 20, right: 20), // Đặt vị trí gần trên
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
