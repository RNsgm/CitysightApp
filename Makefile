run:
	flutter run --debug --dart-define ACCESS_TOKEN=pk.eyJ1Ijoibm9qZWQiLCJhIjoiY2swc2VseDIzMDFzMTNnbHRzeXI4OHM1dSJ9.a5zQLX6VgSABJEdj6U_IXg --dart-define SERVER=http://1.1.0.2:8080

pre:
	flutter packages pub run build_runner build --delete-conflicting-outputs
