import 'package:equatable/equatable.dart';

sealed class const StandardHttpExampleState2() extends Equatable {
  @override
  List<Object?> get props => [];
}

class const StandardHttpExampleInitial() extends StandardHttpExampleState2;

class const StandardHttpExampleLoading() extends StandardHttpExampleState2;

class const StandardHttpExampleReceivingData({
  required final List<String> numbers,
}) extends StandardHttpExampleState2 {
  @override
  List<Object?> get props => [numbers];
}

class const StandardHttpExampleCompleted({required final List<String> numbers})
    extends StandardHttpExampleState2 {
  @override
  List<Object?> get props => [numbers];
}

class const StandardHttpExampleError({required final String message})
    extends StandardHttpExampleState2 {
  @override
  List<Object?> get props => [message];
}
