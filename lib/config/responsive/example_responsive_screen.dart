import 'package:flutter/material.dart';

import '../colors/colors.dart';
import 'responsive.dart';

/// An example screen demonstrating the usage of responsive utilities
class ExampleResponsiveScreen extends StatelessWidget {
  const ExampleResponsiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Responsive Example')),
      body: SafeArea(
        child: Responsive(
          // Define different layouts for different device sizes
          mobileSmall: _buildMobileSmallLayout(context),
          mobile: _buildMobileLayout(context),
          tablet: _buildTabletLayout(context),
          desktop: _buildDesktopLayout(context),
        ),
      ),
    );
  }

  // Layout for small mobile devices (< 480px width)
  Widget _buildMobileSmallLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: context.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          SizedBox(height: context.sectionSpacing),
          _buildInfoCards(context, columns: 1),
          SizedBox(height: context.sectionSpacing),
          _buildForm(context),
          SizedBox(height: context.sectionSpacing),
          _buildButtons(context),
        ],
      ),
    );
  }

  // Layout for normal mobile devices (480px - 768px width)
  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: context.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          SizedBox(height: context.sectionSpacing),
          _buildInfoCards(context, columns: 2),
          SizedBox(height: context.sectionSpacing),
          _buildForm(context),
          SizedBox(height: context.sectionSpacing),
          _buildButtons(context),
        ],
      ),
    );
  }

  // Layout for tablet devices (768px - 1024px width)
  Widget _buildTabletLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: context.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          SizedBox(height: context.sectionSpacing),
          _buildInfoCards(context, columns: 3),
          SizedBox(height: context.sectionSpacing),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 6, child: _buildForm(context)),
              SizedBox(width: context.componentSpacing),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    _buildSummaryCard(context),
                    SizedBox(height: context.componentSpacing),
                    _buildButtons(context),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Layout for desktop devices (> 1024px width)
  Widget _buildDesktopLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: context.screenPadding,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: context.maxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              SizedBox(height: context.sectionSpacing),
              _buildInfoCards(context, columns: 4),
              SizedBox(height: context.sectionSpacing),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 7, child: _buildForm(context)),
                  SizedBox(width: context.componentSpacing * 2),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        _buildSummaryCard(context),
                        SizedBox(height: context.componentSpacing),
                        _buildButtons(context),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Header section with responsive text
  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ResponsiveText(
          'Welome to Fondok',
          mobileSmallSize: 24,
          mobileSize: 28,
          tabletSize: 32,
          desktopSize: 36,
          fontWeight: FontWeight.bold,
          color: AppColors.secondTextColor,
        ),
        SizedBox(height: context.itemSpacing),
        const ResponsiveText(
          'Find the perfect accommodations for your needs',
          mobileSmallSize: 14,
          mobileSize: 16,
          tabletSize: 18,
          desktopSize: 20,
          color: AppColors.grayTextColor,
        ),
      ],
    );
  }

  // Info cards section with responsive grid
  Widget _buildInfoCards(BuildContext context, {required int columns}) {
    return ResponsiveGridView(
      mobileSmallCrossAxisCount: 1,
      mobileCrossAxisCount: 2,
      tabletCrossAxisCount: 3,
      desktopCrossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildInfoCard(
          context,
          icon: Icons.hotel,
          title: 'Hotels',
          description: 'Find the best hotels',
          color: Colors.blue.shade100,
        ),
        _buildInfoCard(
          context,
          icon: Icons.apartment,
          title: 'Apartments',
          description: 'Discover amazing apartments',
          color: Colors.green.shade100,
        ),
        _buildInfoCard(
          context,
          icon: Icons.house,
          title: 'Villas',
          description: 'Luxury villas for your vacation',
          color: Colors.orange.shade100,
        ),
        _buildInfoCard(
          context,
          icon: Icons.cabin,
          title: 'Cabins',
          description: 'Cozy cabins in nature',
          color: Colors.purple.shade100,
        ),
      ],
    );
  }

  // Single info card with responsive design
  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return ResponsiveCard(
      color: color,
      mobileSmallPadding: const EdgeInsets.all(12),
      mobilePadding: const EdgeInsets.all(16),
      tabletPadding: const EdgeInsets.all(20),
      desktopPadding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: context.iconSize * 1.5, color: Colors.black87),
          SizedBox(height: context.itemSpacing),
          ResponsiveText(
            title,
            mobileSmallSize: 16,
            mobileSize: 18,
            tabletSize: 20,
            desktopSize: 22,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: context.itemSpacing / 2),
          ResponsiveText(
            description,
            mobileSmallSize: 12,
            mobileSize: 14,
            tabletSize: 16,
            desktopSize: 18,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

  // Form section with responsive inputs
  Widget _buildForm(BuildContext context) {
    return const ResponsiveCard(
      child: ResponsiveColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveText(
            'Search for Accommodations',
            mobileSmallSize: 18,
            mobileSize: 20,
            tabletSize: 22,
            desktopSize: 24,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 16),
          ResponsiveTextField(
            hintText: 'Location (city, area, or property name)',
            prefixIcon: Icon(Icons.location_on_outlined),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ResponsiveTextField(hintText: 'Check-in', prefixIcon: Icon(Icons.calendar_today)),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ResponsiveTextField(hintText: 'Check-out', prefixIcon: Icon(Icons.calendar_today)),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ResponsiveTextField(
                  hintText: 'Guests',
                  prefixIcon: Icon(Icons.person_outline),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ResponsiveDropdownButton<String>(
                  hint: 'Room type',
                  items: [
                    DropdownMenuItem(value: 'single', child: Text('Single')),
                    DropdownMenuItem(value: 'double', child: Text('Double')),
                    DropdownMenuItem(value: 'suite', child: Text('Suite')),
                    DropdownMenuItem(value: 'family', child: Text('Family')),
                  ],
                  isExpanded: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          ResponsiveCheckbox(value: true, label: 'Include breakfast'),
          ResponsiveCheckbox(value: false, label: 'Pet friendly'),
        ],
      ),
    );
  }

  // Summary card with responsive design
  Widget _buildSummaryCard(BuildContext context) {
    return ResponsiveCard(
      color: AppColors.primary.withAlpha(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ResponsiveText(
            'Your Search',
            mobileSmallSize: 18,
            mobileSize: 20,
            tabletSize: 22,
            desktopSize: 24,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 16),
          _buildSummaryRow(context, 'Location', 'Dubai, UAE'),
          _buildSummaryRow(context, 'Check-in', 'Jun 15, 2023'),
          _buildSummaryRow(context, 'Check-out', 'Jun 20, 2023'),
          _buildSummaryRow(context, 'Guests', '2 Adults, 1 Child'),
          _buildSummaryRow(context, 'Room Type', 'Double Room'),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ResponsiveText(
                'Total',
                mobileSmallSize: 16,
                mobileSize: 18,
                tabletSize: 20,
                desktopSize: 22,
                fontWeight: FontWeight.bold,
              ),
              ResponsiveText(
                '\$750',
                mobileSmallSize: 18,
                mobileSize: 20,
                tabletSize: 22,
                desktopSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method for summary row
  Widget _buildSummaryRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ResponsiveText(label, mobileSmallSize: 12, mobileSize: 14, tabletSize: 16, desktopSize: 18, color: Colors.black54),
          ResponsiveText(
            value,
            mobileSmallSize: 12,
            mobileSize: 14,
            tabletSize: 16,
            desktopSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  // Buttons section with responsive buttons
  Widget _buildButtons(BuildContext context) {
    bool isSmallDevice = context.isMobileSmall;

    return isSmallDevice
        ? Column(
            children: [
              ResponsiveElevatedButton(
                text: 'Search Properties',
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                isFullWidth: true,
                onPressed: () {},
              ),
              SizedBox(height: context.itemSpacing),
              ResponsiveOutlinedButton(
                text: 'Clear Search',
                foregroundColor: AppColors.primary,
                borderColor: AppColors.primary,
                isFullWidth: true,
                onPressed: () {},
              ),
            ],
          )
        : Row(
            children: [
              Expanded(
                child: ResponsiveElevatedButton(
                  text: 'Search Properties',
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  isFullWidth: true,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: context.itemSpacing),
              Expanded(
                child: ResponsiveOutlinedButton(
                  text: 'Clear Search',
                  foregroundColor: AppColors.primary,
                  borderColor: AppColors.primary,
                  isFullWidth: true,
                  onPressed: () {},
                ),
              ),
            ],
          );
  }
}
