import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_app/auth_wrapper.dart';
import 'package:freelance_app/bloc/blocs/image_bloc.dart';
import 'package:freelance_app/bloc/blocs/user_bloc.dart';
import 'package:freelance_app/data/providers/auth_user_provider.dart';
import 'package:freelance_app/data/providers/image_provider.dart';
import 'package:freelance_app/data/repository/auth_user_repository.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://rxbiiphewjkrnmirgexu.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJ4YmlpcGhld2prcm5taXJnZXh1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzA3OTY4MzcsImV4cCI6MjA0NjM3MjgzN30.H88-IODSrm4T3pt7eSABpaBy2lt1ZCisLQxrny77O2g',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthUserRepository(
        authUserProvider: AuthUserProvider(),
        myImageProvider: MyImageProvider(),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (context) => AuthUserBloc(
              context.read<AuthUserRepository>(),
            ),
          ),
          BlocProvider(
            lazy: false,
            create: (context) => MyImageBloc(
              context.read<AuthUserRepository>(),
            ),
          ),
        ],
        child: GetMaterialApp(
          title: 'Freelance App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              useMaterial3: true,
              fontFamily: 'Lato',
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 6, 0, 167),
              ),
              scaffoldBackgroundColor: const Color.fromARGB(255, 222, 222, 222),
              inputDecorationTheme: const InputDecorationTheme()),
          home: const AuthWrapper(),
        ),
      ),
    );
  }
}
