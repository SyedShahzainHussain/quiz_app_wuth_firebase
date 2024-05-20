import 'package:flutter/material.dart';
import 'package:quiz_app_with_firebase/config/colors.dart';
import 'package:shimmer/shimmer.dart';

class SubjectShimmer extends StatelessWidget {
  final int itemCount;
  const SubjectShimmer({super.key, this.itemCount = 10});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 12.0,
              bottom: 6.0,
              top: 5.0,
            ),
            child: Card(
              elevation: 4,
              child: Container(
                color: const Color(0xffffffff),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Shimmer.fromColors(
                    baseColor: AppColors.grey!,
                    highlightColor: AppColors.highlightColor!,
                    child: ListTile(
                      leading: Container(
                        height: 40,
                        width: 40,
                        color: Colors.white,
                      ),
                      title: Container(
                        height: 10,
                        width: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
