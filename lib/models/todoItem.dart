


class TodoItem {
  final String id;
  final String title;
  bool isDone = false;

  TodoItem({
    required this.id,
    required this.title,
    this.isDone = false,
  });

  void checked() {
    isDone = !isDone;
  }
}