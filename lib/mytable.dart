import 'package:flutter/material.dart';
//import 'sql.dart';
//import 'model.dart';

/*class GenerateData {
  final List<Map<String, Object?>> itemData = [];
  final List<Map<String, Object?>> customerData = [];
  final List<Map<String, Object?>> supplierData = [];
  //final List<Map<String, Object?>> saleData = [];

  GenerateData() {
    itemData.add({
      MyTable.itemCodeField: 'NGK BKR5EY',
      MyTable.itemQuantityField: 500.0,
      MyTable.itemUnitField: '',
      MyTable.itemCategoryField: '',
      MyTable.itemQualityField: '',
      MyTable.itemDescriptionField: '',
    });

    itemData.add({
      MyTable.itemCodeField: 'NGK BKR6EY',
      MyTable.itemQuantityField: 350.0,
      MyTable.itemUnitField: '',
      MyTable.itemCategoryField: '',
      MyTable.itemQualityField: '',
      MyTable.itemDescriptionField: '',
    });

    itemData.add({
      MyTable.itemCodeField: 'NGK VPOWER',
      MyTable.itemQuantityField: 150.0,
      MyTable.itemUnitField: '',
      MyTable.itemCategoryField: '',
      MyTable.itemQualityField: '',
      MyTable.itemDescriptionField: '',
    });

    itemData.add({
      MyTable.itemCodeField: 'BOSH DOUBLE PLATINUM',
      MyTable.itemQuantityField: 100.0,
      MyTable.itemUnitField: '',
      MyTable.itemCategoryField: 'SPARK PLUG',
      MyTable.itemQualityField: '',
      MyTable.itemDescriptionField: '',
    });

    itemData.add({
      MyTable.itemCodeField: 'B-BOSH',
      MyTable.itemQuantityField: 12.0,
      MyTable.itemUnitField: 'UNIT',
      MyTable.itemCategoryField: 'BATTERY',
      MyTable.itemQualityField: 'NEW',
      MyTable.itemDescriptionField: 'BUILD TO LAST',
    });
    /*itemData.add({
      MyTable.itemCodeField: 'ART-001',
      MyTable.itemDescriptionField: 'Soja',
      MyTable.itemQuantityField: 345.0,
      MyTable.itemUnitField: 'Gal',
      MyTable.itemCategoryField: 'Cuisine',
      MyTable.itemQualityField: 'Neuf',
    });

    itemData.add({
      MyTable.itemCodeField: 'ART-002',
      MyTable.itemDescriptionField: 'Olive',
      MyTable.itemQuantityField: 500.0,
      MyTable.itemUnitField: 'Gal',
      MyTable.itemCategoryField: 'Cuisine',
      MyTable.itemQualityField: 'Neuf',
    });

    itemData.add({
      MyTable.itemCodeField: 'ART-003',
      MyTable.itemDescriptionField: 'Mazola',
      MyTable.itemQuantityField: 365.0,
      MyTable.itemUnitField: 'Gal',
      MyTable.itemCategoryField: 'Cuisine',
      MyTable.itemQualityField: 'Neuf',
    });

    itemData.add({
      MyTable.itemCodeField: 'ART-004',
      MyTable.itemDescriptionField: 'Grisol',
      MyTable.itemQuantityField: 675.0,
      MyTable.itemUnitField: 'Gal',
      MyTable.itemCategoryField: 'Cuisine',
      MyTable.itemQualityField: 'Neuf',
    });

    itemData.add({
      MyTable.itemCodeField: 'ART-005',
      MyTable.itemDescriptionField: 'fromage tete de mort',
      MyTable.itemQuantityField: 2255.0,
      MyTable.itemUnitField: 'Boite',
      MyTable.itemCategoryField: 'Cuisine',
      MyTable.itemQualityField: 'Neuf',
    });

    itemData.add({
      MyTable.itemCodeField: 'ART-006',
      MyTable.itemDescriptionField: 'fromage kraft',
      MyTable.itemQuantityField: 344.0,
      MyTable.itemUnitField: 'Boite',
      MyTable.itemCategoryField: 'Cuisine',
      MyTable.itemQualityField: 'Neuf',
    });*/

    customerData.add({
      MyTable.customerCodeField: 'CL000',
      MyTable.customerFirstNameField: 'Jhon',
      MyTable.customerLastNameField: 'PIERRE',
      MyTable.customerAddressField: '',
      MyTable.customerEmailField: '',
    });

    customerData.add({
      MyTable.customerCodeField: 'CL001',
      MyTable.customerFirstNameField: 'Rudolf',
      MyTable.customerLastNameField: 'DANGUIE',
      MyTable.customerAddressField: '',
      MyTable.customerEmailField: '',
    });

    customerData.add({
      MyTable.customerCodeField: 'CL002',
      MyTable.customerFirstNameField: 'Pablo',
      MyTable.customerLastNameField: 'ESCOBAR',
      MyTable.customerAddressField: '',
      MyTable.customerEmailField: '',
    });

    /*saleData.add({
      MyTable.saleCodeField: 'SL001',
      MyTable.itemCodeField: 'ART-001',
      MyTable.customerCodeField: 'CT-001',
      MyTable.itemQuantityField: 10.0,
      MyTable.saleDateField: '4/20/2022',
    });

    saleData.add({
      MyTable.saleCodeField: 'SL002',
      MyTable.itemCodeField: 'ART-006',
      MyTable.customerCodeField: 'CT-002',
      MyTable.itemQuantityField: 5.0,
      MyTable.saleDateField: '4/18/2022',
    });*/

    supplierData.add({
      MyTable.supplierCodeField: 'SP001',
      MyTable.supplierNameField: 'E-POWER S.A.',
      MyTable.supplierAddressField: 'FREE LAND TRADE PARK RUE LISIUS',
      MyTable.supplierEmailField: 'epowerhaiti.com',
    });

    supplierData.add({
      MyTable.supplierCodeField: 'SP786',
      MyTable.supplierNameField: 'CK HARDWARE',
      MyTable.supplierAddressField: 'PARK INDUSTRIEL',
      MyTable.supplierEmailField: 'ckhardware.ht',
    });

    supplierData.add({
      MyTable.supplierCodeField: 'SP345',
      MyTable.supplierNameField: 'EYESMART',
      MyTable.supplierAddressField: 'DELMAS 31 NEXT TO RADIO GINEN',
      MyTable.supplierEmailField: 'eyesmart.com',
    });

    supplierData.add({
      MyTable.supplierCodeField: 'SP002',
      MyTable.supplierNameField: 'UNIPIECE S.A.',
      MyTable.supplierAddressField: 'PV HAITI',
      MyTable.supplierEmailField: 'unipiece.com',
    });
  }

  Future<void> generate(StockmaxDatabase db) async {
    for (Map<String, Object?> item in itemData) {
      await db.insertItem(MyItem.copy(MyItem.fromJson(item)));
    }

    for (Map<String, Object?> item in customerData) {
      await db.insertCustomer(MyCustomer.copy(MyCustomer.fromJson(item)));
    }

    for (Map<String, Object?> item in supplierData) {
      await db.insertSupplier(MySupplier.copy(MySupplier.fromJson(item)));
    }

    /*for (Map<String, Object?> item in saleData) {
      await db.insertSale(MySale.fromJson(item));
    }*/
  }
}*/

