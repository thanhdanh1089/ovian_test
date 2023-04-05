import 'package:flutter/material.dart';
import 'package:ovian_test/data/remote/response/Status.dart';
import 'package:ovian_test/models/SOFUserList/SOFUsersMain.dart';
import 'package:ovian_test/res/AppContextExtension.dart';
import 'package:ovian_test/utils/Utils.dart';
import 'package:ovian_test/view/detail/SOFUserDetailScreen.dart';
import 'package:ovian_test/view/widget/MyTextView.dart';
import 'package:ovian_test/view_model/home/SOFUsersListVM.dart';
import 'package:provider/provider.dart';

import 'package:ovian_test/view/widget/MyErrorWidget.dart';
import 'package:ovian_test/view/widget/LoadingWidget.dart';

class HomeScreen extends StatefulWidget {
  static final String id = "home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SOFUsersListVM viewModel = SOFUsersListVM();

  @override
  void initState() {
    viewModel.initSOFData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: MyTextView(
                context.resources.strings.homeScreen,
                context.resources.color.colorWhite,
                context.resources.dimension.bigText)),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ChangeNotifierProvider<SOFUsersListVM>.value(
        value: viewModel,
        child: Consumer<SOFUsersListVM>(builder: (context, viewModel, _) {
          switch (viewModel.sofUserMain.status) {
            case Status.LOADING:
              return LoadingWidget();
            case Status.ERROR:
              return MyErrorWidget(viewModel.sofUserMain.message ?? "NA");
            case Status.COMPLETED:
              return _getSOFUserListView(viewModel.users);
            default:
          }
          return Container();
        }),
      ),
    );
  }

  Widget _getSOFUserListView(List<SOFUser>? sofUserList) {
    return ListView.builder(
        itemCount: sofUserList?.length,
        itemBuilder: (context, position) {
          // return _getSOFUserListItem(sofUserList![position]);
          if (position == sofUserList!.length - 1) {
            viewModel.incrementPage();
            viewModel.fetchSOFUsers();
          }
          return _getSOFUserListItem(sofUserList[position]);
        });
  }

  Widget _getSOFUserListItem2(SOFUser item) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(context.resources.dimension.smallMargin),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () {
          _sendDataToSOFUserDetailScreen(context, item);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(context.resources.dimension.bigMargin),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.network(
                    item.userAvatar ?? "",
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/images/img_error.png');
                    },
                    fit: BoxFit.fill,
                    width: context.resources.dimension.listImageSize,
                    height: context.resources.dimension.listImageSize,
                  ),
                  Container(width: context.resources.dimension.defaultMargin),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              item.userName ?? "",
                              style: TextStyle(
                                  color: context.resources.color.colorGrey,
                                  fontSize:
                                      context.resources.dimension.mediumText),
                            ),
                            Text(
                              '${item.userAge ?? "0"}',
                              style: TextStyle(
                                  color: context.resources.color.colorBlack,
                                  fontSize:
                                      context.resources.dimension.smallText),
                            ),
                            Text(
                              item.location ?? "Unknown",
                              maxLines: 2,
                              style: TextStyle(
                                  color: context.resources.color.colorGrey,
                                  fontSize:
                                      context.resources.dimension.mediumText),
                            ),
                          ],
                        ),
                        IconButton(
                          iconSize: 16,
                          icon: const Icon(Icons.bookmark),
                          color: (item.isBookmark
                              ? context.resources.color.colorAccent
                              : context.resources.color.colorGrey),
                          onPressed: () {
                            !item.isBookmark
                                ? viewModel.insertBookmarkSOFUsers(item)
                                : viewModel.deleteBookmarkSOFUsers(item);
                            // ...
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getSOFUserListItem(SOFUser item) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.network(
                  item.userAvatar ?? "",
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/images/img_error.png');
                  },
                  fit: BoxFit.fill,
                  width: context.resources.dimension.listImageSize,
                  height: context.resources.dimension.listImageSize,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.userName.toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        item.userAge.toString() + " " + r"years",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          iconSize: 16,
                          icon: const Icon(Icons.bookmark),
                          color: (item.isBookmark
                              ? context.resources.color.colorAccent
                              : context.resources.color.colorGrey),
                          onPressed: () {
                            !item.isBookmark
                                ? viewModel.insertBookmarkSOFUsers(item)
                                : viewModel.deleteBookmarkSOFUsers(item);
                            // ...
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _sendDataToSOFUserDetailScreen(BuildContext context, SOFUser item) {
    Navigator.pushNamed(context, SOFUserDetailsScreen.id, arguments: item);
  }
}
