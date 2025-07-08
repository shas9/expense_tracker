import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class IconMapper {
  // Static map containing string keys mapped to FontAwesome icons
  static const Map<String, IconData> _iconMap = {
    // Expense Categories
    'food': FontAwesomeIcons.utensils,
    'car': FontAwesomeIcons.car,
    'bills': FontAwesomeIcons.bolt,
    'transportation': FontAwesomeIcons.bus,
    'utilities':FontAwesomeIcons.lightbulb,
    'home': FontAwesomeIcons.house,
    'shopping': FontAwesomeIcons.bagShopping,
    'clothing': FontAwesomeIcons.shirt,
    'insurance': FontAwesomeIcons.shield,
    'tax': FontAwesomeIcons.fileInvoice,
    'telephone': FontAwesomeIcons.phone,
    'cigarette': FontAwesomeIcons.smoking,
    'health': FontAwesomeIcons.kitMedical,
    'sport': FontAwesomeIcons.dumbbell,
    'baby': FontAwesomeIcons.baby,
    'pet': FontAwesomeIcons.dog,
    'beauty': FontAwesomeIcons.sprayCan,
    'electronics': FontAwesomeIcons.plug,
    'hamburger': FontAwesomeIcons.burger,
    'wine': FontAwesomeIcons.wineGlass,
    'vegetables': FontAwesomeIcons.carrot,
    'snacks': FontAwesomeIcons.cookieBite,
    'gift': FontAwesomeIcons.gift,
    'social': FontAwesomeIcons.users,
    'travel': FontAwesomeIcons.plane,
    'education': FontAwesomeIcons.graduationCap,
    'fruits': FontAwesomeIcons.apple,
    'book': FontAwesomeIcons.book,
    'office': FontAwesomeIcons.paperclip,
    'film': FontAwesomeIcons.film,
    
    // Income Categories
    'salary': FontAwesomeIcons.wallet,
    'awards': FontAwesomeIcons.sackDollar,
    'grants': FontAwesomeIcons.handHoldingHeart,
    'sale': FontAwesomeIcons.tag,
    'rental': FontAwesomeIcons.houseChimney,
    'refunds': FontAwesomeIcons.arrowRotateLeft,
    'coupons': FontAwesomeIcons.ticket,
    'dividends': FontAwesomeIcons.chartLine,
    'investments': FontAwesomeIcons.piggyBank,
    'others': FontAwesomeIcons.infinity,
    'shs': FontAwesomeIcons.bowlFood,
    'add': FontAwesomeIcons.plus,
    
    // Wallet Types
    'general': FontAwesomeIcons.folder,
    'cash': FontAwesomeIcons.coins,
    'current_account': FontAwesomeIcons.buildingColumns,
    'credit_card': FontAwesomeIcons.creditCard,
    'saving_account': FontAwesomeIcons.piggyBank,
    'bonus': FontAwesomeIcons.dollarSign,
    'investment': FontAwesomeIcons.chartPie,
    'loan': FontAwesomeIcons.sackDollar,
    'mortgage': FontAwesomeIcons.houseChimney,
    'account_with_overdraft': FontAwesomeIcons.circleExclamation,
  };

  /// Returns the corresponding FontAwesome icon or a question mark icon if not found
  static IconData getIcon(String key) {
    return _iconMap[key.toLowerCase()] ?? _iconMap['others']!;
  }

  static List<String> getExpenseCategoryIconNames() {
    return [
      'food',
      'car',
      'bills',
      'transportation',
      'home',
      'shopping',
      'clothing',
      'insurance',
      'tax',
      'telephone',
      'cigarette',
      'health',
      'sport',
      'baby',
      'pet',
      'beauty',
      'electronics',
      'hamburger',
      'wine',
      'vegetables',
      'snacks',
      'gift',
      'social',
      'travel',
      'education',
      'fruits',
      'book',
      'office'
    ];
  }

  static List<String> getIncomeCategoryIconNames() {
    return [
      'salary',
      'awards',
      'grants',
      'sale',
      'rental',
      'refunds',
      'coupons',
      'dividends',
      'investments',
      'others',
      'shs',
      'add'
    ];
  }

  static List<String> getWalletTypeIconNames() {
    return [
      'general',
      'cash',
      'current_account',
      'credit_card',
      'saving_account',
      'bonus',
      'investment',
      'loan',
      'mortgage',
      'account_with_overdraft'
    ];
  }
}