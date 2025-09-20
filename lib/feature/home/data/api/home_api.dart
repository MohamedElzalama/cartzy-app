import 'dart:convert';

import 'package:cartzy_app/core/network/network.dart';
import 'package:cartzy_app/feature/home/data/model/response/category_response_dto.dart';
import 'package:cartzy_app/feature/home/data/model/response/product_response_dto.dart';
import 'package:http/http.dart' as http;

class HomeApi {
  HomeApi._();
  static HomeApi? _instance;
  static HomeApi get instance => _instance ??= HomeApi._();

  Future<NetworkResult<List<CategoryResponseDto>>> getCategories() async {
    //https://api.escuelajs.co/api/v1/categories/
    try {
      Uri url = Uri.https("api.escuelajs.co", "/api/v1/categories/");
      var response = await http.get(url);
      var json = jsonDecode(response.body) as List;
      return NetworkSuccess(
        (json).map((e) => CategoryResponseDto.fromJson(e)).toList(),
      );
    } catch (e) {
      return NetworkError(e.toString());
    }
  }

  Future<NetworkResult<List<ProductResponseDto>>> getProducts(
      int? categoryId) async {
    try {
      Uri url;
      if (categoryId != null) {
        //https://api.escuelajs.co/api/v1/products/
        url = Uri.https(
            "api.escuelajs.co", "/api/v1/categories/$categoryId/products");
      } else {
        //https: //api.escuelajs.co/api/v1/categories/2/products
        url = Uri.https("api.escuelajs.co", "/api/v1/products/");
      }
      var response = await http.get(url);
      var json = jsonDecode(response.body) as List;
      return NetworkSuccess(
        (json).map((e) => ProductResponseDto.fromJson(e)).toList(),
      );
    } catch (e) {
      return NetworkError(e.toString());
    }
  }
}
