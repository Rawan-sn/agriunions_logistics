import 'package:flutter/material.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String? text;

  DescriptionTextWidget({required this.text});

  @override
  _DescriptionTextWidgetState createState() =>
      new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  bool flag = true;
  late List<String> list;

  @override
  void initState() {
    super.initState();
    list = [];
    print("length :  ${widget.text!.length}");
    for (int i = 0; i < widget.text!.length; i += 32) {
      if (i + 32 >= widget.text!.length) {
        list.add(widget.text!.substring(i, widget.text!.length));
      } else {
        list.add(widget.text!.substring(i, i + 32));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: (list.length <= 1)
            ? new Text(list[0])
            : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  flag
                      ? Row(
                          children: [
                            Text((list[0] + "..")),
                            InkWell(
                              child: new Text(
                                AppLocalizations.of(context)!.trans("show_more")!,
                                style: new TextStyle(
                                    color: AppColors.Russet, fontSize: 12),
                              ),
                              onTap: () {
                                setState(() {
                                  flag = !flag;
                                });
                              },
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getTextWidgets(list),
                            InkWell(
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: new Text(
                                  AppLocalizations.of(context)!
                                      .trans("show_less")!,
                                  style: new TextStyle(
                                      color: AppColors.Russet, fontSize: 12),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  flag = !flag;
                                });
                              },
                            ),
                          ],
                        ),
                ],
              ));
  }

  Widget getTextWidgets(List<String> strings) {
    List<Widget> list = [];
    for (var i = 0; i < strings.length; i++) {
      list.add(new Text(strings[i]));
    }
    return new Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: list);
  }
}