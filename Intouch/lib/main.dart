import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    Myapp(),
  );
}

class Myapp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  String? data;
  var news;

  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    http.Response response = await http
        .get(Uri.parse("https://inshortsapi.vercel.app/news?category=all"));

    if (response.statusCode == 200) {
      data = response.body;
      setState(() {
        news = jsonDecode(data!)['data'];
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("INTOUCH"),
        actions: [
          Padding(
            padding: EdgeInsets.all(0.5),
            child: Icon(Icons.account_circle),
          ),
          Padding(
            padding: EdgeInsets.all(0.5),
            child: Icon(Icons.lock),
          ),
          Padding(
            padding: EdgeInsets.all(0.5),
            child: Icon(Icons.settings),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: news.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                child: Column(children: [
              ListTile(
                leading: Icon(Icons.arrow_drop_down_circle),
                title: Text(news[index]['title']),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(news[index]['content']),
              ),
              Image.network(
                news[index]['imageUrl'],
                fit: BoxFit.fill,
                width: double.infinity,
                height: 300,
                alignment: Alignment.center,
              ),
            ]));
          }),
      drawer: Drawer(
        child: Column(children: [
          UserAccountsDrawerHeader(
            accountName: Text("Jayesh Pansuriya"),
            accountEmail: Text("JD@INTOUCH.IN"),
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text("Live News"),
          ),
          ListTile(
            leading: Icon(Icons.next_plan),
            title: Text("Latest News "),
          ),
          ListTile(
            leading: Icon(Icons.gps_fixed),
            title: Text("National news "),
          ),
          Divider(
            height: 0.1,
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text("yesterday news"),
          ),
          ListTile(
            leading: Icon(Icons.wallet),
            title: Text("Wallet Balance"),
          ),
          Divider(
            height: 0.1,
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text("Login"),
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text("Create Account"),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.home),
        onPressed: () {
          print("Go to home");
        },
      ),
    );
  }
}
