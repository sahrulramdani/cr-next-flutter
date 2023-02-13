import 'package:flutter/material.dart';
// import 'package:flutter_web_course/pages/marketing/marketing_01lead.dart';

List dataSubMenuDashboard = [
  //menu data item
  {
    "level": 0,
    "icon": Icons.dashboard_outlined,
    "title": "Dashboard",
    "route": ""
  },
];

List dataSubMenuMarketing = [
  {
    "level": 0,
    "icon": Icons.trending_up,
    "title": "Dashboard",
  },

  // {
  //   "level": 0,
  //   "icon": Icons.ac_unit_outlined,
  //   "title": "Contoh",
  //   "route": "/mrkt/leads"
  // },
  {
    "level": 0,
    "icon": Icons.nature_people_outlined,
    "title": "Agency",
    "route": "/mrkt/agency"
  },
  {
    "level": 0,
    "icon": Icons.calendar_month_outlined,
    "title": "Jadwal",
    "route": "/mrkt/jadwal"
  },
  {
    "level": 0,
    "icon": Icons.date_range_outlined,
    "title": "Pemberangkatan",
    "route": "/mrkt/pemberangkatan"
  },
  {
    "level": 0,
    "icon": Icons.personal_injury_outlined,
    "title": "Tour Leader",
    "route": "/mrkt/tourlead"
  },
  {
    "level": 0,
    "icon": Icons.transit_enterexit,
    "title": "Master Transit",
    "route": "/mrkt/transit"
  },
  {
    "level": 0,
    "icon": Icons.flight,
    "title": "Master Maskapai",
    "route": "/mrkt/maskapai"
  },
  {
    "level": 0,
    "icon": Icons.hotel,
    "title": "Master Hotel",
    "route": "/mrkt/hotel"
  }
];

List dataSubMenuJamaah = [
  {
    "level": 0,
    "icon": Icons.people_alt_outlined,
    "title": "Jamaah",
  },
  {
    "level": 0,
    "icon": Icons.people_outline,
    "title": "Data Jamaah",
    "route": "/jamaah/master"
  },
  {
    "level": 0,
    "icon": Icons.file_open_outlined,
    "title": "Pendaftaran",
    "route": "/jamaah/pendaftaran"
  },
  {
    "level": 0,
    "icon": Icons.person_pin_outlined,
    "title": "Pelanggan",
    "route": "/jamaah/pelanggan"
  },
  {
    "level": 0,
    "icon": Icons.collections_bookmark_outlined,
    "title": "Alumni",
    "route": "/jamaah/alumni"
  },
];

List dataSubMenuInventory = [
  //menu data item
  {
    "level": 0,
    "icon": Icons.all_inbox_outlined,
    "title": "Inventory",
  },
  {
    "level": 0,
    "icon": Icons.label_outline_rounded,
    "title": "Satuan",
    "route": "/inventory/satuan"
  },
  {
    "level": 0,
    "icon": Icons.archive_outlined,
    "title": "Barang",
    "route": "/inventory/barang"
  },
  {
    "level": 0,
    "icon": Icons.outbox_outlined,
    "title": "Pengeluaran",
    "route": "/inventory/pengeluaran"
  },

  {
    "level": 0,
    "icon": Icons.group_work_outlined,
    "title": "Grup Barang",
    "route": "/inventory/grup-barang"
  },
  {
    "level": 0,
    "icon": Icons.send_time_extension_outlined,
    "title": "Kirim Barang",
    "route": "/inventory/kirim-barang"
  },
];

List dataSubMenuHR = [
  //menu data item
  {
    "level": 0,
    "icon": Icons.person_add_alt_1_outlined,
    "title": "HR",
  },
  {
    "level": 0,
    "icon": Icons.label_outline_rounded,
    "title": "Karyawan",
    "route": "/hr/karyawan"
  },
];

List dataSubMenuFinance = [
  //menu data item
  {
    "level": 0,
    "icon": Icons.calculate_outlined,
    "title": "Finance",
  },
  {
    "level": 0,
    "icon": Icons.payments_outlined,
    "title": "Pembayaran",
    "route": "/finance/pembayaran-jamaah"
  },
  {
    "level": 0,
    "icon": Icons.file_present_outlined,
    "title": "Ujrah",
    "route": "/finance/pembayaran-ujrah"
  },
  {
    "level": 0,
    "icon": Icons.flight_takeoff_rounded,
    "title": "Penerbangan",
    "route": "/finance/profit-penerbangan"
  },
];

