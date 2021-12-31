class Task {
  int? id;
  String? title;
  String? description;
  String? date;

  Task({this.id,this.title,this.description,this.date});

   factory Task.fromJson(Map<String,dynamic> json){
     return Task(
      id:json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      date: json['date'] as String,
     );
  }

  Map<String, dynamic> toJson(){ 
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['date'] = this.date;
    return data;
  }
}