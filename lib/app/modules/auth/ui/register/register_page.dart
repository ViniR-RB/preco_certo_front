import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:preco_certo/app/core/config/message_constants.dart';
import 'package:preco_certo/app/core/extensions/error_translator.dart';
import 'package:preco_certo/app/core/extensions/loader_message.dart';
import 'package:preco_certo/app/core/extensions/message_translator.dart';
import 'package:preco_certo/app/core/extensions/theme_extension.dart';
import 'package:preco_certo/app/core/types/states/command_state.dart';
import 'package:preco_certo/app/core/widgets/app_snack_bar.dart';
import 'package:preco_certo/app/modules/auth/dto/register_with_email_and_password.dart';
import 'package:preco_certo/app/modules/auth/ui/register/register_with_email_and_password_command.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with
        MessageTranslator<RegisterPage>,
        ErrorTranslator<RegisterPage>,
        LoaderMessageMixin<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _registration = RegisterWithEmailAndPassword(
    email: '',
    password: '',
    name: '',
  );
  late final RegisterWithEmailAndPasswordCommand _registerCommand;

  @override
  void initState() {
    super.initState();
    _registerCommand = context.read<RegisterWithEmailAndPasswordCommand>();
    _registerCommand.addListener(_handleRegisterState);
  }

  void _handleRegisterState() {
    if (!mounted) return;

    switch (_registerCommand.state) {
      case CommandInitial():
        notifier.hideLoader();
      case CommandLoading():
        notifier.showLoader();
      case CommandSuccess():
        notifier.hideLoader();
        context.navigate('/offers');
      case CommandFailure(:final exception):
        notifier
          ..hideLoader()
          ..showMessage(translateError(exception), SnackType.error);
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      _formKey.currentState!.save();
      _registerCommand.execute(_registration);
    }
  }

  @override
  void dispose() {
    _registerCommand.removeListener(_handleRegisterState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colors;
    final text = theme.text;
    final command = context.watch<RegisterWithEmailAndPasswordCommand>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        tooltip: translateMessage(
                          context,
                          MessageConstants.registerBack,
                        ),
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      translateMessage(
                        context,
                        MessageConstants.registerEyebrow,
                      ),
                      style: text.eyebrow.copyWith(color: colors.accent),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      translateMessage(context, MessageConstants.registerTitle),
                      style: text.display,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      translateMessage(
                        context,
                        MessageConstants.registerSubtitle,
                      ),
                      style: text.body.copyWith(color: colors.muted),
                    ),
                    const SizedBox(height: 30),
                    _RegisterField(
                      label: translateMessage(
                        context,
                        MessageConstants.registerNameLabel,
                      ),
                      hint: translateMessage(
                        context,
                        MessageConstants.registerNameHint,
                      ),
                      autofillHints: const [AutofillHints.name],
                      textCapitalization: TextCapitalization.words,
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                          ? translateMessage(
                              context,
                              MessageConstants.registerNameRequired,
                            )
                          : null,
                      onSaved: (value) => _registration.name = value!.trim(),
                    ),
                    const SizedBox(height: 18),
                    _RegisterField(
                      label: translateMessage(
                        context,
                        MessageConstants.registerEmailLabel,
                      ),
                      hint: translateMessage(
                        context,
                        MessageConstants.registerEmailHint,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return translateMessage(
                            context,
                            MessageConstants.registerEmailRequired,
                          );
                        }
                        if (!value.contains('@')) {
                          return translateMessage(
                            context,
                            MessageConstants.registerEmailInvalid,
                          );
                        }
                        return null;
                      },
                      onSaved: (value) => _registration.email = value!.trim(),
                    ),
                    const SizedBox(height: 18),
                    _RegisterField(
                      label: translateMessage(
                        context,
                        MessageConstants.registerPasswordLabel,
                      ),
                      hint: translateMessage(
                        context,
                        MessageConstants.registerPasswordHint,
                      ),
                      obscureText: true,
                      autofillHints: const [AutofillHints.newPassword],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return translateMessage(
                            context,
                            MessageConstants.registerPasswordRequired,
                          );
                        }
                        if (value.length < 6) {
                          return translateMessage(
                            context,
                            MessageConstants.registerPasswordInvalid,
                          );
                        }
                        return null;
                      },
                      onSaved: (value) => _registration.password = value!,
                    ),
                    const SizedBox(height: 24),
                    FilledButton(
                      onPressed: command.state is CommandLoading
                          ? null
                          : _submit,
                      child: Text(
                        translateMessage(
                          context,
                          MessageConstants.registerSubmit,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RegisterField extends StatelessWidget {
  const _RegisterField({
    required this.label,
    required this.hint,
    required this.validator,
    this.onSaved,
    this.keyboardType,
    this.autofillHints,
    this.textCapitalization = TextCapitalization.none,
    this.obscureText = false,
  });

  final String label;
  final String hint;
  final String? Function(String?) validator;
  final void Function(String?)? onSaved;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final TextCapitalization textCapitalization;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).text.label),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: keyboardType,
          autofillHints: autofillHints,
          textCapitalization: textCapitalization,
          obscureText: obscureText,
          enableSuggestions: !obscureText,
          autocorrect: !obscureText,
          validator: validator,
          onSaved: onSaved,
          decoration: InputDecoration(hintText: hint),
        ),
      ],
    );
  }
}
