
import 'package:flutter/cupertino.dart';

import '../models/todoItem.dart';

class Todoprovider extends ChangeNotifier{

  final List<TodoItem> _todo = [];

  void addTodo (String title){
    if(title.trim().isEmpty)
      {
        return;
      }
    final newTodo = TodoItem (

     id : DateTime.now().toString(),
     title : title

    );

    _todo.add(newTodo);
    notifyListeners();

  }

void checStatus (String id){
    for (int i = 0 ; i<_todo.length ; i++){
      if(_todo[i].id == id){
        _todo[i].checked();
        notifyListeners();
        break;

      }

    }

}

  List<TodoItem>  get todos => _todo;

  void deleteTodo(String id) {
    _todo.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

}