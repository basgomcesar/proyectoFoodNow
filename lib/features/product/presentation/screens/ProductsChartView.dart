import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/product_offered_bloc/product_offered_bloc.dart';
import '../bloc/product_offered_bloc/product_offered_event.dart';
import '../bloc/product_offered_bloc/product_offered_state.dart';

class ProductsChartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const ProductsChartViewContent();
  }
}

class ProductsChartViewContent extends StatefulWidget {
  const ProductsChartViewContent({Key? key}) : super(key: key);

  @override
  _ProductsChartViewState createState() => _ProductsChartViewState();
}

class _ProductsChartViewState extends State<ProductsChartViewContent> {
  String selectedMonth = '01';
  String selectedYear = '2025';

  final List<String> months = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12'
  ];
  final List<String> years = [
    '2010',
    '2011',
    '2012',
    '2013',
    '2014',
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
    '2025'
  ];

  @override
  void initState() {
    super.initState();
    _reloadData();
  }

  void _reloadData() {
    context.read<ProductOfferedBloc>().add(
          FetchProductsOffered(
            anio: selectedYear,
            mes: selectedMonth,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top 10 Productos vendidos por mes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedYear,
              decoration: const InputDecoration(
                labelText: 'Selecciona el Año',
                border: OutlineInputBorder(),
              ),
              onChanged: (String? newYear) {
                if (newYear != null) {
                  setState(() {
                    selectedYear = newYear;
                  });
                  _reloadData();
                }
              },
              items: years.map((String year) {
                return DropdownMenuItem<String>(
                  value: year,
                  child: Text(year),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedMonth,
              decoration: const InputDecoration(
                labelText: 'Selecciona el Mes',
                border: OutlineInputBorder(),
              ),
              onChanged: (String? newMonth) {
                if (newMonth != null) {
                  setState(() {
                    selectedMonth = newMonth;
                  });
                  _reloadData();
                }
              },
              items: months.map((String month) {
                return DropdownMenuItem<String>(
                  value: month,
                  child: Text(_getMonthName(month)),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<ProductOfferedBloc, ProductOfferedState>(
                builder: (context, state) {
                  if (state is ProductOfferedLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (state is ProductOfferedError) {
                    return Center(
                        child: Text(state.message.contains("404")
                            ? "Error: No hay datos que mostrar en este periodo de tiempo"
                            : "Error: ${state.message}"));
                  }

                  if (state is ProductOfferedLoaded) {
                    final products = state.products;

                    if (products.isEmpty) {
                      return Center(
                          child: Text(
                              'No hay datos sobre ese periodo de tiempo.'));
                    }

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

                    double maxSales = products.fold(
                        0.0,
                        (max, product) => max > product.sales.toDouble()
                            ? max
                            : product.sales.toDouble());

                    double upperLimit = (maxSales / 10).ceil() * 10;
                    upperLimit = upperLimit < 10 ? 10 : upperLimit;

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: BarChart(
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
                                reservedSize:
                                    80, // Aumentar para dar más espacio a los títulos
                                getTitlesWidget: (index, meta) {
                                  final title = products[index.toInt()].name;
                                  return RotatedBox(
                                    quarterTurns: 1, // Gira el texto 90 grados
                                    child: AutoSizeText(
                                      title,
                                      style: const TextStyle(
                                          fontSize: 10), // Tamaño ajustable
                                      maxLines:
                                          2, // Permitir hasta 2 líneas si el texto es muy largo
                                      overflow: TextOverflow
                                          .ellipsis, // Manejar texto largo con puntos suspensivos
                                      textAlign:
                                          TextAlign.center, // Centrar el texto
                                    ),
                                  );
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 50,
                                getTitlesWidget: (value, meta) {
                                  final intValue = value.toInt();
                                  return intValue >= 1 && intValue <= 10
                                      ? AutoSizeText(
                                          '$intValue',
                                          style: const TextStyle(fontSize: 10),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      : Container();
                                },
                              ),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: const AxisTitles(
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
                              return const FlLine(
                                color: Color(0xff37434d),
                                strokeWidth: 0.8,
                              );
                            },
                            getDrawingVerticalLine: (value) {
                              return const FlLine(
                                color: Color(0xff37434d),
                                strokeWidth: 0.8,
                              );
                            },
                          ),
                          maxY: upperLimit,
                        ),
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(String month) {
    switch (month) {
      case '01':
        return 'Enero';
      case '02':
        return 'Febrero';
      case '03':
        return 'Marzo';
      case '04':
        return 'Abril';
      case '05':
        return 'Mayo';
      case '06':
        return 'Junio';
      case '07':
        return 'Julio';
      case '08':
        return 'Agosto';
      case '09':
        return 'Septiembre';
      case '10':
        return 'Octubre';
      case '11':
        return 'Noviembre';
      case '12':
        return 'Diciembre';
      default:
        return '';
    }
  }
}
