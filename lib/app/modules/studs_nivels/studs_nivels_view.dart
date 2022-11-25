import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'studs_nivels_logic.dart';

class StudsNivelsPage extends StatelessWidget {
  final logic = Get.find<StudsNivelsLogic>();

  StudsNivelsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const tileHeight = 200.0;
    const tileWidth = 300.0;
    const spacing = 20.0;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Estudiantes',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      Expanded(
          child: Padding(
              padding: const EdgeInsets.only(top: 60, right: 60, left: 60),
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Establezca un apoderado a cada estudiante',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Seleccione el área en la que desea establecer apoderados',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 50),
                        GetBuilder<StudsNivelsLogic>(
                            id: 'niveles',
                            builder: (_) {
                              final nivelModel = _.nivelModel;
                              return nivelModel != null
                                  ? nivelModel.niveles.isNotEmpty
                                  ? LayoutBuilder(
                                  builder: (context, constaints) {
                                    final count =
                                        constaints.maxWidth ~/ tileWidth;
                                    return GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                      const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: count,
                                          childAspectRatio:
                                          tileWidth / tileHeight,
                                          crossAxisSpacing: spacing,
                                          mainAxisSpacing: spacing),
                                      itemBuilder: (__, index) {
                                        final nivel =
                                        nivelModel.niveles[index];
                                        return MouseRegion(
                                          cursor:
                                          SystemMouseCursors.click,
                                          child: GestureDetector(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(
                                                      index % 2 == 0
                                                          ? 0xff1E4280
                                                          : 0xffF4C300),
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(8)),
                                              child: Center(
                                                  child: Text(
                                                    nivel.name,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 40,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  )),
                                            ),
                                            onTap: () => logic
                                                .toStudsGrads(nivel.id),
                                          ),
                                        );
                                      },
                                      itemCount:
                                      nivelModel.niveles.length,
                                    );
                                  })
                                  : const Center(
                                child: Text('No encontramos niveles'),
                              )
                                  : const Center(
                                child: CircularProgressIndicator(),
                              );
                            }),
                        const SizedBox(height: 20),
                      ]))))
    ]);
  }
}