class MyTable {
  static const item = 'item';
  static const user = 'user';
  static const customer = 'customer';
  static const sale = 'sale';
  static const supplier = 'supplier';
  static const command = 'command';
  static const itemPriceAtDate = 'ItemPriceAtDate';
  static const wastes = 'wastes';
  static const wastesCodeField = 'wastes_code';
  static const wastesDescriptionField = 'wastes_description';
  static const wastesDateField = 'wastes_date';

  static const customerZero = 'customer_zero';
  static const supplierZero = 'supplier_zero';

  static const itemCodeField = 'item_code';
  static const itemPriceField = 'item_price';
  static const itemDescriptionField = 'item_description';
  static const itemQuantityField = 'item_quantity';
  static const itemUnitField = 'item_unit';
  static const itemCategoryField = 'item_category';
  static const itemQualityField = 'item_quality';

  static const userCodeField = 'user_code';

  static const customerCodeField = 'customer_code';
  static const customerFirstNameField = 'customer_firstName';
  static const customerLastNameField = 'customer_lastName';
  static const customerAddressField = 'customer_address';
  static const customerEmailField = 'customer_email';

  static const saleCodeField = 'sale_code';
  static const saleDateField = 'sale_date';
  static const saleCostField = 'sale_cost';

  static const supplierCodeField = 'supplier_code';
  static const supplierNameField = 'supplier_name';
  static const supplierAddressField = 'supplier_address';
  static const supplierEmailField = 'supplier_email';

