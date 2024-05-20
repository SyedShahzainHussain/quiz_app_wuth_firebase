import 'package:shimmer/shimmer.dart';

import '../subjects.dart';

class SubjectViewWidget extends StatelessWidget {
  final SubjectViewModel state;
  final int index;
  const SubjectViewWidget({
    super.key,
    required this.state,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
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
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => SubjectLevelScreen(
                            subjectModel: state.subjectList.data![index])));
              },
              splashColor: AppColors.purple.withOpacity(0.4),
              child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: state.subjectList.data![index].Image,
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error, color: Colors.red),
                      placeholder: (
                        context,
                        progress,
                      ) =>
                          Shimmer.fromColors(
                        baseColor: AppColors.grey!,
                        highlightColor: AppColors.highlightColor!,
                        child: Container(
                          height: 40,
                          width: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: Text(
                      state.subjectList.data![index].Title.toUpperCase()[0] +
                          state.subjectList.data![index].Title.substring(1),
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: const Color(0xff030605),
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
