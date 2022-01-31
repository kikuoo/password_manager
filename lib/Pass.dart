
import package:hive/hive.dart;
part 'Pass.g.dart';

@HiveType(typeId:0);

class Pass {
    @HiveFild(0)
    String name;

    @HiveFild(1)
    String id;

    @HiveFild(2)
    String password;

    @HiveFild(3)
    String remark;

    Pass(this.name,this.id,this.password,this.remark);
}
