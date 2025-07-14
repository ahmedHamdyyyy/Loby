import 'package:flutter/material.dart';

import 'responsive_utils.dart';

/// A responsive container that adapts its size based on screen dimensions
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double? mobileSmallWidth;
  final double? mobileWidth;
  final double? tabletWidth;
  final double? desktopWidth;
  final double? mobileSmallHeight;
  final double? mobileHeight;
  final double? tabletHeight;
  final double? desktopHeight;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;
  final Color? color;
  final Alignment? alignment;
  final BoxConstraints? constraints;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.mobileSmallWidth,
    this.mobileWidth,
    this.tabletWidth,
    this.desktopWidth,
    this.mobileSmallHeight,
    this.mobileHeight,
    this.tabletHeight,
    this.desktopHeight,
    this.padding,
    this.margin,
    this.decoration,
    this.color,
    this.alignment,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    // Determine width based on screen size
    final width =
        mobileSmallWidth != null || mobileWidth != null || tabletWidth != null || desktopWidth != null
            ? ResponsiveUtils.adaptiveValue(
              context: context,
              mobileSmallValue: mobileSmallWidth,
              mobileValue: mobileWidth,
              tabletValue: tabletWidth,
              desktopValue: desktopWidth,
            )
            : null;

    // Determine height based on screen size
    final height =
        mobileSmallHeight != null || mobileHeight != null || tabletHeight != null || desktopHeight != null
            ? ResponsiveUtils.adaptiveValue(
              context: context,
              mobileSmallValue: mobileSmallHeight,
              mobileValue: mobileHeight,
              tabletValue: tabletHeight,
              desktopValue: desktopHeight,
            )
            : null;

    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: decoration,
      color: color,
      alignment: alignment,
      constraints: constraints,
      child: child,
    );
  }
}

/// A responsive card that adapts its padding and elevation based on screen dimensions
class ResponsiveCard extends StatelessWidget {
  final Widget child;
  final double? mobileSmallElevation;
  final double? mobileElevation;
  final double? tabletElevation;
  final double? desktopElevation;
  final EdgeInsetsGeometry? mobileSmallPadding;
  final EdgeInsetsGeometry? mobilePadding;
  final EdgeInsetsGeometry? tabletPadding;
  final EdgeInsetsGeometry? desktopPadding;
  final Color? color;
  final ShapeBorder? shape;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? margin;

  const ResponsiveCard({
    super.key,
    required this.child,
    this.mobileSmallElevation,
    this.mobileElevation,
    this.tabletElevation,
    this.desktopElevation,
    this.mobileSmallPadding,
    this.mobilePadding,
    this.tabletPadding,
    this.desktopPadding,
    this.color,
    this.shape,
    this.borderRadius,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    // Determine elevation based on screen size
    final elevation =
        mobileSmallElevation != null || mobileElevation != null || tabletElevation != null || desktopElevation != null
            ? ResponsiveUtils.adaptiveValue(
              context: context,
              mobileSmallValue: mobileSmallElevation ?? 2.0,
              mobileValue: mobileElevation ?? 3.0,
              tabletValue: tabletElevation ?? 4.0,
              desktopValue: desktopElevation ?? 5.0,
            )
            : 2.0;

    // Determine padding based on screen size
    final padding =
        mobileSmallPadding != null || mobilePadding != null || tabletPadding != null || desktopPadding != null
            ? ResponsiveUtils.adaptiveValue(
              context: context,
              mobileSmallValue: mobileSmallPadding ?? const EdgeInsets.all(8.0),
              mobileValue: mobilePadding ?? const EdgeInsets.all(12.0),
              tabletValue: tabletPadding ?? const EdgeInsets.all(16.0),
              desktopValue: desktopPadding ?? const EdgeInsets.all(20.0),
            )
            : const EdgeInsets.all(12.0);

    // Create the shape based on the border radius if provided
    final effectiveShape = shape ?? (borderRadius != null ? RoundedRectangleBorder(borderRadius: borderRadius!) : null);

    return Card(
      elevation: elevation,
      color: color,
      shape: effectiveShape,
      margin: margin,
      child: Padding(padding: padding, child: child),
    );
  }
}

/// A responsive grid view that adapts its grid properties based on screen dimensions
class ResponsiveGridView extends StatelessWidget {
  final List<Widget> children;
  final int? mobileSmallCrossAxisCount;
  final int? mobileCrossAxisCount;
  final int? tabletCrossAxisCount;
  final int? desktopCrossAxisCount;
  final double? mobileSmallChildAspectRatio;
  final double? mobileChildAspectRatio;
  final double? tabletChildAspectRatio;
  final double? desktopChildAspectRatio;
  final double? mobileSmallCrossAxisSpacing;
  final double? mobileCrossAxisSpacing;
  final double? tabletCrossAxisSpacing;
  final double? desktopCrossAxisSpacing;
  final double? mobileSmallMainAxisSpacing;
  final double? mobileMainAxisSpacing;
  final double? tabletMainAxisSpacing;
  final double? desktopMainAxisSpacing;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final ScrollController? controller;