List DataSubMenu = [
  //menu data item
  {
    "level": 0,
    "icon": Icons.account_circle_rounded,
    "title": "Dashboard",
  },

  //menu data item
  {
    "level": 0,
    "icon": Icons.verified_outlined,
    "title": "Account",
    "children": [
      {
        "level": 1,
        "icon": Icons.account_box,
        "title": "Username",
        "children": [
          {
            "title": "Change username",
          },
          {"title": "Reset Username"},
          {"title": "History Of change"},
        ],
      },
      {
        "level": 1,
        "icon": Icons.lock,
        "title": "Password",
        "children": [
          {
            "title": "Change Password",
          },
          {"title": "Reset Password"},
          {"title": "History Of change"},
        ],
      },
      {"level": 1, "icon": Icons.delete_forever, "title": "Delete Account"}
    ]
  },

  //menu data item
  {
    "level": 0,
    "icon": Icons.payments,
    "title": "Payments",
    "children": [
      {
        "level": 1,
        "icon": Icons.paypal,
        "title": "Paypal",
      },
      {
        "level": 1,
        "icon": Icons.credit_card,
        "title": "Credit Card",
      },
      {"level": 1, "icon": Icons.credit_card, "title": "Debit Card"}
    ]
  },

  //menu data item
  {
    "level": 0,
    "icon": Icons.travel_explore,
    "title": "Trips",
    "children": [
      {
        "level": 1,
        "icon": Icons.calendar_month,
        "title": "January",
        "children": [
          {
            "icon": Icons.calendar_view_day,
            "title": "15th, 9:30 AM",
          },
          {
            "icon": Icons.calendar_view_day,
            "title": "30th, 9:30 AM",
          },
        ],
      },
      {
        "level": 1,
        "icon": Icons.calendar_month,
        "title": "June",
        "children": [
          {
            "icon": Icons.calendar_view_day,
            "title": "16th, 10:45 AM",
          },
          {
            "icon": Icons.calendar_view_day,
            "title": "29th, 10:45 AM",
          },
        ],
      },
      {
        "level": 1,
        "icon": Icons.calendar_month,
        "title": "November",
        "children": [
          {
            "icon": Icons.calendar_view_day,
            "title": "20th, 10:50 AM",
          },
        ],
      },
    ]
  },

  //menu data item
  {
    "level": 0,
    "icon": Icons.explore,
    "title": "Seminars",
    "children": [
      {
        "level": 1,
        "icon": Icons.money,
        "title": "Entrepreneurship",
      },
      {
        "level": 1,
        "icon": Icons.build,
        "title": "Self Confidence",
      },
      {
        "level": 1,
        "icon": Icons.self_improvement,
        "title": "Financial Management"
      },
    ]
  },

  //menu data item
  {
    "level": 0,
    "icon": Icons.favorite,
    "title": "Favorite",
    "children": [
      {
        "level": 1,
        "icon": Icons.water,
        "title": "Swimming",
      },
      {
        "level": 1,
        "icon": Icons.sports_football,
        "title": "Football",
      },
      {"level": 1, "icon": Icons.movie, "title": "Movie"},
      {"level": 1, "icon": Icons.audiotrack, "title": "Singing"},
      {"level": 1, "icon": Icons.run_circle_outlined, "title": "Jogging"},
    ]
  },
];

List DataSubMenu_Engineering = [
  //menu data item
  {
    "level": 0,
    "icon": Icons.people_alt_outlined,
    "title": "Dashboard",
  },
  //menu data item
  {
    "level": 0,
    "icon": Icons.payments,
    "title": "Engineering",
    "children": [
      {
        "level": 1,
        "icon": Icons.paypal,
        "title": "Paypal",
      },
      {
        "level": 1,
        "icon": Icons.credit_card,
        "title": "Credit Card",
      },
      {"level": 1, "icon": Icons.credit_card, "title": "Debit Card"}
    ]
  },

  //menu data item
];

