// part of message;

// Widget inputChat({
//   required TextEditingController controller,
//   required Function(String) sendMessage,
// }) {
//   return Container(
//     padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//     margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//     decoration: BoxDecoration(
//       color: AppColors.botMessageBackground,
//       borderRadius: BorderRadius.circular(20),
//       // border: Border.all(color: Colors.black, width: 1.0),
//     ),
//     child: Row(
//       children: [
//         Expanded(
//           child: TextField(
//             controller: controller,
//             style: TextStyle(
//                 color: AppColors.InputText,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 decoration: TextDecoration.none),
//             decoration: InputDecoration(
//               hintText: 'Tanyakan sesuatu...',
//               hintStyle:
//                   TextStyle(color: AppColors.hintInputText, fontSize: 15),
//               border: InputBorder.none,
//             ),
//           ),
//         ),
//         IconButton(
//           onPressed: () {
//             sendMessage(controller.text);
//             controller.clear();
//           },
//           icon: Icon(
//             Icons.send,
//             color: AppColors.sendButtonColor,
//           ),
//         ),
//       ],
//     ),
//   );
// }
part of message;

Widget inputChat({
  required TextEditingController controller,
  required Function(String) sendMessage,
}) {
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
