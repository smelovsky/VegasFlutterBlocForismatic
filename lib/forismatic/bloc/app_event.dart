part of 'app_bloc.dart';

sealed class AppEvent {
  const AppEvent();
}

final class AppEventSetLang extends AppEvent {
  AppEventSetLang({required this.lang});
  int lang;
}

final class AppEventSendRequestGet extends AppEvent {
  AppEventSendRequestGet();
}