import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people/utils/app_colors.dart';
import 'package:people/utils/state_status.dart';
import '../../../generated/l10n.dart';
import '../../../utils/app_textstyles.dart';
import '../bloc/edit_group_bloc.dart';
import '../bloc/edit_group_event.dart';
import '../bloc/edit_group_state.dart';

class EditGroupView extends StatefulWidget {
  const EditGroupView({super.key, required this.groupId});

  final int groupId;

  @override
  State<EditGroupView> createState() => _EditGroupViewState();
}

class _EditGroupViewState extends State<EditGroupView> {
  final _formKey = GlobalKey<FormState>();
  final _groupNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<EditGroupBloc>().add(LoadGroupDetailsEvent(groupId: widget.groupId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.whiteColor),
          backgroundColor: AppColors.blackColor,
          title: Text(
            S.current.edit_group,
            style: AppTextStyles.bold16.copyWith(color: AppColors.whiteColor),
          )),
      body: BlocListener<EditGroupBloc, EditGroupState>(
        listener: (context, state) {
          if (state.status == StateStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(S.current.edit_group_success)),
            );
            Navigator.of(context).pop();
          } else if (state.status == StateStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(S.current.edit_group_failure)),
            );
          }
          if (state.group != null && _groupNameController.text.isEmpty) {
            _groupNameController.text = state.group!.name;
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<EditGroupBloc, EditGroupState>(
            builder: (context, state) {
              if (state.status == StateStatus.loading) {
                return const CircularProgressIndicator();
              }

              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      style: AppTextStyles.normal16.copyWith(color: AppColors.whiteColor),
                      controller: _groupNameController,
                      decoration: InputDecoration(
                        labelText: S.current.group_name,
                        labelStyle: AppTextStyles.normal16.copyWith(color: AppColors.whiteColor),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.persons.length,
                        itemBuilder: (context, index) {
                          final person = state.persons[index];
                          final isSelected = state.selectedPersons.contains(person.id);

                          return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: isSelected ? AppColors.redColor : AppColors.whiteColor, width: 1),
                                  ),
                                  child: ListTile(
                                    title: Text('${person.firstName} ${person.lastName}',
                                        style: AppTextStyles.bold14.copyWith(color: AppColors.whiteColor)),
                                    subtitle: Text(
                                      person.address,
                                      style: AppTextStyles.normal14.copyWith(color: AppColors.redColor),
                                    ),
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      context
                                          .read<EditGroupBloc>()
                                          .add(TogglePersonSelectionEvent(personId: person.id!));
                                    },
                                  )));
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<EditGroupBloc>().add(
                                SubmitEditedGroupEvent(
                                  groupId: state.group!.id!,
                                  name: _groupNameController.text,
                                  persons: state.selectedPersons.toList(),
                                ),
                              );
                        }
                      },
                      child: Text(
                        S.current.update_group,
                        style: AppTextStyles.bold16.copyWith(color: AppColors.redColor),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (dialogContext) => AlertDialog(
                            title: Text(S.current.delete_group),
                            content: Text(S.current.dialog_group_desc),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(dialogContext).pop();
                                },
                                child: Text(S.current.cancel),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.read<EditGroupBloc>().add(
                                        DeleteGroupEvent(groupId: state.group!.id!),
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
                        S.current.delete_group,
                        style: AppTextStyles.bold16.copyWith(color: AppColors.whiteColor),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }
}
