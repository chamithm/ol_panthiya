class NoteModel{
  int id;
  String subject;
  // List<String> title;
  // List<String> body;
  String title;
  String body;
  DateTime creation_date;

  NoteModel({this.id,this.title,this.body,this.creation_date,this.subject});

  Map<String, dynamic> toMap(){
    return ({
      "id": id,
      "subject": subject,
      "title": title,
      "body": body,
      "creation_date": creation_date.toString()
    });
  }
}

class SelectedList{
  int index;
  int id;

  SelectedList({this.index,this.id});

  Map<String,int> toMap(){
    return ({
      "index":index,
      "id":id,
    });
  }
}