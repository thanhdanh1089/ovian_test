import 'package:flutter/material.dart';
import 'package:ovian_test/data/remote/response/Status.dart';
import 'package:ovian_test/models/SOFUserList/SOFUsersMain.dart';
import 'package:ovian_test/res/AppContextExtension.dart';
import 'package:ovian_test/view/detail/SOFUserDetailScreen.dart';
import 'package:ovian_test/view/widget/AppTextView.dart';
import 'package:ovian_test/view/widget/ToggleButtonWidget.dart';
import 'package:ovian_test/viewModel/home/SOFUsersListVM.dart';
import 'package:provider/provider.dart';
import 'package:ovian_test/view/widget/AppErrorWidget.dart';
import 'package:ovian_test/view/widget/LoadingWidget.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";

  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
            child: Row(
          children: <Widget>[
            AppTextView(
                context.resources.strings.homeScreen,
                context.resources.color.colorWhite,
                context.resources.dimension.bigText),
            const Spacer(),
            MyToggleSwitch(
                switched: (val) {
                  viewModel.loadFilterData();
                },
                initial: false)
          ],
        )),
        backgroundColor: context.resources.color.statusGrey,
      ),
      body: ChangeNotifierProvider<SOFUsersListVM>.value(
        value: viewModel,
        child: Consumer<SOFUsersListVM>(builder: (context, viewModel, _) {
          switch (viewModel.sofUserMain.status) {
            case Status.LOADING:
              return const LoadingWidget();
            case Status.ERROR:
              return AppErrorWidget(viewModel.sofUserMain.message ?? "NA");
            case Status.COMPLETED:
              return _getSOFUserListView(
                viewModel.users, 
                viewModel.bookmarkUsers, 
                viewModel.isBookmarkFilter);
            default:
          }
          return Container();
        }),
      ),
    );
  }

  Widget _getSOFUserListView(
    List<SOFUser>? sofUserList, 
    List<SOFUser>? sofUserListBookmark, 
    bool isBookmarkFilter) {
    return ListView.builder(
        padding: EdgeInsets.only(
            right: context.resources.dimension.smallMargin,
            left: context.resources.dimension.smallMargin),
        itemCount: isBookmarkFilter ? sofUserListBookmark?.length : sofUserList?.length,
        itemBuilder: (context, position) {
          List<SOFUser>? sofUserItems = isBookmarkFilter ? sofUserListBookmark : sofUserList;
          if (position == sofUserItems!.length - 1 && isBookmarkFilter == false) {
            viewModel.incrementPage();
            viewModel.fetchSOFUsers();
            return Container(
              margin: const EdgeInsets.all(20.0),
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation(context.resources.color.statusGrey),
              ),
            );
          }
          return _getSOFUserListItem(sofUserItems[position]);
        });
  }

  Widget _getSOFUserListItem(SOFUser item) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            _sendDataToSOFUserDetailScreen(context, item);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(
                          context.resources.dimension.listImageSize / 2),
                      child: Image.network(
                        item.userAvatar ?? "",
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/images/img_error.png');
                        },
                        fit: BoxFit.fill,
                        width: context.resources.dimension.listImageSize,
                        height: context.resources.dimension.listImageSize,
                      )),
                  SizedBox(
                    width: context.resources.dimension.smallSizebox,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.userName.toString(),
                          style: TextStyle(
                              fontSize:
                                  context.resources.dimension.textFontSize,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: context.resources.dimension.smallSizebox,
                        ),
                        Text(
                         '${item.userAge.toString()} years old',
                          style: TextStyle(
                              fontSize:
                                  context.resources.dimension.textFontSize,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: context.resources.dimension.smallSizebox,
                        ),
                        Text(
                          item.reputation.toString(),
                          style: TextStyle(
                              fontSize:
                                  context.resources.dimension.textFontSize,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: context.resources.dimension.smallSizebox,
                        ),
                        Text(
                          item.location.toString(),
                          style: TextStyle(
                              fontSize:
                                  context.resources.dimension.textFontSize,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        context.resources.dimension.listImageSize / 2),
                    child: IconButton(
                      iconSize: 16,
                      icon: const Icon(Icons.bookmark),
                      color: (item.isBookmark!
                          ? context.resources.color.colorAccent
                          : context.resources.color.colorGrey),
                      onPressed: () {
                        !item.isBookmark!
                            ? viewModel.insertBookmarkSOFUsers(item)
                            : viewModel.deleteBookmarkSOFUsers(item);
                      },
                    ),
                  ),
                  SizedBox(
                    width: context.resources.dimension.smallSizebox,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _sendDataToSOFUserDetailScreen(BuildContext context, SOFUser item) {
    Navigator.pushNamed(context, SOFUserDetailsScreen.id, arguments: item);
  }
}
