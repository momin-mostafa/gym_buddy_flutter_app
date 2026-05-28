import 'package:gym_buddy/interface/data_source.interface.dart';

import 'model/nutrients.dto.dart' show NutrientsDTO;
import 'model/nutrients.entity.dart' show Nutrients;

class NutrientsRepo {
  DataSource<NutrientsDTO> dataSource;

  NutrientsRepo(this.dataSource);

  Future<List<Nutrients>> getAllNutrientsList() async {
    final dtoList = await dataSource.fetchAllData();
    return dtoList.map((dto) => Nutrients.fromDTO(dto)).toList();
  }

  Future<Nutrients?> getNutrientsForId(int id) async {
    final dto = await dataSource.fetchDataForId(id);
    if (dto == null) return null;
    return Nutrients.fromDTO(dto);
  }

  Future<List<Nutrients>> addNutrients(Nutrients nutrients) async{
    final dtoList =  await dataSource.insertData(nutrients.toDTO());
    return dtoList.map((dto) => Nutrients.fromDTO(dto)).toList();
  }
}
