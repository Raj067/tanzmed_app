import 'package:flutter/material.dart';

List<Map<String, dynamic>> tabiaQuestionss(BuildContext context) => [
      {'question': "Umri wako?"},
      {'question': "Jinsia yako?"},
      {'question': "Mkoa unaoishi"},
      {
        'question':
            "Je unafanya kazi kati ya hizi (Dereva wa marori, Mlinda amani, Mvuvi, Migodini)?"
      },
      {'question': "Umefanyiwa tohara?"},
      {'question': "Una wapenzi zaidi ya mmoja ambao hamtumii kinga?"},
      {
        'question':
            "Umewahi kishiriki ngono bila kinga na mwenza usiyejua hali yake?"
      },
      {
        'question':
            "Umewahi kushiriki ngono bila kinga na mwenza mwenye maambukizi ya VVU?"
      },
      {
        'question':
            "Je, unashiriki ngono kinyume na maumbile bila kutumia kinga?"
      },
      {
        'question':
            "Umewahi kushiriki ngono ukiwa umelewa au haujitambui hivi karibuni?"
      },
      {
        'question':
            "Je,wewe au mwanza wako anatumia dawa za kulevya kwa njia ya kujidunga?"
      },
      {
        'question':
            "Je, umewahi kujichoma/kuchangia vitu vyenye ncha kali (mfano kiwembe, sindano n.k)?"
      },
      {
        'question':
            "Je, unashiriki biashara ya ngono au huwa unatumia ngono kama njia ya kujiingizia kipato (Kudanga/Marioo)"
      },
      {
        'question':
            "Je, wewe au mwenza wako amewahi kuugua magonjwa ya zinaa (Mfano kisonono, kaswende, kisamaki n.k)?"
      },
      {
        'question':
            "Hivi karibuni umewahi kupata changamoto ya Afya ya akili au kuwa na msongo wa mawazo uliopitiliza kukufanya ushindwe kujiamulia?"
      },
    ];

