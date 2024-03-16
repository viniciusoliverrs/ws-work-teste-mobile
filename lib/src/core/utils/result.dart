typedef Result<Failure, Success> = (Failure? exception, Success? data);

extension ResultExtension<Failure, Success> on Result<Failure, Success> {
  Success? fold({
    Function(Success)? success,
    Function(Failure)? failure,
  }) {
    if (this.$1 != null) {
      failure?.call(this.$1 as Failure);
    } else if (this.$2 != null) {
      success?.call(this.$2 as Success);
    }
    return this.$2;
  }

  bool get isSuccess => this.$2 != null;
  bool get isFailure => this.$1 != null;

  Success get getSuccess => this.$2!;
  Failure get getFailure => this.$1!;

  bool get isNull => this.$1 == null && this.$2 == null;

  bool get isTrue => this.$1 == true;
  bool get isFalse => this.$1 == false;
}
