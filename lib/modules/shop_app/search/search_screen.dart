import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/search/search_cubit/search_cubit.dart';
import 'package:shop_app/shared/components/component.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  // search screen

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
        create: (BuildContext context) => SearchCubit(),
        child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(),
                body: Form(
                  key: formkey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        defaultFormField(
                            border: const OutlineInputBorder(),
                            type: TextInputType.text,
                            label: 'Search',
                            prefix: Icons.search,
                            controller: searchController,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'اكتب حاجه نسيرش عليها الله يرضي عليك';
                              }
                              return null;
                            },
                          onFieldSubmitted: (String text){

                            SearchCubit.get(context).Search(text);


                          }
                        ),
                        SizedBox(height: 15,),
                        if(state is SearchLoadingState)
                          LinearProgressIndicator(),
                        SizedBox(height: 15,),

                        if(state is SearchSuccessState)

                        Expanded(
                          child: ListView.separated(

                            itemBuilder:(context , index) => buildListProduct (SearchCubit.get(context).model!.data!.data[index] , context , isOldPrice: false),
                            separatorBuilder: (context , index) => myDivider(),
                            itemCount: SearchCubit.get(context).model!.data!.data.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          },
        ));
  }
}
