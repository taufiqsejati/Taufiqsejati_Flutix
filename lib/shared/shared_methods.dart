part of 'shared.dart';

Future<File> getImage() async {
  // var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  var logger = Logger();
  logger.d("Logger is working1!", image);
  return image;
}

Future<String> uploadImage(File image) async {
  String fileName = basename(image.path);
  String imgUrl;
  var logger = Logger();
  logger.d("Line 1 ${fileName}");
  FirebaseStorage storage = FirebaseStorage.instance;
  Reference ref = storage.ref().child(fileName);
  logger.d("Line 2 ${ref}");
  UploadTask task = ref.putFile(image);
  imgUrl = await (await task).ref.getDownloadURL();
  logger.d("Line 3 ${imgUrl}");
  return imgUrl;
  // task.then((res) async {
  //   logger.d("Line 3 ${res.ref.getDownloadURL().toString()}");
  //   return await res.ref.getDownloadURL();
  // });
  // await task.whenComplete(() {
  //   var logger = Logger();
  //   logger.d("Logger is working2!");
  //   return ref.getDownloadURL();
  // }).catchError((onError) {
  //   print('ini error upload ${onError}');
  //   var logger = Logger();
  //   logger.d("Logger is working3!");
  // });
  // task.then((res) {
  //   res.ref.getDownloadURL();
  // });
  // Reference snapshot = await task.onComplete;

  // return await snapshot.ref.getDownloadURL();
}

Widget generateDashedDivider(double width) {
  int n = width ~/ 5;
  return Row(
    children: List.generate(
        n,
        (index) => (index % 2 == 0)
            ? Container(
                height: 2,
                width: width / n,
                color: Color(0xFFE4E4E4),
              )
            : SizedBox(
                width: width / n,
              )),
  );
}
