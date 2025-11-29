import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackathon_app/constants/app_size.dart';
import 'package:hackathon_app/constants/routes/app_routes.dart';
import 'package:hackathon_app/constants/theme/app_colors.dart';
import 'package:hackathon_app/presentation/view/components/common_button.dart';

///
/// ゲームの結果画面
///
class ResultPage extends StatelessWidget {
  const ResultPage({super.key, this.isFailed = true});

  final bool isFailed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsetsGeometry.symmetric(
          horizontal: AppSize.sm,
          vertical: AppSize.xs,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              isFailed ? 'ざんねん！' : 'よくできました！',
              style: TextStyle(fontSize: AppSize.resultTitleTextSize),
            ),
            Text(
              isFailed ? 'でもよくがんばりました！' : 'すばらしいです！',
              style: TextStyle(fontSize: AppSize.xm),
            ),
            SizedBox(height: AppSize.sm),
            Row(
              spacing: AppSize.xxs,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonButton(
                  bgColor: AppColors.azureBlue,
                  children: Text(
                    'もう一度',
                    style: TextStyle(color: AppColors.accentColor),
                  ),
                  tapFunc: () {
                    context.go(AppRoutes.top);
                  },
                ),
                CommonButton(
                  bgColor: AppColors.strawberryRed,
                  children: Text(
                    'トップへ',
                    style: TextStyle(color: AppColors.accentColor),
                  ),
                  tapFunc: () {
                    context.go(AppRoutes.top);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
