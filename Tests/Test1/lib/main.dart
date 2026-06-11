import 'package:flutter/material.dart';

void main() {
  runApp(const MessengerCloneApp());
}

class MessengerCloneApp extends StatelessWidget {
  const MessengerCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Messenger Clone',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0084FF),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Arial',
      ),
      home: const MessengerHomePage(),
    );
  }
}

class MessengerHomePage extends StatefulWidget {
  const MessengerHomePage({super.key});

  @override
  State<MessengerHomePage> createState() => _MessengerHomePageState();
}

class _MessengerHomePageState extends State<MessengerHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: const [ChatScreen(), PeopleScreen()],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        height: 68,
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFE7F1FF),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.chat_bubble),
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chats',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.people),
            icon: Icon(Icons.people_outline),
            label: 'People',
          ),
        ],
      ),
    );
  }
}

class Contact {
  const Contact({
    required this.name,
    required this.avatarUrl,
    required this.avatarColor,
    this.lastMessage,
    this.lastActive,
    this.isOnline = false,
  });

  final String name;
  final String avatarUrl;
  final Color avatarColor;
  final String? lastMessage;
  final String? lastActive;
  final bool isOnline;
}

const List<Contact> suggestedContacts = [
  Contact(
    name: 'Ngoc Anh',
    avatarUrl: 'https://i.pravatar.cc/150?img=44',
    avatarColor: Color(0xFFFF8A80),
    isOnline: true,
  ),
  Contact(
    name: 'Minh Quan',
    avatarUrl: 'https://i.pravatar.cc/150?img=32',
    avatarColor: Color(0xFF80CBC4),
    isOnline: true,
  ),
  Contact(
    name: 'Thanh Truc',
    avatarUrl: 'https://i.pravatar.cc/150?img=49',
    avatarColor: Color(0xFFFFCC80),
  ),
  Contact(
    name: 'Gia Huy',
    avatarUrl: 'https://i.pravatar.cc/150?img=12',
    avatarColor: Color(0xFFA5D6A7),
    isOnline: true,
  ),
  Contact(
    name: 'Bao Chau',
    avatarUrl: 'https://i.pravatar.cc/150?img=47',
    avatarColor: Color(0xFFB39DDB),
  ),
];

const List<Contact> recentChats = [
  Contact(
    name: 'Ngoc Anh',
    avatarUrl: 'https://i.pravatar.cc/150?img=44',
    avatarColor: Color(0xFFFF8A80),
    lastMessage: 'Mai gap nhe!',
    lastActive: '11:15',
    isOnline: true,
  ),
  Contact(
    name: 'Minh Quan',
    avatarUrl: 'https://i.pravatar.cc/150?img=32',
    avatarColor: Color(0xFF80CBC4),
    lastMessage: 'Gui minh file bai tap voi.',
    lastActive: '10:42',
    isOnline: true,
  ),
  Contact(
    name: 'Thanh Truc',
    avatarUrl: 'https://i.pravatar.cc/150?img=49',
    avatarColor: Color(0xFFFFCC80),
    lastMessage: 'Ok, minh xem roi.',
    lastActive: '09:30',
  ),
  Contact(
    name: 'Gia Huy',
    avatarUrl: 'https://i.pravatar.cc/150?img=12',
    avatarColor: Color(0xFFA5D6A7),
    lastMessage: 'Dang tren duong toi lop.',
    lastActive: 'Yesterday',
    isOnline: true,
  ),
  Contact(
    name: 'Bao Chau',
    avatarUrl: 'https://i.pravatar.cc/150?img=47',
    avatarColor: Color(0xFFB39DDB),
    lastMessage: 'Cam on ban nha.',
    lastActive: 'Sunday',
  ),
  Contact(
    name: 'Tuan Kiet',
    avatarUrl: 'https://i.pravatar.cc/150?img=59',
    avatarColor: Color(0xFFFFAB91),
    lastMessage: 'Chieu nay hoc Flutter.',
    lastActive: 'Saturday',
  ),
];

