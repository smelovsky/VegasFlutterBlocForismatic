import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vegas_flutter_bloc_forismatic/forismatic/bloc/forismatic.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc()
      : super( AppStateInitial(_lang, getUrl(), _forismatic, _author, _error)) {

    on<AppEventSetLang>(_onSetLang);
    on<AppEventSendRequestGet>(_onSendRequestGet);
  }

  static  int _lang = 1;
  static  String _forismatic = "";
  static  String _author = "";
  static  String _error = "";

  static  String getUrl() {
    return (_lang == 0) ?
      'https://api.forismatic.com/api/1.0/?method=getQuote&format=json&lang=en':
      'https://api.forismatic.com/api/1.0/?method=getQuote&format=json&lang=ru';
  }

  @override
  Future<void> close() {
    return super.close();
  }

  void _onSetLang(AppEventSetLang event, Emitter<AppState> emit) {
    _lang = event.lang;
    emit(AppStateInitial(_lang, getUrl(), _forismatic, _author, _error));
  }

  void _onSendRequestGet(AppEventSendRequestGet event, Emitter<AppState> emit) {

    print("_onSendRequestGet");

    _sendRequestGet();
  }

 void _sendRequestGet() {

    int status = 0;

    final uri = Uri.parse(getUrl());

    http.get(uri).then((response){

      status = response.statusCode;

      print(utf8.decode(response.bodyBytes));

      var forismatic =  Forismatic.fromJson(json.decode(utf8.decode(response.bodyBytes)));

      _forismatic = forismatic.quoteText;
      _author = forismatic.quoteAuthor;

      if (status == 200) {
        emit(AppStateResult(_lang, getUrl(), _forismatic, _author, _error));
      } else {
        _error = "Error code: ${status}";
        emit(AppStateError(_lang, getUrl(), _forismatic, _author, _error));
      }

      print("forismatic: ($status) ${forismatic.quoteText}");

    }).catchError((error){

      print("forismatic: ERROR");

      _error = error.toString();

      emit(AppStateError(_lang, getUrl(), _forismatic, _author, _error));

      });//reBuildWidget

  }

}