import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/blocs/process_link_request_bloc.dart';
import 'package:agriunions_logistics/blocs/unlink_user_bloc.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/app_permissions.dart';
import 'package:agriunions_logistics/models/link_request_model.dart';
import 'package:agriunions_logistics/user_interfaces/dialogs&bottom_sheets/show_dialogs.dart';

class LinkRequestCard extends StatefulWidget {
  final LinkRequestModel? model;
  final Function? onTap;

  LinkRequestCard({this.model, this.onTap});

  @override
  __LinkRequestCardState createState() => __LinkRequestCardState();
}

class __LinkRequestCardState extends State<LinkRequestCard> {
  ProcessLinkRequestBloc bloc = new ProcessLinkRequestBloc();
  UnlinkUserBloc bloc1 = new UnlinkUserBloc();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 10.0, left: 15.0, right: 15.0, bottom: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: kElevationToShadow[3],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Visibility(
                      visible: AppPermissions.isServiceProvider(),
                      child: Row(
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.trans('username')} : ",
                          ),
                          Text(
                            "${widget.model!.username}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      replacement: Row(
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.trans('master')} : ",
                          ),
                          Text(
                            "${widget.model!.masterUserName}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Text(
                      AppLocalizations.of(context)!.trans(widget.model!.status)!,
                      style: TextStyle(
                        fontSize: 10,
                        color: widget.model!.status == 'pending'
                            ? Colors.yellow[700]
                            : widget.model!.status == 'Accepted'
                                ? Colors.green
                                : AppColors.Russet,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                children: [
                  Text(
                    "${AppLocalizations.of(context)!.trans('current_master')} : ",
                  ),
                  Expanded(
                    child: Text(
                      "${(widget.model!.currentMasterUserName ?? '').isEmpty ? AppLocalizations.of(context)!.trans('not_set') : widget.model!.currentMasterUserName}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: widget.model!.status == "pending",
              child: Visibility(
                visible: AppPermissions.isServiceProvider(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: OutlinedButton(
                        onPressed: () {
                          ShowDialogs.showAlert(
                              context,
                              AppLocalizations.of(context)!
                                  .trans('accept_request'),
                              AppLocalizations.of(context)!
                                  .trans('do_you_want_accept_request'), () {
                            Navigator.of(context).pop();
                            bloc.processLinkRequestBloc(context,
                                widget.model!.id, "Accepted", widget.onTap);
                          });
                        },
                        child: Text(
                          AppLocalizations.of(context)!.trans("accept")!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.green),
                        ),
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(Colors.green),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: OutlinedButton(
                        onPressed: () {
                          ShowDialogs.showAlert(
                              context,
                              AppLocalizations.of(context)!
                                  .trans('reject_request'),
                              AppLocalizations.of(context)!
                                  .trans('do_you_want_reject_request'), () {
                            Navigator.of(context).pop();
                            bloc.processLinkRequestBloc(context,
                                widget.model!.id, "Rejected", widget.onTap);
                          });
                        },
                        child: Text(
                          AppLocalizations.of(context)!.trans("reject")!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: AppColors.Russet),
                        ),
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(AppColors.Russet),
                        ),
                      ),
                    ),
                  ],
                ),
                replacement: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: OutlinedButton(
                        onPressed: () {
                          ShowDialogs.showAlert(
                              context,
                              AppLocalizations.of(context)!.trans('delete_link'),
                              AppLocalizations.of(context)!
                                  .trans('do_you_want_delete_link'), () {
                            Navigator.of(context).pop();
                            Fluttertoast.showToast(
                              msg: AppLocalizations.of(context)!
                                  .trans("API_comming_soon")!,
                            );
                          });
                        },
                        child: Text(
                          AppLocalizations.of(context)!.trans('delete_link')!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(AppColors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              replacement: Visibility(
                visible: AppPermissions().isAllowToRemoveUserLink(widget.model!),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: OutlinedButton(
                        onPressed: () {
                          ShowDialogs.showAlert(
                              context,
                              AppLocalizations.of(context)!.trans('unlink_user'),
                              AppLocalizations.of(context)!
                                  .trans('do_you_want_unlink_user'), () {
                            Navigator.of(context).pop();

                            bloc1.unlinkUserBloc(
                              context,
                              AppPermissions.isServiceProvider()
                                  ? widget.model!.userId
                                  : null,
                              widget.onTap,
                            );
                          });
                        },
                        child: Text(
                          AppLocalizations.of(context)!.trans('unlink')!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(AppColors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
