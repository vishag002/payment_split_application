import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_application/utilis/colors/color_constant.dart';
import 'package:split_application/utilis/components/app_dimensions.dart';
import 'package:split_application/utilis/components/widget_components.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppComponents.appBarStyle(),
      body: const Column(
        children: [
          _headerWidget(),
          _buttonRow(),
          SplitGroupsList(),
        ],
      ),
    );
  }
}

class _headerWidget extends ConsumerWidget {
  const _headerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: AppDimensions.heightPercentage(20),
      width: AppDimensions.widthPercentage(100),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(.8),
      ),
    );
  }
}

//buttons
class _buttonRow extends ConsumerWidget {
  const _buttonRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Container(
        height: AppDimensions.heightPercentage(10),
        width: AppDimensions.widthPercentage(95),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(.08),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: AppDimensions.heightPercentage(7),
              width: AppDimensions.widthPercentage(30),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Text("Alert"),
              ),
            ),
            Container(
              height: AppDimensions.heightPercentage(7),
              width: AppDimensions.widthPercentage(30),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Text("Alert"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SplitGroupsList extends ConsumerWidget {
  const SplitGroupsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => groupsCard(),
      ),
    );
  }
}

Widget groupsCard() {
  return Card(
    color: AppColors.secondaryColor,
    child: ListTile(
      leading: Container(
        height: AppDimensions.heightPercentage(12),
        width: AppDimensions.widthPercentage(12),
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          shape: BoxShape.circle,
        ),
      ),
      title: Text("Group Name"),
    ),
  );
}
