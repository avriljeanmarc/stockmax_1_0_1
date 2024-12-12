import 'package:flutter/material.dart';
import 'model.dart';
import 'package:provider/provider.dart';
import 'materials.dart';
import 'package:intl/intl.dart';
import 'mytable.dart';
import 'more.dart';

class Sale extends StatelessWidget {
  const Sale({super.key});

  @override
  Widget build(BuildContext context) {
    List<MySale> items = context.watch<DataCenter>().saleList;
    return MyScaffold(
      addData: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddSale(),
          ),
        );
      },
      appBarTitle: Text(MyTable.getStringByLanguageCode(
          'List of sales', context.read<DataCenter>().languageCode)),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: items.isEmpty
              ? const Icon(
                  MyTable.saleIcon,
                  size: 100,
                  color: Colors.blue,
                )
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MySaleDetails(
                          index: index,
                        ),
                      ),
                    ),
                    leading: MyIcon(
                      text: items[index].saleCode![0],
                      oddOrEven: index,
                    ),
                    title: Text(items[index].saleCode!),
                    subtitle: Text('${items[index].itemCode}'),
                    trailing: Text('${items[index].itemQuantity}'),
                  ),
                ),
        ),
      ),
    );
  }
}

class AddSale extends StatelessWidget {
  const AddSale({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String? saleCode, itemCode, customerCode = MyTable.customerZero, saleDate;
    String itemQuantity = '0.0';
    String saleCost = '0.0';
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

    double quantityInStock =
        itemList.isNotEmpty ? itemList[0].itemQuantity! : 0.0;

    List<MyCustomer> customerList = context.read<DataCenter>().customerList;
    List<String> customerCodeList = [];
    for (int i = 0; i < customerList.length; i++) {
      customerCodeList.add(customerList[i].customerCode!);
    }
    String selectedValue1 =
        customerCodeList.isNotEmpty ? customerCodeList[0] : '';
    List<DropdownMenuItem<String>> customerCodeDropDownMenuItem = [];
    for (int i = 0; i < customerCodeList.length; i++) {
      customerCodeDropDownMenuItem.add(DropdownMenuItem(
        value: customerCodeList[i],
        child: Text(customerCodeList[i]),
      ));
    }

    DateTime? datetime;
    bool value = false;

    return MyScaffold(
      actions: [
        IconButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              context.read<DataCenter>().insertSale(
                    MySale.copy(
                      MySale(
                        saleCode: saleCode,
                        itemCode: itemCode,
                        customerCode: customerCode,
                        itemQuantity: double.tryParse(itemQuantity),
                        saleCost: double.tryParse(saleCost),
                        saleDate: saleDate,
                      ),
                    ),
                  );

              MyItem? item =
                  context.read<DataCenter>().getItemByCode(itemCode!);
              item = MyItem.copy(MyItem(
                itemCode: itemCode,
                itemQuantity:
                    item!.itemQuantity! - (double.tryParse(itemQuantity)!),
                itemDescription: item.itemDescription,
                itemCategory: item.itemCategory,
                itemQuality: item.itemQuality,
                itemUnit: item.itemUnit,
              ));

              context.read<DataCenter>().updateItem(item, itemCode: itemCode!);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(MyTable.getStringByLanguageCode(
                      'Sale added', context.read<DataCenter>().languageCode)),
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
          'New sale', context.read<DataCenter>().languageCode)),
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
                    onSaved: (newValue) => saleCode = newValue,
                    validator: (value) {
                      bool isThere = false;
                      if (value != null) {
                        if (value.isEmpty) {
                          return MyTable.getStringByLanguageCode(
                              'Field is required',
                              context.read<DataCenter>().languageCode);
                        }

                        context.read<DataCenter>().saleList.forEach((item) {
                          if (item.saleCode!
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
                        for (MyItem element in itemList) {
                          if (element.itemCode == selectedValue) {
                            quantityInStock = element.itemQuantity!;
                            break;
                          }
                        }
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

                        double? quantity = double.tryParse(value);
                        if (quantity! > quantityInStock) {
                          return MyTable.getStringByLanguageCode(
                              'Insufficient stock',
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
                    //initialValue: _saleCost,
                    controller: TextEditingController(text: saleCost),
                    keyboardType: TextInputType.number,
                    onSaved: (newValue) => saleCost = newValue!,
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
                      labelText: MyTable.getStringByLanguageCode('Total cost',
                          context.read<DataCenter>().languageCode),
                      suffixIcon: IconButton(
                        onPressed: () {
                          List<MyItemPriceAtDate> pricesHistory = [];
                          context
                              .read<DataCenter>()
                              .itemPriceAtDateList
                              .forEach((price) {
                            if (price.itemCode == selectedValue) {
                              pricesHistory.add(price);
                            }
                          });

                          double lastPrice = 0.0;
                          DateTime lastDate = DateTime(1800);
                          for (MyItemPriceAtDate price in pricesHistory) {
                            if (lastDate
                                .isBefore(DateTime.parse(price.atDate!))) {
                              lastDate = DateTime.parse(price.atDate!);
                              lastPrice = price.itemPrice!;
                            }
                          }

                          setState(
                            () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                saleCost =
                                    (double.tryParse(itemQuantity)! * lastPrice)
                                        .toString();
                              }
                            },
                          );
                        },
                        icon: const Icon(Icons.attach_money),
                      ),
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
                    onSaved: (newValue) => saleDate =
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
                  if (value) //if (context.read<DataCenter>().addSaleCustomerCodeField)
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: MyTable.getStringByLanguageCode(
                            'Customer code',
                            context.read<DataCenter>().languageCode),
                      ),
                      validator: (value) {
                        return null;
                      },
                      onSaved: (newValue) => customerCode = newValue as String,
                      isExpanded: true,
                      items: customerCodeDropDownMenuItem,
                      value: selectedValue1,
                      onChanged: (selectedValue) {
                        setState(() {
                          selectedValue1 = selectedValue as String;
                        });
                      },
                    ),
                  SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        MyTable.getStringByLanguageCode('Add customer field',
                            context.read<DataCenter>().languageCode),
                      ),
                      value: value,
                      onChanged: (bool value) {
                        setState(() {
                          value = value;
                        });
                      }),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class MySaleDetails extends StatelessWidget {
  final int index;
  const MySaleDetails({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    MySale sale = context.read<DataCenter>().saleList[index];

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
              onTap: () {
                Future.delayed(
                    const Duration(seconds: 0),
                    () => {
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (context) => AlertDialog(
                              title: Text(
                                '${MyTable.getStringByLanguageCode('Are you sure you want to delete', context.read<DataCenter>().languageCode)} ${sale.saleCode!}',
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    context.read<DataCenter>().deleteRow(
                                          MyTable.sale,
                                          MyTable.saleCodeField,
                                          sale.saleCode!,
                                        );

                                    sale.itemCode!;
                                    MyItem? item = context
                                        .read<DataCenter>()
                                        .getItemByCode(sale.itemCode!);

                                    item = MyItem.copy(MyItem(
                                      itemCode: sale.itemCode!,
                                      itemQuantity: item!.itemQuantity! +
                                          sale.itemQuantity!,
                                    ));

                                    context.read<DataCenter>().updateItem(item,
                                        itemCode: sale.itemCode!);
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
        sale.saleCode!,
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
                subtitle: Text(sale.saleCode!),
                title: Text(
                  MyTable.getStringByLanguageCode(
                      'Code', context.read<DataCenter>().languageCode),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                subtitle: Text(sale.itemCode!),
                title: Text(
                  MyTable.getStringByLanguageCode(
                      'Item code', context.read<DataCenter>().languageCode),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              if (sale.customerCode!.isNotEmpty &&
                  sale.customerCode != MyTable.customerZero)
                ListTile(
                  subtitle: Text(sale.customerCode!),
                  title: Text(
                    MyTable.getStringByLanguageCode('Customer code',
                        context.read<DataCenter>().languageCode),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ListTile(
                subtitle: Text(sale.itemQuantity!.toString()),
                title: Text(
                  MyTable.getStringByLanguageCode(
                      'Quantity', context.read<DataCenter>().languageCode),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                subtitle: Text(sale.saleCost!.toString()),
                title: Text(
                  MyTable.getStringByLanguageCode(
                      'Total cost', context.read<DataCenter>().languageCode),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                subtitle: Text(MyTable.formatDateToLanguageCode(
                    context.read<DataCenter>().languageCode, sale.saleDate!)),
                title: Text(
                  MyTable.getStringByLanguageCode(
                      'Date', context.read<DataCenter>().languageCode),
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
