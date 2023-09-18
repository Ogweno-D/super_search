import 'package:flutter/material.dart';
import 'package:super_search/screens/search/tile.dart';
import 'package:super_search/style.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<String>? _results;
  String _input = '';

  _onSearchFieldChanged(String value) async {
    _input = value;

    if (value.isEmpty) {
      setState(() => _results = null);
    }

    final results = await _searchUsers(value);

    setState(() {
      _results = results;
      if (value.isEmpty) {
        _results = null;
      }
    });
    //To fill out next
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Search Users'),
        ),
        body: Column(children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  onChanged: _onSearchFieldChanged,
                  autocorrect: false,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Name",
                    hintStyle: placeholderTextFieldStyle,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ))),
          Expanded(
              child: (_results ?? []).isNotEmpty
                  ? GridView.count(
                      childAspectRatio: 1,
                      crossAxisCount: 2,
                      padding: const EdgeInsets.all(2.0),
                      mainAxisSpacing: 1.0,
                      crossAxisSpacing: 1.0,
                      children: _results!.map((r) => Tile(r)).toList())
                  : Padding(
                      padding: const EdgeInsets.only(top: 200),
                      child: _results == null
                          ? Container()
                          : Text("No results for '$_input'",
                              style: Theme.of(context).textTheme.bodySmall))),
        ]));
  }
}

Future<List<String>> _searchUsers(String name) async {
  final result = await Supabase.instance.client
      .from('names')
      .select('fname, lname')
      .textSearch('fts', "$name:*")
      .limit(100)
      .onError((error, stackTrace) => null);

  if (result!= null) {
    // print('error: ${result.error.toString()}');
    return [];
  }

  final List<String> names = [];
  for (var v in ((result.data ?? []) as List<dynamic>)) {
    names.add("${v['fname']} ${v['lname']}");
  }
  return names;
}

// void showFlashError(BuildContext context, String message) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Container(
//         height: 30, // Adjust the height as needed
//         child: Row(
//           children: [
//             Icon(Icons.error, color: Colors.white),
//             SizedBox(width: 10),
//             Expanded(
//               child: Text(
//                 message,
//                 style: TextStyle(color: Colors.white),
//                 overflow: TextOverflow.visible,
//               ),
//             ),
//           ],
//         ),
//       ),
//       backgroundColor: Colors.blue,
//       duration: Duration(seconds: 3),
//       action: SnackBarAction(
//         label: 'Dismiss',
//         textColor: Colors.white,
//         backgroundColor: Colors.black,
//         onPressed: () {
//           ScaffoldMessenger.of(context).hideCurrentSnackBar();
//         },
//       ),
//     ),
//   );
// }

// Future<List<String>> _searchUsers(String name) async {
//   try {
//     final result = await Supabase.instance.client
//         .from('names')
//         .select('fname, lname')
//         .textSearch('fts', "$name:*")
//         .limit(100);

//     final List<String> names = [];
//     for (var v in ((result.data ?? []) as List<dynamic>)) {
//       names.add("${v['fname']} ${v['lname']}");
//     }
//     return names;
//   } catch (e) {
//     showFlashError(context as BuildContext, 'Invalid Search');
//     return [];
//   }
//   // } on Error catch (e) {
//   //   // Handle the Supabase error here.
//   //   // For example, you could display a message to the user or log the error.
//   //   print('Supabase error: ${e.message}');
//   //   return [];
//   // } catch (e) {
//   //   // Handle any other errors here.
//   //   // For example, you could display a message to the user or log the error.
//   //   print('Unexpected error: ${error.message}');
//   //   return [];
//   // }
// }
