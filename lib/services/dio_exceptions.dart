import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Запрос к серверу API был отменен";
        break;
      case DioErrorType.connectionTimeout:
        message = "Тайм-аут соединения с API-обслуживанием";
        break;
      case DioErrorType.unknown:
        message =
            "Не удалось подключиться к серверу API из-за подключения к Интернету";
        break;
      case DioErrorType.receiveTimeout:
        message = "Тайм-аут получения в связи с сервером API";
        break;
      case DioErrorType.badResponse:
        message = _handleError(
            dioError.response!.statusCode!, dioError.response!.data);
        break;
      case DioErrorType.sendTimeout:
        message = "Тайм-аут отправки в связи с сервером API";
        break;
      default:
        message = "Что-то пошло не так";
        break;
    }
  }

  late String message;

  String _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Данные были введены неверно';
      case 404:
        return error["message"];
      case 500:
        return 'Внутренняя ошибка сервера';
      default:
        return 'Упс! Что-то пошло не так';
    }
  }

  @override
  String toString() => message;
}
