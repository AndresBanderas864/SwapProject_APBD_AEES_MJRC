import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/article_model.dart';
import '../providers/article_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/article_card.dart';
import 'article_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();
  List<String> _history = [];
  String _query = '';

  static const String _historyKey = 'swap_search_history';
  static const int _maxHistory = 8;

  @override
  void initState() {
    super.initState();
    _loadHistory();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
    _searchController.addListener(() {
      setState(() => _query = _searchController.text.trim());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_historyKey);
    if (raw != null) {
      final list = List<String>.from(jsonDecode(raw));
      setState(() => _history = list);
    }
  }

  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_historyKey, jsonEncode(_history));
  }

  void _addToHistory(String term) {
    if (term.isEmpty) return;
    setState(() {
      _history.remove(term);
      _history.insert(0, term);
      if (_history.length > _maxHistory) {
        _history = _history.sublist(0, _maxHistory);
      }
    });
    _saveHistory();
  }

  void _removeFromHistory(String term) {
    setState(() => _history.remove(term));
    _saveHistory();
  }

  void _applyHistoryItem(String term) {
    _searchController.text = term;
    setState(() => _query = term);
    _focusNode.requestFocus();
  }

  List<Article> _filterArticles(List<Article> all) {
    if (_query.isEmpty) return all;
    final q = _query.toLowerCase();
    return all
        .where((a) =>
            a.title.toLowerCase().contains(q) ||
            a.description.toLowerCase().contains(q))
        .toList();
  }

  Widget _buildHistorySection() {
    if (_history.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            'Búsquedas recientes',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.carbonOscuro,
            ),
          ),
        ),
        ..._history.map((term) => ListTile(
              leading: const Icon(Icons.history, color: Colors.grey),
              title: Text(term,
                  style: GoogleFonts.inter(
                      fontSize: 14, color: AppColors.carbonOscuro)),
              trailing: IconButton(
                icon: const Icon(Icons.close, size: 18, color: Colors.grey),
                onPressed: () => _removeFromHistory(term),
              ),
              onTap: () => _applyHistoryItem(term),
            )),
      ],
    );
  }

  Widget _buildResults(List<Article> all) {
    final results = _filterArticles(all);
    if (results.isEmpty) {
      return SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 32),
            const Icon(Icons.search_off, size: 48, color: Colors.grey),
            const SizedBox(height: 12),
            Text(
              'No se encontraron resultados',
              style: GoogleFonts.inter(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Vea también',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.carbonOscuro,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
              itemCount: all.length,
              itemBuilder: (context, index) {
                final article = all[index];
                return ArticleCard(
                  article: article,
                  onTap: () {
                    _addToHistory(_query);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ArticleDetailScreen(article: article),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final article = results[index];
        return ArticleCard(
          article: article,
          onTap: () {
            _addToHistory(_query);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ArticleDetailScreen(article: article),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final all = context.watch<ArticleProvider>().articles;

    return Scaffold(
      backgroundColor: AppColors.mentaClaro,
      appBar: AppBar(
        backgroundColor: AppColors.verdeTeal,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: _searchController,
            focusNode: _focusNode,
            style: GoogleFonts.inter(
                fontSize: 14, color: AppColors.carbonOscuro),
            decoration: InputDecoration(
              hintText: '¿Qué estás buscando?',
              hintStyle:
                  GoogleFonts.inter(fontSize: 14, color: Colors.grey),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              suffixIcon: _query.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.close,
                          size: 18, color: Colors.grey),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _query = '');
                      },
                    )
                  : null,
            ),
          ),
        ),
      ),
      body: _query.isEmpty
          ? SingleChildScrollView(child: _buildHistorySection())
          : _buildResults(all),
    );
  }
}
