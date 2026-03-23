class Message {
  final String text;
  final DateTime date;
  final bool userSent;

  const Message({
    required this.text,
    required this.date,
    required this.userSent,
  });
}
