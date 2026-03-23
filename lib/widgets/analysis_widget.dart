import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:smart_spend/constants/cons_values.dart';
import 'package:smart_spend/Objects/message_func.dart';
import 'package:smart_spend/constants/notifier.dart';

class AnalysisWidget extends StatefulWidget {
  const AnalysisWidget({super.key});

  @override
  State<AnalysisWidget> createState() => _AnalysisWidgetState();
}

class _AnalysisWidgetState extends State<AnalysisWidget> {
  TextEditingController user_message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: dark_mode,
      builder: (context, dark, child) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: ValueListenableBuilder(
              valueListenable: container_colors,
              builder: (context, decorate, child) {
                return Container(
                  height: 600,
                  width: 400,
                  decoration: decorate,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 30,
                            right: 30,
                            left: 30,
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    "https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg",
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              Text(
                                "SmartSpend AI",
                                style: TextStyleDisplay.main_text,
                              ),
                              Divider(
                                thickness: 2,
                                color: dark ? Colors.white : Colors.black,
                                indent: 5,
                                endIndent: 5,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 340,
                          width: double.infinity,

                          child: GroupedListView<Message, DateTime>(
                            useStickyGroupSeparators: true,
                            padding: EdgeInsets.all(10),
                            elements: AnalysisTab.message_list,
                            stickyHeaderBackgroundColor: dark
                                ? ColorContainer.main_containers_dark
                                : Colors.white,
                            groupBy: (message) => DateTime(
                              message.date.year,
                              message.date.month,
                              message.date.day,
                            ),
                            groupHeaderBuilder: (Message message) => SizedBox(
                              height: 40,
                              child: Center(
                                child: Card(
                                  color: Color.fromRGBO(73, 57, 113, 1),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      DateFormat.yMMMd().format(message.date),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            itemBuilder: (context, Message message) => Align(
                              alignment: message.userSent
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Card(
                                color: message.userSent
                                    ? Color.fromRGBO(208, 188, 254, 1)
                                    : Color.fromRGBO(73, 57, 113, 1),
                                elevation: 10,
                                child: Padding(
                                  padding: const EdgeInsetsGeometry.all(10),
                                  child: Text(
                                    message.text,
                                    style: TextStyle(
                                      color: message.userSent
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                width: 252,
                                height: 50,
                                child: TextField(
                                  controller: user_message,
                                  decoration: InputDecoration(
                                    hintText: "Type your message here",
                                    filled: true,
                                    fillColor: dark
                                        ? ColorContainer
                                              .main_containers_indicator
                                        : ColorContainer.chat_box,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: IconButton(
                                  alignment: AlignmentGeometry.center,
                                  onPressed: () {
                                    final sentMessage = Message(
                                      text: user_message.text,
                                      date: DateTime.now(),
                                      userSent: true,
                                    );
                                    setState(() {
                                      AnalysisTab.message_list.add(sentMessage);
                                      user_message = TextEditingController();
                                    });
                                  },
                                  icon: Icon(Icons.send_outlined),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
