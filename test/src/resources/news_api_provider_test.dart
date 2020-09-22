import 'package:flutter_news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('fetchTopIds returns a list of Ids', () {
    //setup of Test cases

    final sum = 1 + 3;

    //expectations
    expect(sum, 4);
  });
}
