import 'dart:async';
import 'dart:ui';

import 'package:hackathon_app/presentation/view/pages/game/components/heart_beat_wave.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vibration/vibration.dart';

///
/// 押す動作を検知するクラス
///
class ShakeManager {
  bool _movingDown = false;
  final double _threshold = 2.0;
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;

  ShakeManager({required this.controller, required this.successFunc});
  final HeartbeatWaveController controller;
  final VoidCallback successFunc;

  void gameStart() {
    if (_accelerometerSubscription != null) {
      _accelerometerSubscription = null;
    }
    // ignore: deprecated_member_use
    _accelerometerSubscription = accelerometerEvents.listen((event) async {
      double z = event.z;

      // 下方向に動いた
      if (!_movingDown && z < -_threshold) {
        _movingDown = true;

        // 下方向に動いたときだけバイブ
        if (await Vibration.hasVibrator()) {
          // 短く強く震える
          await Vibration.vibrate(
            pattern: [0, 120, 60, 120],
            intensities: [255, 255],
          );
          controller.triggerPulse();
        }
        successFunc();
      }

      // 上方向に戻ったらカウント
      if (_movingDown && z > _threshold) {
        _movingDown = false;
        controller.triggerPulse();
      }
    });
  }

  Future<void> dispose() async {
    // ★ センサーの購読をキャンセルし、ストリームを停止
    await _accelerometerSubscription?.cancel();
    _accelerometerSubscription = null;
  }
}
