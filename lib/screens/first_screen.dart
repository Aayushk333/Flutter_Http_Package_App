import 'package:flutter/material.dart';
import 'package:http_package/models/news_item_class.dart';
import 'package:http_package/services/news_provider.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var stories = List<NewsItem>();
  @override 
  void initState(){
    super.initState();
    getNewsList();
  }


  getNewsList() async{
    final newsList = await getHotNewsIds()
    .then((ids)=>ids.take(20).map((id)async=>await getNewsItem(id)));
    print(newsList);
    List<NewsItem> newsitems = await Future.wait(newsList);
    setState((){
      this.stories.addAll(newsitems);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FlutterLearn HackerNews"),
        elevation: 0.7,
      ),
      body: ListView.builder(
        itemCount: stories.length,
        itemBuilder: (context,index){
              final item = stories[index];
              return ListTile(title: Text(item.title),
              subtitle: Text(item.author),
              );



        }

      )
      
      
    );
  }
}

