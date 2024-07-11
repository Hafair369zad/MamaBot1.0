part of dashboard;

class HistoryMessageScreen extends StatefulWidget {
  final String isField;

  const HistoryMessageScreen({Key? key, required this.isField})
      : super(key: key);

  @override
  _HistoryMessageScreenState createState() => _HistoryMessageScreenState();
}

class _HistoryMessageScreenState extends State<HistoryMessageScreen> {
  final TextEditingController _controller = TextEditingController();
  late FirestoreService firestoreService;
  late Stream<QuerySnapshot> chatStream;
  late ChatbotController chatbotController;
  double _textSize = 15.0;
  // String? intentName;

  @override
  void initState() {
    super.initState();
    firestoreService = FirestoreService();
    chatbotController = ChatbotController();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      chatStream = FirebaseFirestore.instance
          .collection('Chats')
          .doc(user.uid)
          .collection('messages')
          .where('isField', isEqualTo: widget.isField)
          .orderBy('timestamp')
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          const _BackgroundImageMessage(),
          Column(
            children: [
              _AppBarMessage(
                increaseTextSize: _increaseTextSize,
                decreaseTextSize: _decreaseTextSize,
                textSize: _textSize,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: chatStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final messages = snapshot.data!.docs
                        .map((doc) => doc.data() as Map<String, dynamic>)
                        .toList();

                    return ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(10),
                          child: chatBubble(
                            message: messages[index]['message'],
                            time: messages[index]['timestamp'] != null
                                ? DateFormat('hh:mm a').format(
                                    messages[index]['timestamp'].toDate())
                                : 'Unknown time',
                            isUserMessage: messages[index]['senderId'] ==
                                FirebaseAuth.instance.currentUser!.uid,
                            w: w,
                            textSize: _textSize,
                            intentName: messages[index]['intentName'],
                            onLike: () => handleLike(index),
                            onDislike: () => handleDislike(index),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: inputChat(
                  controller: _controller,
                  sendMessage: sendMessage,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      //

      // text = text.replaceAll(
      //     RegExp(r'\b1 tahun\b|\b1 thn\b|\b1 Tahun\b|\bsatu tahun\b'),
      //     '12 bulan');

      // 6 bulan
      text = text.replaceAll(
          RegExp(
              r'\b0.5 tahun\b|\b0.5 thn\b|\b0,5 tahun\b|\b0,5 TAHUN\b|\b0,5 thn\b|\bsetengah tahun\b'),
          '6 bulan');

      // 12 bulan
      text = text.replaceAll(
          RegExp(
              r'\b1 tahun\b|\b1 thn\b|\b1 Tahun\b|\b1 TAHUN\b|\bsatu tahun\b|\bsatu thn\b'),
          '12 bulan');

      // 18 bulan
      text = text.replaceAll(
          RegExp(
              r'\b1.5 tahun\b|\b1.5 thn\b|\b1,5 TAHUN\b|\b1,5 tahun\b|\b1,5 thn\b|\bsatu setengah tahun\b'),
          '18 bulan');

      // 24 bulan
      text = text.replaceAll(
          RegExp(
              r'\b2 tahun\b|\b2 thn\b|\b2 Tahun\b|\b2 TAHUN\b|\bdua tahun\b|\bdua thn\b'),
          '24 bulan');

      // 30 bulan
      text = text.replaceAll(
          RegExp(
              r'\b2.5 tahun\b|\b2.5 thn\b|\b2,5 tahun\b|\b2,5 TAHUN\b|\b2,5 thn\b|\bdua setengah tahun\b'),
          '30 bulan');

      // 36 bulan
      text = text.replaceAll(
          RegExp(
              r'\b3 tahun\b|\b3 thn\b|\b3 Tahun\b|\b3 TAHUN\b|\btiga tahun\b|\btiga thn\b'),
          '36 bulan');

      // 42 bulan
      text = text.replaceAll(
          RegExp(
              r'\b3.5 tahun\b|\b3.5 thn\b|\b3,5 tahun\b|\b3,5 TAHUN\b|\b3,5 thn\b|\btiga setengah tahun\b'),
          '42 bulan');

      // 48 bulan
      text = text.replaceAll(
          RegExp(
              r'\b4 tahun\b|\b4 thn\b|\b4 Tahun\b|\b4 TAHUN\b|\bempat tahun\b|\bempat thn\b'),
          '48 bulan');

      // 54 bulan
      text = text.replaceAll(
          RegExp(
              r'\b4.5 tahun\b|\b4.5 thn\b|\b4,5 tahun\b|\b4,5 TAHUN\b|\b4,5 thn\b|\bempat setengah tahun\b'),
          '54 bulan');

      // 60 bulan
      text = text.replaceAll(
          RegExp(
              r'\b5 tahun\b|\b5 thn\b|\b5 Tahun\b|\b5 TAHUN\b|\blima tahun\b|\blima thn\b'),
          '60 bulan');

      // 66 bulan
      text = text.replaceAll(
          RegExp(
              r'\b5.5 tahun\b|\b5.5 thn\b|\b5,5 tahun\b|\b5,5 TAHUN\b|\b5,5 thn\b|\blima setengah tahun\b'),
          '66 bulan');

      // 72 bulan
      text = text.replaceAll(
          RegExp(
              r'\b6 tahun\b|\b6 thn\b|\b6 Tahun\b|\b6 TAHUN\b|\benam tahun\b|\benam thn\b'),
          '72 bulan');

      //

      String currentTime = DateFormat('hh:mm a').format(DateTime.now());
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      String chatId = user.uid;

      // Add user message to Firestore using FirestoreService
      await firestoreService.addMessage(
          chatId, user.uid, 'bot', text, currentTime, widget.isField);

      setState(() {
        _controller.clear();
      });

      Map<String, dynamic> responseMessage =
          await chatbotController.sendMessage(text);
      if (responseMessage.isNotEmpty) {
        String intentName = responseMessage['intentName'];

        if (intentName == 'Fallback Intent - yes') {
          responseMessage['message'];
        } else if (intentName == 'Fallback Intent - no') {
          responseMessage['message'];
        }

        responseMessage['time'] = DateFormat('hh:mm a').format(DateTime.now());
        responseMessage['isUserMessage'] = false;

        // Add bot response to Firestore using FirestoreService
        await firestoreService.addMessage(
            chatId,
            'bot',
            user.uid,
            responseMessage['message'],
            responseMessage['time'],
            widget.isField);
      }
    }
  }

  void handleLike(int index) {
    sendMessage('iya,cukup membantu');
  }

  void handleDislike(int index) {
    sendMessage('belum bisa membantu');
  }

  void _increaseTextSize() {
    setState(() {
      _textSize += 1;
    });
  }

  void _decreaseTextSize() {
    setState(() {
      if (_textSize > 10) {
        _textSize -= 1;
      }
    });
  }
}

class _BackgroundImageMessage extends StatelessWidget {
  const _BackgroundImageMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Container(
            color: AppColors.FillWhiteOnboarding,
          ),
          Image.asset(
            'assets/images/DotGridMessage.png',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ],
      ),
    );
  }
}

class _AppBarMessage extends StatefulWidget {
  final VoidCallback increaseTextSize;
  final VoidCallback decreaseTextSize;
  final double textSize;

