import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:pet_health_app/models/bath.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/models/vaccination.dart';
import 'package:pet_health_app/utilities.dart';
import 'package:pet_health_app/models/vetVisits.dart';

Future<void> createVaccinationNotification(
    Vaccination vaccination, Pet pet) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: '${Emojis.medical_syringe} Vaccination Reminder',
        body:
            'Remined you - ${vaccination.vaccination} vaccination\ntoday to ${pet.name}',
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar(
        year: vaccination.date.year,
        month: vaccination.date.month,
        day: vaccination.date.day,
        hour: vaccination.hour,
        minute: vaccination.minutes,
        second: 0,
        millisecond: 0,
      ));
}

Future<void> createVetVisitNotification(VetVistis vetVisit, Pet pet) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: '${Emojis.medical_stethoscope} Vet Visit Reminder',
        body:
            'Remined you - ${vetVisit.treatmeantType} at  ${vetVisit.clinicName}\ntoday to ${pet.name}',
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar(
        year: vetVisit.date.year,
        month: vetVisit.date.month,
        day: vetVisit.date.day,
        hour: vetVisit.hour,
        minute: vetVisit.minutes,
        second: 0,
        millisecond: 0,
      ));
}

Future<void> birthdayNotification(Pet pet) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: '${Emojis.activites_confetti_ball} Birthday Time !!',
        body: 'Today is ${pet.name} birthday! Congrates!',
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar(
        month: pet.birthday.month,
        day: pet.birthday.day,
        hour: 21,
        minute: 04,
        second: 0,
        millisecond: 0,
      ));
}

Future<void> createBathNotificationEveryMonth(
    NotificationWeekAndTime notificationWeekAndTime, Pet pet) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: '${Emojis.household_bathtub} Bath Reminder',
        body: 'Remined you - It\'s time for bath\ntoday to ${pet.name}',
        notificationLayout: NotificationLayout.Default,
      ),
      actionButtons: [
        NotificationActionButton(key: 'MARK_DONE', label: 'Mark Done')
      ],
      schedule: NotificationCalendar(
          weekday: notificationWeekAndTime.dayOfTheWeek,
          hour: notificationWeekAndTime.timeOfDay.hour,
          minute: notificationWeekAndTime.timeOfDay.minute,
          second: 0,
          millisecond: 0,
          repeats: true));
}

Future<void> createCleanNotification(
    NotificationWeekAndTime notificationWeekAndTime,
    Pet pet,
    String title) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: '$title Clean Reminder',
        body: 'Remined you - It\'s time for clean ${pet.name}\'s $title',
        notificationLayout: NotificationLayout.Default,
      ),
      actionButtons: [
        NotificationActionButton(key: 'MARK_DONE', label: 'Mark Done')
      ],
      schedule: NotificationCalendar(
          weekday: notificationWeekAndTime.dayOfTheWeek,
          hour: notificationWeekAndTime.timeOfDay.hour,
          minute: notificationWeekAndTime.timeOfDay.minute,
          second: 0,
          millisecond: 0,
          repeats: true));
}

Future<void> createHygieneNotification(
    NotificationWeekAndTime notificationWeekAndTime,
    Pet pet,
    String title) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: '$title Reminder',
        body: 'Remined you - It\'s time for $title to ${pet.name}',
        notificationLayout: NotificationLayout.Default,
      ),
      actionButtons: [
        NotificationActionButton(key: 'MARK_DONE', label: 'Mark Done')
      ],
      schedule: NotificationCalendar(
          weekday: notificationWeekAndTime.dayOfTheWeek,
          hour: notificationWeekAndTime.timeOfDay.hour,
          minute: notificationWeekAndTime.timeOfDay.minute,
          second: 0,
          millisecond: 0,
          repeats: true));
}

Future<void> createTeethNotificationEveryDay(
    NotificationEveryDayAtTime notificationEveryDayAtTime, Pet pet) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: '${Emojis.household_toothbrush} Brush Teeth Reminder',
        body: 'Remined you - It\'s time for brush\n${pet.name} teeth',
        notificationLayout: NotificationLayout.Default,
      ),
      actionButtons: [
        NotificationActionButton(key: 'MARK_DONE', label: 'Mark Done')
      ],
      schedule: NotificationCalendar(
          hour: notificationEveryDayAtTime.timeOfDay.hour,
          minute: notificationEveryDayAtTime.timeOfDay.minute,
          second: 0,
          millisecond: 0,
          repeats: true));
}

Future<void> createFoodNotificationEveryDay(
    int hour, int minute, Pet pet) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: '${Emojis.body_bone} Feed Reminder',
        body: 'Remined you - It\'s time for feed ${pet.name}',
        notificationLayout: NotificationLayout.Default,
      ),
      actionButtons: [
        NotificationActionButton(key: 'MARK_DONE', label: 'Mark Done')
      ],
      schedule: NotificationCalendar(
          hour: hour,
          minute: minute,
          second: 0,
          millisecond: 0,
          repeats: true));
}

Future<void> createWalkNotificationEveryDay(
    int hour, int minute, Pet pet) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: '${Emojis.person_activity_man_walking} Walking Reminder',
        body: 'Remined you - It\'s time for a walk to ${pet.name}',
        notificationLayout: NotificationLayout.Default,
      ),
      actionButtons: [
        NotificationActionButton(key: 'MARK_DONE', label: 'Mark Done')
      ],
      schedule: NotificationCalendar(
          hour: hour,
          minute: minute,
          second: 0,
          millisecond: 0,
          repeats: true));
}

Future<void> createMedicationNotificationEveryDay(
    int hour, int minute, Pet pet) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: '${Emojis.medical_pill} Feed Reminder',
        body: 'Remined you - It\'s time for give medication to ${pet.name}',
        notificationLayout: NotificationLayout.Default,
      ),
      actionButtons: [
        NotificationActionButton(key: 'MARK_DONE', label: 'Mark Done')
      ],
      schedule: NotificationCalendar(
          hour: hour,
          minute: minute,
          second: 0,
          millisecond: 0,
          repeats: true));
}

Future<void> cancelScheduleNotifcations() async {
  await AwesomeNotifications().cancelAllSchedules();
}
