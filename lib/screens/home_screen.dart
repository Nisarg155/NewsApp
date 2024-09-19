
import 'package:flutter/material.dart';
import '../services/news_api.dart';
import '../models/news.dart';
import '../widgets/news_title.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  final String email;

  HomeScreen({required this.username, required this.email});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NewsApi newsApi = NewsApi();
  final TextEditingController _searchController = TextEditingController();
  List<News> _newsList = [];
  bool _isLoading = false;
  String _searchQuery = 'general'; // Default search term
  final List<String> _categories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology',
  ]; // List of categories
  String _selectedCategory = 'general'; // Default category
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchNews(_searchQuery); // Fetch general news on initial load
  }

  // Function to fetch news based on search query
  void _fetchNews(String query) async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    try {
      final news = await newsApi.fetchNews(query);
      setState(() {
        _newsList = news; // Update news list
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false; // Stop loading indicator in case of error
      });
      print(error);
    }
  }

  // Function to update selected category
  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category; // Update selected category
      _fetchNews(category); // Fetch news for selected category
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      Scaffold(
        appBar: AppBar(
          title: Text('News App'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(110.0), // Adjust height to accommodate search bar and categories
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        _fetchNews(value); // Trigger search when user submits query
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Search news...',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          final query = _searchController.text;
                          if (query.isNotEmpty) {
                            _fetchNews(query); // Trigger search when search icon is pressed
                          }
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50.0, // Height for the category bar
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ChoiceChip(
                          label: Text(category),
                          selected: _selectedCategory == category,
                          onSelected: (isSelected) {
                            if (isSelected) {
                              _onCategorySelected(category); // Change category on selection
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _newsList.isEmpty
            ? Center(child: Text('No news articles found'))
            : ListView.builder(
          itemCount: _newsList.length,
          itemBuilder: (context, index) {
            return NewsTile(news: _newsList[index]);
          },
        ),
      ),
      ProfileScreen(username: widget.username, email: widget.email), // Pass user data here
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}