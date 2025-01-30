import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mutfak Yardımcım',
      debugShowCheckedModeBanner: false, // Debug banner'ı kaldırdık
      theme: ThemeData(
        primaryColor: Color(0xFF5F6368),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.light(
          primary: Color(0xFF5F6368),
          secondary: Color(0xFFFB8C00),
        ),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primaryColor: Color(0xFF2E7D32),
        scaffoldBackgroundColor: Color(0xFF1A1A1A),
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF2E7D32),
          secondary: Color(0xFFFF6F00),
        ),
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: IntroScreen(),
    );
  }
}

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yemek Tarifi'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF5F6368), Color(0xFFFB8C00)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IngredientSelectionScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    textStyle: TextStyle(fontSize: 20),
                  ),
                  child: Text(
                    'Giriş',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IngredientSelectionScreen extends StatefulWidget {
  @override
  _IngredientSelectionScreenState createState() =>
      _IngredientSelectionScreenState();
}

class _IngredientSelectionScreenState extends State<IngredientSelectionScreen> {
  final List<String> ingredients = [
    'Domates',
    'Peynir',
    'Yumurta',
    'Un',
    'Zeytinyağı'
  ];
  List<String> selectedIngredients = [];

  void _onIngredientSelected(String ingredient) {
    setState(() {
      if (selectedIngredients.contains(ingredient)) {
        selectedIngredients.remove(ingredient);
      } else {
        if (selectedIngredients.length < 2) {
          selectedIngredients.add(ingredient);
        }
      }
    });
  }

  void _goToRecipeScreen() {
    if (selectedIngredients.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecipeScreen(ingredients: selectedIngredients),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Malzeme Seçimi'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF5F6368), Color(0xFFFB8C00)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sahip Olduğunuz Malzemeleri Seçin',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Column(
                  children: ingredients.map((ingredient) {
                    return ElevatedButton(
                      onPressed: () => _onIngredientSelected(ingredient),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            selectedIngredients.contains(ingredient)
                                ? Colors.green
                                : Colors.white,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        textStyle: TextStyle(fontSize: 18),
                        side: BorderSide(color: Colors.black),
                      ),
                      child: Text(
                        ingredient,
                        style: TextStyle(
                          color: selectedIngredients.contains(ingredient)
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _goToRecipeScreen,
                  child: Text('Tarif Önerileri Al'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    textStyle: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecipeScreen extends StatelessWidget {
  final List<String> ingredients;

  RecipeScreen({required this.ingredients});

  String _getRecipeSuggestion() {
    if (ingredients.contains('Domates') && ingredients.contains('Peynir')) {
      return 'Domates ve Peynirli Salata Tarifi:\n\nMalzemeler:\n- Domates\n- Peynir\nHazırlık: Domatesleri dilimleyin, peynirle karıştırın, zeytinyağı dökün ve baharatlarla tatlandırın.';
    } else if (ingredients.contains('Yumurta') && ingredients.contains('Un')) {
      return 'Yumurta ve Unlu Omlet Tarifi:\n\nMalzemeler:\n- Yumurta\n- Un\nHazırlık: Yumurtaları çırpın, un ekleyin, tuz ve karabiber ile tatlandırın. Karışımı tavada pişirin.';
    } else if (ingredients.contains('Zeytinyağı') &&
        ingredients.contains('Un')) {
      return 'Zeytinyağlı Krep Tarifi:\n\nMalzemeler:\n- Zeytinyağı\n- Un\nHazırlık: Un ve suyu karıştırarak krep hamuru yapın. Tavada zeytinyağı ile pişirin.';
    } else if (ingredients.contains('Zeytinyağı') &&
        ingredients.contains('Domates')) {
      return 'Zeytinyağlı Domates Salatası Tarifi:\n\nMalzemeler:\n- Zeytinyağı\n- Domates\nHazırlık: Domatesleri doğrayın, üzerine zeytinyağı gezdirin ve tuz ile karıştırın.';
    } else if (ingredients.contains('Zeytinyağı') &&
        ingredients.contains('Peynir')) {
      return 'Zeytinyağlı Peynirli Salata Tarifi:\n\nMalzemeler:\n- Zeytinyağı\n- Peynir\nHazırlık: Peynirleri doğrayın, zeytinyağı ve baharatlarla karıştırın.';
    } else if (ingredients.contains('Zeytinyağı') &&
        ingredients.contains('Yumurta')) {
      return 'Zeytinyağlı Omlet Tarifi:\n\nMalzemeler:\n- Zeytinyağı\n- Yumurta\nHazırlık: Yumurtayı çırpın, zeytinyağında pişirin. Yanında ekmekle servis yapabilirsiniz.';
    } else if (ingredients.contains('Domates') &&
        ingredients.contains('Yumurta')) {
      return 'Domatesli Yumurta Tarifi:\n\nMalzemeler:\n- Domates\n- Yumurta\nHazırlık: Domatesleri doğrayıp tavada pişirin, üzerine yumurtayı kırın ve karıştırın.';
    } else if (ingredients.contains('Un') && ingredients.contains('Peynir')) {
      return 'Un ve Peynirli Krep Tarifi:\n\nMalzemeler:\n- Un\n- Peynir\nHazırlık: Un ve suyu karıştırarak krep hamuru yapın. Pişen krep üzerine peynir serpin ve tavada pişirin.';
    } else if (ingredients.contains('Yumurta') &&
        ingredients.contains('Peynir')) {
      return 'Yumurtalı Peynirli Omlet Tarifi:\n\nMalzemeler:\n- Yumurta\n- Peynir\nHazırlık: Yumurtaları çırpın, peynir ekleyin ve karıştırarak tavada pişirin.';
    } else {
      return 'Seçilen malzemelere uygun tarifler:\n\n- Tarif önerileri için malzeme kombinasyonlarına bakınız.';
    }
  }

  @override
  Widget build(BuildContext context) {
    String recipeSuggestion = _getRecipeSuggestion();

    return Scaffold(
      appBar: AppBar(
        title: Text('Tarif Önerisi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Tarif Önerisi:',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              Text(
                recipeSuggestion,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
