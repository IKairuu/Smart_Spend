import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:smart_spend/constants/cons_values.dart';
import 'package:smart_spend/Objects/memo_func.dart';
import 'package:smart_spend/constants/notifier.dart';

class MemoWidget extends StatefulWidget {
  const MemoWidget({super.key});

  @override
  State<MemoWidget> createState() => _MemoWidgetState();
}

class _MemoWidgetState extends State<MemoWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: dark_mode,
      builder: (context, dark, child) {
        return Padding(
          padding: const EdgeInsets.all(2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: ValueListenableBuilder(
                      valueListenable: container_colors,
                      builder: (context, decorate, child) {
                        return Container(
                          height: 240,
                          width: double.infinity,
                          decoration: decorate,
                          child: Center(
                            child: ValueListenableBuilder(
                              valueListenable: memos,
                              builder: (context, memo, child) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 500,
                                    child: GroupedListView<MemoFunc, DateTime>(
                                      padding: EdgeInsets.all(10),
                                      elements: memo,
                                      groupBy: (element) => DateTime(
                                        element.date.year,
                                        element.date.month,
                                        element.date.day,
                                      ),
                                      itemBuilder: (context, lists) => Material(
                                        child: Theme(
                                          data: ThemeData(
                                            splashColor: Color.fromRGBO(
                                              208,
                                              188,
                                              254,
                                              1,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 5,
                                              bottom: 5,
                                            ),
                                            child: ListTile(
                                              leading: Text(
                                                DateFormat(
                                                  "MMMM dd, yyyy",
                                                ).format(lists.date),
                                                style: TextStyle(
                                                  color: dark
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
                                              tileColor: dark
                                                  ? ColorContainer
                                                        .main_containers_indicator
                                                  : ColorContainer
                                                        .main_containers_light,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadiusGeometry.circular(
                                                      20,
                                                    ),
                                              ),
                                              title: Text(
                                                lists.title,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: dark
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
                                              titleAlignment:
                                                  ListTileTitleAlignment.center,
                                              onTap: () {
                                                setState(() {
                                                  selected_memo_title.value =
                                                      lists.title;
                                                  selected_memo_text.value =
                                                      lists.text;
                                                  memo_view.value = 2;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      groupHeaderBuilder: (element) =>
                                          SizedBox(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 51,
                    width: 151,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: dark
                            ? ColorContainer.main_containers_indicator
                            : ColorContainer.main_containers_light,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(20),
                        ),
                      ),
                      onPressed: () {
                        memo_view.value = 0;
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: dark ? Colors.white : Colors.black,
                          ),
                          Text(
                            "Add Memo",
                            style: TextStyle(
                              color: dark ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  SizedBox(
                    height: 51,
                    width: 151,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: dark
                            ? ColorContainer.main_containers_indicator
                            : ColorContainer.main_containers_light,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(20),
                        ),
                      ),
                      onPressed: () {
                        memo_view.value = 1;
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.remove,
                            color: dark ? Colors.white : Colors.black,
                          ),
                          Text(
                            "Remove Memo",
                            style: TextStyle(
                              color: dark ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ValueListenableBuilder(
                valueListenable: memo_view,
                builder: (context, view, child) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 15,
                      right: 15,
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: container_colors,
                      builder: (context, decorate, child) {
                        return Container(
                          height: 280,
                          decoration: decorate,
                          child: MemoTab.memo_widgets[view],
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
