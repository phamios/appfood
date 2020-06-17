import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'WinmartCook'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List data;

  // Function to get the JSON data
  Future<String> getJSONData() async {
    var response = await http.get(
        Uri.encodeFull("https://cookapi.vinmart.com/api/menus/get"),
        headers: {"Accept": "application/json","ProvinceCode":"HAN"}
    );

    setState(() {
      data = json.decode(response.body)['result'][0]['items'];
    });

    return "Successfull";
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // body: _buildListView(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Khu vực hiện tại: Hà Nội',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 80.0,
              child: _buildListView(data),
            ),
           
            Text(
              'Danh sách món ăn hôm nay',
              style: TextStyle(fontSize: 18),
            ),
            Card(
              child: ListTile(title: Text('Motivation $int'), subtitle: Text('this is a description of the motivation')),
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _buildListView(dynamic item) {
    return Expanded(
      child: 
        ListView.builder(
              shrinkWrap: true,
              
              scrollDirection: Axis.horizontal,
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) => InkWell(
                    onTap: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SecondRoute()),
                    );
                    },
                    child: Center(
                      child:  new CachedNetworkImage(
                          imageUrl: data[index]['thumbnail'],
                          placeholder: (context, url) => new CircularProgressIndicator(),
                          errorWidget: (context, url, error) => new Icon(Icons.error),
                          fadeOutDuration: new Duration(seconds: 1),
                          fadeInDuration: new Duration(seconds: 3),
                        ),  
                      ),  
                  ), 
            ),
    );
  }
 

  // Widget _buildImageColumn(dynamic item) => Container(
  //     decoration: BoxDecoration(
  //       color: Colors.white54
  //     ),
  //     margin: const EdgeInsets.all(1),
  //     child: Column(
  //       children: [
  //         new CachedNetworkImage(
  //           imageUrl: item['thumbnail'],
  //           placeholder: (context, url) => new CircularProgressIndicator(),
  //           errorWidget: (context, url, error) => new Icon(Icons.error),
  //           fadeOutDuration: new Duration(seconds: 1),
  //           fadeInDuration: new Duration(seconds: 3),
  //         ),
  //         _buildRow(item)
  //       ],
  //     ),
  //   );

  Widget _buildRow(dynamic item) {
    return ListTile(
      title: Text(
        item['itemName'] == null ? '': item['itemName'],
      ),
      subtitle: Text("Giá: " + item['unitPrice'].toString()),
    );
  }
 
  @override
  void initState() {
    super.initState();
    // Call the getJSONData() method when the app initializes
    this.getJSONData();
  }
}


class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}