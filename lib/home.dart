import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_box/addRecipe.dart';
import 'package:recipe_box/editRecipe.dart';


class Home extends StatelessWidget {

  final ref = FirebaseFirestore.instance.collection('recipes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Screen',
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),
        onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>AddRecipe()));
        },),
      body: StreamBuilder(
        stream: ref.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: snapshot.hasData?snapshot.data.docs.length:0,
              itemBuilder: (_,index){
            return GestureDetector(

              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>EditRecipe(docToEdit: snapshot.data.docs[index],)));
              },
              child: Container(
                margin: EdgeInsets.all(10),
                height: 150,
                color: Colors.grey[200],
                child: Column(
                  children: [
                    Text(snapshot.data.docs[index].data()['title']),
                    Text(snapshot.data.docs[index].data()['content'])
                  ],
                ),
              ),
            );
              });
        }
      )
    );
  }
}