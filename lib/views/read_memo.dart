import 'package:flutter/material.dart';
import 'package:smart_spend/constants/cons_values.dart';
import 'package:smart_spend/constants/notifier.dart';

class ReadMemo extends StatefulWidget {
  const ReadMemo({super.key});

  @override
  State<ReadMemo> createState() => _ReadMemoState();
}

class _ReadMemoState extends State<ReadMemo> {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: selected_memo_title,
                      builder: (context, title, child) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Text("TITLE: "),
                              Expanded(
                                child: Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: dark
                                        ? ColorContainer
                                              .main_containers_indicator
                                        : ColorContainer.main_containers_light,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Center(
                                      child: Text(
                                        title,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Center(child: Text("CONTENT")),
                    ValueListenableBuilder(
                      valueListenable: selected_memo_text,
                      builder: (context, value, child) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: dark ? Colors.white : Colors.black,
                              ),
                            ),
                            height: 180,
                            width: double.infinity,
                            child: Scrollbar(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(value),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
