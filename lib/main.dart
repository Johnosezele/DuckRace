import 'package:duckrace/core/types/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/firebase_config.dart';
import 'core/config/router.dart';
import 'core/config/supabase_config.dart';
import 'services/firebase/messaging_service.dart';
import 'services/supabase/supabase_service.dart';

// Service Providers
final supabaseServiceProvider = Provider((ref) => SupabaseService());
final messagingServiceProvider = Provider((ref) => MessagingService());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Enable back button callback for Android 13+
  SystemNavigator.setFrameworkHandlesBack(true);
  
  // Initialize Firebase
  await FirebaseConfig.init();
  
  // Initialize Supabase
  await SupabaseConfig.init();
  
  // Initialize Messaging Service
  final messagingService = MessagingService();
  final result = await messagingService.initialize();
  
  switch (result) {
    case Success():
      debugPrint('Messaging service initialized successfully');
    case Failure(message: final message, error: final error):
      debugPrint('Failed to initialize messaging service: $message');
  }
  
  runApp(
    ProviderScope(
      overrides: [
        messagingServiceProvider.overrideWithValue(messagingService),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Lions Duckrace Cluj-Napoca',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Text('Welcome to DuckRace!'),
      ),
    );
  }
}