  const _AppBarMessage({
    Key? key,
    required this.increaseTextSize,
    required this.decreaseTextSize,
    required this.textSize,
  }) : super(key: key);

  @override
  State<_AppBarMessage> createState() => _AppBarMessageState();
}

class _AppBarMessageState extends State<_AppBarMessage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(right: 28.0, left: 28.0, top: 30.0, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // tombol back arrow
          CircleAvatar(
            backgroundColor: Colors.black,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardScreen(),
                  ),
                );
              },
            ),
          ),
          //
          // dropdown pilih history chat
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              width: 133,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.BlueButtonOnboardingBG,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                    color: AppColors.BlueButtonOnboarding, width: 1.0),
              ),
              child: Center(
                child: Text(
                  'Riwayat Chat',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          // menu pengaturan chat
          CircleAvatar(
            backgroundColor: Colors.black,
            child: PopupMenuButton<int>(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
                size: 25,
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem<int>(
                    enabled: false,
                    child: Text(
                      'Ubah Ukuran Chat',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.add, color: Colors.black),
                              onPressed: () {
                                widget.increaseTextSize();
                                setState(() {});
                              },
                            ),
                            Text(
                              '${widget.textSize.toInt()}',
                              style: TextStyle(color: Colors.black),
                            ),
                            IconButton(
                              icon: Icon(Icons.remove, color: Colors.black),
                              onPressed: () {
                                widget.decreaseTextSize();
                                setState(() {});
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ];
              },
            ),
          ),
        ],
      ),
    );
  }
}

