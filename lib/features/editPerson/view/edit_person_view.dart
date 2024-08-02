import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people/features/editPerson/bloc/edit_person_bloc.dart';
import 'package:people/features/editPerson/bloc/edit_person_event.dart';
import 'package:people/features/editPerson/bloc/edit_person_state.dart';

import '../../../generated/l10n.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_textstyles.dart';
import '../../../utils/state_status.dart';
import '../../../utils/universal_methods.dart';

class EditPersonView extends StatefulWidget {
  const EditPersonView({super.key, required this.personId});

  final int personId;

  @override
  State<EditPersonView> createState() => _EditPersonViewState();
}

class _EditPersonViewState extends State<EditPersonView> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _addressController = TextEditingController();
  final _addressFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    context.read<EditPersonBloc>().add(LoadPersonDetailsEvent(personId: widget.personId));
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
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dateOfBirthController.dispose();
    _addressController.dispose();
    _addressFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.whiteColor),
          backgroundColor: AppColors.blackColor,
          title: Text(
            S.current.edit_person,
            style: AppTextStyles.bold16.copyWith(color: AppColors.whiteColor),
          )),
      body: BlocConsumer<EditPersonBloc, EditPersonState>(
        listener: (context, state) {
          if (state.status == StateStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.current.edit_person_success)));
            Navigator.of(context).pop();
          } else if (state.status == StateStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.current.edit_person_failure)));
          }
        },
        builder: (context, state) {
          if (state.status == StateStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          final person = state.person;

          if (person != null) {
            _firstNameController.text = person.firstName;
            _lastNameController.text = person.lastName;
            if (_dateOfBirthController.text.isEmpty) _dateOfBirthController.text = person.birthDate;
            if (_addressController.text.isEmpty) _addressController.text = person.address;
          }
          return Padding(
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
                  Expanded(
                    child: ListView(
                      children: state.groups.map((group) {
                        final isSelected = state.selectedGroups.contains(group);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: isSelected ? AppColors.redColor : Colors.white, width: 1),
                            ),
                            child: ListTile(
                              title: Text(
                                group.name,
                                style: AppTextStyles.bold14.copyWith(color: AppColors.whiteColor),
                              ),
                              subtitle: Text(
                                '${S.current.amount_of_people} ${group.persons.length}',
                                style: AppTextStyles.normal14.copyWith(color: AppColors.redColor),
                              ),
                              splashColor: Colors.transparent,
                              onTap: () {
                                context.read<EditPersonBloc>().add(
                                      ToggleGroupSelectionEvent(group: group),
                                    );
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        context.read<EditPersonBloc>().add(
                              UpdatePersonEvent(
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text,
                                birthDate: _dateOfBirthController.text,
                                address: _addressController.text,
                              ),
                            );
                      }
                    },
                    child: Text(
                      S.current.update_person,
                      style: AppTextStyles.bold16.copyWith(color: AppColors.redColor),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (dialogContext) => AlertDialog(
                          title: Text(S.current.delete_person),
                          content: Text(S.current.dialog_person_desc),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(dialogContext).pop();
                              },
                              child: Text(S.current.cancel),
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<EditPersonBloc>().add(
                                      DeletePersonEvent(personId: state.person!.id!),
                                    );
                                Navigator.of(dialogContext).pop();
                              },
                              child: Text(S.current.delete),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text(
                      S.current.delete_person,
                      style: AppTextStyles.bold16.copyWith(color: AppColors.whiteColor),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
