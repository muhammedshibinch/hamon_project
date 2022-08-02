import 'package:flutter/material.dart';
import 'package:hamon_project/controllers/classroom_provider.dart';
import 'package:hamon_project/utils/utils.dart';
import 'package:hamon_project/views/classroom/widgets/room_space.dart';
import 'package:provider/provider.dart';
import '../../models/classroom_model.dart';
import 'widgets/subject_adding_dialog.dart';

class RoomDetailPage extends StatefulWidget {
  final Room roomModel;
  const RoomDetailPage({Key? key, required this.roomModel}) : super(key: key);

  @override
  State<RoomDetailPage> createState() => _RoomDetailPageState();
}

class _RoomDetailPageState extends State<RoomDetailPage> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getRoom(widget.roomModel.id);
  }

  getRoom(int id) async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<RoomProvider>(context, listen: false)
        .toGetSelectedRoomDetails(id)
        .then((value) {
      setState(() {
        isLoading = false;
      });

      Future.delayed(const Duration(seconds: 1), () {
        final room =
            Provider.of<RoomProvider>(context, listen: false).currentRoom;
        room!.subject == null ? showDialogBox() : null;
      });
    });
  }

  showDialogBox() => showDialog(
        context: context,
        builder: (context) => AddSubjectDialog(roomId: widget.roomModel.id),
      );

  @override
  Widget build(BuildContext context) {
    final room = Provider.of<RoomProvider>(context).currentRoom;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomModel.name),
      ),
      body: isLoading
          ? const Center(child: progressIndicator)
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Space(model: room!, size: size)),
            ),
      floatingActionButton: isLoading
          ? null
          : room!.subject == null
              ? FloatingActionButton(
                  onPressed: showDialogBox, child: const Icon(Icons.add))
              : null,
    );
  }
}