  const ResponsiveGridView({
    super.key,
    required this.children,
    this.mobileSmallCrossAxisCount = 1,
    this.mobileCrossAxisCount = 2,
    this.tabletCrossAxisCount = 3,
    this.desktopCrossAxisCount = 4,
    this.mobileSmallChildAspectRatio,
    this.mobileChildAspectRatio,
    this.tabletChildAspectRatio,
    this.desktopChildAspectRatio,
    this.mobileSmallCrossAxisSpacing,
    this.mobileCrossAxisSpacing,
    this.tabletCrossAxisSpacing,
    this.desktopCrossAxisSpacing,
    this.mobileSmallMainAxisSpacing,
    this.mobileMainAxisSpacing,
    this.tabletMainAxisSpacing,
    this.desktopMainAxisSpacing,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // Determine cross axis count based on screen size
    final crossAxisCount = ResponsiveUtils.adaptiveValue(
      context: context,
      mobileSmallValue: mobileSmallCrossAxisCount ?? 1,
      mobileValue: mobileCrossAxisCount ?? 2,
      tabletValue: tabletCrossAxisCount ?? 3,
      desktopValue: desktopCrossAxisCount ?? 4,
    );

    // Determine child aspect ratio based on screen size
    final childAspectRatio =
        mobileSmallChildAspectRatio != null ||
                mobileChildAspectRatio != null ||
                tabletChildAspectRatio != null ||
                desktopChildAspectRatio != null
            ? ResponsiveUtils.adaptiveValue(
              context: context,
              mobileSmallValue: mobileSmallChildAspectRatio ?? 1.0,
              mobileValue: mobileChildAspectRatio ?? 1.0,
              tabletValue: tabletChildAspectRatio ?? 1.0,
              desktopValue: desktopChildAspectRatio ?? 1.0,
            )
            : 1.0;

    // Determine cross axis spacing based on screen size
    final crossAxisSpacing =
        mobileSmallCrossAxisSpacing != null ||
                mobileCrossAxisSpacing != null ||
                tabletCrossAxisSpacing != null ||
                desktopCrossAxisSpacing != null
            ? ResponsiveUtils.adaptiveValue(
              context: context,
              mobileSmallValue: mobileSmallCrossAxisSpacing ?? 8.0,
              mobileValue: mobileCrossAxisSpacing ?? 10.0,
              tabletValue: tabletCrossAxisSpacing ?? 12.0,
              desktopValue: desktopCrossAxisSpacing ?? 16.0,
            )
            : 10.0;

    // Determine main axis spacing based on screen size
    final mainAxisSpacing =
        mobileSmallMainAxisSpacing != null ||
                mobileMainAxisSpacing != null ||
                tabletMainAxisSpacing != null ||
                desktopMainAxisSpacing != null
            ? ResponsiveUtils.adaptiveValue(
              context: context,
              mobileSmallValue: mobileSmallMainAxisSpacing ?? 8.0,
              mobileValue: mobileMainAxisSpacing ?? 10.0,
              tabletValue: tabletMainAxisSpacing ?? 12.0,
              desktopValue: desktopMainAxisSpacing ?? 16.0,
            )
            : 10.0;

    return GridView.count(
      crossAxisCount: crossAxisCount,
      childAspectRatio: childAspectRatio,
      crossAxisSpacing: crossAxisSpacing,
      mainAxisSpacing: mainAxisSpacing,
      padding: padding,
      physics: physics,
      shrinkWrap: shrinkWrap,
      controller: controller,
      children: children,
    );
  }
}

/// A responsive row that adapts its properties based on screen dimensions
class ResponsiveRow extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisSize? mainAxisSize;
  final TextDirection? textDirection;
  final VerticalDirection? verticalDirection;
  final TextBaseline? textBaseline;
  final bool adaptiveSpacing;

  const ResponsiveRow({
    super.key,
    required this.children,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.mainAxisSize,
    this.textDirection,
    this.verticalDirection,
    this.textBaseline,
    this.adaptiveSpacing = true,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> spacedChildren = [];

    if (adaptiveSpacing && children.length > 1) {
      final spacing = ResponsiveUtils.adaptiveValue(
        context: context,
        mobileSmallValue: 4.0,
        mobileValue: 8.0,
        tabletValue: 12.0,
        desktopValue: 16.0,
      );

      for (int i = 0; i < children.length; i++) {
        spacedChildren.add(children[i]);
        if (i < children.length - 1) {
          spacedChildren.add(SizedBox(width: spacing));
        }
      }
    } else {
      spacedChildren.addAll(children);
    }

    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      mainAxisSize: mainAxisSize ?? MainAxisSize.max,
      textDirection: textDirection,
      verticalDirection: verticalDirection ?? VerticalDirection.down,
      textBaseline: textBaseline,
      children: adaptiveSpacing ? spacedChildren : children,
    );
  }
}

/// A responsive column that adapts its properties based on screen dimensions
class ResponsiveColumn extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisSize? mainAxisSize;
  final TextDirection? textDirection;
  final VerticalDirection? verticalDirection;
  final TextBaseline? textBaseline;
  final bool adaptiveSpacing;

  const ResponsiveColumn({
    super.key,
    required this.children,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.mainAxisSize,
    this.textDirection,
    this.verticalDirection,
    this.textBaseline,
    this.adaptiveSpacing = true,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> spacedChildren = [];

    if (adaptiveSpacing && children.length > 1) {
      final spacing = ResponsiveUtils.adaptiveValue(
        context: context,
        mobileSmallValue: 6.0,
        mobileValue: 10.0,
        tabletValue: 16.0,
        desktopValue: 20.0,
      );

      for (int i = 0; i < children.length; i++) {
        spacedChildren.add(children[i]);
        if (i < children.length - 1) {
          spacedChildren.add(SizedBox(height: spacing));
        }
      }
    } else {
      spacedChildren.addAll(children);
    }

    return Column(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      mainAxisSize: mainAxisSize ?? MainAxisSize.max,
      textDirection: textDirection,
      verticalDirection: verticalDirection ?? VerticalDirection.down,
      textBaseline: textBaseline,
      children: adaptiveSpacing ? spacedChildren : children,
    );
  }
}