const List<Contact> peopleContacts = [
  ...suggestedContacts,
  Contact(
    name: 'Tuan Kiet',
    avatarUrl: 'https://i.pravatar.cc/150?img=59',
    avatarColor: Color(0xFFFFAB91),
    isOnline: true,
  ),
  Contact(
    name: 'Phuong Linh',
    avatarUrl: 'https://i.pravatar.cc/150?img=9',
    avatarColor: Color(0xFF90CAF9),
  ),
  Contact(
    name: 'Duc Anh',
    avatarUrl: 'https://i.pravatar.cc/150?img=68',
    avatarColor: Color(0xFFE6EE9C),
    isOnline: true,
  ),
  Contact(
    name: 'Mai Lan',
    avatarUrl: 'https://i.pravatar.cc/150?img=5',
    avatarColor: Color(0xFFF48FB1),
  ),
  Contact(
    name: 'Hoang Nam',
    avatarUrl: 'https://i.pravatar.cc/150?img=14',
    avatarColor: Color(0xFFCE93D8),
  ),
];

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Contact> get _filteredSuggestions {
    return _filterContacts(suggestedContacts);
  }

  List<Contact> get _filteredChats {
    return _filterContacts(recentChats);
  }

  List<Contact> _filterContacts(List<Contact> contacts) {
    final normalizedQuery = _query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) {
      return contacts;
    }

    return contacts.where((contact) {
      final name = contact.name.toLowerCase();
      final message = contact.lastMessage?.toLowerCase() ?? '';
      return name.contains(normalizedQuery) ||
          message.contains(normalizedQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredSuggestions = _filteredSuggestions;
    final filteredChats = _filteredChats;

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 16, 20, 10),
            child: ScreenHeader(title: 'Chats', showChatActions: true),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SearchField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _query = value;
                });
              },
              onClear: () {
                _searchController.clear();
                setState(() {
                  _query = '';
                });
              },
            ),
          ),
        ),
        if (filteredSuggestions.isNotEmpty)
          SliverToBoxAdapter(
            child: SizedBox(
              height: 140,
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return SuggestedContactCard(
                    key: ValueKey(
                      'suggestion-${filteredSuggestions[index].name}',
                    ),
                    contact: filteredSuggestions[index],
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemCount: filteredSuggestions.length,
              ),
            ),
          ),
        if (filteredChats.isEmpty)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: EmptySearchResult(),
          )
        else
          SliverList.separated(
            itemBuilder: (context, index) {
              return ChatListTile(
                key: ValueKey('chat-${filteredChats[index].name}'),
                contact: filteredChats[index],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 2),
            itemCount: filteredChats.length,
          ),
        const SliverToBoxAdapter(child: SizedBox(height: 12)),
      ],
    );
  }
}

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 16, 20, 10),
            child: ScreenHeader(title: 'People'),
          ),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Text(
              'Active friends',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF65676B),
              ),
            ),
          ),
        ),
        SliverList.separated(
          itemBuilder: (context, index) {
            return PeopleListTile(
              key: ValueKey('person-${peopleContacts[index].name}'),
              contact: peopleContacts[index],
            );
          },
          separatorBuilder: (context, index) => const Divider(
            indent: 88,
            endIndent: 20,
            height: 1,
            color: Color(0xFFECEFF3),
          ),
          itemCount: peopleContacts.length,
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 12)),
      ],
    );
  }
}

class ScreenHeader extends StatelessWidget {
  const ScreenHeader({
    super.key,
    required this.title,
    this.showChatActions = false,
  });

