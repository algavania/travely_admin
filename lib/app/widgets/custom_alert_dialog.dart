import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function onYesTap;

  const CustomAlertDialog(
      {Key? key, required this.title, required this.content, required this.onYesTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 40.0),
          margin: const EdgeInsets.only(top: 35.0),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: const [
                BoxShadow(color: Colors.black, offset: Offset(0, 5), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  content,
                  style: TextStyle(fontSize: 12.sp),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Tidak',
                            style:
                                TextStyle(fontWeight: FontWeight.w500, color: Colors.grey))),
                    TextButton(
                        onPressed: () {
                          onYesTap();
                          Navigator.of(context).pop();
                        },
                        child: const Text('Iya',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, color: Colors.orange))),
                  ],
                ),
              )
            ],
          ),
        ),
        const Positioned(
          left: 5.0,
          right: 5.0,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35.0,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                child: Icon(
                  Icons.warning_rounded,
                  color: Colors.orange,
                  size: 50.0,
                )),
          ),
        ),
      ],
    );
  }
}
