import 'package:autoverse/exports.dart';

class SupabaseController extends GetxController {
  static SupabaseController get to => Get.find();

  SupabaseClient? supabase;

  SupabaseQuerySchema? supabaseQueryBuilder;

  @override
  Future<void> onInit() async {
    super.onInit();

    supabase = Supabase.instance.client;
    supabaseQueryBuilder = supabase!.schema("public");
  }

  Future<List<Map<String, dynamic>>> getPopularMarks() async {
    try {
      final response = await supabase!
          .schema("public")
          .from("mark")
          .select()
          .eq("popular", 1);
      return response;
    } catch (error) {
      logW(error);
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getMarks() async {
    try {
      final response = await supabase!.schema("public").from("mark").select();
      return response;
    } catch (error) {
      logW(error);
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getModels(String markId) async {
    try {
      final response = await supabase!
          .schema("public")
          .from('model')
          .select('*, generation(*, configuration(*))')
          .eq('mark_id', markId);

      return response;
    } catch (error) {
      logW(error);
      rethrow;
    }
  }

  Future<List<Configuration>> getConfigurations(String generationId) async {
    try {
      final response = await supabase!
          .schema("public")
          .from('configuration')
          .select()
          .eq('generation_id', generationId);
      return (response as List)
          .map<Configuration>((config) => Configuration.fromJson(config))
          .toList();
    } catch (error) {
      logW(error);
      rethrow;
    }
  }
}