  static const atDateField = 'atDate';
  static const commandCodeField = 'command_code';
  static const commandDateField = 'command_date';

  static const settingsAccessCodeField = 'settings_access_code';

  static const frDateFormat = 'dd/MM/yyyy';
  static const enDateFormat = 'MM/dd/yyyy';
  static const saveDateFormat = 'yyyy-MM-dd';

  static const List<String> menuList = [
    'Items',
    'Customers',
    'Suppliers',
  ];

  static const IconData itemIcon = Icons.sell;
  static const IconData customerIcon = Icons.contacts;
  static const IconData saleIcon = Icons.shopping_cart;
  static const IconData supplierIcon = Icons.local_shipping;
  static const IconData customizeDataIcon = Icons.engineering;
  static const IconData commandIcon = Icons.store;
  static const IconData itemPriceAtDateIcon = Icons.attach_money;
  static const IconData WastesIcon = Icons.recycling;

  static const List<String> enMonthsOfYear = [
    'Jan.',
    'Feb.',
    'Mar.',
    'Apr.',
    'May',
    'Jun.',
    'Jul.',
    'Aug.',
    'Sep.',
    'Oct.',
    'Nov.',
    'Dec.',
  ];
  static const List<String> frMonthsOfYear = [
    'Jan.',
    'Fev.',
    'Mar.',
    'Avr.',
    'Mai',
    'Jui.',
    'Jul.',
    'Aou.',
    'Sep.',
    'Oct.',
    'Nov.',
    'Dec.',
  ];

  static String formatDateToLanguageCode(String languageCode, String date) {
    String dateWithlanguageCode = date;
    if (languageCode == 'fr') {
      List<String> tab = date.split('-');
      dateWithlanguageCode =
          '${tab[2]} ${frMonthsOfYear[int.tryParse(tab[1])! - 1]} ${tab[0]}';
    }

    if (languageCode == 'en') {
      List<String> tab = date.split('-');
      dateWithlanguageCode =
          '${enMonthsOfYear[int.tryParse(tab[1])! - 1]} ${tab[2]}, ${tab[0]}';
    }

    return dateWithlanguageCode;
  }

