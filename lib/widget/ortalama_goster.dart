import 'package:flutter/material.dart';
import 'package:practice_ortalama_hesapla/costants/app_constants.dart';

class OrtalamaGoster extends StatelessWidget {
  final double ortalama;
  final int dersSayisi;
  const OrtalamaGoster({
    super.key,
    required this.ortalama,
    required this.dersSayisi,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          dersSayisi > 0 ? '$dersSayisi Ders Girildi' : 'Ders Seçiniz',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppConstants.anaRenk,
          ),
        ),
        Text(
          ortalama >= 0 ? '${ortalama.toStringAsFixed(2)}' : '0.0',
          style: TextStyle(
            fontSize: 55,
            fontWeight: FontWeight.w800,
            color: AppConstants.anaRenk,
          ),
        ),
        Text(
          'Ortalama',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppConstants.anaRenk,
          ),
        ),
      ],
    );
  }
}
