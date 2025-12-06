import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import 'talker.dart';

part 'http_client.g.dart';

const String _baseUrl =
    'https://raw.githubusercontent.com/WesselvanDam/carbon-guessr-app/refs/heads/main/data/api';

@Riverpod(keepAlive: true)
Dio httpClient(Ref ref) {
  final dio = Dio();

  dio.options.baseUrl = _baseUrl;

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) => handler.next(options),
      onResponse: (response, handler) {
        if (response.data is String && (response.data as String).isNotEmpty) {
          try {
            response.data = jsonDecode(response.data as String);
          } catch (e) {
            // Handle JSON parse error
            debugPrint('Failed to parse JSON response: $e');
          }
        }
        return handler.next(response);
      },
    ),
  );
  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(printResponseData: false),
    ),
  );

  ref.onDispose(() => dio.close());

  return dio;
}
