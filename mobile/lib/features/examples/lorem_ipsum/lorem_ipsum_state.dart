import 'package:equatable/equatable.dart';

sealed class const LoremIpsumState() extends Equatable {
  @override
  List<Object?> get props => [];
}

class const LoremIpsumInitial() extends LoremIpsumState;

class const LoremIpsumLoading() extends LoremIpsumState;

class const LoremIpsumReceivingData({
  required final String text,
  required final int charactersSent,
  required final int charactersRemaining,
}) extends LoremIpsumState {
  @override
  List<Object?> get props => [text, charactersSent, charactersRemaining];
}

class const LoremIpsumCompleted({
  required final String text,
  required final int charactersSent,
}) extends LoremIpsumState {
  @override
  List<Object?> get props => [text, charactersSent];
}

class const LoremIpsumError({required final String message})
    extends LoremIpsumState {
  @override
  List<Object?> get props => [message];
}
