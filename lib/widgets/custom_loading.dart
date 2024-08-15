import 'package:flutter/material.dart';

// mpesaWaitingMessage
class CustomLoadingDialog extends StatefulWidget {
  const CustomLoadingDialog(
      {super.key, this.message, this.color, this.isMpesa = false});
  final String? message;
  final Color? color;
  final bool isMpesa;

  @override
  State<CustomLoadingDialog> createState() => _CustomLoadingDialogState();
}

class _CustomLoadingDialogState extends State<CustomLoadingDialog> {
  String image = "";

  @override
  void initState() {
    image = "assets/icon/TanzmedIcon.gif";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isMpesa
        ? Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 300,
              width: 400,
              child: Dialog(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: Center(
                        key: UniqueKey(),
                        child: Image.asset(
                          image,
                          key: UniqueKey(),
                        ),
                      ),
                    ),
                    Text(
                      "mpesaWaitingMessage",
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          )
        : Center(
            child: SizedBox(
              height: 150,
              width: 150,
              child: Center(
                key: UniqueKey(),
                child: Image.asset(
                  image,
                  key: UniqueKey(),
                ),
              ),
            ),
          );
  }
}
