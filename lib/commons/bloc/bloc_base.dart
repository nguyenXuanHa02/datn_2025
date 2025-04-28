import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum BaseStateEntry { init, loading, success, fail }

sealed class BaseState<T> extends Equatable {
  final BaseStateEntry state;
  final T? data;

  const BaseState(this.state, this.data);

  @override
  List<Object?> get props => [state, data];
}

class InitialState<T> extends BaseState<T> {
  const InitialState() : super(BaseStateEntry.init, null);
}

sealed class BaseEvent {}

// class Submit
class UpdateField extends BaseEvent {
  final String key;
  final dynamic data;
  UpdateField(this.key, this.data);
}

class BaseBloc<T> extends Bloc<BaseEvent, BaseState<T>> {
  final String urlEndpoint;
  Map<String, dynamic> fields = {};
  BaseBloc(this.urlEndpoint, {Map<String, dynamic>? initFields})
      : super(InitialState<T>()) {
    if (initFields != null) {
      this.fields = initFields;
    }
  }
}
