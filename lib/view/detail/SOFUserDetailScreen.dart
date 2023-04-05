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
        title: Center(
            child: MyTextView(
                context.resources.strings.sofUserDetailScreen,
                context.resources.color.colorWhite,
                context.resources.dimension.bigText)),
        backgroundColor: Theme.of(context).primaryColor,
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
        itemBuilder: (context, position) {
          // return _getSOFUserListItem(sofUserList![position]);
          if (position == sofUserPostList!.length - 1) {
            viewModel.incrementPage();
            viewModel.fetchSOFUserDetail();
          }
          return _getSOFUserDetailItem(sofUserPostList[position]);
        });
  }

  Widget _getSOFUserDetailItem(SOFPost item) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(context.resources.dimension.smallMargin),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(context.resources.dimension.bigMargin),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(width: context.resources.dimension.defaultMargin),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            item.reputationType ?? "",
                            style: TextStyle(
                                color: context.resources.color.colorGrey,
                                fontSize:
                                    context.resources.dimension.mediumText),
                          ),
                          Text(
                            '${item.postId ?? "0"}',
                            style: TextStyle(
                                color: context.resources.color.colorBlack,
                                fontSize:
                                    context.resources.dimension.smallText),
                          ),
                          Text(
                            '${item.creationDate ?? "0"}',
                            maxLines: 2,
                            style: TextStyle(
                                color: context.resources.color.colorGrey,
                                fontSize:
                                    context.resources.dimension.mediumText),
                          ),
                          Text(
                            '${item.reputationChange ?? "0"}',
                            maxLines: 2,
                            style: TextStyle(
                                color: context.resources.color.colorGrey,
                                fontSize:
                                    context.resources.dimension.mediumText),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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
