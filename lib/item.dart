import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'model.dart';
import 'package:provider/provider.dart';
import 'materials.dart';
import 'mytable.dart';
import 'more.dart';

class Item extends StatelessWidget {
  const Item({super.key});

  @override
  Widget build(BuildContext context) {
    List<MyItem> items = context.watch<DataCenter>().itemList;

    return MyScaffold(
      addData: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddItem(),
        ),
      ),
      appBarTitle: Text(
        MyTable.getStringByLanguageCode(
            'List of items', context.read<DataCenter>().languageCode),
      ),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: items.isEmpty
              ? Icon(
                  MyTable.itemIcon,
                  size: 100,
                  color: Theme.of(context).primaryColor,
                )
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyItemDetails(
                          index: index,
                        ),
                      ),
                    ),
                    subtitle: Text(items[index].itemDescription!),
                    leading: MyIcon(
                      text: items[index].itemCode![0],
                      oddOrEven: index,
                    ),
                    title: Text(items[index].itemCode!),
                    trailing: items[index].itemQuantity! <= 100
                        ? Text(
                            '${items[index].itemQuantity}',
                            style: const TextStyle(color: Colors.red),
                          )
                        : Text(
                            '${items[index].itemQuantity}',
                            style: const TextStyle(color: Colors.green),
                          ),
                  ),
                ),
        ),
      ),
    );
  }
}

class AddItem extends StatelessWidget {
  const AddItem({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String? itemQuantity,
        itemCode,
        itemDescription,
        itemQuality,
        itemUnit,
        itemCategory;

    return MyScaffold(
      actions: [
        IconButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              context.read<DataCenter>().insertItem(
                    MyItem.copy(MyItem(
                      itemCode: itemCode,
                      itemDescription: itemDescription,
                      itemQuantity: double.tryParse(itemQuantity!),
                      itemUnit: itemUnit,
                      itemCategory: itemCategory,
                      itemQuality: itemQuality,
                    )),
                  );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(MyTable.getStringByLanguageCode(
                      'Item added', context.read<DataCenter>().languageCode)),
                ),
              );
              Navigator.pop(context);
              //Navigator.pop(context);
            }
          },
          icon: const Icon(
            Icons.check,
            //color: Colors.white,
          ),
        ),
      ],
      showActionsButton: true,
      showFloatingButton: false,
      appBarTitle: Text(MyTable.getStringByLanguageCode(
          'New item', context.read<DataCenter>().languageCode)),
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
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (newValue) => itemCode = newValue!,
                    validator: (value) {
                      bool isThere = false;
                      if (value != null) {
                        if (value.isEmpty) {
                          return MyTable.getStringByLanguageCode(
                              'Field is required',
                              context.read<DataCenter>().languageCode);
                        }

                        context.read<DataCenter>().itemList.forEach((item) {
                          if (item.itemCode!
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

                        double? val = double.tryParse(value);
                        if (val != null) {
                          if (val < 0.0) {
                            return MyTable.getStringByLanguageCode(
                                'Value cannot be negative',
                                context.read<DataCenter>().languageCode);
                          }
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
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (newValue) => itemDescription = newValue,
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLanguageCode('Description',
                          context.read<DataCenter>().languageCode),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (newValue) => itemUnit = newValue,
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLanguageCode(
                          'Unit', context.read<DataCenter>().languageCode),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (newValue) => itemCategory = newValue,
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLanguageCode(
                          'Category', context.read<DataCenter>().languageCode),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (newValue) => itemQuality = newValue,
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: MyTable.getStringByLanguageCode(
                          'Quality', context.read<DataCenter>().languageCode),
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

class EditItemPrice extends StatelessWidget {
  final String itemCode;
  const EditItemPrice({super.key, required this.itemCode});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    String? itemPrice, atDate;
    DateTime? datetime;
    bool isThere = false;

    return MyScaffold(
      showActionsButton: true,
      actions: [
        IconButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              context.read<DataCenter>().itemPriceAtDateList.forEach((price) {
                if (price.itemCode == itemCode && price.atDate == atDate) {
                  isThere = true;
                }
              });
              if (!isThere) {
                context.read<DataCenter>().insertItemPriceAtDate(
                      MyItemPriceAtDate.copy(MyItemPriceAtDate(
                        itemCode: itemCode,
                        atDate: atDate,
                        itemPrice: double.tryParse(itemPrice!),
                      )),
                    );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(MyTable.getStringByLanguageCode(
                        'Price edited',
                        context.read<DataCenter>().languageCode)),
                  ),
                );
                Navigator.pop(context);
                Navigator.pop(context);
              } else {
                Future.delayed(
                    const Duration(seconds: 0),
                    () => {
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (context) => AlertDialog(
                              title: Column(children: [
                                Text(
                                  MyTable.getStringByLanguageCode(
                                      'Duplicated value',
                                      context.read<DataCenter>().languageCode),
                                ),
                                Text(
                                  '$itemCode - ${MyTable.formatDateToLanguageCode(context.read<DataCenter>().languageCode, atDate!)}',
                                  style: const TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ]),
                              actions: [
                                TextButton(
                                  child: const Text('CANCEL'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          )
                        });
              }
            }
          },
          icon: const Icon(
            Icons.check,
            //color: Colors.white,
          ),
        ),
      ],
      showFloatingButton: false,
      appBarTitle: Text(
        MyTable.getStringByLanguageCode(
            'Edit price', context.read<DataCenter>().languageCode),
      ),
      child: Center(
        child: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      onSaved: (newValue) => itemPrice = newValue!,
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return MyTable.getStringByLanguageCode(
                                'Field is required',
                                context.read<DataCenter>().languageCode);
                          }

                          double? val = double.tryParse(value);
                          if (val != null) {
                            if (val < 0.0) {
                              return MyTable.getStringByLanguageCode(
                                  'Value cannot be negative',
                                  context.read<DataCenter>().languageCode);
                            }
                          }
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode(
                            'Price', context.read<DataCenter>().languageCode),
                      ),
                    ),
                    TextFormField(
                      controller: TextEditingController(
                          text: datetime == null
                              ? ''
                              : DateFormat(
                                      context.read<DataCenter>().languageCode ==
                                              'US'
                                          ? MyTable.enDateFormat
                                          : MyTable.frDateFormat)
                                  .format(datetime!)),
                      readOnly: true,
                      onSaved: (newValue) => atDate =
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
            },
          ),
        ),
      ),
    );
  }
}

