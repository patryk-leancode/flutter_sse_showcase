import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sse_showcase/features/examples/shapes_and_colors/color_utils.dart';
import 'package:flutter_sse_showcase/features/examples/shapes_and_colors/shapes_and_colors_state.dart';
import 'package:flutter_sse_showcase/models/api/color_change_event.dart';
import 'package:flutter_sse_showcase/models/api/shape_change_event.dart';
import 'package:flutter_sse_showcase/models/api/sse_event.dart';
import 'package:flutter_sse_showcase/services/sse_service/sse_service.dart';

class ShapesAndColorsCubit({required final SseService _sseService})
    extends Cubit<ShapesAndColorsState> {
  this : super(const ShapesAndColorsInitial());

  StreamSubscription<SseEvent>? _streamSubscription;

  static const ShapesAndColorsReceivingData _initialData =
      ShapesAndColorsReceivingData(
        shape: 'square',
        size: 100,
        color: Color(0xFFFF6666),
        intensity: 'medium',
      );

  Future<void> startStreaming() async {
    await _streamSubscription?.cancel();

    try {
      emit(_initialData);

      _streamSubscription = _sseService.streamShapesAndColors().listen(
        (sseEvent) {
          if (sseEvent.event == 'change_shape') {
            final jsonData = jsonDecode(sseEvent.data) as Map<String, dynamic>;
            final shapeChangeEvent = ShapeChangeEvent.fromJson(jsonData);
            final newState = state.copyWith(
              shape: shapeChangeEvent.shape,
              size: shapeChangeEvent.size,
            );
            emit(newState);
          } else if (sseEvent.event == 'change_color') {
            final jsonData = jsonDecode(sseEvent.data) as Map<String, dynamic>;
            final colorChangeEvent = ColorChangeEvent.fromJson(jsonData);
            final newState = state.copyWith(
              color: ColorUtils.getColor(
                colorChangeEvent.color,
                colorChangeEvent.intensity,
              ),
              intensity: colorChangeEvent.intensity,
            );
            emit(newState);
          }
        },
        onError: (Object error) {
          emit(ShapesAndColorsError(message: error.toString()));
        },
        cancelOnError: false,
      );
    } catch (err) {
      emit(ShapesAndColorsError(message: err.toString()));
    }
  }

  Future<void> refreshData() async {
    await startStreaming();
  }

  void clearData() {
    emit(const ShapesAndColorsInitial());
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
