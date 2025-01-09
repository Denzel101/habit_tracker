enum BuildFlavour {
  development,
  staging,
  production;

  @override
  String toString() {
    switch (this) {
      case BuildFlavour.development:
        return 'development';
      case BuildFlavour.staging:
        return 'staging';
      case BuildFlavour.production:
        return 'production';
    }
  }
}
