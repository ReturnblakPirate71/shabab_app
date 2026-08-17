
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Todoprovider.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // নতুন টাস্ক ইনপুট নেওয়ার জন্য একটি পপ-আপ ডায়ালগ ফাংশন
  void _showAddTodoDialog(BuildContext context) {
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(hintText: 'Enter task title...'),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // ক্যানসেল বাটন
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // 🔌 প্রোভাইডারের addTodo ফাংশনকে কল করলাম এবং ডাটা পাঠিয়ে দিলাম
                // listen: false দেওয়া হয়েছে কারণ আমরা শুধু অ্যাকশন ট্রিগার করছি, ডাটা ওয়াচ করছি না।
                Provider.of<Todoprovider>(context, listen: false)
                    .addTodo(textController.text);

                Navigator.pop(context); // কাজ শেষে পপ-আপ বন্ধ করে দাও
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 🔌 প্রোভাইডারকে ওয়াচ (Watch) করছি। যখনই notifyListeners() হবে, এই স্ক্রিনটা রিফ্রেশ হবে।
    final todoProvider = context.watch<Todoprovider>();
    final todoList = todoProvider.todos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todo Tasks'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      // যদি লিস্ট খালি থাকে তবে মেসেজ দেখাবে, আর টাস্ক থাকলে ListView দেখাবে
      body: todoList.isEmpty
          ? const Center(
        child: Text(
          'No tasks added yet!',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          final item = todoList[index];

          return ListTile(
            leading: Checkbox(
              value: item.isDone,
              onChanged: (value) {
                // 🔌 চেকবক্সে চাপ দিলে স্ট্যাটাস টগল হবে
                context.read<Todoprovider>().checStatus(item.id);
              },
            ),
            title: Text(
              item.title,
              style: TextStyle(
                // টাস্ক কমপ্লিট হলে লেখার মাঝখান দিয়ে দাগ (Strikethrough) কেটে দেবে
                decoration: item.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                color: item.isDone ? Colors.grey : Colors.black,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // 🔌 ডিলিট বাটনে চাপ দিলে টাস্ক মুছে যাবে
                context.read<Todoprovider>().deleteTodo(item.id);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoDialog(context), // বাটনে চাপ দিলে পপ-আপ খুলবে
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}