  final String title;
  final bool showChatActions;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Avatar(
          name: 'Me',
          imageUrl: 'https://i.pravatar.cc/150?img=60',
          color: const Color(0xFF455A64),
          size: 42,
          showOnlineBadge: false,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 31,
              fontWeight: FontWeight.w800,
              color: Color(0xFF111111),
            ),
          ),
        ),
        if (showChatActions) ...[
          HeaderIconButton(
            icon: Icons.camera_alt,
            tooltip: 'Camera',
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
        HeaderIconButton(
          icon: showChatActions ? Icons.edit : Icons.person_add,
          tooltip: showChatActions ? 'New message' : 'Add friend',
          onPressed: () {},
        ),
      ],
    );
  }
}

class HeaderIconButton extends StatelessWidget {
  const HeaderIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 40,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 21),
        tooltip: tooltip,
        style: IconButton.styleFrom(
          backgroundColor: const Color(0xFFF0F2F5),
          foregroundColor: const Color(0xFF111111),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Search Messenger',
        hintStyle: const TextStyle(
          color: Color(0xFF6E737B),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: const Icon(Icons.search, color: Color(0xFF7A7F87)),
        suffixIcon: controller.text.isEmpty
            ? null
            : IconButton(
                onPressed: onClear,
                icon: const Icon(Icons.close, size: 20),
                color: const Color(0xFF7A7F87),
                tooltip: 'Clear search',
              ),
        filled: true,
        fillColor: const Color(0xFFF3F4F6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }
}

class EmptySearchResult extends StatelessWidget {
  const EmptySearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Text(
          'No conversations found',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF65676B),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class SuggestedContactCard extends StatelessWidget {
  const SuggestedContactCard({super.key, required this.contact});

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      child: Column(
        children: [
          Avatar(
            name: contact.name,
            imageUrl: contact.avatarUrl,
            color: contact.avatarColor,
            size: 62,
            showOnlineBadge: contact.isOnline,
          ),
          const SizedBox(height: 8),
          Text(
            contact.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF242526),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatListTile extends StatelessWidget {
  const ChatListTile({super.key, required this.contact});

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Avatar(
        name: contact.name,
        imageUrl: contact.avatarUrl,
        color: contact.avatarColor,
        size: 58,
        showOnlineBadge: contact.isOnline,
      ),
      title: Text(
        contact.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Color(0xFF1C1E21),
        ),
      ),
      subtitle: Text(
        '${contact.lastMessage} - ${contact.lastActive}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 14, color: Color(0xFF65676B)),
      ),
      trailing: contact.isOnline
          ? const SizedBox(
              width: 10,
              height: 10,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFF0084FF),
                  shape: BoxShape.circle,
                ),
              ),
            )
          : const Icon(Icons.check_circle, size: 18, color: Color(0xFFBCC0C4)),
    );
  }
}

class PeopleListTile extends StatelessWidget {
  const PeopleListTile({super.key, required this.contact});

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 12,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      leading: Avatar(
        name: contact.name,
        imageUrl: contact.avatarUrl,
        color: contact.avatarColor,
        size: 54,
        showOnlineBadge: contact.isOnline,
      ),
      title: Text(
        contact.name,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Color(0xFF1C1E21),
        ),
      ),
      subtitle: Text(
        contact.isOnline ? 'Active now' : 'Offline',
        style: TextStyle(
          fontSize: 13,
          color: contact.isOnline
              ? const Color(0xFF21A85B)
              : const Color(0xFF73777F),
        ),
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.color,
    required this.size,
    required this.showOnlineBadge,
  });

  final String name;
  final String imageUrl;
  final Color color;
  final double size;
  final bool showOnlineBadge;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: size / 2,
          backgroundColor: color,
          child: ClipOval(
            child: Image.network(
              key: ValueKey('$name-$imageUrl'),
              imageUrl,
              width: size,
              height: size,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Text(
                    _initials,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size * 0.32,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        if (showOnlineBadge)
          Positioned(
            right: 1,
            bottom: 1,
            child: Container(
              width: size * 0.25,
              height: size * 0.25,
              decoration: BoxDecoration(
                color: const Color(0xFF31A24C),
                border: Border.all(color: Colors.white, width: 2),
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }

  String get _initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
}
