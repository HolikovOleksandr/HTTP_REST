import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/item_card.dart';
import '../http_helper.dart';

class PostList extends StatelessWidget {
  PostList({super.key});
  final Future<List<Map>> _futurePost = HTTPHelper().fetchItem();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: FutureBuilder<List<Map>>(
        future: _futurePost,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //Check foe errors
          if (snapshot.hasError) {
            return Center(
              child: Text('Error ${snapshot.error}'),
            );
          }
          //Has data arrived
          if (snapshot.hasData) {
            var posts = snapshot.data;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                var thisItem = posts[index];
                return ItemCard(
                  title: '${thisItem['title']}',
                  subtitle: '${thisItem['body']}',
                );
              },
            );
          }
          //Display a loader
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
