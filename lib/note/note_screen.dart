import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ol_panthiya/note/db/database_provider.dart';
import 'package:ol_panthiya/note/model/note_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:multi_select_item/multi_select_item.dart';
import 'package:ol_panthiya/video/video_page/play_video.dart';

import '../globle.dart';

class NoteScreen extends StatefulWidget {
  Widget player;
  String subject;
  NoteScreen(this.player,this.subject);

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  MultiSelectController multiSelectController = new MultiSelectController();
  bool visibleMultiselectIcon = false;
  bool noteVisible = false;
  bool readOnly = false;
  TextEditingController titleCon = TextEditingController();
  TextEditingController noteCon = TextEditingController();
  bool isEdit = false;
  int selectedNoteId;
  DateTime date;
  int note_id = 0;
  List<int> selectedListId = [];
  bool showItem = false;
  bool isCallFutureBuilder = true;
  bool isTitle = true;
  bool emojiShowing = false;
  bool isItem = false;
  int len;
  Future getData;
  final ScrollController listScrollController = ScrollController();

  Future<bool> _onBackPress(){
    bool isBack;
    if(multiSelectController.isSelecting){
      setState(() {
        multiSelectController.deselectAll();
        visibleMultiselectIcon = false;
        isBack = false;
      });
    }
    else{
      setState(() {
        isBack = true;        
      });
    }
    return Future<bool>.value(isBack);
  }

  getNotes() async{
    final notes = await DatabaseProvider.db.getNotes(widget.subject);

    if(notes == Null){
      len = 0;
      note_id = len + 1;
    }else{
      len = notes.length;
      note_id = len + 1;
    }

    getData = Future.value(notes);
    
    return notes;
  }

