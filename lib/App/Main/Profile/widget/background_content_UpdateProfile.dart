part of ProfileUpdate;

class _BackgroundContentUpdateProfile extends StatelessWidget {
  const _BackgroundContentUpdateProfile({required this.child, Key? key})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      child: child,
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          )),
    );
  }
}
