import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:preco_certo/app/core/config/message_constants.dart';
import 'package:preco_certo/app/core/extensions/error_translator.dart';
import 'package:preco_certo/app/core/extensions/loader_message.dart';
import 'package:preco_certo/app/core/extensions/message_translator.dart';
import 'package:preco_certo/app/core/extensions/theme_extension.dart';
import 'package:preco_certo/app/core/types/states/command_state.dart';
import 'package:preco_certo/app/core/widgets/app_snack_bar.dart';
import 'package:preco_certo/app/modules/auth/ui/login/login_controller.dart';
import 'package:preco_certo/app/modules/auth/ui/login/login_with_email_and_password_command.dart';
import 'package:preco_certo/gen/assets.gen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with
        MessageTranslator<LoginPage>,
        ErrorTranslator<LoginPage>,
        LoaderMessageMixin<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late final LoginWithEmailAndPasswordCommand _loginCommand;

  @override
  void initState() {
    super.initState();
    _loginCommand = context.read<LoginWithEmailAndPasswordCommand>();
    _loginCommand.addListener(_handleLoginState);
  }

  void _handleLoginState() {
    if (!mounted) return;

    switch (_loginCommand.state) {
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
      _loginCommand.execute(context.read<LoginController>().credentials);
    }
  }

  @override
  void dispose() {
    _loginCommand.removeListener(_handleLoginState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colors;
    final text = theme.text;
    final controller = context.watch<LoginController>();
    final command = context.watch<LoginWithEmailAndPasswordCommand>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Assets.logo.image(
                        height: 68,
                        fit: BoxFit.contain,
                        semanticLabel: 'Preço Certo',
                      ),
                    ),
                    const SizedBox(height: 65),
                    Text(
                      translateMessage(context, MessageConstants.loginEyebrow),
                      style: text.eyebrow.copyWith(color: colors.accent),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      translateMessage(context, MessageConstants.loginTitle),
                      style: text.display,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      translateMessage(context, MessageConstants.loginSubtitle),
                      style: text.body.copyWith(color: colors.muted),
                    ),
                    const SizedBox(height: 34),
                    _LoginField(
                      label: translateMessage(
                        context,
                        MessageConstants.loginEmailLabel,
                      ),
                      hint: translateMessage(
                        context,
                        MessageConstants.loginEmailHint,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      validator: controller.validateEmail,
                    ),
                    const SizedBox(height: 18),
                    _LoginField(
                      label: translateMessage(
                        context,
                        MessageConstants.loginPasswordLabel,
                      ),
                      hint: translateMessage(
                        context,
                        MessageConstants.loginPasswordHint,
                      ),
                      obscureText: !controller.isPasswordVisible,
                      autofillHints: const [AutofillHints.password],
                      suffixIcon: IconButton(
                        tooltip: controller.isPasswordVisible
                            ? translateMessage(
                                context,
                                MessageConstants.loginHidePassword,
                              )
                            : translateMessage(
                                context,
                                MessageConstants.loginShowPassword,
                              ),
                        onPressed: context
                            .read<LoginController>()
                            .togglePasswordVisibility,
                        icon: Icon(
                          controller.isPasswordVisible
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                      ),
                      validator: controller.validatePassword,
                    ),
                    const SizedBox(height: 24),
                    FilledButton(
                      onPressed: command.state is CommandLoading
                          ? null
                          : _submit,
                      child: Text(
                        translateMessage(
                          context,
                          MessageConstants.loginUnlockButton,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Center(
                      child: TextButton(
                        onPressed: () => context.pushNamed('/register'),
                        child: RichText(
                          text: TextSpan(
                            style: text.body.copyWith(color: colors.muted),
                            children: [
                              TextSpan(
                                text: translateMessage(
                                  context,
                                  MessageConstants.loginNoAccount,
                                ),
                              ),
                              TextSpan(
                                text: translateMessage(
                                  context,
                                  MessageConstants.loginCreateAccount,
                                ),
                                style: text.button.copyWith(
                                  color: colors.accent,
                                ),
                              ),
                            ],
                          ),
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

class _LoginField extends StatelessWidget {
  const _LoginField({
    required this.label,
    required this.hint,
    required this.validator,
    this.keyboardType,
    this.autofillHints,
    this.obscureText = false,
    this.suffixIcon,
  });

  final String label;
  final String hint;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.text.label),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: keyboardType,
          autofillHints: autofillHints,
          obscureText: obscureText,
          enableSuggestions: !obscureText,
          autocorrect: !obscureText,
          validator: validator,
          decoration: InputDecoration(hintText: hint, suffixIcon: suffixIcon),
        ),
      ],
    );
  }
}
