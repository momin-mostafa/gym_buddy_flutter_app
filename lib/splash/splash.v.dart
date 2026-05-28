import 'package:amplitude_flutter/amplitude.dart' show Amplitude;
import 'package:amplitude_flutter/configuration.dart' show Configuration;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'
    show
        AnimateWidgetExtensions,
        FadeEffectExtensions,
        NumDurationExtensions,
        SwapEffectExtensions;
import 'package:gym_buddy/authentication/view/login.view.dart' show LoginView;
import 'package:gym_buddy/authentication/view_model/auth.vm.dart' show AuthVM;
import 'package:gym_buddy/home/home.v.dart' show HomeView;
import 'package:gym_buddy/main.dart' show white, fitGreen;
import 'package:gym_buddy/splash/water_background.dart';
import 'package:gym_buddy/user_interaction_tracker.dart'
    show UserInteractionTracker;
import 'package:provider/provider.dart' show WatchContext;
import 'package:supabase_flutter/supabase_flutter.dart'
    show Supabase, FlutterAuthClientOptions;


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      initAmplitude();
      await initSupabase();
      navigate();
    });
  }

  void initAmplitude() {
    UserInteractionTracker.init(
      Amplitude(Configuration(apiKey: "1715f54d771453a9cedb297f7d33a612")),
    );
  }

  Future<void> initSupabase() async {
    await Supabase.initialize(
      url: 'https://jnazxpavphuknrwrzdaq.supabase.co',
      anonKey: 'sb_publishable_Ef6s_udDcnC0JDWHEufwaQ_euxoXOp4',
      // url: 'http://127.0.0.1:54321',
      // anonKey: 'sb_publishable_ACJWlzQHlZjBrEguHvfOxg_3BJgxAaH',
      authOptions: FlutterAuthClientOptions(
        autoRefreshToken: true,
        authFlowType: .pkce,
      ),
    );
  }

  void navigate() {
    // await Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return Container(
              // color: white, // IMPORTANT
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    white.withAlpha(0),
                    white.withAlpha(10),
                    white.withAlpha(80),
                    white.withAlpha(180),
                    white.withAlpha(200),
                    white.withAlpha(230),
                    fitGreen.withAlpha(0),
                    fitGreen.withAlpha(10),
                    fitGreen.withAlpha(80),
                    fitGreen.withAlpha(180),
                    fitGreen.withAlpha(200),
                    fitGreen.withAlpha(230),
                  ],
                  begin: .topCenter,
                  end: .bottomCenter,
                ),
              ),
              child: context.watch<AuthVM>().isUserAuthenticated
                  ? const HomeView()
                  : const LoginView(),
            );
          },

          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;

            final tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: Curves.easeInOut));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },

          transitionDuration: const Duration(milliseconds: 650),
          reverseTransitionDuration: const Duration(milliseconds: 650),
        ),
      );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WaterShaderBackground(),
          Align(
            alignment: Alignment.center,
            child:
                Text(
                      "Hi !",
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(color: white),
                    )
                    .animate()
                    .fadeIn()
                    .swap(
                      duration: 1.seconds,
                      builder: (context, child) => Text(
                        "Welcome Back !",
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge?.copyWith(color: white),
                      ).animate().fadeIn(),
                    )
                    .fadeOut(duration: 1.seconds, delay: 1.seconds),
          ),
        ],
      ),
    );
  }
}
