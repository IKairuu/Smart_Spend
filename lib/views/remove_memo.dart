import 'package:flutter/material.dart';
import 'package:smart_spend/constants/cons_values.dart';
import 'package:smart_spend/constants/notifier.dart';
import 'package:smart_spend/functions/background.dart';

class RemoveMemo extends StatefulWidget {
  const RemoveMemo({super.key});

  @override
  State<RemoveMemo> createState() => _RemoveMemoState();
}

class _RemoveMemoState extends State<RemoveMemo> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: dark_mode,
      builder: (context, dark, child) {
        return Padding(
          padding: const EdgeInsets.only(right: 15, left: 15),
          child: ValueListenableBuilder(
            valueListenable: container_colors,
            builder: (context, decorate, child) {
              return Container(
                height: 285,
                width: double.infinity,
                decoration: decorate,
                child: Column(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: memo_check_data,
                      builder: (context, memo, child) {
                        return SizedBox(
                          height: 215,
                          width: double.infinity,
                          child: ListView.builder(
                            itemCount: memos.value.length,
                            itemBuilder: (context, index) => CheckboxListTile(
                              value: memo[index].keys.first,
                              onChanged: (value) {
                                setState(() {
                                  var temp =
                                      memo_check_data.value[index].values.first;
                                  memo_check_data.value[index].remove(!value!);
                                  memo_check_data.value[index][value] = temp;

                                  if (value) {
                                    to_delete_memo.value.add(
                                      memo_check_data
                                          .value[index][value]
                                          ?.title,
                                    );
                                  } else {
                                    to_delete_memo.value.remove(
                                      memo_check_data
                                          .value[index][value]
                                          ?.title,
                                    );
                                  }
                                });
                              },
                              title: Text(memo[index].values.first.title),
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              for (
                                int index = 0;
                                index < to_delete_memo.value.length;
                                index++
                              ) {
                                AppDatabase.delete_memo_data(
                                  AppDatabase.identify_key(
                                    to_delete_memo.value[index]!,
                                    false,
                                  ),
                                );
                              }
                              memo_view.value = 0;
                              to_delete_memo.value.clear();
                              memo_check_data.value.clear();
                              memos.value.clear();
                              memos.value = AppDatabase.get_memo_data();
                              memo_check_data.value =
                                  AppDatabase.generate_check_box_memo();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: dark
                                ? ColorContainer.main_containers_indicator
                                : ColorContainer.main_containers_light,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(20),
                            ),
                          ),
                          child: Text(
                            "Remove",
                            style: TextStyle(
                              color: dark ? Colors.white : Colors.black,
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
        );
      },
    );
  }
}