  Widget close(){
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: SizedBox(
        width: 25.0,
        height: 25.0,
        child: FloatingActionButton(
          backgroundColor: Colors.black54,
          child: Icon(Icons.close,color: Colors.red[100],size: 20.0),
          onPressed: () {
            setState(() {
              isCallFutureBuilder = false;
              noteVisible = false;
              titleCon.text = "";
              noteCon.text = "";
              isEdit = false;
              readOnly = false;
              isItem = !isItem;
              showItem = false;                    
            });
          },
        ),
      ),
    );
  }

  Widget toolSet(String unicode){
    return TextButton(
      onPressed: () {
        emojiShowing = !emojiShowing;
        isTitle ? titleCon : noteCon
          ..text += unicode
          ..selection = TextSelection.fromPosition(
              TextPosition(offset: isTitle ? titleCon.text.length : noteCon.text.length));
      },
      style: TextButton.styleFrom(
        minimumSize: Size(10, 10),
      ),
      child: Text(unicode),
    );
  }

  addNotes(NoteModel note) {
    if(isEdit){
      DatabaseProvider.db.updateNote(note);
      print("in edit");
    }else{
      DatabaseProvider.db.addNewNote(note);
      print("not in edit");
    }
  }

  Widget currentNoteSaveWhenOpenNew(int id,String title,String body,int n_id){
    return AlertDialog(
      content: Text("Do you want to save current note?"),
      actions: [
        FlatButton(
          onPressed: (){
            setState(() {
              isCallFutureBuilder = false;
              if(id == 1){
                titleCon.text = "";
                noteCon.text = "";
                readOnly = false;
                isEdit = false; 
              }
              else{
                titleCon.text = title;
                noteCon.text = body;
                selectedNoteId = n_id;
                readOnly = true;
                isEdit = true;
              }                                 
            });
            Navigator.of(context).pop();
          },
          child: Text("Cancel",style: TextStyle(color: Colors.red),),
        ),
        FlatButton(
          onPressed: (){
            date = DateTime.now();
            int notes_id = isEdit ? selectedNoteId : note_id;
            NoteModel note = NoteModel(title:titleCon.text,body: noteCon.text,creation_date: date,id: notes_id,subject: widget.subject);
            addNotes(note);
            setState(() {
              isCallFutureBuilder = true;
              if(id == 1){
                titleCon.text = "";
                noteCon.text = "";
                readOnly = false;
                isEdit = false;
              }
              else{
                titleCon.text = title;
                noteCon.text = body;
                selectedNoteId = n_id;
                readOnly = true;
                isEdit = true;
              }                                  
            });
            Navigator.of(context).pop();
          },
          child: Text("Save",style: TextStyle(color: Colors.blue),),
        ),
      ],
    );
  }

  void deleteNote(int selectItem){
    var alert = AlertDialog(
      content: Text(
        "Are you sure you want to delete?"),
      actions: <Widget>[
        FlatButton(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text(
            "Delete",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () async{
            if(selectItem == 1){
              for(int i=0;i<selectedListId.length;i++){
                await DatabaseProvider.db.deleteData(selectedListId[i]);
                if(selectedListId[i] == selectedNoteId){
                  setState(() {
                    noteVisible = false;
                    titleCon.text = "";
                    noteCon.text = "";
                    readOnly = !readOnly; 
                    showItem = false;
                  });
                }
              }
              setState(() {
                isCallFutureBuilder = true;
                visibleMultiselectIcon = false;
                multiSelectController.deselectAll();
              });
            }
            else{
              await DatabaseProvider.db.deleteData(selectedNoteId);
              setState(() {
                isCallFutureBuilder = true;
                noteVisible = false;
                titleCon.text = "";
                noteCon.text = "";
                readOnly = !readOnly;
                showItem = false;
              });
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    showDialog(context: context,builder:(_) => alert);
  }
  
  Widget addSubTitle(){
    return Padding(
      padding: const EdgeInsets.only(top:10.0,left: 8.0,right: 8.0),
      child: Column(
        children: [
          TextField(
            controller: titleCon,
            autofocus: true,
            textAlign: TextAlign.center,
            readOnly: readOnly,
            style: TextStyle(fontSize: 18.0,color: Colors.white,fontWeight: FontWeight.w600),
            onTap: (){
              setState(() {
                isCallFutureBuilder = false;
                isTitle = true;                
              });
            },
            keyboardType: TextInputType.multiline,
            maxLines: null,
            scrollPadding: const EdgeInsets.only(bottom: 32.0),
            decoration: InputDecoration(
              hintText: "Title",
              hintStyle: TextStyle(color: Colors.grey[100]),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 3.0),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:14.0,top:8.0,right: 14.0),
            child: TextFormField(
              controller: noteCon,
              readOnly: readOnly,
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white,fontSize: 14.0),
              onTap: (){
                setState(() {
                  isCallFutureBuilder = false;
                  isTitle = false;                 
                });
              },
              keyboardType: TextInputType.multiline,
              maxLines: null,
              scrollPadding: const EdgeInsets.only(bottom: 64.0),
              decoration: InputDecoration(
                hintText: "Note",
                hintStyle: TextStyle(color: Colors.grey[100]),
                fillColor: Colors.white,
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPress,
      child: SafeArea(
          child: Column(
            children: [
              // Container(
              //   child: widget.player
              // ),
              // SizedBox(height: 10.0,),
              Padding(
                padding: const EdgeInsets.only(left:12.0,top: 4.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 110.0,
                      height: 30.0,
                      child: ElevatedButton(
                        onPressed: (){
                          setState(() {
                            isCallFutureBuilder = false;
                            Globle.showItem = false;
                            if(noteVisible && !readOnly){
                              var alert = currentNoteSaveWhenOpenNew(1,"","",0);
                              showDialog(context: context,builder:(_) => alert);
                            }
                            else{
                              noteVisible = true;
                              titleCon.text = "";
                              noteCon.text = "";
                              readOnly = false;
                              isEdit = false;
                            }
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey[900]),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.blue[100]),
                            )
                          )
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.note_add_outlined,color: Colors.blue[100],size: 15.0,),
                              Padding(
                                padding: const EdgeInsets.only(left:4.0),
                                child: Text("Add Note",style: TextStyle(color: Colors.blue[100],fontSize: 11)),
                              ),
                            ],
                          ),
                      ),
                    ),
                    SizedBox(width: 8,),
                    SizedBox(
                      width: 100.0,
                      height: 30.0,
                      child: Visibility(
                        visible: visibleMultiselectIcon,
                        child: ElevatedButton(
                          onPressed: (){
                            deleteNote(1);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey[900]),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red[200]),
                              )
                            )
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.delete,color: Colors.red[200],size: 15.0,),
                                Padding(
                                  padding: const EdgeInsets.only(left:4.0),
                                  child: Text("Delete",style: TextStyle(color: Colors.red[200],fontSize: 11)),
                                ),
                              ],
                            ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(height: 10.0,),
                        Visibility(
                          visible: noteVisible,
                          child: Padding(
                            padding: EdgeInsets.only(left:8.0,right: 8.0),
                            child: InteractiveViewer(
                              child: Stack(
                                children: [
                                  Card(
                                    color: Colors.blueGrey[500],
                                    child: Column(
                                      children: [
                                        addSubTitle(),
                                        Visibility(
                                          visible: !readOnly,
                                          child: Row(
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.save,color: Colors.white70),
                                                onPressed: (){
                                                  date = DateTime.now();
                                                  int notes_id = isEdit ? selectedNoteId : note_id;
                                                  NoteModel note = NoteModel(title:titleCon.text,body: noteCon.text,creation_date: date,id: notes_id,subject: widget.subject);
                                                  addNotes(note);
                                                  setState(() {
                                                    isCallFutureBuilder = true;
                                                    titleCon.text = "";
                                                    noteCon.text = "";
                                                    noteVisible = false;                                      
                                                  });
                                                }
                                              ),
                                              AnimatedSwitcher(
                                                duration: Duration(seconds: 1),
                                                transitionBuilder: (Widget child, Animation<double> animation) =>
                                                FadeTransition(
                                                  opacity: animation,
                                                  child: SizeTransition(child:
                                                  child,
                                                    sizeFactor: animation,
                                                    axis: Axis.horizontal,
                                                  ),
                                                ) ,
                                                child: showItem ?
                                                Container(
                                                  height: 28.0,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black12,
                                                    borderRadius: BorderRadius.all(Radius.circular(5.0))
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      toolSet("\u{1F53A}"),
                                                      toolSet("\u{1F53B}"),
                                                      toolSet("\u{25FB}"),
                                                      toolSet("\u{25FD}"),
                                                      toolSet("\u{25AB}"),
                                                      toolSet("\u{1F538}"),
                                                      IconButton(
                                                        icon: Icon(Icons.arrow_back_ios,color: Colors.white70,size: 15),
                                                        onPressed: (){
                                                          setState(() {
                                                            isCallFutureBuilder = false;
                                                            showItem = !showItem;                                       
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ) : IconButton(
                                                  icon: Icon(Icons.list_alt,color: Colors.white70,),
                                                  onPressed: (){
                                                    setState(() {
                                                      isCallFutureBuilder = false;
                                                      showItem = !showItem;                                       
                                                    });
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  isEdit ? AnimatedSwitcher(
                                    duration: Duration(seconds: 1),
                                    transitionBuilder: (Widget child, Animation<double> animation) =>
                                    FadeTransition(
                                      opacity: animation,
                                      child: SizeTransition(child:
                                      child,
                                        sizeFactor: animation,
                                        axis: Axis.horizontal,
                                      ),
                                    ),
                                    child: isItem ? Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top:6.0,right: 6.0),
                                        child: Container(
                                          height: 35.0,
                                          width: 180.0,
                                          decoration: BoxDecoration(
                                            color: Colors.black38,
                                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(right:12.0),
                                                child: IconButton(
                                                  icon: Icon(Icons.arrow_forward_ios,color: Colors.red[100],size: 15),
                                                  onPressed: (){
                                                    setState(() {
                                                      isCallFutureBuilder = false;
                                                      isItem = !isItem;                                      
                                                    });
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(right: 16.0),
                                                child: Visibility(
                                                  visible: isEdit,
                                                  child: SizedBox(
                                                    width: 25.0,
                                                    height: 25.0,
                                                    child: FloatingActionButton(
                                                      backgroundColor: readOnly ? Colors.black54 : Colors.green[200],
                                                      child: Icon(Icons.edit,size: 20.0,color: readOnly ? Colors.red[100] : Colors.blueGrey,),
                                                      onPressed: () {
                                                        setState(() {
                                                          isCallFutureBuilder = false;
                                                          readOnly = !readOnly;
                                                          isItem = !isItem;                     
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(right: 16.0),
                                                child: Visibility(
                                                  visible: isEdit,
                                                  child: SizedBox(
                                                    width: 25.0,
                                                    height: 25.0,
                                                    child: FloatingActionButton(
                                                      backgroundColor: Colors.black54,
                                                      child: Icon(Icons.delete,size: 20.0,color: Colors.red[100],),
                                                      onPressed: () {
                                                        deleteNote(2);
                                                        setState(() {
                                                          isCallFutureBuilder = false;
                                                          isItem = !isItem;                                                  
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              close(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ) : Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                            icon: Icon(Icons.more_vert,color: Colors.red[100]),
                                            onPressed: (){
                                              setState(() {
                                                isCallFutureBuilder = false;
                                                isItem = !isItem;                                    
                                              });
                                            },
                                          ),
                                    ),
                                  ) : Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top:8.0),
                                      child: close(),
                                    )
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        FutureBuilder(
                          future: isCallFutureBuilder ? getNotes() : getData,
                          //future: getNotes(),
                          builder: (context,noteData){
                            switch(noteData.connectionState){
                              case ConnectionState.waiting:
                                {
                                  return Center(child: CircularProgressIndicator(),);
                                }
                              case ConnectionState.done:
                                {
                                  if(noteData.data == Null){
                                    return Center(child: Text("You don't have any notes yet"),);
                                  }
                                  else{
                                    List<int> index_num_e = [];
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: StaggeredGridView.countBuilder(
                                        physics: NeverScrollableScrollPhysics(),
                                        crossAxisCount: 4,
                                        controller: listScrollController,
                                        shrinkWrap: true,
                                        itemCount: noteData.data.length,
                                        itemBuilder: (context,index1){
                                          int arrayKey = (noteData.data.length) - (index1 + 1);
                                          String title = noteData.data[arrayKey]["title"];
                                          String body = noteData.data[arrayKey]["body"];
                                          int id = noteData.data[arrayKey]["id"];

                                          return MultiSelectItem(
                                            isSelecting: multiSelectController.isSelecting,
                                            onSelected: () {
                                              print("is selected before $index1: ${multiSelectController.isSelecting}");
                                              setState(() {
                                                isCallFutureBuilder = false;
                                                if(multiSelectController.isSelected(index1)){
                                                  multiSelectController.deselect(index1);
                                                  selectedListId.remove(id);
                                                }
                                                else{
                                                  multiSelectController.toggle(index1);
                                                  selectedListId.add(id);
                                                }
                                                visibleMultiselectIcon = true;
                                              });
                                            },
                                            child: !multiSelectController.isSelecting ? InkWell(
                                              onTap: (){
                                                setState(() {
                                                  isEdit = true;
                                                  Globle.showItem =false;
                                                  if(noteVisible && !readOnly){
                                                    var alert = currentNoteSaveWhenOpenNew(2,title,body,id);
                                                    showDialog(context: context,builder:(_) => alert);
                                                    // titleCon.text = title;
                                                    // noteCon.text = body;
                                                    // selectedNoteId = id;
                                                    // readOnly = true;
                                                    // isEdit = true;
                                                    // noteVisible = true;
                                                  }
                                                  else{
                                                    titleCon.text = title;
                                                    noteCon.text = body;
                                                    selectedNoteId = id;
                                                    readOnly = true;
                                                    isEdit = true;
                                                    noteVisible = true;
                                                  }                                           
                                                });
                                              },
                                              child: allNotes(index1,title,body,id),
                                            ) : allNotes(index1,title,body,id),
                                          );
                                        },
                                        staggeredTileBuilder: (int index) =>
                                          new StaggeredTile.count(2, index.isEven ? 2 : 1),
                                        mainAxisSpacing: 4.0,
                                        crossAxisSpacing: 4.0,
                                      ),
                                    );
                                  }
                                }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  Widget allNotes(int index1,String title,String body,int id){
    return Card(
      color: Colors.blueGrey[700],
      //setColor(index1),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:8.0,right:8.0),
                child: Visibility(
                  visible: visibleMultiselectIcon,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: multiSelectController.isSelected(index1)
                            ? Icon(
                                Icons.check,
                                size: 16.0,
                                color: Colors.black,
                              )
                            : Icon(
                                Icons.check_box_outline_blank,
                                size: 16.0,
                                color: Colors.black54,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:5.0,left: 2.0,right: 2.0),
                child: ListTile(
                  title: Text(title,
                    style: TextStyle(
                        color: Colors.transparent,
                        shadows: [
                          Shadow(
                            color: Colors.white,
                            offset: Offset(0,-5)
                          ),
                        ],
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue[50],
                        decorationThickness: 2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(left:4.0,top: 6.0,bottom: 24.0),
                    child: Text(body,style: TextStyle(color: Colors.white,fontSize: 14.0),overflow: TextOverflow.ellipsis),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

class TopContainerLandscape extends StatefulWidget {
  Widget player;
  TopContainerLandscape(this.player);
  @override
  _TopContainerLandscapeState createState() => _TopContainerLandscapeState();
}

class _TopContainerLandscapeState extends State<TopContainerLandscape> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: widget.player
      ),
    );
  }
}