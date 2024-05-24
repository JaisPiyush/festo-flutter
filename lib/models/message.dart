class MessageChipOption {
  final String title;
  final String actionId;

  const MessageChipOption({required this.title, required this.actionId});

  factory MessageChipOption.fromJson(Map<String, dynamic> json) {
    return MessageChipOption(title: json['title'], actionId: json['actionId']);
  }
}

class MessageRichContent {
  final String? rawUrl;
  final String type;
  final List<MessageChipOption>? options;
  final dynamic id;
  final String? text;

  MessageRichContent(
      {this.rawUrl, required this.type, this.options, this.id, this.text});

  factory MessageRichContent.fromJson(Map<String, dynamic> json) {
    return MessageRichContent(
        type: json['type'],
        id: json['id'],
        rawUrl: json['rawUrl'],
        options: json['options'] == null
            ? null
            : (json['options'] as List<Map<String, dynamic>>)
                .map(MessageChipOption.fromJson)
                .toList(),
        text: json['text']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {"type": type};

    if (rawUrl != null) {
      json['rawUrl'] = rawUrl;
    }

    if (text != null) {
      json['text'] = text;
    }

    return json;
  }
}

class ServerMessage {
  String id;
  int? created_at;
  List<MessageRichContent> message;
  String author_id;

  ServerMessage(
      {required this.message,
      required this.author_id,
      required this.id,
      this.created_at});

  factory ServerMessage.fromJson(Map<String, dynamic> json) {
    return ServerMessage(
        message: (json['message'] as List<Map<String, dynamic>>)
            .map(MessageRichContent.fromJson)
            .toList(),
        author_id: json['author_id'],
        created_at: json['created_at'],
        id: json['id']);
  }
}
