import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://dqoutbfudrbrkfxtgbxq.supabase.co';
const supabaseKey = String.fromEnvironment('SUPABASE_KEY');

final supabase = Supabase.instance.client;
