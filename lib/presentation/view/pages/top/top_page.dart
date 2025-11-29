import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackathon_app/constants/app_size.dart';
import 'package:hackathon_app/constants/routes/app_routes.dart';
import 'package:hackathon_app/constants/theme/app_colors.dart';
import 'package:hackathon_app/presentation/view/components/common_button.dart';

///
/// トップ画面
///
class TopPage extends StatefulWidget {
  const TopPage({super.key});
  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  int currentIndex = 0;
  final sampleTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 左半分：キャラクター画像
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/images/chara/cat_start.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          // 右半分：タイトルとボタン
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: AppSize.sm,
                children: <Widget>[
                  const Text(
                    'リズムでレスキュー',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.strawberryRed,
                    ),
                  ),
                  const Text(
                    'たのしくリズムにのって、いのちをまもろう！',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.subtitleGray,
                    ),
                  ),
                  CommonButton(
                    children: Text(
                      'スタート',
                      style: TextStyle(color: AppColors.accentColor),
                    ),
                    tapFunc: () {
                      context.go(AppRoutes.game);
                    },
                  ),
                  CommonButton(
                    bgColor: AppColors.strawberryRed,
                    children: Text(
                      '設定画面へ',
                      style: TextStyle(color: AppColors.accentColor),
                    ),
                    tapFunc: () {
                      context.go(AppRoutes.setting);
                    },
                  ),
                  CommonButton(
                    bgColor: AppColors.strawberryRed,
                    children: Text(
                      'あそびかた',
                      style: TextStyle(color: AppColors.accentColor),
                    ),
                    tapFunc: () {
                      context.go(AppRoutes.result);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
