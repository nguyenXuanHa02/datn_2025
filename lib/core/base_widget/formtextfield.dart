import 'package:get/get.dart';
import 'package:kichikichi/commons/bloc/baseController.dart';
import 'package:kichikichi/core/styles/theme.dart';

import '../imports/imports.dart';

Widget textFieldWith<T extends BaseController>(String key,
        {String? label,
        TextInputType? keyType,
        bool haveInitValue = false,
        bool isPass = false}) =>
    Get.isRegistered<T>()
        ? GetBuilder<T>(
            builder: (controller) => TextFormField(
              controller: (haveInitValue)
                  ? TextEditingController(text: controller.fields[key])
                  : null,
              onChanged: (value) {
                controller[key] = value;
                controller.validate();
              },
              decoration: InputDecoration(
                labelText: label ?? key,
                errorText: controller.error[key],
              ),
              obscureText: isPass,
              keyboardType: keyType ?? TextInputType.text,
            ),
          )
        : ErrorWidget(Exception('${T} is not init'));

Widget dateTimeSelect<T extends BaseController>(String key,
        {String? label, bool willPickTime = false}) =>
    Builder(builder: (context) {
      final now = DateTime.now();

      return GetBuilder<T>(
        builder: (controller) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label ?? key,
              style: AppTextStyles.hintText,
            ),
            InkWell(
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: (controller.fields[key] != null)
                      ? DateTimeUtils.parse(controller.fields[key])
                      : null,
                  firstDate: DateTime(now.year),
                  lastDate: DateTime(now.year + 1),
                );
                if (pickedDate != null) {
                  if (willPickTime && context.mounted) {
                    final pickTime = await showTimePicker(
                        context: context,
                        initialTime:
                            TimeOfDay(hour: now.hour, minute: now.minute));

                    controller[key] = DateTimeUtils.format(
                        DateTimeUtils.roundToQuarterHour(DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            pickTime?.hour ?? now.hour,
                            pickTime?.minute ?? now.minute)));
                  } else {
                    controller[key] = DateTimeUtils.format(pickedDate);
                  }
                  controller.validate();
                }
              },
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                    errorText: controller.error[key],
                    labelText: controller.fields[key] ?? key,
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.calendar_today))),
              ),
            )
          ],
        ),
      );
    });