List<List<Map<String, dynamic>>> tabiaAnswers1(BuildContext context) => [
      // age
      [
        {'answer': '15-19', 'value': '15-19', 'contribution': 0.5},
        {'answer': '20-24', 'value': '20-24', 'contribution': 0.5},
        {'answer': '25-29', 'value': '25-29', 'contribution': 0},
        {'answer': '30-34', 'value': '30-34', 'contribution': 0},
        {'answer': '35-39', 'value': '35-39', 'contribution': 0},
        {'answer': '40-44', 'value': '40-44', 'contribution': 0},
        {'answer': '45-above', 'value': '45-above', 'contribution': 0},
      ],
      // gender
      [
        {'answer': "male", 'value': "male", 'contribution': 0},
        {'answer': "female", 'value': "female", 'contribution': 0.5},
      ],
      // region
      [
        {'answer': 'Dodoma', 'value': 'Dodoma', 'contribution': 0},
        {'answer': 'arusha', 'value': 'arusha', 'contribution': 0},
        {'answer': 'Kilimanjaro', 'value': 'Kilimanjaro', 'contribution': 0},
        {'answer': 'Tanga', 'value': 'Tanga', 'contribution': 0},
        {'answer': 'Morogoro', 'value': 'Morogoro', 'contribution': 0},
        {'answer': 'Pwani', 'value': 'Pwani', 'contribution': 0},
        {
          'answer': 'Dar es salaam',
          'value': 'Dar es salaam',
          'contribution': 0
        },
        {'answer': 'Lindi', 'value': 'Lindi', 'contribution': 0},
        {'answer': 'Mtwara', 'value': 'Mtwara', 'contribution': 0},
        {'answer': 'Ruvuma', 'value': 'Ruvuma', 'contribution': 0},
        {'answer': 'Iringa', 'value': 'Iringa', 'contribution': 5},
        {'answer': 'Mbeya', 'value': 'Mbeya', 'contribution': 5},
        {'answer': 'Singida', 'value': 'Singida', 'contribution': 0},
        {'answer': 'Tabora', 'value': 'Tabora', 'contribution': 0},
        {'answer': 'Rukwa', 'value': 'Rukwa', 'contribution': 0},
        {'answer': 'Kigoma', 'value': 'Kigoma', 'contribution': 0},
        {'answer': 'Shinyanga', 'value': 'Shinyanga', 'contribution': 0},
        {'answer': 'Kigoma', 'value': 'Kigoma', 'contribution': 0},
        {'answer': 'Mwanza', 'value': 'Mwanza', 'contribution': 0},
        {'answer': 'Mara', 'value': 'Mara', 'contribution': 0},
        {'answer': 'Manyara', 'value': 'Manyara', 'contribution': 0},
        {'answer': 'Njombe', 'value': 'Njombe', 'contribution': 5},
        {'answer': 'Katavi', 'value': 'Katavi', 'contribution': 0},
        {'answer': 'Simiyu', 'value': 'Simiyu', 'contribution': 0},
        {'answer': 'Geita', 'value': 'Geita', 'contribution': 0},
        {'answer': 'Songwe', 'value': 'Songwe', 'contribution': 0},
        {
          'answer': 'Kaskazini Unguja',
          'value': 'Kaskazini Unguja',
          'contribution': 0
        },
        {
          'answer': 'Kusini Unguja',
          'value': 'Kusini Unguja',
          'contribution': 0
        },
        {
          'answer': 'Mjini Magharibi',
          'value': 'Mjini Magharibi',
          'contribution': 0
        },
        {
          'answer': 'Kaskazini Pemba',
          'value': 'Kaskazini Pemba',
          'contribution': 0
        },
        {'answer': 'Kusini Pemba', 'value': 'Kusini Pemba', 'contribution': 0},
      ],
      // occupation
      [
        {'answer': "Yes", 'value': 1, 'contribution': 5},
        {'answer': "No", 'value': 0, 'contribution': 0},
      ],
      // circumsized
      [
        {'answer': "Yes", 'value': 1, 'contribution': 0},
        {'answer': "No", 'value': 0, 'contribution': 4},
      ],
      // multiple sexual partner
      [
        {'answer': "Yes", 'value': 1, 'contribution': 15},
        {'answer': "No", 'value': 0, 'contribution': 0},
      ],
      // partner unknown HIV status
      [
        {'answer': "Yes", 'value': 1, 'contribution': 10},
        {'answer': "No", 'value': 0, 'contribution': 0},
      ],
      //  sex with HIV positive partner
      [
        {'answer': "Yes", 'value': 1, 'contribution': 10},
        {'answer': "No", 'value': 0, 'contribution': 0},
      ],
      // engaged in anal sex
      [
        {'answer': "Yes", 'value': 1, 'contribution': 10},
        {'answer': "No", 'value': 0, 'contribution': 0},
      ],
      // under alcohol influence
      [
        {'answer': "Yes", 'value': 1, 'contribution': 5},
        {'answer': "No", 'value': 0, 'contribution': 0},
      ],
      // inject drugs
      [
        {'answer': "Yes", 'value': 1, 'contribution': 10},
        {'answer': "No", 'value': 0, 'contribution': 0},
      ],
      //  shared sharp objects
      [
        {'answer': "Yes", 'value': 1, 'contribution': 5},
        {'answer': "No", 'value': 0, 'contribution': 0},
      ],
      // engage in sex work
      [
        {'answer': "Yes", 'value': 1, 'contribution': 10},
        {'answer': "No", 'value': 0, 'contribution': 0},
      ],
      // STI
      [
        {'answer': "Yes", 'value': 1, 'contribution': 5},
        {'answer': "No", 'value': 0, 'contribution': 0},
      ],
      //  mental health challenges
      [
        {'answer': "Yes", 'value': 1, 'contribution': 5},
        {'answer': "No", 'value': 0, 'contribution': 0},
      ],
    ];
