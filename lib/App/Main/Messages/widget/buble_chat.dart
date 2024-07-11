part of message;

Widget chatBubble({
  required String message,
  required String time,
  required bool isUserMessage,
  required double w,
  required double textSize,
  String? intentName,
  Function()? onLike,
  Function()? onDislike,
}) {
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
                      intentName != 'Fallback Intent - no' &&
                      intentName != 'Default Fallback Intent') ...[
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
                                  color:
                                      const Color.fromARGB(255, 142, 142, 142),
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
