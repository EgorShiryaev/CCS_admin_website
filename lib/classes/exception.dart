enum Exceptions { userNotFound }

class ExceptionConvert {
  static toTextError(Exceptions ex) {
    switch (ex) {
      case Exceptions.userNotFound:
        return 'Пользователь с такими данными не найден.\nПроверьте введенные данные.';
      default:
        return 'Неизвестная ошибка';
    }
  }
}
