import 'package:equatable/equatable.dart';

sealed class const StandardHttpExampleState() with Equatable {
  @override
  List<Object?> get props => [];
}

class const StandardHttpExampleInitial() extends StandardHttpExampleState;

class const StandardHttpExampleLoading() extends StandardHttpExampleState;

class const StandardHttpExampleReceivingData({
  required final List<String> numbers,
}) extends StandardHttpExampleState {
  @override
  List<Object?> get props => [numbers];
}

class const StandardHttpExampleCompleted({required final List<String> numbers})
    extends StandardHttpExampleState {
  @override
  List<Object?> get props => [numbers];
}

class const StandardHttpExampleError({required final String message})
    extends StandardHttpExampleState {
  @override
  List<Object?> get props => [message];
}
