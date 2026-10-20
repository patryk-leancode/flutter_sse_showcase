import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class const ShapesAndColorsState() with Equatable {
  ShapesAndColorsState copyWith({
    String? shape,
    int? size,
    Color? color,
    String? intensity,
  });

  @override
  List<Object?> get props => [];
}

class const ShapesAndColorsInitial() extends ShapesAndColorsState {
  @override
  ShapesAndColorsState copyWith({
    String? shape,
    int? size,
    Color? color,
    String? intensity,
  }) {
    return const ShapesAndColorsInitial();
  }
}

class const ShapesAndColorsLoading() extends ShapesAndColorsState {
  @override
  ShapesAndColorsState copyWith({
    String? shape,
    int? size,
    Color? color,
    String? intensity,
  }) {
    return const ShapesAndColorsLoading();
  }
}

class const ShapesAndColorsReceivingData({
  required final String shape,
  required final int size,
  required final Color color,
  required final String intensity,
}) extends ShapesAndColorsState {
  @override
  ShapesAndColorsReceivingData copyWith({
    String? shape,
    int? size,
    Color? color,
    String? intensity,
  }) {
    return ShapesAndColorsReceivingData(
      shape: shape ?? this.shape,
      size: size ?? this.size,
      color: color ?? this.color,
      intensity: intensity ?? this.intensity,
    );
  }

  @override
  List<Object?> get props => [shape, size, color, intensity];
}

class const ShapesAndColorsError({required final String message})
    extends ShapesAndColorsState {
  @override
  ShapesAndColorsState copyWith({
    String? shape,
    int? size,
    Color? color,
    String? intensity,
  }) {
    return ShapesAndColorsError(message: message);
  }

  @override
  List<Object?> get props => [message];
}
