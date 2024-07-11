part of profile;

class _WebMaintenance extends StatelessWidget {
  const _WebMaintenance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'MamaBot',
          style: TextStyle(
            color: white,
          ),
        ),
        backgroundColor: black,
      ),
      body: Center(
        child: Text(
          'Sorry,Under Maintenance',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
