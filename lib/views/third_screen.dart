import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/viewmodels/third_screen_viewmodel.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final viewModel = Provider.of<ThirdScreenViewmodel>(context, listen: false);
      if (viewModel.users.isEmpty) viewModel.fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ThirdScreenViewmodel>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Third Screen',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          color: const Color(0xFF554AF0),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: const Color(0xFFE2E3E4),
            height: 1.0,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => viewModel.fetchUsers(refresh: true),
        child: viewModel.users.isEmpty
            ? Center(
                child: viewModel.isLoading
                    ? const CircularProgressIndicator()
                    : const Text('No Users Found'),
              )
            : NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (!viewModel.isLoading &&
                      viewModel.hasMore &&
                      scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                    viewModel.fetchUsers();
                  }
                  return false;
                },
                child: ListView.separated(
                  itemCount: viewModel.users.length + (viewModel.hasMore ? 1 : 0),
                  separatorBuilder: (_, __) => const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(
                      thickness: 1,
                      color: Color(0xFFE2E3E4),
                    ),
                  ),
                  itemBuilder: (context, index) {
                    if (index == viewModel.users.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    final user = viewModel.users[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.avatar),
                      ),
                      title: Text(
                        '${user.firstName} ${user.lastName}',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        user.email.toUpperCase(),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context, '${user.firstName} ${user.lastName}');
                      },
                );
              },
           ),
        ),
      )
    );
  }
}
