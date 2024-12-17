import 'package:duckrace/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DropDownMenu extends StatelessWidget {
  const DropDownMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.close),
              color: Colors.black,
            ),
          ],),
          const SizedBox(
            height: 20,
          ),
          _buildMenuListTile(
             'REGISTER AS SPONSOR',
            () {
              context.pop();
              context.goNamed('registerSponsor');
            },
          ),
          _buildMenuListTile(
            'THE SPONSORS RACE',
            () {
              context.pop();
              context.goNamed('sponsor');
            },
          ),
          _buildMenuListTile(
            'SHOP',
            () {
              context.pop();
              // TODO: Implement shop navigation
            },
          ),
          _buildMenuListTile(
            'WINNER',
            () {
              context.pop();
              context.goNamed('winners');
            },
          ),
          _buildMenuListTile(
            'MY DUCK',
            () {
              context.pop();
              // TODO: Implement my duck navigation
            },
          ),
          _buildMenuListTile(
            'SPONSORS',
            () {
              context.pop();
              context.goNamed('sponsorShowcase');
            },
          ),
        ],)
      ),
    );
  }

  Widget _buildMenuListTile(String title, VoidCallback onTap) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          onTap: onTap,
        ),
        const SizedBox(height: 10,),
        const Center(
          child: SizedBox(
            width: 323,
            child: Divider(
              color: AppColors.black,
              thickness: 1,
              height: 2,
            ),
          ),
        ),
        const SizedBox(height: 10,),
      ],
    );
  }
}