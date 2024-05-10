library playpackage;

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dartssh2/dartssh2.dart';

class SshHelper {
  void runScript() async {
    print("Inside the Script");
    final client = SSHClient(
      await SSHSocket.connect('lab', 22),
      username: 'test',
      onPasswordRequest: () {
        return "test";
      },
    );


  final uptime = await client.run("uptime");
  print(utf8.decode(uptime));

  client.close();
  await client.done;
  }
}
