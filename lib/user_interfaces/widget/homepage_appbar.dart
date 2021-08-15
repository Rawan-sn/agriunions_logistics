import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/models/create_models/search_filter_model.dart';
import 'package:agriunions_logistics/user_interfaces/dialogs&bottom_sheets/show_dialogs.dart';

class HomePageAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _HomePageAppBarState createState() => _HomePageAppBarState();
  final searthFilterSubmit;
  final searchTextController;
  final searthKeywordSubmit;

  HomePageAppBar(
    this.searthFilterSubmit,
    this.searchTextController,
    this.searthKeywordSubmit,
  );

  @override
  Size get preferredSize {
    return Size.fromHeight(kToolbarHeight);
  }
}

class _HomePageAppBarState extends State<HomePageAppBar> {
  Widget? appBarTitle;
  Icon actionIcon = new Icon(
    Icons.notifications_none,
    size: 30,
  );
  SearchFilterModel? filterModel;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.Russet,
      titleSpacing: 2,
      title: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(2),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(2),
          ),
        ),
        child: TextFormField(
          textAlign: TextAlign.start,
          onFieldSubmitted: (term) {
            widget.searthKeywordSubmit(term);
          },
          textInputAction: TextInputAction.search,
          controller: widget.searchTextController,
          decoration: new InputDecoration(
            // contentPadding: EdgeInsets.all(0),
            border: InputBorder.none,
            prefixIcon: new Icon(Icons.search, color: Colors.grey[700]),
            hintText: AppLocalizations.of(context)!.trans('search_hint'),
            hintStyle: new TextStyle(color: Colors.grey, height: 1.2),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(FontAwesome5.filter, color: AppColors.white),
          onPressed: () {
            ShowDialogs.showSearchFilterDialog(context, filterModel,
                (adSearchModel) {
              if (adSearchModel != null) {
                filterModel = adSearchModel;
                widget.searthFilterSubmit(adSearchModel);
              }
            });
          },
        )
      ],
    );
  }
}
