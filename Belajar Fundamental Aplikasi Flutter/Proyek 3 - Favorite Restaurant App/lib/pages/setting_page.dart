import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';

class SettingPage extends StatelessWidget {
  static const routeName = '/setting-page';
  const SettingPage({Key? key}) : super(key: key);

  Widget _buildContent(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Material(
          child: ListTile(
            title: const Text('Saran Restoran'),
            subtitle: const Text('Kamu akan menerima notifikasi saran restoran dari kami'),
            trailing: Consumer<SchedulingProvider>(
              builder: (context, scheduled, _) {
                return Switch.adaptive(
                  value: scheduled.isScheduled,
                  onChanged: (value) async {
                    scheduled.setScheduledStatus(value);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAndroid(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "Pengaturan",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.white
              ),
            )
        ),
        body: _buildContent(context)
    );
  }

  Widget _buildIos(BuildContext context){
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            "Pengaturan",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white
            ),
          ),
          transitionBetweenRoutes: false,
        ),
        child: _buildContent(context)
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}