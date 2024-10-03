import 'package:clean_architecture/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../constant/link.dart';

class CrudDio {
  late Dio dio;

  CrudDio() {
    BaseOptions options = BaseOptions(
      baseUrl: AppLinkUrl.baseUrl,
      receiveDataWhenStatusError: true,
      sendTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );
    dio = Dio(options);
  }

  Future<Either<Failure, List>> dioGetMethod({
    required String endPoint,
    @required String? token,
    @required Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      if (token != null) {
        headers.addAll({'Authorization': 'Bearer $token'});
      }
      if (kDebugMode) {
        print(
          '''
          url = $endPoint ,
          token = $token , 
          header = $headers ,
          query parameter = $queryParameters
          ''',
        );
      }
      var response = await dio.get(
        endPoint,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      if (kDebugMode) {
        print('Status Code : ${response.statusCode}');
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        List responseBody = response.data;
        return Right(responseBody);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List>> dioPostMethod({
    required String endPoint,
    required Map data,
    @required String? token,
    @required Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      if (token != null) {
        headers.addAll({'Authorization': 'Bearer $token'});
      }
      if (kDebugMode) {
        print(
          '''
          body = $data ,
          url = $endPoint ,
          token = $token , 
          header = $headers ,
          query parameter = $queryParameters
          ''',
        );
      }
      var response = await dio.post(
        endPoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        List responsebody = response.data;
        return Right(responsebody);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List>> dioPutMethod({
    required String endPoint,
    @required Map? data,
    @required String? token,
    @required Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      if (token != null) {
        headers.addAll({'Authorization': 'Bearer $token'});
      }
      if (kDebugMode) {
        print(
          '''
          body = $data ,
          url = $endPoint ,
          token = $token , 
          header = $headers ,
          query parameter = $queryParameters
          ''',
        );
      }
      var response = await dio.put(
        endPoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        List responsebody = response.data;
        return Right(responsebody);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List>> dioPatchMethod({
    required String endPoint,
    @required Map? data,
    @required String? token,
    @required Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      if (token != null) {
        headers.addAll({'Authorization': 'Bearer $token'});
      }
      if (kDebugMode) {
        print(
          '''
          body = $data ,
          url = $endPoint ,
          token = $token , 
          header = $headers ,
          query parameter = $queryParameters
          ''',
        );
      }
      var response = await dio.patch(
        endPoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        List responsebody = response.data;
        return Right(responsebody);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List>> dioDeleteMethod({
    required String endPoint,
    @required Map? data,
    @required String? token,
    @required Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      if (token != null) {
        headers.addAll({'Authorization': 'Bearer $token'});
      }
      if (kDebugMode) {
        print(
          '''
          body = $data ,
          url = $endPoint ,
          token = $token , 
          header = $headers ,
          query parameter = $queryParameters
          ''',
        );
      }
      var response = await dio.delete(
        endPoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        List responsebody = response.data;
        return Right(responsebody);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
