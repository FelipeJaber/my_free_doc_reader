import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_free_doc_reader/pages/text_page/TextPageStates.dart';

class TextPageBLoC extends Cubit<TextPageState> {
  TextPageBLoC() : super(TextPageInitialState());
}
