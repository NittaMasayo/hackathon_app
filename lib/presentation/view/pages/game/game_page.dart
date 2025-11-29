import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackathon_app/constants/routes/app_routes.dart';
import 'package:hackathon_app/constants/theme/app_colors.dart';
import 'package:hackathon_app/presentation/view/pages/game/components/heart_beat_wave.dart';
import 'package:hackathon_app/presentation/view_model/game/game_timer.dart';
import 'package:hackathon_app/presentation/view_model/game/shake_manager.dart';

///
/// ゲーム画面
///
class GamePage extends StatefulWidget {
  const GamePage({super.key});
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static const double _optimalBpm = 120;

  // マネージャーとコントローラーを late final で宣言
  late final HeartbeatWaveController _heartbeatController;
  late final CountdownManager _countdownManager;
  late final ShakeManager _shakeManager;

  // 状態変数
  int _countDown = 0; // 成功回数

  @override
  void initState() {
    super.initState();
    _heartbeatController = HeartbeatWaveController();

    void isSuccess() {
      setState(() {
        _countDown++;
      });
    }

    void checkCondition(int currentTime) {
      if (!mounted) return;

      if (currentTime <= 40 && _countDown == 0) {
        _countdownManager.stopAndFinish();
      }
    }

    void navigateToResult(int remainingSeconds) {
      if (mounted) {
        context.go(AppRoutes.result, extra: (remainingSeconds, _countDown));
      }
    }

    _countdownManager = CountdownManager(
      onFinished: () => navigateToResult(60),
      onForcedStop: navigateToResult,
      onTick: checkCondition,
    );

    _shakeManager = ShakeManager(
      controller: _heartbeatController,
      successFunc: isSuccess,
    );

    // --- ゲーム開始処理 ---
    _countdownManager.start();
    _shakeManager.gameStart();
  }

  // リソースを解放するために dispose をオーバーライド
  @override
  void dispose() {
    // タイマーをキャンセル
    unawaited(_shakeManager.dispose());
    _countdownManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // buildメソッド内ではインスタンスの生成やタイマー開始は行わない
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            // 左側: HeartbeatWave
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: HeartbeatWave(
                  bpm: _optimalBpm,
                  waveColor: AppColors.azureBlue,
                  controller: _heartbeatController,
                ),
              ),
            ),
            // 右側: deepSpaceBlue色のボックス (タップ処理)
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _heartbeatController.triggerPulse();
                },
                child: Container(
                  color: AppColors.deepSpaceBlue,
                  child: Center(
                    child: Column(
                      // カウントを表示するためにColumnでラップ
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'ここに手をおいてね！',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
