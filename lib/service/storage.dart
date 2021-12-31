import 'dart:async';
import 'dart:io' as io;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// import 'ProgressBar.dart';

class Storage {
  File? _image;
  final picker = ImagePicker();
  late String url = '';

  Future getImage(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return pickedFile;
    } else {
      return null;
    }
  }

  Future uploadFile(File file, context) async {
    if (file == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No file was selected")));
      return null;
    }

    //show Progress bar

    showDialog(context: context, builder: (context) => ProgressBar());

    firebase_storage.UploadTask uploadTask;
    // Random rand = new Random();

    _image = File(file.path);
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('photos')
        .child('/${DateTime.now().toIso8601String()}');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      uploadTask = ref.putFile(io.File(file.path), metadata);
    }
    uploadTask.snapshotEvents.listen((event) {
      progress.value =
          (100 * (event.bytesTransferred / event.totalBytes)).round();
      print('${(100 * (event.bytesTransferred / event.totalBytes)).round()}');
    });

    await uploadTask.whenComplete(() {
      Navigator.pop(context);
      print('finished upload');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Image uploaded successfully")));
      // progress.value = 0;
    });

    this.url = await ref.getDownloadURL();
  }

  String getUrl() {
    return this.url;
  }
}

ValueNotifier<int> progress = ValueNotifier<int>(0);

class ProgressBar extends StatefulWidget {
  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  void initState() {
    progress.value = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 80,
      width: MediaQuery.of(context).size.width / 2.4,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Text('Uploading..'),
          // ValueListenableBuilder(
          //     valueListenable: progress,
          //     builder: (BuildContext context, int prog, _) {
          //       return FAProgressBar(
          //         currentValue: prog,
          //         displayText: '%',
          //       );
          //     })
        ],
      ),
    );
  }
}
