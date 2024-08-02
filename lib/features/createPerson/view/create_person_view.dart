import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people/utils/app_textstyles.dart';
import 'package:people/utils/state_status.dart';
import '../../../generated/l10n.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/universal_methods.dart';
import '../bloc/create_person_bloc.dart';
import '../bloc/create_person_event.dart';
import '../bloc/create_person_state.dart';

class CreatePersonView extends StatefulWidget {
  const CreatePersonView({super.key});

  @override
  State<CreatePersonView> createState() => _CreatePersonViewState();
}

class _CreatePersonViewState extends State<CreatePersonView> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _addressController = TextEditingController();
  final _addressFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _addressFocusNode.addListener(_onAddressFocusChange);
  }

  void _onAddressFocusChange() async {
    if (!_addressFocusNode.hasFocus) {
      final postalCode = _addressController.text;
      if (isValidPostalCode(postalCode)) {
        final address = await fetchAddress(postalCode);
        if (address != null) {
          setState(() {
            _addressController.text = address;
          });
        }
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null && selectedDate != DateTime.now()) {
      setState(() {
        _dateOfBirthController.text =
            "${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.whiteColor),
          backgroundColor: AppColors.blackColor,
          title: Text(S.current.create_person, style: AppTextStyles.bold16.copyWith(color: AppColors.whiteColor))),
      body: BlocListener<CreatePersonBloc, CreatePersonState>(
        listener: (context, state) {
          if (state.status == StateStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.current.add_person_success)));
            Navigator.of(context).pop();
          } else if (state.status == StateStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.current.add_person_failure)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  style: AppTextStyles.normal16.copyWith(color: AppColors.whiteColor),
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    labelText: S.current.name,
                    labelStyle: AppTextStyles.normal16.copyWith(color: AppColors.whiteColor),
                  ),
                ),
                TextFormField(
                  style: AppTextStyles.normal16.copyWith(color: AppColors.whiteColor),
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    labelText: S.current.surname,
                    labelStyle: AppTextStyles.normal16.copyWith(color: AppColors.whiteColor),
                  ),
                ),
                GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                          style: AppTextStyles.normal16.copyWith(color: AppColors.whiteColor),
                          controller: _dateOfBirthController,
                          decoration: InputDecoration(
                            labelText: S.current.date_of_birth,
                            labelStyle: AppTextStyles.normal16.copyWith(color: AppColors.whiteColor),
                            suffixIcon: Icon(Icons.calendar_today, color: AppColors.whiteColor),
                          )),
                    )),
                TextFormField(
                  style: AppTextStyles.normal16.copyWith(color: AppColors.whiteColor),
                  controller: _addressController,
                  focusNode: _addressFocusNode,
                  decoration: InputDecoration(
                      labelText: S.current.address,
                      labelStyle: AppTextStyles.normal16.copyWith(color: AppColors.whiteColor)),
                ),
                const SizedBox(height: 20),
                BlocBuilder<CreatePersonBloc, CreatePersonState>(
                  builder: (context, state) {
                    if (state.status == StateStatus.loading) {
                      return const CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<CreatePersonBloc>().add(
                                SubmitPersonEvent(
                                  firstName: _firstNameController.text,
                                  lastName: _lastNameController.text,
                                  dateOfBirth: _dateOfBirthController.text,
                                  address: _addressController.text,
                                ),
                              );
                        }
                      },
                      child: Text(
                        S.current.add_person,
                        style: AppTextStyles.bold16.copyWith(color: AppColors.redColor),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dateOfBirthController.dispose();
    _addressController.dispose();
    _addressFocusNode.dispose();
    super.dispose();
  }
}
