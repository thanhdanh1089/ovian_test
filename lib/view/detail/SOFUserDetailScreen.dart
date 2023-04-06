import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ovian_test/models/SOFUserDetail/SOFUsersDetailMain.dart';
import 'package:ovian_test/models/SOFUserList/SOFUsersMain.dart';
import 'package:ovian_test/res/Resources.dart';
import 'package:ovian_test/utils/Utils.dart';
import 'package:ovian_test/view/widget/MyChips.dart';
import 'package:ovian_test/view/widget/MyTextView.dart';
import 'package:ovian_test/res/AppContextExtension.dart';
import 'package:ovian_test/view_model/detail/SOFUserDetailVM.dart';
import 'package:ovian_test/data/remote/response/Status.dart';
import 'package:ovian_test/res/AppContextExtension.dart';
import 'package:ovian_test/utils/Utils.dart';
import 'package:provider/provider.dart';

import 'package:ovian_test/view/widget/MyErrorWidget.dart';
import 'package:ovian_test/view/widget/LoadingWidget.dart';

class SOFUserDetailsScreen extends StatefulWidget {
  static final String id = "sofuser_details";
  final SOFUser? sofUserData;
  const SOFUserDetailsScreen(this.sofUserData);

  @override
  _SOFUserDetailsState createState() => _SOFUserDetailsState();
}

class _SOFUserDetailsState extends State<SOFUserDetailsScreen> {
  final SOFUserDetailVM viewModel = SOFUserDetailVM();
  SOFUser? sofUserData;

  @override
  void initState() {
    viewModel.userId = widget.sofUserData?.userId ?? 0;
    viewModel.initSOFData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyTextView(
            widget.sofUserData?.userName ??
                context.resources.strings.homeScreen,
            context.resources.color.colorWhite,
            context.resources.dimension.bigText),
        backgroundColor: context.resources.color.statusGrey,
      ),
      body: ChangeNotifierProvider<SOFUserDetailVM>.value(
        value: viewModel,
        child: Consumer<SOFUserDetailVM>(builder: (context, viewModel, _) {
          switch (viewModel.sofUserDetailMain.status) {
            case Status.LOADING:
              return LoadingWidget();
            case Status.ERROR:
              return MyErrorWidget(viewModel.sofUserDetailMain.message ?? "NA");
            case Status.COMPLETED:
              return _getSOFUserDetailView(viewModel.posts);
            default:
          }
          return Container();
        }),
      ),
    );
  }

  Widget _getSOFUserDetailView(List<SOFPost>? sofUserPostList) {
    return ListView.builder(
        itemCount: sofUserPostList?.length,
        padding: EdgeInsets.only(
            right: context.resources.dimension.smallMargin,
            left: context.resources.dimension.smallMargin),
        itemBuilder: (context, position) {
          if (position == sofUserPostList!.length - 1) {
            viewModel.incrementPage();
            viewModel.fetchSOFUserDetail();
            return Container(
              margin: const EdgeInsets.all(20.0),
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation(Color.fromARGB(255, 38, 42, 49)),
              ),
            );
          }
          return _getSOFUserDetailItem(sofUserPostList[position]);
        });
  }

  Widget _getSOFUserDetailItem(SOFPost item) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.history,
                                color: Colors.amber,
                                size:
                                    context.resources.dimension.smallIconImage),
                            SizedBox(
                                width:
                                    context.resources.dimension.largeSizebox),
                            Text(
                              item.postId.toString(),
                              style: TextStyle(
                                  fontSize:
                                      context.resources.dimension.textFontSize,
                                  fontWeight: FontWeight.w700),
                            ),
                            
                          ],
                        ),
                        SizedBox(
                          height: context.resources.dimension.smallSizebox,
                        ),
                        Row(
                          children: [
                            Icon(
                                item.reputationType == "post_upvoted"
                                    ? Icons.thumb_up
                                    : Icons.check,
                                color: item.reputationType == "post_upvoted"
                                    ? Colors.amber
                                    : Colors.green,
                                size:
                                    context.resources.dimension.smallIconImage),
                            SizedBox(
                                width:
                                    context.resources.dimension.largeSizebox),
                            Text(
                              item.reputationChange.toString(),
                              style: TextStyle(
                                  fontSize:
                                      context.resources.dimension.textFontSize,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                                width:
                                    context.resources.dimension.smallSizebox),
                            Text(
                              item.reputationType.toString(),
                              style: TextStyle(
                                  fontSize:
                                      context.resources.dimension.smallText,
                                  fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),
                            Text(
                              Utils.formatDateTime(item.creationDate ?? 0),
                              style: TextStyle(
                                  fontSize:
                                      context.resources.dimension.smallText,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: context.resources.dimension.smallSizebox,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget _setChipView(List<String>? data, Color color) {
  //   var size = data?.length ?? 0;
  //   return Container(
  //     alignment: AlignmentDirectional.topStart,
  //     child: Wrap(
  //       alignment: WrapAlignment.start,
  //       spacing: 8,
  //       children: [
  //         for (var i = 0; i < size; i++) MyChips(data?[i] ?? "NA", color)
  //       ],
  //     ),
  //   );
  // }
}