  static String getStringByLanguageCode(String str, String languageCode) {
    String translatedString = str;

    if (str == 'Quantity') {
      if (languageCode == 'fr') {
        translatedString = 'Quantit\u00E9';
        return translatedString;
      }
    }
    if (str == 'Unit') {
      if (languageCode == 'fr') {
        translatedString = 'Unit\u00E9';
        return translatedString;
      }
    }
    if (str == 'Category') {
      if (languageCode == 'fr') {
        translatedString = 'Cat\u00E9gorie';
        return translatedString;
      }
    }
    if (str == 'Quality') {
      if (languageCode == 'fr') {
        translatedString = 'Qualit\u00E9';
        return translatedString;
      }
    }
    if (str == 'First name') {
      if (languageCode == 'fr') {
        translatedString = 'Pr\u00E9nom';
        return translatedString;
      }
    }
    if (str == 'Last name') {
      if (languageCode == 'fr') {
        translatedString = 'Nom';
        return translatedString;
      }
    }
    if (str == 'Address') {
      if (languageCode == 'fr') {
        translatedString = 'Adresse';
        return translatedString;
      }
    }

    if (str == 'Item code') {
      if (languageCode == 'fr') {
        translatedString = 'Code article';
        return translatedString;
      }
    }
    if (str == 'Customer code') {
      if (languageCode == 'fr') {
        translatedString = 'Code client';
        return translatedString;
      }
    }
    if (str == 'E-mail') {
      if (languageCode == 'fr') {
        translatedString = 'E-mail';
        return translatedString;
      }
    }
    if (str == 'Date') {
      if (languageCode == 'fr') {
        translatedString = 'Date';
        return translatedString;
      }
    }
    if (str == 'Settings') {
      if (languageCode == 'fr') {
        translatedString = 'Param\u00E8tres';
        return translatedString;
      }
    }
    if (str == 'French') {
      if (languageCode == 'fr') {
        translatedString = 'Fran\u00E7ais';
        return translatedString;
      }
    }
    if (str == 'English') {
      if (languageCode == 'fr') {
        translatedString = 'Anglais';
        return translatedString;
      }
    }
    if (str == 'Item') {
      if (languageCode == 'fr') {
        translatedString = 'Article';
        return translatedString;
      }
    }
    if (str == 'Items') {
      if (languageCode == 'fr') {
        translatedString = 'Articles';
        return translatedString;
      }
    }
    if (str == 'Customer') {
      if (languageCode == 'fr') {
        translatedString = 'Client';
        return translatedString;
      }
    }
    if (str == 'Customers') {
      if (languageCode == 'fr') {
        translatedString = 'Clients';
        return translatedString;
      }
    }
    if (str == 'Sale') {
      if (languageCode == 'fr') {
        translatedString = 'Vente';
        return translatedString;
      }
    }
    if (str == 'Sales') {
      if (languageCode == 'fr') {
        translatedString = 'Ventes';
        return translatedString;
      }
    }
    if (str == 'Supplier') {
      if (languageCode == 'fr') {
        translatedString = 'Fournisseur';
        return translatedString;
      }
    }
    if (str == 'Suppliers') {
      if (languageCode == 'fr') {
        translatedString = 'Fournisseurs';
        return translatedString;
      }
    }
    if (str == 'Stock & Inventory') {
      if (languageCode == 'fr') {
        translatedString = 'Stock et Inventaire';
        return translatedString;
      }
    }
    if (str == 'Invalid user code') {
      if (languageCode == 'fr') {
        translatedString = 'Code utilisateur invalide';
        return translatedString;
      }
    }
    if (str == 'User code') {
      if (languageCode == 'fr') {
        translatedString = 'Code utilisateur';
        return translatedString;
      }
    }
    if (str == 'Log in') {
      if (languageCode == 'fr') {
        translatedString = 'Connexion';
        return translatedString;
      }
    }
    if (str == 'List of customers') {
      if (languageCode == 'fr') {
        translatedString = 'Liste des clients';
        return translatedString;
      }
    }
    if (str == 'List of items') {
      if (languageCode == 'fr') {
        translatedString = 'Liste des articles';
        return translatedString;
      }
    }
    if (str == 'List of sales') {
      if (languageCode == 'fr') {
        translatedString = 'Liste des ventes';
        return translatedString;
      }
    }
    if (str == 'New item') {
      if (languageCode == 'fr') {
        translatedString = 'Nouveau article';
        return translatedString;
      }
    }
    if (str == 'Item added') {
      if (languageCode == 'fr') {
        translatedString = 'Article ajout\u00E9';
        return translatedString;
      }
    }
    if (str == 'Add') {
      if (languageCode == 'fr') {
        translatedString = 'Ajouter';
        return translatedString;
      }
    }
    if (str == 'New customer') {
      if (languageCode == 'fr') {
        translatedString = 'Nouveau client';
        return translatedString;
      }
    }
    if (str == 'Customer added') {
      if (languageCode == 'fr') {
        translatedString = 'Client ajout\u00E9';
        return translatedString;
      }
    }
    if (str == 'New sale') {
      if (languageCode == 'fr') {
        translatedString = 'Nouvelle vente';
        return translatedString;
      }
    }
    if (str == 'Sale added') {
      if (languageCode == 'fr') {
        translatedString = 'Vente ajout\u00E9e';
        return translatedString;
      }
    }

    if (str == 'Customize items data') {
      if (languageCode == 'fr') {
        translatedString = 'Personnaliser les donn\u00E9es des articles';
        return translatedString;
      }
    }

    if (str == 'Customize customers data') {
      if (languageCode == 'fr') {
        translatedString = 'Personnaliser les donn\u00E9es des clients';
        return translatedString;
      }
    }

    if (str == 'Items data') {
      if (languageCode == 'fr') {
        translatedString = 'Donn\u00E9es des articles';
        return translatedString;
      }
    }

    if (str == 'Customers data') {
      if (languageCode == 'fr') {
        translatedString = 'Donn\u00E9es des clients';
        return translatedString;
      }
    }

    if (str == 'Add description field') {
      if (languageCode == 'fr') {
        translatedString = 'Ajouter le champ description';
        return translatedString;
      }
    }

    if (str == 'Add e-mail field') {
      if (languageCode == 'fr') {
        translatedString = 'Ajouter le champ e-mail';
        return translatedString;
      }
    }

    if (str == 'Add address field') {
      if (languageCode == 'fr') {
        translatedString = 'Ajouter le champ adresse';
        return translatedString;
      }
    }

    if (str == 'Add quality field') {
      if (languageCode == 'fr') {
        translatedString = 'Ajouter le champ qualit\u00E9';
        return translatedString;
      }
    }

    if (str == 'Add unit field') {
      if (languageCode == 'fr') {
        translatedString = 'Ajouter le champ unit\u00E9';
        return translatedString;
      }
    }

    if (str == 'Add category field') {
      if (languageCode == 'fr') {
        translatedString = 'Ajouter le champ cat\u00E9gorie';
        return translatedString;
      }
    }

    if (str == 'Edit') {
      if (languageCode == 'fr') {
        translatedString = 'Editer';
        return translatedString;
      }
    }

    if (str == 'Delete') {
      if (languageCode == 'fr') {
        translatedString = 'Supprimer';
        return translatedString;
      }
    }

    if (str == 'Field is required') {
      if (languageCode == 'fr') {
        translatedString = 'Champ obligatoire';
        return translatedString;
      }
    }

    if (str == 'Duplicated value') {
      if (languageCode == 'fr') {
        translatedString = 'Valeur dupliqu\u00E9e';
        return translatedString;
      }
    }

    if (str == 'Value cannot be negative') {
      if (languageCode == 'fr') {
        translatedString = 'Cette valeur ne peut \u00EAtre n\u00E9gative';
        return translatedString;
      }
    }

    if (str == 'Are you sure you want to delete') {
      if (languageCode == 'fr') {
        translatedString = 'Etes-vous s\u00FBr(e) de vouloir supprimer';
        return translatedString;
      }
    }

    if (str == 'Edit item') {
      if (languageCode == 'fr') {
        translatedString = 'Modifier article';
        return translatedString;
      }
    }

    if (str == 'Item edited') {
      if (languageCode == 'fr') {
        translatedString = 'Article modifi\u00E9';
        return translatedString;
      }
    }

    if (str == 'Customize sales data') {
      if (languageCode == 'fr') {
        translatedString = 'Personnaliser les donn\u00E9es des ventes';
        return translatedString;
      }
    }

    if (str == 'Customer edited') {
      if (languageCode == 'fr') {
        translatedString = 'Client modifi\u00E9';
        return translatedString;
      }
    }

    if (str == 'Edit customer') {
      if (languageCode == 'fr') {
        translatedString = 'Modifier client';
        return translatedString;
      }
    }

    if (str == 'Sales data') {
      if (languageCode == 'fr') {
        translatedString = 'Donn\u00E9es des ventes';
        return translatedString;
      }
    }

    if (str == 'Add customer field') {
      if (languageCode == 'fr') {
        translatedString = 'Ajouter le champ client';
        return translatedString;
      }
    }

    if (str == 'List of suppliers') {
      if (languageCode == 'fr') {
        translatedString = 'Liste des fournisseurs';
        return translatedString;
      }
    }

    if (str == 'Supplier added') {
      if (languageCode == 'fr') {
        translatedString = 'Fournisseur ajout\u00E9';
        return translatedString;
      }
    }

    if (str == 'New supplier') {
      if (languageCode == 'fr') {
        translatedString = 'Nouveau fournisseur';
        return translatedString;
      }
    }

    if (str == 'Supplier name') {
      if (languageCode == 'fr') {
        translatedString = 'Nom fournisseur';
        return translatedString;
      }
    }

    if (str == 'Supplier address') {
      if (languageCode == 'fr') {
        translatedString = 'Adresse fournisseur';
        return translatedString;
      }
    }

    if (str == 'Supplier e-mail') {
      if (languageCode == 'fr') {
        translatedString = 'E-mail fournisseur';
        return translatedString;
      }
    }

    if (str == 'Insufficient stock') {
      if (languageCode == 'fr') {
        translatedString = 'Stock insuffisant';
        return translatedString;
      }
    }

    if (str == 'Update stock') {
      if (languageCode == 'fr') {
        translatedString = 'Actualiser stock';
        return translatedString;
      }
    }

    if (str == 'Current quantity') {
      if (languageCode == 'fr') {
        translatedString = 'Quantit\u00E9 actuelle';
        return translatedString;
      }
    }

    if (str == 'New quantity') {
      if (languageCode == 'fr') {
        translatedString = 'Nouvelle quantit\u00E9';
        return translatedString;
      }
    }

    if (str == 'Final quantity') {
      if (languageCode == 'fr') {
        translatedString = 'Quantit\u00E9 finale';
        return translatedString;
      }
    }

    if (str == 'Item updated') {
      if (languageCode == 'fr') {
        translatedString = 'Article actualis\u00E9';
        return translatedString;
      }
    }

    if (str == 'Commands') {
      if (languageCode == 'fr') {
        translatedString = 'Commandes';
        return translatedString;
      }
    }

    if (str == 'List of commands') {
      if (languageCode == 'fr') {
        translatedString = 'Liste des commandes';
        return translatedString;
      }
    }

    if (str == 'Command added') {
      if (languageCode == 'fr') {
        translatedString = 'Commande ajout\u00E9e';
        return translatedString;
      }
    }

    if (str == 'New command') {
      if (languageCode == 'fr') {
        translatedString = 'Nouvelle commande';
        return translatedString;
      }
    }

    if (str == 'Add supplier code field') {
      if (languageCode == 'fr') {
        translatedString = 'Ajouter le champ code du fournisseur';
        return translatedString;
      }
    }

    if (str == 'Supplier code') {
      if (languageCode == 'fr') {
        translatedString = 'Code fournisseur';
        return translatedString;
      }
    }

    if (str == 'Total cost') {
      if (languageCode == 'fr') {
        translatedString = 'Co\u00FBt total';
        return translatedString;
      }
    }

    if (str == 'Edit price') {
      if (languageCode == 'fr') {
        translatedString = 'Editer prix';
        return translatedString;
      }
    }

    if (str == 'Price') {
      if (languageCode == 'fr') {
        translatedString = 'Prix';
        return translatedString;
      }
    }

    if (str == 'Price edited') {
      if (languageCode == 'fr') {
        translatedString = 'Prix modifi\u00E9';
        return translatedString;
      }
    }

    if (str == 'View prices history') {
      if (languageCode == 'fr') {
        translatedString = 'Voir l\'historicit\u00E9 des prix';
        return translatedString;
      }
    }

    if (str == 'Prices history') {
      if (languageCode == 'fr') {
        translatedString = 'Historicit\u00E9 des prix';
        return translatedString;
      }
    }

    if (str == 'Supplier edited') {
      if (languageCode == 'fr') {
        translatedString = 'Fournisseur modifi\u00E9';
        return translatedString;
      }
    }

    if (str == 'Import excel sheet') {
      if (languageCode == 'fr') {
        translatedString = 'Importer une feuille excel';
        return translatedString;
      }
    }

    if (str == 'Export excel sheet') {
      if (languageCode == 'fr') {
        translatedString = 'Exporter une feuille excel';
        return translatedString;
      }
    }

    if (str == 'Wastes') {
      if (languageCode == 'fr') {
        translatedString = 'Pertes';
        return translatedString;
      }
    }

    if (str == 'List of wastes') {
      if (languageCode == 'fr') {
        translatedString = 'Liste des pertes';
        return translatedString;
      }
    }

    if (str == 'Waste added') {
      if (languageCode == 'fr') {
        translatedString = 'Perte ajout\u00E9e';
        return translatedString;
      }
    }

    if (str == 'New waste') {
      if (languageCode == 'fr') {
        translatedString = 'Nouvelle perte';
        return translatedString;
      }
    }

    if (str == 'Theme') {
      if (languageCode == 'fr') {
        translatedString = 'Th\u00E8me';
        return translatedString;
      }
    }

    return translatedString;

//StatefulBuilder(builder: (context, setState){})
  }
}
