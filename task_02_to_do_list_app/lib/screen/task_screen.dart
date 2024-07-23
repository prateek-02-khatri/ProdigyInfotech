import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_02_to_do_list_app/Utils.dart';
import 'package:task_02_to_do_list_app/provider/to_do_list_provider.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => MyHomePageState();
}

class MyHomePageState extends State<TaskScreen>{

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,

      appBar: Utils.CustomAppBar(context),

      body: Container(

        height: MediaQuery.of(context).size.height,
        color: Colors.orange.shade400,

        child: Consumer<ToDoListProvider>(builder: (context, value, child) {
          return Container(
              margin: const EdgeInsets.only(
                  top: 15, bottom: 15, left: 12, right: 12),
              decoration: BoxDecoration(
                color: Colors.yellow.shade200,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: value.taskList.isEmpty
                    ?
                  customEmptyList()
                    :
                  Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),

                        Consumer<ToDoListProvider>(
                          builder: (BuildContext context, value, Widget? child) {
                            return SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: value.taskList.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 1),
                                      leading: Checkbox(
                                        value: value.isChecked[index],
                                        onChanged: (val) {
                                          value.setChecks(index, val!);
                                        },
                                        activeColor: Colors.black,
                                        checkColor: Colors.white,
                                      ),

                                      title: TextField(
                                        style: Utils.CustomTextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 2.0
                                        ),
                                        maxLines: 1,
                                        controller: value.taskList[index],
                                        decoration: const InputDecoration(
                                            border: InputBorder.none
                                        ),
                                      ),

                                      trailing: IconButton(
                                          onPressed: () {
                                            value.removeTasks(index);
                                            value.removeChecks(index);
                                          },
                                          icon: const Icon(Icons.delete, size: 24)
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        ),

                      ],
                    )
              // customListUI(),
              );
        }),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            )),
            builder: (BuildContext context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                    height: 200,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        )),
                    child: Consumer<ToDoListProvider>(
                      builder:(BuildContext context, ToDoListProvider value, Widget? child) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ListTile(
                              leading: Checkbox(
                                value: value.isCheck,
                                onChanged: (val) {
                                  value.setBoolValue(val!);
                                },
                                activeColor: Colors.black,
                                checkColor: Colors.white,
                              ),
                              title: TextField(
                                style: Utils.CustomTextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 2.0),
                                autofocus: true,
                                maxLines: 1,
                                controller: value.controller,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Utils.CustomElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  buttonName: "Cancel"),
                              Consumer<ToDoListProvider>(
                                builder: (BuildContext context,
                                    ToDoListProvider value, Widget? child) {
                                  return Utils.CustomElevatedButton(
                                    onPressed: () {
                                      if (value.controller.text != "") {
                                        value.addTasks(TextEditingController(text: value.controller.text));
                                        value.addChecks(value.isCheck);
                                      }
                                      Navigator.pop(context);
                                    },
                                    buttonName: "Done",
                                  );
                                },
                              )
                            ],
                          )
                        ],
                      );
                    })),
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
          size: 38,
          color: Colors.black,
        ),
      ),
    );
  }

  customEmptyList() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: SizedBox(
          width: 436,
          height: 397,
          child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/images/Empty Duck.png",
                ),
                Positioned(
                  top: 220,
                  child: Column(
                      children: [
                        Text(
                          "Click +",
                          style: Utils.CustomTextStyle(
                              color: Colors.grey,
                              fontSize: 28,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          "to add task",
                          style: Utils.CustomTextStyle(
                              color: Colors.grey,
                              fontSize: 28,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ]
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }

}
