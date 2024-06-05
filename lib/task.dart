class Task{
  //initializing properties
  String? dueDate;
  String? todoText;

  //the constructor, takes in and sets the values
  Task({this.dueDate, this.todoText});

  static List<Task> tasklist(){
    return [
      Task(dueDate: "6/5/2024", todoText: "Homework"),
      Task(dueDate: "6/6/2024", todoText: "Gym"),

    ];
  }
}