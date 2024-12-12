import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'model.dart';
import 'package:provider/provider.dart';
import 'materials.dart';
import 'mytable.dart';

class Wastes extends StatelessWidget {
  const Wastes({super.key});

  @override
  Widget build(BuildContext context) {
    List<MyWastes> wastes = context.watch<DataCenter>().wastesList;

    return MyScaffold(
      addData: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddWastes(),
        ),
      ),
      appBarTitle: Text(
        MyTable.getStringByLanguageCode(
            'List of wastes', context.read<DataCenter>().languageCode),
      ),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: wastes.isEmpty
              ? const Icon(
                  MyTable.WastesIcon,
                  size: 100,
                  color: Colors.blue,
                )
              : ListView.builder(
                  itemCount: wastes.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyWastesDetails(
                          index: index,
                        ),
                      ),
                    ),
                    subtitle: Text(wastes[index].wastesCode!),
                    leading: MyIcon(
                      text: wastes[index].itemCode![0],
                      oddOrEven: index,
                    ),
                    title: Text(wastes[index].itemCode!),
                    trailing: Text(wastes[index].wastesDate!),
                  ),
                ),
        ),
      ),
    );
  }
}

class AddWastes extends StatelessWidget {
  const AddWastes({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String? wastesCode, itemCode, wastesDescription, wastesDate;
    String itemQuantity = '0.0';
    List<MyItem> itemList = context.read<DataCenter>().itemList;
    List<String> itemCodeList = [];
    for (int i = 0; i < itemList.length; i++) {
      itemCodeList.add(itemList[i].itemCode!);
    }
    String selectedValue = itemCodeList.isNotEmpty ? itemCodeList[0] : '';
    List<DropdownMenuItem<String>> itemCodeDropDownMenuItem = [];

    for (int i = 0; i < itemCodeList.length; i++) {
      itemCodeDropDownMenuItem.add(DropdownMenuItem(
        value: itemCodeList[i],
        child: Text(itemCodeList[i]),
      ));
    }

    DateTime? datetime;

    return MyScaffold(
      actions: [
        IconButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              context.read<DataCenter>().insertWastes(
                    MyWastes.copy(
                      MyWastes(
                        wastesCode: wastesCode,
                        itemCode: itemCode,
                        itemQuantity: double.tryParse(itemQuantity),
                        wastesDate: wastesDate,
                        wastesDescription: wastesDescription,
                      ),
                    ),
                  );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(MyTable.getStringByLanguageCode(
                      'Waste added', context.read<DataCenter>().languageCode)),
                ),
              );
            }
          },
          icon: const Icon(
            Icons.check,
            color: Colors.white,
          ),
        ),
      ],
      showActionsButton: true,
      showFloatingButton: false,
      appBarTitle: Text(MyTable.getStringByLanguageCode(
          'New waste', context.read<DataCenter>().languageCode)),
      child: Center(
        child: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: StatefulBuilder(builder: (context, setState) {
            return Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    onSaved: (newValue) => wastesCode = newValue,
                    validator: (value) {
                      bool isThere = false;
                      if (value != null) {
                        if (value.isEmpty) {
                          return MyTable.getStringByLanguageCode(
                              'Field is required',
                              context.read<DataCenter>().languageCode);
                        }

                        context.read<DataCenter>().wastesList.forEach((wastes) {
                          if (wastes.wastesCode!
                                  .toLowerCase()
                                  .replaceAll(' ', '') ==
                              value.toLowerCase().replaceAll(' ', '')) {
                            isThere = true;
                          }
                        });

                        if (isThere) {
                          return MyTable.getStringByLanguageCode(
                              'Duplicated value',
                              context.read<DataCenter>().languageCode);
                        }
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLanguageCode(
                          'Code', context.read<DataCenter>().languageCode),
                    ),
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLanguageCode(
                          'Item code', context.read<DataCenter>().languageCode),
                    ),
                    validator: (value) {
                      return null;
                    },
                    onSaved: (newValue) => itemCode = newValue as String,
                    isExpanded: true,
                    items: itemCodeDropDownMenuItem,
                    value: selectedValue,
                    onChanged: (selectedValue) {
                      setState(() {
                        selectedValue = selectedValue as String;
                      });
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onSaved: (newValue) => itemQuantity = newValue!,
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return MyTable.getStringByLanguageCode(
                              'Field is required',
                              context.read<DataCenter>().languageCode);
                        }
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLanguageCode(
                          'Quantity', context.read<DataCenter>().languageCode),
                    ),
                  ),
                  TextFormField(
                    onSaved: (newValue) => wastesDescription = newValue!,
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLanguageCode('Description',
                          context.read<DataCenter>().languageCode),
                    ),
                  ),
                  TextFormField(
                    controller: TextEditingController(
                        text: datetime == null
                            ? ''
                            : DateFormat(
                                    context.read<DataCenter>().languageCode ==
                                            'en'
                                        ? MyTable.enDateFormat
                                        : MyTable.frDateFormat)
                                .format(datetime!)),
                    readOnly: true,
                    onSaved: (newValue) => wastesDate =
                        DateFormat(MyTable.saveDateFormat).format(datetime!),
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return MyTable.getStringByLanguageCode(
                              'Field is required',
                              context.read<DataCenter>().languageCode);
                        }
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () => showDatePicker(
                                locale: Locale(
                                    context.read<DataCenter>().languageCode),
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1800),
                                lastDate: DateTime(5000))
                            .then((value) => setState(() {
                                  datetime = value;
                                })),
                        icon: const Icon(
                          Icons.calendar_month,
                        ),
                      ),
                      labelText: MyTable.getStringByLanguageCode(
                          'Date', context.read<DataCenter>().languageCode),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class MyWastesDetails extends StatelessWidget {
  final int index;
  const MyWastesDetails({super.key, required this.index});
  @override
  Widget build(Object context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
