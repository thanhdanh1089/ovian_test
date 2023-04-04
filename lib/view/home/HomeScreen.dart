import 'package:flutter/material.dart';
import 'package:ovian_test/data/remote/response/Status.dart';
import 'package:ovian_test/models/SOFUserList/SOFUsersMain.dart';
import 'package:ovian_test/res/AppContextExtension.dart';
import 'package:ovian_test/utils/Utils.dart';
// import 'package:ovian_test/view/details/MovieDetailsScreen.dart';
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
    viewModel.fetchSOFUsers();
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
              return _getSOFUserListView(viewModel.sofUserMain.data?.sofUsers);
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
          return _getSOFUserListItem2(sofUserList![position]);
        });
  }

  Widget _getSOFUserListItem(SOFUser item) {
    return Card(
      child: ListTile(
        leading: ClipRRect(
          child: Image.network(
            item.userAvatar ?? "",
            errorBuilder: (context, error, stackTrace) {
              return new Image.asset('assets/images/img_error.png');
            },
            fit: BoxFit.fill,
            width: context.resources.dimension.listImageSize,
            height: context.resources.dimension.listImageSize,
          ),
          borderRadius: BorderRadius.circular(
              context.resources.dimension.imageBorderRadius),
        ),
        title: MyTextView(
            item.userName ?? "NA",
            context.resources.color.colorPrimaryText,
            context.resources.dimension.bigText),
        subtitle: MyTextView(
            item.userAge ?? "NA",
            context.resources.color.colorSecondaryText,
            context.resources.dimension.mediumText),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyTextView(
                item.location ?? "NA",
                context.resources.color.colorBlack,
                context.resources.dimension.mediumText),
            SizedBox(
              width: context.resources.dimension.verySmallMargin,
            ),
            Icon(
              Icons.bookmark,
              color: context.resources.color.colorAccent,
            ),
          ],
        ),
        onTap: () {
          // _sendDataToMovieDetailScreen(context, item);
        },
      ),
      elevation: context.resources.dimension.lightElevation,
    );
  }

  Widget _getSOFUserListItem2(SOFUser item) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
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
                Container(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(height: 5),
                      Row(
                        children: <Widget>[
                          Text(
                            item.userName ?? "",
                            style: TextStyle(
                                color: context.resources.color.colorGrey,
                                fontSize: context.resources.dimension.mediumText),
                          ),
                          IconButton(
                            iconSize: 16,
                            icon: const Icon(Icons.bookmark),
                            color: context.resources.color.colorAccent,
                            onPressed: () {
                              // ...
                            },
                          ),
                        ],
                      ),
                      Container(height: 5),
                      Text(
                        '${item.userAge ?? "0"}',
                        style: TextStyle(
                            color: context.resources.color.colorBlack,
                            fontSize: context.resources.dimension.smallText),
                      ),
                      Container(height: 10),
                      Text(
                        item.location ?? "Unknown",
                        maxLines: 2,
                        style: TextStyle(
                            color: context.resources.color.colorGrey,
                            fontSize: context.resources.dimension.mediumText),
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

  // void _sendDataToMovieDetailScreen(BuildContext context, Movie item) {
  //   Navigator.pushNamed(context, MovieDetailsScreen.id, arguments: item);
  // }
}
