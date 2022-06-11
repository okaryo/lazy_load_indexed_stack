name: Test and Lint

on:
  push:

jobs:
  test:
    name: Run test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Set up Flutter
      uses: subosito/flutter-action@v2
      with:
        flutter-version: '2.10.5'
        channel: 'stable'
      - name: Run pub get
        run: flutter pub get
      - name: Run test
        run: flutter test

  lint:
    name: Run lint
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Set up Flutter
    uses: subosito/flutter-action@v2
    with:
      flutter-version: '2.10.5'
      channel: 'stable'
    - name: Run pub get
      run: flutter pub get
    - name: Run analyze
      run: flutter analyze
