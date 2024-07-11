library message;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trestapkmamabot/App/Auth/model/space.dart';
import 'package:trestapkmamabot/App/Main/Dashboard/screen/DashboardScreen.dart';
import 'package:trestapkmamabot/App/Main/Messages/controller/chatbot_controller.dart';
import 'package:trestapkmamabot/App/Main/Messages/model/color.dart';
import 'package:trestapkmamabot/App/Main/Messages/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

part '../widget/buble_chat.dart';
part '../widget/input_chat.dart';
part '../widget/background_messagesscreen.dart';
part '../widget/appBar_message.dart';

class MessagesScreen extends StatefulWidget {
  final List<Map<String, dynamic>> messages;
  final String isField;

  const MessagesScreen(
      {Key? key, required this.messages, required this.isField})
      : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController _controller = TextEditingController();
  late ChatbotController chatbotController;
  late FirestoreService firestoreService;
  double _textSize = 15.0;
  bool _showInitialBox = true;

  List<String> _promptTemplates = [];

  @override
  void initState() {
    super.initState();
    chatbotController = ChatbotController();
    firestoreService = FirestoreService();
    _fetchPromptTemplates();
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

  Future<void> _fetchPromptTemplates() async {
    List<String> templates = await firestoreService.getPromptTemplates();
    setState(() {
      _promptTemplates = templates;
    });
  }

  void _sendPrompt(String text) {
    _controller.text = text;
    sendMessage(text);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          _BackgroundImageMessage(),
          Column(
            children: [
              _AppBarMessage(
                increaseTextSize: _increaseTextSize,
                decreaseTextSize: _decreaseTextSize,
                textSize: _textSize,
              ),
              Expanded(
                child: Stack(
                  children: [
                    ListView.builder(
                      itemCount: widget.messages.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(10),
                          child: chatBubble(
                            message: widget.messages[index]['message'],
                            time: widget.messages[index]['time'],
                            isUserMessage: widget.messages[index]
                                ['isUserMessage'],
                            w: w,
                            textSize: _textSize,
                            intentName: widget.messages[index]['intentName'],
                            onLike: () => handleLike(index),
                            onDislike: () => handleDislike(index),
                          ),
                        );
                      },
                    ),
                    if (_showInitialBox)
                      SingleChildScrollView(
                        reverse: true,
                        child: Container(
                          margin: EdgeInsets.only(top: 70),
                          child: Center(
                            child: Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      right: 25.0,
                                      left: 25.0,
                                      top: 50,
                                      bottom: 50),
                                  child: Image.asset(
                                    'assets/images/KotakPrompt2.png',
                                    alignment: Alignment.center,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 60.0, right: 45.0, top: 170.0),
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Selamat datang di ',
                                              style: TextStyle(
                                                  color: AppColors
                                                      .textBlackButtonOnboarding,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w800,
                                                  height: 1.1,
                                                  fontFamily: 'Poppins'),
                                            ),
                                            TextSpan(
                                              text: 'Mama',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800,
                                                height: 1.1,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'Bot',
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800,
                                                height: 1.1,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 40.0, right: 40.0, top: 10.0),
                                      child: Text(
                                        'Untuk memulai percakapan, ketik “Mamabot". Kami hanya dapat berdiskusi mengenai tumbuh kembang anak atau informasi terkait tumbuh kembang anak yang terdapat di buku KIA dan SDIDTK.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 40.0, right: 40.0, top: 5.0),
                                      child: Text(
                                        'Atau, pilih salah satu prompt yang tersedia di bawah ini untuk memulai percakapan.Mari mulai dan temukan informasi yang Anda butuhkan!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    SpaceVH(
                                      height: 100,
                                    ),
                                    // ///////////////////// TEMPLATE PROMPT ////////////////
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 25),
                                      height: 80,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _promptTemplates.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () => _sendPrompt(
                                                _promptTemplates[index]),
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              padding: EdgeInsets.all(10.0),
                                              decoration: BoxDecoration(
                                                color: Color(0xFFC1EAFF),
                                                border: Border.all(
                                                    color: Color(0xFF008FD7)),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  _promptTemplates[index],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )

                                    // ///////////////////// TEMPLATE PROMPT ////////////////
                                  ],
                                ),
                                Positioned(
                                  top: -12,
                                  left: 130,
                                  width: 161,
                                  height: 179,
                                  child: Image.asset(
                                      'assets/images/NewRobotMamabot3.png'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              inputChat(
                controller: _controller,
                sendMessage: sendMessage,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // MessageScreen.dart
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

      // Update Firestore document for user if needed
      // await firestoreService.createUserDocument(user);

      setState(() {
        addMessage({
          'message': text,
          'isUserMessage': true,
          'time': currentTime,
        });
        _showInitialBox = false;
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

        setState(() {
          addMessage(responseMessage);
        });
      }
    }
  }

  void addMessage(Map<String, dynamic> message) {
    setState(() {
      widget.messages.add(message);
    });
  }

  void handleLike(int index) {
    sendMessage('iya,cukup membantu');
  }

  void handleDislike(int index) {
    sendMessage('belum bisa membantu');
  }
}
