import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people/utils/state_status.dart';
import '../../../generated/l10n.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_textstyles.dart';
import '../bloc/create_group_bloc.dart';
import '../bloc/create_group_event.dart';
import '../bloc/create_group_state.dart';

class CreateGroupView extends StatefulWidget {
  const CreateGroupView({super.key});

  @override
  State<CreateGroupView> createState() => _CreateGroupViewState();
}

class _CreateGroupViewState extends State<CreateGroupView> {
  final _formKey = GlobalKey<FormState>();
  final _groupNameController = TextEditingController();
  final Set<int> _chosenPersonsIds = <int>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.whiteColor),
          backgroundColor: AppColors.blackColor,
          title: Text(S.current.add_group, style: AppTextStyles.bold16.copyWith(color: AppColors.whiteColor))),
      body: BlocListener<CreateGroupBloc, CreateGroupState>(
        listener: (context, state) {
          if (state.status == StateStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(S.current.add_group_success)),
            );
            Navigator.of(context).pop();
          } else if (state.status == StateStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(S.current.add_group_failure)),
            );
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
                  controller: _groupNameController,
                  decoration: InputDecoration(
                    labelText: S.current.group_name,
                    labelStyle: AppTextStyles.normal16.copyWith(color: AppColors.whiteColor),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: BlocBuilder<CreateGroupBloc, CreateGroupState>(
                    builder: (context, state) {
                      if (state.status == StateStatus.loading) {
                        return const CircularProgressIndicator();
                      }
                      return ListView.builder(
                        itemCount: state.persons.length,
                        itemBuilder: (context, index) {
                          final person = state.persons[index];
                          final isSelected = _chosenPersonsIds.contains(person.id);

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: isSelected ? AppColors.redColor : AppColors.whiteColor, width: 1),
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
                                  setState(() {
                                    if (isSelected) {
                                      _chosenPersonsIds.remove(person.id);
                                    } else {
                                      if (person.id != null) {
                                        _chosenPersonsIds.add(person.id!);
                                      }
                                    }
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                BlocBuilder<CreateGroupBloc, CreateGroupState>(
                  builder: (context, state) {
                    if (state.status == StateStatus.loading) {
                      return const CircularProgressIndicator();
                    }

                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<CreateGroupBloc>().add(
                                SubmitGroupEvent(
                                  name: _groupNameController.text,
                                  persons: _chosenPersonsIds.toList(),
                                ),
                              );
                        }
                      },
                      child: Text(
                        S.current.add_group,
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
    _groupNameController.dispose();
    super.dispose();
  }
}
