import 'package:http/http.dart' as http;
import 'package:LangkahApp/Classes/article_model.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class News {
  List<Article> news = new List<Article>();
  // DateTime _now;
  // _now = new DateTime.now();
  Future<void> getNews() async {
    String url =
        "http://newsapi.org/v2/top-headlines?q=covid&category=health&country=my&apiKey=c1249f02ac474876b4f15979ad6f3806";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null &&
            element['description'] != null &&
            element['content'] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
  }
}
