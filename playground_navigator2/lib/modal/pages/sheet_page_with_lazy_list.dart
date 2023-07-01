import 'package:demo_ui_components/demo_ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playground_navigator2/bloc/playground_cubit.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class SheetPageWithLazyList {
  SheetPageWithLazyList._();

  static WoltModalSheetPage build(BuildContext context, {bool isLastPage = true}) {
    final colors = allMaterialColors;
    const titleText = 'Material Colors';
    final cubit = context.read<PlaygroundCubit>();
    return WoltModalSheetPage.withCustomSliverList(
      mainContentPadding: EdgeInsetsDirectional.zero,
      stickyActionBar: StickyActionBarWrapper(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: WoltElevatedButton(
            onPressed: isLastPage ? cubit.close : cubit.goToNextPage,
            child: Text(isLastPage ? "Close" : "Next"),
          ),
        ),
      ),
      pageTitle: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ModalSheetTitle(titleText),
      ),
      topBarTitle: const ModalSheetTopBarTitle(titleText),
      backButton: WoltModalSheetBackButton(onBackPressed: cubit.goToPreviousPage),
      closeButton: WoltModalSheetCloseButton(onClosed: cubit.close),
      sliverList: SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, index) => ColorTile(color: colors[index]),
          childCount: colors.length,
        ),
      ),
    );
  }
}

class ColorTile extends StatelessWidget {
  final Color color;

  const ColorTile({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: 100,
      child: Center(
        child: Text(
          color.toString(),
          style: TextStyle(
            color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

List<Color> get allMaterialColors {
  List<Color> allMaterialColorsWithShades = [];

  for (MaterialColor color in Colors.primaries) {
    allMaterialColorsWithShades.add(color.shade100);
    allMaterialColorsWithShades.add(color.shade200);
    allMaterialColorsWithShades.add(color.shade300);
    allMaterialColorsWithShades.add(color.shade400);
    allMaterialColorsWithShades.add(color.shade500);
    allMaterialColorsWithShades.add(color.shade600);
    allMaterialColorsWithShades.add(color.shade700);
    allMaterialColorsWithShades.add(color.shade800);
    allMaterialColorsWithShades.add(color.shade900);
  }
  return allMaterialColorsWithShades;
}