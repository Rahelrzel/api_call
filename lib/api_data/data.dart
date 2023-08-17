import 'dart:async';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'data.g.dart';

FutureOr<List<dynamic>> getData() async {
  var dio = Dio();
  dio.interceptors.add(PrettyDioLogger());
  var response = await dio.get('https://dummyjson.com/products');

  var data = response.data;
  List<dynamic> dataList = data['products'];
  return dataList;
}

@riverpod
FutureOr<List<dynamic>> products(Ref ref) {
  return getData();
}
