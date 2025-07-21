class DersModel {
  final String ad;
  final double harfDegeri;
  final double krediDegeri;

  DersModel({
    required this.ad,
    required this.harfDegeri,
    required this.krediDegeri,
  });

  @override
  String toString() {
    // TODO: implement toString
    return "ad : $ad - harfDegeri : $harfDegeri - kredidegeri : $krediDegeri";
  }
}