class inputChat extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) sendMessage;

  const inputChat({
    Key? key,
    required this.controller,
    required this.sendMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
            margin: EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 8),
            decoration: BoxDecoration(
              color: AppColors.botMessageBackground,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5.0,
                  offset: Offset(0.5, 0.5),
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              style: TextStyle(
                color: AppColors.InputText,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.none,
              ),
              decoration: InputDecoration(
                hintText: 'Tanyakan sesuatu...',
                hintStyle: TextStyle(
                  color: AppColors.hintInputText,
                  fontSize: 15,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            iconSize: 35,
            onPressed: () {
              sendMessage(controller.text);
              controller.clear();
            },
            icon: Icon(
              Icons.send_rounded,
              color: AppColors.BlueButtonOnboarding,
            ),
          ),
        ),
      ],
    );
  }
}

//
class chatBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isUserMessage;
  final double w;
  final double textSize;
  final String? intentName;
  final Function()? onLike;
  final Function()? onDislike;

  const chatBubble({
    Key? key,
    required this.message,
    required this.time,
    required this.isUserMessage,
    required this.w,
    required this.textSize,
    this.intentName,
    this.onLike,
    this.onDislike,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxWidth = isUserMessage ? w * 0.5 : w * 0.8;

    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Column(
        crossAxisAlignment:
            isUserMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(isUserMessage ? 20 : 0),
                topRight: Radius.circular(isUserMessage ? 20 : 20),
                bottomRight: Radius.circular(isUserMessage ? 0 : 20),
                topLeft: Radius.circular(isUserMessage ? 20 : 20),
              ),
              color: isUserMessage
                  ? AppColors.userMessageBackground
                  : AppColors.botMessageBackground,
            ),
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isUserMessage ? 'Anda' : 'Mamabot',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: textSize,
                        color: isUserMessage
                            ? Colors.white
                            : AppColors.AppTextMessageBot,
                      ),
                    ),
                    SizedBox(height: 7),
                    Container(
                      margin: EdgeInsets.only(bottom: 30, right: 10),
                      child: SelectableText(
                        message,
                        style: TextStyle(
                          fontSize: textSize,
                          fontWeight: FontWeight.w500,
                          color: isUserMessage ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    if (!isUserMessage &&
                        intentName != 'Default Welcome Intent' &&
                        intentName != 'Fallback Intent - yes' &&
                        intentName != 'Fallback Intent - no') ...[
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                ElevatedButton(
                                  onPressed: onLike,
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    backgroundColor:
                                        Color.fromARGB(255, 184, 230, 255),
                                    side: BorderSide(
                                      color: Color.fromARGB(255, 56, 139, 207),
                                    ),
                                    padding: EdgeInsets.all(8),
                                  ),
                                  child: Icon(
                                    Icons.thumb_up,
                                    color: Color.fromARGB(255, 56, 139, 207),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Iya',
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 142, 142, 142),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 10),
                            Column(
                              children: [
                                ElevatedButton(
                                  onPressed: onDislike,
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    backgroundColor:
                                        Color.fromARGB(255, 218, 222, 225),
                                    side: BorderSide(
                                      color: Color.fromARGB(255, 113, 113, 113),
                                    ),
                                    padding: EdgeInsets.all(8),
                                  ),
                                  child: Icon(
                                    Icons.thumb_down,
                                    color: Color.fromARGB(255, 113, 113, 113),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Tidak',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 5),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Text(
                    time,
                    style: TextStyle(
                      fontSize: 11,
                      color: isUserMessage ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
