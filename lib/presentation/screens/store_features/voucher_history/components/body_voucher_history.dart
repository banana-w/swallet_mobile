import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/student/student_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/student_features/voucher_history/components/vh_transaction_card.dart';
import 'package:swallet_mobile/presentation/widgets/shimmer_widget.dart';

import '../../widgets/store_empty_card.dart';

class BodyVoucherHistoryStore extends StatefulWidget {
  const BodyVoucherHistoryStore({super.key, required this.storeId});

  final String storeId;

  @override
  State<BodyVoucherHistoryStore> createState() => _BodyVoucherHistoryState();
}

class _BodyVoucherHistoryState extends State<BodyVoucherHistoryStore> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<StudentBloc>().add(
      LoadVoucherStoreTransactions(id: widget.storeId),
    );

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<StudentBloc>().add(
          LoadMoreVoucherStoreTransactions(_scrollController),
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<StudentBloc>().add(
          LoadVoucherStoreTransactions(id: widget.storeId),
        );
      },
      child: BlocBuilder<StudentBloc, StudentState>(
        builder: (context, state) {
          if (state is StudentTransactionLoading) {
            return buildTransactionShimmer(5, fem, hem);
          }
          if (state is! StudentTransactionsLoaded) {
            return const SizedBox.shrink();
          }

          final transactions = state.transactions;
          if (transactions.isEmpty) {
            // ListView để RefreshIndicator vẫn kéo được khi danh sách rỗng.
            return ListView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(height: 25 * hem),
                StoreEmptyCard(
                  icon: 'assets/icons/transaction-icon.svg',
                  message: 'Không có chi tiết sử dụng',
                  fem: fem,
                  hem: hem,
                ),
              ],
            );
          }

          return ListView.builder(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 25 * hem),
            // Thêm một ô cuối làm vòng quay khi còn trang để tải.
            itemCount:
                state.hasReachedMax
                    ? transactions.length
                    : transactions.length + 1,
            itemBuilder: (context, index) {
              if (index >= transactions.length) {
                return const Center(
                  child: CircularProgressIndicator(color: kPrimaryColor),
                );
              }
              return VoucherHistoryTransactionCard(
                fem: fem,
                hem: hem,
                ffem: ffem,
                transaction: transactions[index],
              );
            },
          );
        },
      ),
    );
  }
}

Widget buildTransactionShimmer(int count, double fem, double hem) {
  return ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: count,
    itemBuilder: (context, index) {
      return Container(
        margin: EdgeInsets.only(top: 15 * hem, left: 10 * fem, right: 10 * fem),
        padding: EdgeInsets.only(left: 10 * fem),
        constraints: BoxConstraints(maxHeight: 100 * hem, minWidth: 340 * fem),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15 * fem),
          color: Colors.white,
          border: Border.all(color: klighGreyColor),
          boxShadow: [
            BoxShadow(
              color: const Color(0x0c000000),
              offset: Offset(0 * fem, 0 * fem),
              blurRadius: 5 * fem,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ShimmerWidget.rectangular(height: 15 * hem, width: 280 * fem),
            ShimmerWidget.rectangular(height: 15 * hem, width: 200 * fem),
            ShimmerWidget.rectangular(height: 15 * hem, width: 100 * fem),
          ],
        ),
      );
    },
  );
}
