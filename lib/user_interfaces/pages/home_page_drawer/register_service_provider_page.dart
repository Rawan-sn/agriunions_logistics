import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/blocs/register_as_service_bloc.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/TextSizes.dart';
import 'package:agriunions_logistics/helper/data_store.dart';
import 'package:agriunions_logistics/user_interfaces/pages/general/add_media_page.dart';

class RegisterServiceProvidersPage extends StatefulWidget {
  @override
  _RegisterServiceProvidersPageState createState() =>
      _RegisterServiceProvidersPageState();
}

class _RegisterServiceProvidersPageState
    extends State<RegisterServiceProvidersPage> {
  TextEditingController? descriptionController;
  AddMediaPage? addMediaPage;
  RegisterAsServiceBloc _bloc = RegisterAsServiceBloc();

  @override
  void initState() {
    super.initState();
    addMediaPage = AddMediaPage();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: Text(
          AppLocalizations.of(context)!.trans("register_as_service_provider")!,
          style: TextStyle(
            fontSize: TextSizes.smallText,
          ),
        ),
        flexibleSpace: Container(
          color: Color(0xff7a0808),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Visibility(
              visible: (dataStore.initialData?.registerNote ?? "").isNotEmpty,
              child: Text(
                dataStore.initialData?.registerNote ?? "",
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: descriptionController,
                        maxLines: null,
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                            borderSide:
                                BorderSide(width: 0, style: BorderStyle.none),
                          ),
                          hintText: AppLocalizations.of(context)!
                              .trans('add_description'),
                          hintStyle: TextStyle(color: AppColors.darkRed),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Text(
                        AppLocalizations.of(context)!.trans('upload_photos')!,
                        style: TextStyle(color: AppColors.darkRed),
                      ),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height / 3,
                        child: addMediaPage),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              color: AppColors.Russet,
              child: InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  _bloc.registerAsService(
                    context,
                    addMediaPage!,
                    descriptionController!.text,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context)!.trans('register')!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
