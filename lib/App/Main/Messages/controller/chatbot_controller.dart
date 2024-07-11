// controllers/chatbot_controller.dart

import 'package:dialog_flowtter/dialog_flowtter.dart';

class ChatbotController {
  late DialogFlowtter dialogFlowtter;

  ChatbotController() {
    init();
  }

  void init() async {
    dialogFlowtter = await DialogFlowtter.fromFile();
  }

  Future<Map<String, dynamic>> sendMessage(String text) async {
    DetectIntentResponse response = await dialogFlowtter.detectIntent(
      queryInput: QueryInput(text: TextInput(text: text)),
    );
    if (response.message == null) return {};
    String intentName = response.queryResult?.intent?.displayName ?? '';
    return {
      'message': response.message!.text?.text?[0] ?? '',
      'isUserMessage': false,
      'intentName': intentName,
    };
  }
}
