
abstract class StringValidator{
  bool isValid(String value);
}
class NonEmpetyStringValidator implements StringValidator{
  @override
  bool isValid(String value) {
   return value.isNotEmpty;
  }
}

class EmailandPasswordValidator{
  final StringValidator emailValidator = NonEmpetyStringValidator();
  final StringValidator passwordValidator = NonEmpetyStringValidator();

}