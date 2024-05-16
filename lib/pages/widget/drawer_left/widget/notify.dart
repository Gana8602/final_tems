import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.notifications_outlined,
        color: Colors.white,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
            child: ListTile(
          title: const Text('Station Bitarkanika National Park - Buoy'),
          subtitle: Text('${DateTime.now()}'),
          trailing: const Icon(Icons.delete),
          leading: Image.asset('assets/image/general.png'),
        )),
        PopupMenuItem(
            child: ListTile(
          title: const Text('Station Bitarkanika National Park - Buoy'),
          subtitle: Text('${DateTime.now()}'),
          trailing: const Icon(Icons.delete),
          leading: Image.asset('assets/image/general.png'),
        ))
      ],
    );
  }
}
