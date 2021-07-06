import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const CATEGORY_LIST = [
  {
    "name": "Arts, Media & Entertainment",
    "icon": Icons.movie,
    "sub_categories": [
      {"name": "TV / Radio"},
      {"name": "Promotion & Advertising"},
      {"name": "Production / Studio"},
      {"name": "Cinema"},
      {"name": "Music"},
    ]
  },
  {
    "name": "Food & Catering",
    "icon": Icons.restaurant_menu_rounded,
    "sub_categories": [
      {"name": "Restaurant"},
      {"name": "Cafe"},
      {"name": "Fast Food"},
      {"name": "Cultural & Traditional Food"},
      {"name": "Catering"},
      {"name": "Ice Cream"},
      {"name": "Bakery"},
      {"name": "Butchery"},
      {"name": "Fruit & Juice House"},
    ]
  },
  {
    "name": "Beauty & Spa",
    "icon": Icons.spa_rounded,
    "sub_categories": [
      {"name": "Beauty Salon"},
      {"name": "Barber Shop"},
      {"name": "Massage & spa"},
    ]
  },
  {
    "name": "Hotel , Hospitality  & Cleaning",
    "icon": Icons.hotel,
    "sub_categories": [
      {"name": "Hotel"},
      {"name": "Guest House"},
      {"name": "Resort & Lodge"},
      {"name": "Laundry"},
      {"name": "Cleaning"},
    ]
  },
  {
    "name": "Shopping / Household & Furniture",
    "icon": Icons.shopping_basket_rounded,
    "sub_categories": [
      {"name": "Mall"},
      {"name": "Household"},
      {"name": "Furniture"},
      {"name": "Supermarket"},
      {"name": "Mini market"},
      {"name": "Fashion Shop & Designer"},
      {"name": "Boutiques"},
      {"name": "Antique & cultural Shop"},
      {"name": "E-commerce"},
    ]
  },
  {
    "name": "Financial service",
    "icon": Icons.money,
    "sub_categories": [
      {"name": "Bank"},
      {"name": "Insurance"},
      {"name": "Saving & Credit"},
    ]
  },
  {
    "name": "Tour , Travel & Transport",
    "icon": Icons.car_rental,
    "sub_categories": [
      {"name": "Tour & Travel Agent"},
      {"name": "Ticket Office"},
      {"name": "Taxi Hailing"},
      {"name": "Cross Country Transport"},
      {"name": "Delivery"},
      {"name": "Logistics & Supply Chain"},
      {"name": "Train Station"},
    ]
  },
  {
    "name": "Night Life & liquor Store",
    "icon": Icons.local_bar,
    "sub_categories": [
      {"name": "Club"},
      {"name": "Bars & Lounges"},
      {"name": "Liquor Store"},
      {"name": "24 hrs Open"},
    ]
  },
  {
    "name": "Construction",
    "icon": Icons.business,
    "sub_categories": [
      {"name": "Real Estate"},
      {"name": "Contractor"},
      {"name": "Construction Material  Rental & Sale"},
      {"name": "Finishing"},
      {"name": "Interior Designer"},
    ]
  },
  {
    "name": "Education & Training",
    "icon": FontAwesomeIcons.graduationCap,
    "sub_categories": [
      {"name": "University"},
      {"name": "School"},
      {"name": "Training Center"},
      {"name": "Nursery & Child Care"},
    ]
  },
  {
    "name": "Event Organizers",
    "icon": Icons.event,
    "sub_categories": [
      {"name": "Celebration Organizer"},
      {"name": "Wedding Planner"},
      {"name": "Concert Organizer"},
      {"name": "Meeting & Gathering Organizer"},
      {"name": "Funeral Service"},
    ]
  },
  {
    "name": "Import / Export & Manufacturing",
    "icon": Icons.compare_arrows_rounded,
    "sub_categories": [
      {"name": "Import"},
      {"name": "Export"},
      {"name": "Manufacturing"},
    ]
  },
  {
    "name": "Religious Organizations",
    "icon": FontAwesomeIcons.placeOfWorship,
    "sub_categories": [
      {"name": "Orthodox"},
      {"name": "Catholic"},
      {"name": "Protestant"},
      {"name": "Mosque"},
    ]
  },
  {
    "name": "Automotive & Gas Stations",
    "icon": Icons.local_gas_station_rounded,
    "sub_categories": [
      {"name": "Gas Station"},
      {"name": "Car Wash"},
      {"name": "Garage"},
      {"name": "Spare Part"},
      {"name": "Car Rental / Sale"},
    ]
  },
  {
    "name": "Sport & leisure",
    "icon": Icons.sports_baseball_rounded,
    "sub_categories": [
      {"name": "Gym"},
      {"name": "Sport Equipment"},
      {"name": "Stadium"},
      {"name": "Sport Club"},
      {"name": "Martial Art Center"},
      {"name": "Swimming pool & Bowling alley"},
    ]
  },
  {
    "name": "Government Offices",
    "icon": Icons.account_balance_rounded,
    "sub_categories": [
      {"name": "Government Office"},
    ]
  },
  {
    "name": "Farm & Agriculture",
    "icon": Icons.agriculture_rounded,
    "sub_categories": [
      {"name": "Farm & dairy"},
      {"name": "Agro Industry"},
      {"name": "Agricultural Equipment"},
    ]
  },
  {
    "name": "Health",
    "icon": Icons.local_hospital_rounded,
    "sub_categories": [
      {"name": "Hospital"},
      {"name": "Clinic"},
      {"name": "Diagnostics Center"},
      {"name": "Pharmacy & Drug Store"},
      {"name": "Traditional Treatment"},
      {"name": "Medical Equipment"},
      {"name": "Veterinary"},
    ]
  },
  {
    "name": "Humanitarian & Emergency Numbers",
    "icon": FontAwesomeIcons.universalAccess,
    "sub_categories": [
      {"name": "Emergency Numbers"},
      {"name": "NGO"},
      {"name": "Rotary"},
      {"name": "Charity"},
    ]
  },
  {
    "name": "Local Services",
    "icon": Icons.construction_rounded,
    "sub_categories": [
      {"name": "Local Service"},
    ]
  },
];

const HOME_CATEGORY_LIST = [
  {
    "name": "Restaurant",
    "icon": Icons.restaurant,
  },
  {
    "name": "Cafe",
    "icon": Icons.local_cafe,
  },
  {
    "name": "Beauty & Spa",
    "icon": Icons.spa_rounded,
  },
  {
    "name": "Bars & Lounges",
    "icon": Icons.sports_bar,
  },
  {
    "name": "Supermarkets",
    "icon": Icons.shopping_basket_rounded,
  },
  {
    "name": "Delivery",
    "icon": Icons.delivery_dining,
  },
  {
    "name": "Banks",
    "icon": Icons.business,
  },
];
