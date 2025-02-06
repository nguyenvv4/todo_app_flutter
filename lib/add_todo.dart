import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tolist_app/menu_bar.dart';
import 'package:tolist_app/todo_list.dart';

class AddTodoList extends StatefulWidget {
  const AddTodoList({super.key});

  @override
  State<AddTodoList> createState() => _AddTodoListState();
}

class _AddTodoListState extends State<AddTodoList> {
  TextEditingController titleEditController = new TextEditingController();
  TextEditingController descriptionEditController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add new todo",
          style: TextStyle(fontSize: 17, color: Colors.grey),
        ),
      ),
      drawer: MenuLeft(),
      body: ListView(
        children: [
          TextField(
            decoration: InputDecoration(hintText: "Title"),
            controller: titleEditController,
          ),
          TextField(
            controller: descriptionEditController,
            decoration: InputDecoration(hintText: "Description"),
            keyboardType: TextInputType.multiline,
            minLines: 2,
            maxLines: 5,
          ),
          ElevatedButton(onPressed: addNewTodo, child: Text("Submit"))
        ],
      ),
    );
  }

  Future<void> addNewTodo() async {
    final title = titleEditController.text;
    final description = descriptionEditController.text;
    if (title.isEmpty) {
      showErrorMessage('Title is Empty');
    }
    if (description.isEmpty) {
      showErrorMessage("Description is Empty");
    } else {
      final body = {
        // "id": 6,
        "title": title.toString(),
        "description": description.toString(),
        "completed": false
      };
      final url = "http://10.0.2.2:3000/todos";
      final uri = Uri.parse(url);
      final response = await http.post(uri,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 201) {
        titleEditController.text = '';
        descriptionEditController.text = "";
        // susscess
        showSuccessMessage('Created !!');
        // sleep(Duration(seconds: 2));
        backToHomePage();
      } else {
        showErrorMessage('Created fail');
      }
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void backToHomePage() {
    final route = MaterialPageRoute(builder: (context) => TodoListPage());
    //Chuyển đến màn hình AddTodoList
    Navigator.push(context, route);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message,
          style: TextStyle(
            color: Colors.red,
          )),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.white,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
