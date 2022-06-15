import 'package:flutter/material.dart';
import 'package:wasteagram/models/waste_item.dart';

class DetailScreen extends StatelessWidget
{

  DetailScreen({Key? key, required this.item}) : super(key: key);

  WasteItem item;

  @override
  Widget build(BuildContext context) {

      return Scaffold(
        appBar: AppBar(
          title: Text('Detail Screen'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                item.date!,
                style: Theme.of(context).textTheme.headline4
              ),
              Image.network(
                item.imageURL!,
                height: 300,
              ),
              Text(
                'Waste Items: ${item.quantity.toString()}',
                style: Theme.of(context).textTheme.headline5),
              Text('Latitude: ${item.latitude.toString()} Longitude: ${item.longitude.toString()}')
            ],
          ),
        ),
      );
    //}
  }
}