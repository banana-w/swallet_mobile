import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/blocs/student/student_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/student_features/voucher_history/components/vh_transaction_card.dart';
import 'package:swallet_mobile/presentation/widgets/shimmer_widget.dart';

class BodyVoucherHistoryStore extends StatefulWidget {
  const BodyVoucherHistoryStore({super.key, required this.storeId});

  final String storeId;

  @override
  State<BodyVoucherHistoryStore> createState() => _BodyVoucherHistoryState();
}

class _BodyVoucherHistoryState extends State<BodyVoucherHistoryStore> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  
    context.read<StudentBloc>().add(
      LoadVoucherStoreTransactions(id: widget.storeId),
    );

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        context.read<StudentBloc>().add(LoadMoreVoucherStoreTransactions(scrollController));
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<StudentBloc>().add(
          LoadVoucherStoreTransactions(id: widget.storeId),
        );
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: scrollController,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                children: [
                  SizedBox(height: 25 * hem),
                  BlocBuilder<StudentBloc, StudentState>(
                    builder: (context, state) {
                      if (state is StudentTransactionLoading) {
                        return buildTransactionShimmer(5, fem, hem);
                      } else if (state is StudentTransactionsLoaded) {
                        if (state.transactions.isEmpty) {
                          return Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 15 * fem),
                            height: 220 * hem,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/transaction-icon.svg',
                                  width: 60 * fem,
                                  colorFilter: ColorFilter.mode(
                                    kLowTextColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    'Không có chi tiết sử dụng',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.openSans(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10 * fem),
                              ],
                            ),
                          );
                        }
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              state.hasReachedMax
                                  ? state.transactions.length
                                  : state.transactions.length + 1,
                          itemBuilder: (context, index) {
                            if (index >= state.transactions.length) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: kPrimaryColor,
                                ),
                              );
                            } else {
                              return VoucherHistoryTransactionCard(
                                fem: fem,
                                hem: hem,
                                ffem: ffem,
                                transaction: state.transactions[index],
                              );
                            }
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

Widget buildTransactionShimmer(count, double fem, double hem) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: count,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(
              top: 15 * hem,
              left: 10 * fem,
              right: 10 * fem,
            ),
            padding: EdgeInsets.only(left: 10 * fem),
            constraints: BoxConstraints(
              maxHeight: 100 * hem,
              minWidth: 340 * fem,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15 * fem),
              color: Colors.white,
              border: Border.all(color: klighGreyColor),
              boxShadow: [
                BoxShadow(
                  color: Color(0x0c000000),
                  offset: Offset(0 * fem, 0 * fem),
                  blurRadius: 5 * fem,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ShimmerWidget.rectangular(
                      height: 15 * hem,
                      width: 280 * fem,
                    ),
                    ShimmerWidget.rectangular(
                      height: 15 * hem,
                      width: 200 * fem,
                    ),
                    ShimmerWidget.rectangular(
                      height: 15 * hem,
                      width: 100 * fem,
                    ),
                  ],
                ),
                SizedBox(width: 10 * fem),
              ],
            ),
          );
        },
      ),
    ],
  );
}
