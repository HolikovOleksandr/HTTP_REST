import 'dart:convert';

import 'package:http/http.dart' as http;

class HTTPHelper {
  //--Fetching all items
  Future<List<Map>> fetchItem() async {
    List<Map> items = [];

    //Get the data from the API
    http.Response response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (response.statusCode == 200) {
      //Get the data from the response
      var jsonString = response.body;
      //Convert to List<Map>
      List data = jsonDecode(jsonString);
      items = data.cast<Map>();
    }

    return items;
  }

  //--Fetching details of one item
  Future<Map> getItem(itemId) async {
    Map item = {};

    //Get tne item from the API
    http.Response response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$itemId'),
    );

    if (response.statusCode == 200) {
      //Get the data from the response
      var jsonString = response.body;
      //Convert to List<Map>
      item = jsonDecode(jsonString);
    }

    return item;
  }

  //--Add a new item
  Future<bool> addItem(Map data) async {
    bool status = false;

    //Get tne item from the API
    http.Response response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      body: jsonEncode(data),
      headers: {'contrnt-type': 'application/json'},
    );

    if (response.statusCode == 200) {
      status = response.body.isNotEmpty;
    }

    return status;
  }

  //--Update item
  Future<bool> updateItem(Map data, String itemId) async {
    bool status = false;

    //Update the item, call the api
    http.Response response = await http.put(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$itemId'),
      body: jsonEncode(data),
      headers: {'contrnt-type': 'application/json'},
    );

    if (response.statusCode == 200) {
      status = response.body.isNotEmpty;
    }

    return status;
  }

  //--Delete item
  Future<bool> deleteItem(String itemId) async {
    bool status = false;

    http.Response response = await http.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$itemId'),
    );

    if (response.statusCode == 200) status = true;

    //Delete item from the db
    return status;
  }
}
