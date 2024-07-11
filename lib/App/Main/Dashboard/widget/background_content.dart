part of dashboard;

class _BackgroundContent extends StatelessWidget {
  const _BackgroundContent({required this.child, Key? key}) : super(key: key);

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
