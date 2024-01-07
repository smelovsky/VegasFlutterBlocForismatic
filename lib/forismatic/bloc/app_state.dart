part of 'app_bloc.dart';

sealed class AppState extends Equatable {
  const AppState(this.lang, this.url, this.forismatic, this.author, this.error);

  final int lang;
  final String url;
  final String forismatic;
  final String author;
  final String error;

  @override
  List<Object> get props => [lang, forismatic, error];
}

final class AppStateInitial extends AppState {
  const AppStateInitial(super.lang, super.url, super.forismatic, super.author, super.erorr);

  @override
  String toString() => 'AppStateInitial { $lang  $url $forismatic }';
}

final class AppStateResult extends AppState {
  const AppStateResult(super.lang, super.url, super.forismatic, super.author, super.erorr);

  @override
  String toString() => 'AppStateResult { $lang  $url $forismatic }';
}

final class AppStateError extends AppState {
  const AppStateError(super.lang, super.url, super.forismatic, super.author, super.erorr);

  @override
  String toString() => 'AppStateError { $error }';
}