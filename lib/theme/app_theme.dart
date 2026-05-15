import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color verdeTeal    = Color(0xFF1D9E75);
  static const Color coralCalido  = Color(0xFFF0997B);
  static const Color coralSuave   = Color(0xFFF5C4B3);
  static const Color mentaClaro   = Color(0xFFE1F5EE);
  static const Color carbonOscuro = Color(0xFF2C2C2A);
  static const Color white        = Color(0xFFFFFFFF);
  static const Color error        = Color(0xFFD32F2F);
}

class AppTheme {
  static ThemeData get lightTheme {
    final base = ThemeData(
      useMaterial3: false,
      primaryColor: AppColors.verdeTeal,
      scaffoldBackgroundColor: AppColors.mentaClaro,
      colorScheme: ColorScheme.light(
        primary: AppColors.verdeTeal,
        secondary: AppColors.coralCalido,
        background: AppColors.mentaClaro,
        surface: AppColors.white,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onBackground: AppColors.carbonOscuro,
        onSurface: AppColors.carbonOscuro,
        error: AppColors.error,
        onError: AppColors.white,
      ),
    );

    return base.copyWith(
      textTheme: GoogleFonts.interTextTheme(base.textTheme).copyWith(
        displayLarge: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.carbonOscuro,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.carbonOscuro,
        ),
        displaySmall: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.carbonOscuro,
        ),
        headlineMedium: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.carbonOscuro,
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.carbonOscuro,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.carbonOscuro,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.carbonOscuro,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.carbonOscuro,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.carbonOscuro,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.carbonOscuro,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.verdeTeal,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.verdeTeal,
          foregroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.verdeTeal,
          side: const BorderSide(color: AppColors.verdeTeal, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.verdeTeal,
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.coralSuave),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.coralSuave),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: AppColors.verdeTeal, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        labelStyle: GoogleFonts.inter(
          fontSize: 14,
          color: AppColors.carbonOscuro,
        ),
        hintStyle: GoogleFonts.inter(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: EdgeInsets.zero,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.verdeTeal,
        foregroundColor: AppColors.white,
        elevation: 4,
      ),
      dividerColor: AppColors.coralSuave,
      iconTheme: const IconThemeData(color: AppColors.carbonOscuro),
    );
  }

  static ThemeData get darkTheme {
    const bgMain    = Color(0xFF1A1A18);
    const bgCard    = Color(0xFF242422);
    const bgInput   = Color(0xFF2E2E2B);
    const teal      = Color(0xFF5DCAA5);
    const coral     = Color(0xFFD85A30);
    const textMain  = Color(0xFFE8E6DF);
    const textSub   = Color(0xFF888780);

    return ThemeData(
      useMaterial3: false,
      brightness: Brightness.dark,
      primaryColor: teal,
      scaffoldBackgroundColor: bgMain,
      colorScheme: const ColorScheme.dark(
        primary: teal,
        secondary: coral,
        background: bgMain,
        surface: bgCard,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onBackground: textMain,
        onSurface: textMain,
        error: Color(0xFFCF6679),
        onError: Colors.white,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
        displayLarge:  GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600, color: textMain),
        displayMedium: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: textMain),
        titleLarge:    GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: textMain),
        titleMedium:   GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500, color: textMain),
        bodyLarge:     GoogleFonts.inter(fontSize: 14, color: textMain),
        bodyMedium:    GoogleFonts.inter(fontSize: 14, color: textMain),
        bodySmall:     GoogleFonts.inter(fontSize: 12, color: textSub),
        labelSmall:    GoogleFonts.inter(fontSize: 12, color: textSub),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: bgCard,
        foregroundColor: textMain,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
            fontSize: 18, fontWeight: FontWeight.w600, color: textMain),
        iconTheme: const IconThemeData(color: textMain),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: teal,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: teal,
          side: const BorderSide(color: teal, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: teal,
          textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: bgInput,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: bgInput)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: bgInput)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: teal, width: 2)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFCF6679))),
        labelStyle: GoogleFonts.inter(fontSize: 14, color: textSub),
        hintStyle: GoogleFonts.inter(fontSize: 14, color: textSub),
      ),
      cardTheme: CardThemeData(
        color: bgCard,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: EdgeInsets.zero,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: teal,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith(
            (s) => s.contains(MaterialState.selected) ? teal : textSub),
        trackColor: MaterialStateProperty.resolveWith(
            (s) => s.contains(MaterialState.selected)
                ? teal.withOpacity(0.4)
                : bgInput),
      ),
      dividerColor: bgInput,
      iconTheme: const IconThemeData(color: textMain),
    );
  }
}
