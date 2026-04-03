import 'package:flutter/material.dart';
import 'package:smart_spend/Objects/memo_func.dart';
import 'package:smart_spend/constants/cons_values.dart';
import 'package:smart_spend/constants/notifier.dart';
import 'package:smart_spend/functions/background.dart';

class AddMemo extends StatefulWidget {
  const AddMemo({super.key});

  @override
  State<AddMemo> createState() => _AddMemoState();
}

class _AddMemoState extends State<AddMemo> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: dark_mode,
      builder: (context, dark, child) {
        return Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: ValueListenableBuilder(
            valueListenable: container_colors,
            builder: (context, decorate, child) {
              return Container(
                width: double.infinity,
                decoration: decorate,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("TITLE: "),
                          Expanded(
                            child: Container(
                              height: 40,
                              child: TextField(
                                controller: title,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Center(child: Text("CONTENT")),
                      ),
                      Container(
                        height: 140,
                        child: TextField(
                          controller: content,
                          maxLines: 5,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: ElevatedButton(
                          onPressed: () {
                            if (title.text.trim().isEmpty ||
                                content.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Title and Content is required",
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            } else if (AppDatabase.identify_duplicates(
                              title.text,
                              false,
                            )) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Title already exists."),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            } else {
                              AppDatabase.add_memo_data(
                                MemoFunc(
                                  title: title.text,
                                  text: content.text,
                                  date: DateTime.now(),
                                ),
                              );
                              memos.value = AppDatabase.get_memo_data();
                              memo_check_data.value =
                                  AppDatabase.generate_check_box_memo();

                              title.clear();
                              content.clear();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: dark
                                ? ColorContainer.main_containers_indicator
                                : ColorContainer.main_containers_light,
                            minimumSize: Size(double.infinity, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(20),
                            ),
                          ),
                          child: Text(
                            "Confirm",
                            style: TextStyle(
                              color: dark ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
