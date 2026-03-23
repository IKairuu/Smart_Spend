class MemoFunc {
  final String title;
  final String text;
  final DateTime date;

  const MemoFunc({required this.title, required this.text, required this.date});

  Map<dynamic, dynamic> create_map() {
    return {"title": title, "text": text, "date": date};
  }
}
