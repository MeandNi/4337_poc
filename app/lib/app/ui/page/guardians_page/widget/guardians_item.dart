import 'package:app/app/model/guardian_model.dart';
import 'package:app/app/res/colors.dart';
import 'package:app/app/res/r.dart';
import 'package:app/app/ui/widget/address_text.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuardiansItem extends StatelessWidget {
  GuardianModel model;

  GuardiansItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onItemClick(),
      child: Container(
        decoration: const BoxDecoration(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 3, top: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    style: const TextStyle(
                      fontSize: 18,
                      color: ColorStyle.color_black_80,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: SizedBox(
                      width: 70,
                      child: AddressText(
                        model.address,
                        style: const TextStyle(
                          fontSize: 12,
                          color: ColorStyle.color_black_40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text(
                  'Added',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: ColorStyle.color_8F8F8F,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'Effective in 24 hours',
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorStyle.color_DA8700_80,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 3),
              child: Image.asset(
                R.assetsImagesArrowRight,
                width: 14,
                height: 24,
              ),
            )
          ],
        ),
      ),
    );
  }

  onItemClick() {
    Get.toNamed(Routes.guardianPage, arguments: model);
  }
}