class EditItem extends StatelessWidget {
  final int index;
  const EditItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    String? itemCode,
        itemDescription,
        itemQuality,
        itemUnit,
        itemQuantity,
        itemCategory;
    MyItem item = context.read<DataCenter>().itemList[index];

    return MyScaffold(
      actions: [
        IconButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              context.read<DataCenter>().updateItem(
                    MyItem.copy(MyItem(
                      itemCode: itemCode,
                      itemDescription: itemDescription,
                      itemQuantity: double.tryParse(itemQuantity!),
                      itemUnit: itemUnit,
                      itemCategory: itemCategory,
                      itemQuality: itemQuality,
                    )),
                    index: index,
                  );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(MyTable.getStringByLanguageCode(
                      'Item edited', context.read<DataCenter>().languageCode)),
                ),
              );
              Navigator.pop(context);
              Navigator.pop(context);
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
          'Edit item', context.read<DataCenter>().languageCode)),
      child: Center(
        child: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: item.itemCode,
                      keyboardType: TextInputType.visiblePassword,
                      onSaved: (newValue) => itemCode = newValue!,
                      validator: (value) {
                        bool isThere = false;
                        if (value != null) {
                          if (value.isEmpty) {
                            return MyTable.getStringByLanguageCode(
                                'Field is required',
                                context.read<DataCenter>().languageCode);
                          }

                          List<MyItem> items =
                              context.read<DataCenter>().itemList;
                          for (int i = 0; i < items.length; i++) {
                            if (i == index) {
                              continue;
                            }

                            if (items[i]
                                    .itemCode!
                                    .toLowerCase()
                                    .replaceAll(' ', '') ==
                                value.toLowerCase().replaceAll(' ', '')) {
                              isThere = true;
                            }
                          }

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
                    TextFormField(
                      initialValue: item.itemQuantity.toString(),
                      enabled: false,
                      keyboardType: TextInputType.number,
                      onSaved: (newValue) => itemQuantity = newValue!,
                      /*validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return MyTable.getStringByLanguageCode(
                                'Field is required',
                                context.read<DataCenter>().languageCode);
                          }

                          double? val = double.tryParse(value);
                          if (val != null) {
                            if (val < 0.0) {
                              return MyTable.getStringByLanguageCode(
                                  'Value cannot be negative',
                                  context.read<DataCenter>().languageCode);
                            }
                          }
                        }

                        return null;
                      },*/
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode('Quantity',
                            context.read<DataCenter>().languageCode),
                      ),
                    ),
                    TextFormField(
                      initialValue: item.itemDescription,
                      keyboardType: TextInputType.visiblePassword,
                      onSaved: (newValue) => itemDescription = newValue,
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode(
                            'Description',
                            context.read<DataCenter>().languageCode),
                      ),
                    ),
                    TextFormField(
                      initialValue: item.itemUnit,
                      keyboardType: TextInputType.visiblePassword,
                      onSaved: (newValue) => itemUnit = newValue,
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode(
                            'Unit', context.read<DataCenter>().languageCode),
                      ),
                    ),
                    TextFormField(
                      initialValue: item.itemCategory,
                      keyboardType: TextInputType.visiblePassword,
                      onSaved: (newValue) => itemCategory = newValue,
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode('Category',
                            context.read<DataCenter>().languageCode),
                      ),
                    ),
                    TextFormField(
                      initialValue: item.itemQuality,
                      keyboardType: TextInputType.visiblePassword,
                      onSaved: (newValue) => itemQuality = newValue,
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode(
                            'Quality', context.read<DataCenter>().languageCode),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class MyItemDetails extends StatelessWidget {
  final int index;
  const MyItemDetails({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    MyItem item = context.read<DataCenter>().itemList[index];

    return MyScaffold(
      showActionsButton: true,
      actions: [
        IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeWidget(),
            ),
          ),
          icon: const Icon(
            Icons.home,
          ),
        ),
        PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text(
                MyTable.getStringByLanguageCode(
                    'Edit price', context.read<DataCenter>().languageCode),
              ),
              onTap: () {
                Future.delayed(
                    const Duration(seconds: 0),
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditItemPrice(
                              itemCode: item.itemCode!,
                            ),
                          ),
                        ));

                return;
              },
            ),
            PopupMenuItem(
              child: Text(
                MyTable.getStringByLanguageCode(
                    'Edit', context.read<DataCenter>().languageCode),
              ),
              onTap: () {
                Future.delayed(
                    const Duration(seconds: 0),
                    () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditItem(
                              index: index,
                            ),
                          ),
                        ));

                return;
              },
            ),
            PopupMenuItem(
              onTap: () {
                Future.delayed(
                    const Duration(seconds: 0),
                    () => {
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (context) => AlertDialog(
                              title: Column(children: [
                                Text(
                                  MyTable.getStringByLanguageCode(
                                      'Are you sure you want to delete',
                                      context.read<DataCenter>().languageCode),
                                ),
                                Text(
                                  item.itemCode!,
                                  style: const TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ]),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    context.read<DataCenter>().deleteRow(
                                          MyTable.item,
                                          MyTable.itemCodeField,
                                          item.itemCode!,
                                        );
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text('CANCEL'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          )
                        });
                Navigator.pop(context);
              },
              child: Text(
                MyTable.getStringByLanguageCode(
                    'Delete', context.read<DataCenter>().languageCode),
              ),
            ),
          ],
        ),
      ],
      showFloatingButton: false,
      appBarTitle: Text(
        item.itemCode!,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                subtitle: Text(item.itemCode!),
                title: Text(
                  MyTable.getStringByLanguageCode(
                      'Code', context.read<DataCenter>().languageCode),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                subtitle: Text(item.itemQuantity!.toString()),
                title: Text(
                  MyTable.getStringByLanguageCode(
                      'Quantity', context.read<DataCenter>().languageCode),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              if (item.itemDescription!.isNotEmpty)
                ListTile(
                  subtitle: Text(item.itemDescription!),
                  title: Text(
                    MyTable.getStringByLanguageCode(
                        'Description', context.read<DataCenter>().languageCode),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              if (item.itemUnit!.isNotEmpty)
                ListTile(
                  subtitle: Text(item.itemUnit!),
                  title: Text(
                    MyTable.getStringByLanguageCode(
                        'Unit', context.read<DataCenter>().languageCode),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              if (item.itemCategory!.isNotEmpty)
                ListTile(
                  subtitle: Text(item.itemCategory!),
                  title: Text(
                    MyTable.getStringByLanguageCode(
                        'Category', context.read<DataCenter>().languageCode),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              if (item.itemQuality!.isNotEmpty)
                ListTile(
                  subtitle: Text(item.itemQuality!),
                  title: Text(
                    MyTable.getStringByLanguageCode(
                        'Quality', context.read<DataCenter>().languageCode),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
