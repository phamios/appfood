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
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Widget'),
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
        // Encode the url
        Uri.encodeFull("https://cookapi.vinmart.com/api/menus/get"),
        // Only accept JSON response
        headers: {"Accept": "application/json","ProvinceCode":"HAN"}
    );

    setState(() {
      // Get the JSON data
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
      body: _buildListViewHorizonal(),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (context, index) {
        return _buildImageColumn(data[index]);
        //return _buildRow(data[index]);
      }
    );
  }

   Widget _buildListViewHorizonal() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (context, index) {
        return _buildrowslide(data[index]);
        
      }
    );
  }

  Widget _buildImageColumn(dynamic item) => Container(
      decoration: BoxDecoration(
        color: Colors.white54
      ),
      margin: const EdgeInsets.all(1),
      child: Column(
        children: [
          new CachedNetworkImage(
            imageUrl: item['thumbnail'],
            placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
            fadeOutDuration: new Duration(seconds: 1),
            fadeInDuration: new Duration(seconds: 3),
          ),
          _buildRow(item)
        ],
      ),
    );

  Widget _buildRow(dynamic item) {
    return ListTile(
      title: Text(
        item['itemName'] == null ? '': item['itemName'],
      ),
      subtitle: Text("Giá: " + item['unitPrice'].toString()),
    );
  }



  Widget _buildrowslide(dynamic item){
    return Card(
        child: ListTile(
          title: Text(
          item['itemName'] == null ? '': item['itemName'],), 
          subtitle: Text("Giá: " + item['unitPrice'].toString()
          ),
      ),
      );
  }


  @override
  void initState() {
    super.initState();
    // Call the getJSONData() method when the app initializes
    this.getJSONData();
  }
}
