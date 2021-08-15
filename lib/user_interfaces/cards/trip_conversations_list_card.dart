import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/models/conversation_item_model.dart';

class TripConversationListCard extends StatefulWidget {
  final ConversationItemModel model;

  TripConversationListCard({
    required this.model,
  });

  @override
  _TripConversationListCardState createState() =>
      _TripConversationListCardState();
}

class _TripConversationListCardState extends State<TripConversationListCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height/13,
             margin: EdgeInsets.only(left: 12), //
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.grey.shade100, Colors.grey.shade300]),
              boxShadow: [

                BoxShadow(
                  color: Colors.amber.shade200,
                  blurRadius: 1,
                  offset: Offset(0, 2), // Shadow position
                ),
              ],              color: Colors.grey.shade100,
            ),
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.chat),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "${widget.model.withUserName}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ),

        Container(
          height: MediaQuery.of(context).size.height/13,
          width: MediaQuery.of(context).size.width/8,
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.amberAccent,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1,
                offset: Offset(0, 2), // Shadow position
              ),
            ],
            borderRadius: BorderRadius.all(
              (Radius.circular(10)),
            ),
          ),
          child: Center(
            child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text(
                  "${widget.model.numberOfMessages}",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )),
          ),
        ),
      ],
    );
  }
}
