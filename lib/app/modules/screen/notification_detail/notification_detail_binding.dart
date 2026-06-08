part of 'notification_detail_view.dart';

class NotificationDetailViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationDetailViewController>(
      () => NotificationDetailViewController(),
    );
  }
}
