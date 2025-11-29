import 'package:flutter/material.dart';
import 'package:hackathon_app/constants/app_size.dart';

///
/// 音量を上げることを促すダイアログ
///
class VolumeUpDialog extends StatelessWidget {
  const VolumeUpDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // ダイアログの角丸はThemeで設定済み
      contentPadding: const EdgeInsets.all(AppSize.xm),
      // ダイアログのコンテンツ
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'もっと大きな声で！',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: AppSize.md,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 2,
            child: Image.asset('assets/images/chara/cat_volume_up.png'),
          ),
        ],
      ),
    );
  }
}
