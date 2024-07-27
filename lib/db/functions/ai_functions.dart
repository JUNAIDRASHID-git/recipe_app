import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:recipe_app/db/models/response_model.dart';

Future<String> sendRequest(String ingredients) async {
  const apiKey = 'AIzaSyBU54wLc8iTtXKp8omRMajzp3ezstx6Oyc'; // Replace with your actual API key
  const url = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey';

  final payload = jsonEncode({
    'contents': [
      {
        'role': 'user',
        'parts': [
          {'text': 'I need recipe for these ingredients: $ingredients'}
        ]
      }
    ],
    'generationConfig': {
      'temperature': 1,
      'topK': 64,
      'topP': 0.95,
      'maxOutputTokens': 8192,
      'responseMimeType': 'text/plain'
    },
    'safetySettings': [
      {
        'category': 'HARM_CATEGORY_HARASSMENT',
        'threshold': 'BLOCK_MEDIUM_AND_ABOVE'
      },
      {
        'category': 'HARM_CATEGORY_HATE_SPEECH',
        'threshold': 'BLOCK_MEDIUM_AND_ABOVE'
      },
      {
        'category': 'HARM_CATEGORY_SEXUALLY_EXPLICIT',
        'threshold': 'BLOCK_MEDIUM_AND_ABOVE'
      },
      {
        'category': 'HARM_CATEGORY_DANGEROUS_CONTENT',
        'threshold': 'BLOCK_MEDIUM_AND_ABOVE'
      }
    ]
  });

  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: payload,
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to load data: ${response.reasonPhrase}');
  }

  return response.body;
}

RecipeModel parseRecipe(String content) {
  final lines = content.split('\n');
  String name = '';
  String yield = '';
  String prepTime = '';
  String cookTime = '';
  List<String> ingredients = [];
  List<String> instructions = [];
  List<String> tips = [];

  String currentSection = '';

  for (var line in lines) {
    line = line.trim();
    log('Processing line: $line');
    if (line.startsWith('##')) {
      name = line.substring(2).trim();
      log('Parsed name: $name');
    } else if (line.startsWith('**Yields:**')) {
      yield = line.split('**Yields:**')[1].trim();
      log('Parsed yield: $yield');
    } else if (line.startsWith('**Prep time:**')) {
      prepTime = line.split('**Prep time:**')[1].trim();
      log('Parsed prep time: $prepTime');
    } else if (line.startsWith('**Cook time:**')) {
      cookTime = line.split('**Cook time:**')[1].trim();
      log('Parsed cook time: $cookTime');
    } else if (line.startsWith('**Ingredients:**')) {
      currentSection = 'ingredients';
      log('Entering ingredients section');
    } else if (line.startsWith('**Instructions:**')) {
      currentSection = 'instructions';
      log('Entering instructions section');
    } else if (line.startsWith('**Tips:**')) {
      currentSection = 'tips';
      log('Entering tips section');
    } else if (line.isNotEmpty) {
      switch (currentSection) {
        case 'ingredients':
          ingredients.add(line);
          log('Added to ingredients: $line');
          break;
        case 'instructions':
          // Remove numbering and asterisks
          var cleanedLine = line.replaceFirst(RegExp(r'^\d+\.\s*'), '');
          cleanedLine = cleanedLine.replaceAll(RegExp(r'\*+'), '');
          if (cleanedLine.isNotEmpty) {
            instructions.add(cleanedLine.trim());
          }
          break;
        case 'tips':
          tips.add(line);
          log('Added to tips: $line');
          break;
          
      }
    }
  }

  log('Parsed Recipe Model: Name: $name, Yield: $yield, Prep Time: $prepTime, Cook Time: $cookTime, Ingredients: $ingredients, Instructions: $instructions, Tips: $tips'); // Log final parsed recipe

  return RecipeModel(
    name: name,
    yield: yield,
    prepTime: prepTime,
    cookTime: cookTime,
    ingredients: ingredients,
    instructions: instructions,
    tips: tips,
  );
}