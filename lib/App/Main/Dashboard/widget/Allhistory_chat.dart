part of dashboard;

class _AllhistoryChat extends StatefulWidget {
  const _AllhistoryChat({Key? key}) : super(key: key);

  @override
  _AllhistoryChatState createState() => _AllhistoryChatState();
}

class _AllhistoryChatState extends State<_AllhistoryChat> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = "";
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: _isSearching
            ? TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Cari histori pesan',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: FillOnboarding),
                ),
                style: TextStyle(color: FillOnboarding),
                autofocus: true,
              )
            : Text('All History Chat'),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: _toggleSearch,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HistoryCard(context),
          ],
        ),
      ),
    );
  }

  Widget _skeletonCard() {
    return SkeletonAnimation(
      child: Container(
        width: double.infinity,
        height: 80,
        margin: EdgeInsets.only(
          left: 25,
          right: 25,
          bottom: 10,
          top: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Widget _HistoryCard(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Chats')
            .doc(user?.uid)
            .collection('messages')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView(
              scrollDirection: Axis.vertical,
              children: List.generate(4, (index) => _skeletonCard()),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No chat history'));
          }

          final messages = snapshot.data!.docs;
          final isFieldMap = <String, List<Map<String, dynamic>>>{};

          for (var message in messages) {
            final data = message.data() as Map<String, dynamic>;
            final isField = data['isField'] ?? 'unknown';
            if (!isFieldMap.containsKey(isField)) {
              isFieldMap[isField] = [];
            }
            isFieldMap[isField]!.add(data);
          }

          final isFieldEntries = isFieldMap.entries.toList();
          final filteredEntries = isFieldEntries.where((entry) {
            String title = '';
            final chatMessages = entry.value;
            if (chatMessages.length == 2) {
              title = chatMessages[0]['message'] ?? 'No title';
            } else if (chatMessages.length > 2) {
              title = chatMessages[2]['message'] ?? 'No title';
            }
            return title.toLowerCase().contains(_searchText);
          }).toList();

          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: filteredEntries.length,
            itemBuilder: (context, index) {
              final isField = filteredEntries[index].key;
              final chatMessages = filteredEntries[index].value;
              String title = 'No title';

              if (chatMessages.length == 2) {
                title = chatMessages[0]['message'] ?? 'No title';
              } else if (chatMessages.length > 2) {
                title = chatMessages[2]['message'] ?? 'No title';
              }
              return _listVerticalCard(context, title, isField);
            },
          );
        },
      ),
    );
  }

  Widget _listVerticalCard(BuildContext context, String title, String isField) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HistoryMessageScreen(isField: isField),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 80,
        margin: EdgeInsets.only(left: 25, right: 25, bottom: 10, top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.black,
            width: 1,
            style: BorderStyle.solid,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xEDF2F8).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 0),
              child: Container(
                width: 40,
                height: 40,
                child: Image.asset(
                  'assets/icon/lightning2.png',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  bottom: 0,
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
