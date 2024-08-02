import 'package:people/sevices/router/app_router.dart';
import 'app.dart';
import 'bootstrap.dart';
import 'database/database.dart';

void main() async {
  await bootstrap(() async {
    final databaseHandler = DatabaseHandler.instance;
    final router = AppRouter(databaseHandler);

    return App(router: router, databaseHandler: databaseHandler);
  });
}
