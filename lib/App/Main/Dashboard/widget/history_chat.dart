part of dashboard;

class _historyChat extends StatelessWidget {
  final bool isLoading;

  const _historyChat({Key? key, this.isLoading = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(context),
        _HistoryCard(context),
      ],
    );
  }

  Widget _title(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 29.0, top: 14.0, bottom: 0.0, right: 29.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Riwayat Pesan",
            style: TextStyle(
              fontSize: 17,
              color: mainBlack,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => _AllhistoryChat()),
              );
            },
            child: Text(
              "Lihat Semua >>",
              style: TextStyle(
                fontSize: 12,
                color: Colors.blue,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
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
      height: 350,
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
            return EmptyChatHistory();
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

          // Display only the last 5 chat fields
          final displayedEntries = isFieldEntries.length > 4
              ? isFieldEntries.sublist(0, 4)
              : isFieldEntries;

          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: displayedEntries.length,
            itemBuilder: (context, index) {
              final isField = displayedEntries[index].key;
              final chatMessages = displayedEntries[index].value;
              String title = 'No title';

              // SUDAH BENAR
              if (chatMessages.length == 2) {
                // Mengambil inputan kedua dari pengguna setelah chat default 'Mamabot'
                title = chatMessages[0]['message'] ?? 'No title';
              } else if (chatMessages.length > 2) {
                // Mengambil inputan ketiga dari pengguna setelah chat default 'Mamabot'
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

class EmptyChatHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.all(50.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.blue,
            width: 2,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Riwayat chat belum ada',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Ketuk button + untuk memulai chat awal anda',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Icon(
              Icons.arrow_downward,
              size: 24,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}