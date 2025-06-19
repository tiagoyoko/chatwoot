import 'package:flutter/material.dart';
import '../../../../shared/constants/app_colors.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  final List<ChatItem> _chats = [
    ChatItem(
      id: '1',
      customerName: 'João Silva',
      lastMessage: 'Olá, preciso de ajuda com meu pedido',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      isUnread: true,
      status: ChatStatus.open,
    ),
    ChatItem(
      id: '2',
      customerName: 'Maria Santos',
      lastMessage: 'Obrigada pelo atendimento!',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      isUnread: false,
      status: ChatStatus.resolved,
    ),
    ChatItem(
      id: '3',
      customerName: 'Pedro Costa',
      lastMessage: 'Quando será entregue?',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isUnread: true,
      status: ChatStatus.pending,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implementar busca
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Implementar filtros
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _chats.length,
        itemBuilder: (context, index) {
          final chat = _chats[index];
          return _buildChatItem(chat);
        },
      ),
    );
  }

  Widget _buildChatItem(ChatItem chat) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: chat.isUnread ? AppColors.primary.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: chat.isUnread ? AppColors.primary.withOpacity(0.2) : Colors.transparent,
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Text(
            chat.customerName[0].toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                chat.customerName,
                style: TextStyle(
                  fontWeight: chat.isUnread ? FontWeight.bold : FontWeight.normal,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            _buildStatusChip(chat.status),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              chat.lastMessage,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: chat.isUnread ? FontWeight.w500 : FontWeight.normal,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              _formatTimestamp(chat.timestamp),
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
        trailing: chat.isUnread
            ? Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              )
            : null,
        onTap: () {
          // Navegar para a conversa
        },
      ),
    );
  }

  Widget _buildStatusChip(ChatStatus status) {
    Color color;
    String text;
    
    switch (status) {
      case ChatStatus.open:
        color = AppColors.success;
        text = 'Aberto';
        break;
      case ChatStatus.pending:
        color = AppColors.warning;
        text = 'Pendente';
        break;
      case ChatStatus.resolved:
        color = AppColors.grey;
        text = 'Resolvido';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}min atrás';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h atrás';
    } else {
      return '${difference.inDays}d atrás';
    }
  }
}

class ChatItem {
  final String id;
  final String customerName;
  final String lastMessage;
  final DateTime timestamp;
  final bool isUnread;
  final ChatStatus status;

  ChatItem({
    required this.id,
    required this.customerName,
    required this.lastMessage,
    required this.timestamp,
    required this.isUnread,
    required this.status,
  });
}

enum ChatStatus { open, pending, resolved }

