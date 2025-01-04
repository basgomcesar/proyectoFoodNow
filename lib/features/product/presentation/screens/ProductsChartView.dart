import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_offered_bloc/product_offered_bloc.dart';
import '../bloc/product_offered_bloc/product_offered_event.dart';
import '../bloc/product_offered_bloc/product_offered_state.dart';

class ProductsChartView extends StatefulWidget {
  const ProductsChartView({Key? key}) : super(key: key);

  @override
  _ProductsChartViewState createState() => _ProductsChartViewState();
}

class _ProductsChartViewState extends State<ProductsChartView> {
  @override
  void initState() {
    super.initState();
    // Despachar el evento para obtener los productos
    BlocProvider.of<ProductOfferedBloc>(context).add(
      FetchProductsOffered(
        userId: "1",  // Id del vendedor
        anio: "2024", // Año
        mes: "12",    // Mes
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top 10 Productos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<ProductOfferedBloc, ProductOfferedState>(
          builder: (context, state) {
            if (state is ProductOfferedLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is ProductOfferedError) {
              return Center(child: Text('Error: ${state.message}'));
            }

            if (state is ProductOfferedLoaded) {
              final products = state.products;

              final List<Color> colors = [
                Color(0xFFEB5B00),
                Color(0xFFFFB200),
                Color(0xFFFA4032),
                Color(0xFF1E3E62),
                Color(0xFF1E3E62),
                Color(0xFFE9F679),
                Color(0xFF9BDF46),
                Color(0xFF25A55F),
              ];

              return BarChart(
                BarChartData(
                  barGroups: products
                      .asMap()
                      .entries
                      .map(
                        (entry) => BarChartGroupData(
                          x: entry.key,
                          barRods: [
                            BarChartRodData(
                              toY: entry.value.sales.toDouble(),
                              color: colors[entry.key % colors.length],
                            ),
                          ],
                        ),
                      )
                      .toList(),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 50,
                        getTitlesWidget: (index, meta) {
                          final title = products[index.toInt()].name;
                          return RotatedBox(
                            quarterTurns: 1,
                            child: AutoSizeText(
                              title,
                              style: const TextStyle(fontSize: 12),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return AutoSizeText(
                            value.toString(),
                            style: const TextStyle(fontSize: 10),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          );
                        },
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: const Color(0xff37434d),
                      width: 1,
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    drawHorizontalLine: true,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: const Color(0xff37434d),
                        strokeWidth: 0.8,
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: const Color(0xff37434d),
                        strokeWidth: 0.8,
                      );
                    },
                  ),
                ),
              );
            }

            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
