import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  String keyword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gallery'), backgroundColor: Colors.green,),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: 'Type a keyword ...'),
              onChanged: (value){
                setState(() {
                  this.keyword = value;
                });
              },
              onSubmitted: (value) {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GalleryData(value)));
              },
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GalleryData(this.keyword)));
                },
                color: Colors.green,
                textColor: Colors.white,
                child: Text('Get Images'),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class GalleryData extends StatefulWidget {
  String keyword;

  GalleryData(this.keyword);

  @override
  _GalleryDataState createState() => _GalleryDataState();
}

class _GalleryDataState extends State<GalleryData> {
  List<dynamic> data;
  int currentPage = 1;
  int pageSize = 10;
  int totalPages = 0;
  ScrollController _scrollController = new ScrollController();
  dynamic dataGallery;
  List<dynamic> hits = new List();

  getData(url) {
    http.get(url).then((resp) {
      setState(() {
        dataGallery = json.decode(resp.body);
        hits.addAll(dataGallery['hits']);
        if((dataGallery['totalHits'] % this.pageSize) == 0)
          this.totalPages = dataGallery['totalHits']~/this.pageSize;
        else this.totalPages = 1+(dataGallery['totalHits']/this.pageSize).floor();
      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  void initState() {
    super.initState();
    this.loadData();
    this._scrollController.addListener((){
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if(currentPage < totalPages) {
          ++currentPage;
          this.loadData();
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void loadData() {
    String url="https://pixabay.com/api/?key=15652428-85cdfd2466fd69376e375cf15&q=${widget.keyword}&page=$currentPage&per_page=$pageSize";
    print(url);
    this.getData(url);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: (hits == null)?Text('Gallery'):Text('${widget.keyword} : $currentPage/$totalPages'), backgroundColor: Colors.green,),
      body: (hits == null)?Center(
        child: CircularProgressIndicator(),
      )
          :ListView.builder(
          controller: _scrollController,
          itemCount: hits.length,
          itemBuilder: (context, index){
            return Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    color: Colors.lightGreen,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                          '${hits[index]['tags']}',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)
                      ),
                    ),
                  ),
                  Image(
                    image: NetworkImage('${hits[index]['webformatURL']}'),
                  )
                ],
              ),
            );
          }
      )
    );
  }

}


