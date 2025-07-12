import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryLibraryPage extends StatefulWidget {
  const HistoryLibraryPage({Key? key}) : super(key: key);

  @override
  State<HistoryLibraryPage> createState() => _HistoryLibraryPageState();
}

class _HistoryLibraryPageState extends State<HistoryLibraryPage> {
  final List<Map<String, String>> _entries = [
    {'title': 'Administrative Division of Nepal', 'url': 'https://en.wikipedia.org/wiki/Administrative_divisions_of_Nepal'},
    {'title': 'Araniko', 'url': 'https://en.wikipedia.org/wiki/Araniko'},
    {'title': 'Bhaktapur', 'url': 'https://en.wikipedia.org/wiki/Bhaktapur'},
    {'title': 'Bhimsen Thapa', 'url': 'https://en.wikipedia.org/wiki/Bhimsen_Thapa'},
    {'title': 'Buddhism in Nepal', 'url': 'https://en.wikipedia.org/wiki/Buddhism_in_Nepal'},
    {'title': 'Constitution of Nepal 2015', 'url': 'https://en.wikipedia.org/wiki/Constitution_of_Nepal'},
    {'title': 'Cultural Heritage of Nepal', 'url': 'https://en.wikipedia.org/wiki/Culture_of_Nepal'},
    {'title': 'Democracy Movement in Nepal', 'url': 'https://en.wikipedia.org/wiki/History_of_Nepal#Democracy_movement'},
    {'title': 'Federal Democratic Republic of Nepal', 'url': 'https://en.wikipedia.org/wiki/Federal_Democratic_Republic_of_Nepal'},
    {'title': 'First People\'s Movement (1990)', 'url': 'https://en.wikipedia.org/wiki/1990_people%27s_movement'},
    {'title': 'Gautama Buddha', 'url': 'https://en.wikipedia.org/wiki/Gautama_Buddha'},
    {'title': 'Gorkha Kingdom', 'url': 'https://en.wikipedia.org/wiki/Gorkha_Kingdom'},
    {'title': 'Janakpur', 'url': 'https://en.wikipedia.org/wiki/Janakpur,_Nepal'},
    {'title': 'Judicial System of Nepal', 'url': 'https://en.wikipedia.org/wiki/Judiciary_of_Nepal'},
    {'title': 'King Mahendra', 'url': 'https://en.wikipedia.org/wiki/Mahendra_of_Nepal'},
    {'title': 'King Prithvi Narayan Shah', 'url': 'https://en.wikipedia.org/wiki/Prithvi_Narayan_Shah'},
    {'title': 'Lichhavi Dynasty', 'url': 'https://en.wikipedia.org/wiki/Licchavi_(kingdom)'},
    {'title': 'Malla Dynasty', 'url': 'https://en.wikipedia.org/wiki/Malla_dynasty'},
    {'title': 'Mount Everest', 'url': 'https://en.wikipedia.org/wiki/Mount_Everest'},
    {'title': 'National Symbols of Nepal', 'url': 'https://en.wikipedia.org/wiki/National_symbols_of_Nepal'},
    {'title': 'Natural Disasters in Nepal', 'url': 'https://en.wikipedia.org/wiki/Natural_disasters_in_Nepal'},
    {'title': 'Nepal Unification Campaign', 'url': 'https://en.wikipedia.org/wiki/Unification_of_Nepal'},
    {'title': 'Panchayat System', 'url': 'https://en.wikipedia.org/wiki/Panchayat_(Nepal)'},
    {'title': 'People\'s Movement II (2006)', 'url': 'https://en.wikipedia.org/wiki/2006_democracy_movement_in_Nepal'},
    {'title': 'Rana Regime', 'url': 'https://en.wikipedia.org/wiki/Rana_dynasty'},
    {'title': 'Siddhartha Gautama', 'url': 'https://en.wikipedia.org/wiki/Gautama_Buddha'},
    {'title': 'Sita', 'url': 'https://en.wikipedia.org/wiki/Sita'},
    {'title': 'Social Stratification in Nepal', 'url': 'https://en.wikipedia.org/wiki/Caste_system_in_Nepal'},
    {'title': 'Sustainable Development in Nepal', 'url': 'https://en.wikipedia.org/wiki/Sustainable_development_in_Nepal'},
    {'title': 'Swayambhunath', 'url': 'https://en.wikipedia.org/wiki/Swayambhunath'},
    {'title': 'Treaty of Sugauli', 'url': 'https://en.wikipedia.org/wiki/Treaty_of_Sugauli'},
    {'title': 'UN and Nepal', 'url': 'https://en.wikipedia.org/wiki/Nepal_and_the_United_Nations'}
  ];


  String _searchText = '';

  List<Map<String, String>> get _filteredEntries {
    if (_searchText.isEmpty) return _entries;
    return _entries
        .where((entry) =>
        entry['title']!.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the link')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History Library'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search history',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredEntries.length,
              itemBuilder: (context, index) {
                final entry = _filteredEntries[index];
                return ListTile(
                  title: Text(entry['title']!),
                  trailing: const Icon(Icons.open_in_new),
                  onTap: () => _launchURL(entry['url']!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
