import 'user_model.dart';

class ConversationModel {
  final int id;
  final String displayId;
  final String status;
  final int unreadCount;
  final DateTime? lastActivityAt;
  final UserModel? assignee;
  final ContactModel contact;
  final InboxModel inbox;
  final List<MessageModel> messages;
  final Map<String, dynamic>? customAttributes;
  final DateTime createdAt;
  final DateTime updatedAt;

  ConversationModel({
    required this.id,
    required this.displayId,
    required this.status,
    required this.unreadCount,
    this.lastActivityAt,
    this.assignee,
    required this.contact,
    required this.inbox,
    required this.messages,
    this.customAttributes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] as int,
      displayId: json['display_id'] as String,
      status: json['status'] as String,
      unreadCount: json['unread_count'] as int? ?? 0,
      lastActivityAt: json['last_activity_at'] != null
          ? DateTime.parse(json['last_activity_at'] as String)
          : null,
      assignee: json['assignee'] != null
          ? UserModel.fromJson(json['assignee'] as Map<String, dynamic>)
          : null,
      contact: ContactModel.fromJson(json['contact'] as Map<String, dynamic>),
      inbox: InboxModel.fromJson(json['inbox'] as Map<String, dynamic>),
      messages: (json['messages'] as List<dynamic>?)
              ?.map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      customAttributes: json['custom_attributes'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'display_id': displayId,
      'status': status,
      'unread_count': unreadCount,
      'last_activity_at': lastActivityAt?.toIso8601String(),
      'assignee': assignee?.toJson(),
      'contact': contact.toJson(),
      'inbox': inbox.toJson(),
      'messages': messages.map((e) => e.toJson()).toList(),
      'custom_attributes': customAttributes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  ConversationModel copyWith({
    int? id,
    String? displayId,
    String? status,
    int? unreadCount,
    DateTime? lastActivityAt,
    UserModel? assignee,
    ContactModel? contact,
    InboxModel? inbox,
    List<MessageModel>? messages,
    Map<String, dynamic>? customAttributes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ConversationModel(
      id: id ?? this.id,
      displayId: displayId ?? this.displayId,
      status: status ?? this.status,
      unreadCount: unreadCount ?? this.unreadCount,
      lastActivityAt: lastActivityAt ?? this.lastActivityAt,
      assignee: assignee ?? this.assignee,
      contact: contact ?? this.contact,
      inbox: inbox ?? this.inbox,
      messages: messages ?? this.messages,
      customAttributes: customAttributes ?? this.customAttributes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ConversationModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class ContactModel {
  final int id;
  final String name;
  final String? email;
  final String? phoneNumber;
  final String? avatar;
  final Map<String, dynamic>? customAttributes;
  final DateTime createdAt;

  ContactModel({
    required this.id,
    required this.name,
    this.email,
    this.phoneNumber,
    this.avatar,
    this.customAttributes,
    required this.createdAt,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      avatar: json['avatar'] as String?,
      customAttributes: json['custom_attributes'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'avatar': avatar,
      'custom_attributes': customAttributes,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class InboxModel {
  final int id;
  final String name;
  final String channelType;
  final DateTime createdAt;

  InboxModel({
    required this.id,
    required this.name,
    required this.channelType,
    required this.createdAt,
  });

  factory InboxModel.fromJson(Map<String, dynamic> json) {
    return InboxModel(
      id: json['id'] as int,
      name: json['name'] as String,
      channelType: json['channel_type'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'channel_type': channelType,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class MessageModel {
  final int id;
  final String content;
  final String messageType;
  final bool isPrivate;
  final UserModel? sender;
  final List<AttachmentModel> attachments;
  final DateTime createdAt;

  MessageModel({
    required this.id,
    required this.content,
    required this.messageType,
    required this.isPrivate,
    this.sender,
    required this.attachments,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as int,
      content: json['content'] as String,
      messageType: json['message_type'] as String,
      isPrivate: json['private'] as bool? ?? false,
      sender: json['sender'] != null
          ? UserModel.fromJson(json['sender'] as Map<String, dynamic>)
          : null,
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'message_type': messageType,
      'private': isPrivate,
      'sender': sender?.toJson(),
      'attachments': attachments.map((e) => e.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class AttachmentModel {
  final int id;
  final String fileName;
  final String fileType;
  final int fileSize;
  final String dataUrl;

  AttachmentModel({
    required this.id,
    required this.fileName,
    required this.fileType,
    required this.fileSize,
    required this.dataUrl,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) {
    return AttachmentModel(
      id: json['id'] as int,
      fileName: json['file_name'] as String,
      fileType: json['file_type'] as String,
      fileSize: json['file_size'] as int,
      dataUrl: json['data_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'file_name': fileName,
      'file_type': fileType,
      'file_size': fileSize,
      'data_url': dataUrl,
    };
  }
}

