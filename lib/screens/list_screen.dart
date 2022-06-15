import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wasteagram/models/waste_item.dart';
import 'detail_screen.dart';
import 'new_post_screen.dart';

class ListScreen extends StatefulWidget {
  ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  WasteItem? item;
  List<WasteItem> items = [];

  int count = 0;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wasteagram'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('wasteItems').snapshots(),
        builder: (content, snapshot) {
          if(snapshot.hasData && snapshot.data!.docs != null && snapshot.data!.docs.length > 0) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var post = snapshot.data!.docs[index];
                item = WasteItem(
                  imageURL: post['imageURL'],
                  date: post['date'],
                  latitude: post['latitude'],
                  longitude: post['longitude'],
                  quantity: post['quantity']
                );
                  items.add(item!);
                return ListTile(
                  leading: Text(
                    item!.date!,
                    style: Theme.of(context).textTheme.headline5
                  ),
                  trailing: Text(
                    item!.quantity.toString(), 
                    style: Theme.of(context).textTheme.headline4
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => DetailScreen(item: items[index])
                      )
                    );
                  },
                );
              }
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_photo_alternate),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NewPostScreen()));
        }
      )
    );
  }
}
