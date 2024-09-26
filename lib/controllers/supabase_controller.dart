import 'package:autoverse/exports.dart';

class SupabaseController extends GetxController {
  static SupabaseController get to => Get.find();

  SupabaseClient? supabase;

  SupabaseQueryBuilder? supabaseQueryBuilder;

  @override
  Future<void> onInit() async {
    super.onInit();

    supabase = Supabase.instance.client;
    supabaseQueryBuilder = supabase!.schema("public").from("mark");
  }

  Future<List<Map<String, dynamic>>> getPopularMarks() async {
    try {
      dynamic data = await supabaseQueryBuilder?.select().eq("popular", 1);
      return data;
    } catch (error) {
      logW(error);
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getMarks() async {
    try {
      dynamic data = await supabaseQueryBuilder?.select();
      return data;
    } catch (error) {
      logW(error);
      rethrow;
    }
  }
}
