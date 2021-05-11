import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditRecipe extends StatefulWidget {

  DocumentSnapshot docToEdit;
  EditRecipe({this.docToEdit});

  @override
  _EditRecipeState createState() => _EditRecipeState();
}

class _EditRecipeState extends State<EditRecipe> {

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  @override
  void initState() {
    title = TextEditingController(text: widget.docToEdit.data()['title']);
    content = TextEditingController(text: widget.docToEdit.data()['content']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(onPressed: () {
              widget.docToEdit.reference.update({
                'title': title.text,
                'content': content.text
              }).whenComplete(() => Navigator.pop(context));
            }, child: Text('Save')),
            TextButton(onPressed: () {
              widget.docToEdit.reference.delete().whenComplete(() =>
                  Navigator.pop(context));
            }, child: Text('Delete'))
          ],
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: title,
                  decoration: InputDecoration(hintText: 'Title'),
                ),
              ),
              SizedBox(height: 10,),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: TextField(
                    controller: content,
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(hintText: 'Content'),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