List DataSubMenu_PPIC = [
  //menu data item
  {
    "level": 0,
    "icon": Icons.list_alt_outlined,
    "title": "Dashboard",
  },

  //menu data item
  {
    "level": 0,
    "icon": Icons.travel_explore,
    "title": "PPIC",
    "children": [
      {
        "level": 1,
        "icon": Icons.calendar_month,
        "title": "January",
        "children": [
          {
            "icon": Icons.calendar_view_day,
            "title": "15th, 9:30 AM",
          },
          {
            "icon": Icons.calendar_view_day,
            "title": "30th, 9:30 AM",
          },
        ],
      },
      {
        "level": 1,
        "icon": Icons.calendar_month,
        "title": "June",
        "children": [
          {
            "icon": Icons.calendar_view_day,
            "title": "16th, 10:45 AM",
          },
          {
            "icon": Icons.calendar_view_day,
            "title": "29th, 10:45 AM",
          },
        ],
      },
      {
        "level": 1,
        "icon": Icons.calendar_month,
        "title": "November",
        "children": [
          {
            "icon": Icons.calendar_view_day,
            "title": "20th, 10:50 AM",
          },
        ],
      },
    ]
  },

  //menu data item

  //menu data item
];

List DataSubMenu_Purchasing = [
  //menu data item
  {
    "level": 0,
    "icon": Icons.shopping_cart_checkout_outlined,
    "title": "Dashboard",
  },
  {
    "level": 0,
    "icon": Icons.explore,
    "title": "Purchasing",
    "children": [
      {
        "level": 1,
        "icon": Icons.money,
        "title": "Entrepreneurship",
      },
      {
        "level": 1,
        "icon": Icons.build,
        "title": "Self Confidence",
      },
      {
        "level": 1,
        "icon": Icons.self_improvement,
        "title": "Financial Management"
      },
    ]
  },
];
List DataSubMenu_Warehouse = [
  //menu data item
  {
    "level": 0,
    "icon": Icons.warehouse_outlined,
    "title": "Dashboard",
  },
  {
    "level": 0,
    "icon": Icons.favorite,
    "title": "Warehouse",
    "children": [
      {
        "level": 1,
        "icon": Icons.water,
        "title": "Swimming",
      },
      {
        "level": 1,
        "icon": Icons.sports_football,
        "title": "Football",
      },
      {"level": 1, "icon": Icons.movie, "title": "Movie"},
      {"level": 1, "icon": Icons.audiotrack, "title": "Singing"},
      {"level": 1, "icon": Icons.run_circle_outlined, "title": "Jogging"},
    ]
  },
];

List DataSubMenu_Produksi = [
  //menu data item
  {
    "level": 0,
    "icon": Icons.factory_outlined,
    "title": "Dashboard",
  },
  {
    "level": 0,
    "icon": Icons.favorite,
    "title": "Produksi",
    "children": [
      {
        "level": 1,
        "icon": Icons.water,
        "title": "Swimming",
      },
      {
        "level": 1,
        "icon": Icons.sports_football,
        "title": "Football",
      },
      {"level": 1, "icon": Icons.movie, "title": "Movie"},
      {"level": 1, "icon": Icons.audiotrack, "title": "Singing"},
      {"level": 1, "icon": Icons.run_circle_outlined, "title": "Jogging"},
    ]
  },
];

List DataSubMenu_QC = [
  //menu data item
  {
    "level": 0,
    "icon": Icons.verified,
    "title": "Dashboard",
  },
  {
    "level": 0,
    "icon": Icons.favorite,
    "title": "QC",
    "children": [
      {
        "level": 1,
        "icon": Icons.water,
        "title": "Swimming",
      },
      {
        "level": 1,
        "icon": Icons.sports_football,
        "title": "Football",
      },
      {"level": 1, "icon": Icons.movie, "title": "Movie"},
      {"level": 1, "icon": Icons.audiotrack, "title": "Singing"},
      {"level": 1, "icon": Icons.run_circle_outlined, "title": "Jogging"},
    ]
  },
];

List DataSubMenu_PM = [
  //menu data item
  {
    "level": 0,
    "icon": Icons.verified,
    "title": "Dashboard",
  },
  {
    "level": 0,
    "icon": Icons.favorite,
    "title": "PM",
    "children": [
      {
        "level": 1,
        "icon": Icons.water,
        "title": "Swimming",
      },
      {
        "level": 1,
        "icon": Icons.sports_football,
        "title": "Football",
      },
      {"level": 1, "icon": Icons.movie, "title": "Movie"},
      {"level": 1, "icon": Icons.audiotrack, "title": "Singing"},
      {"level": 1, "icon": Icons.run_circle_outlined, "title": "Jogging"},
    ]
  },
];
