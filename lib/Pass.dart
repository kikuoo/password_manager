
import 'package:hive/hive.dart';
part 'Pass.g.dart';

@HiveType(typeId:0)

class Pass {
    @HiveField(0)
    String name;

    @HiveField(1)
    String id;

    @HiveField(2)
    String password;

    @HiveField(3)
    String remark;

    Pass(this.name,this.id,this.password,this.remark);
}
