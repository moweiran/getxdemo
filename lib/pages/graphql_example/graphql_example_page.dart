import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

// class GraphqlExamplePage extends HookWidget {
//   const GraphqlExamplePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     const String readRepositories = """
//         query QueryStudents(\$keyword: String, \$page: Page) {
//         queryStudents(keyword: \$keyword, page: \$page) {
//           id
//           name
//           roll
//         }
//       }
//       """;
//     final queryResult = useQuery(
//       QueryOptions(
//         document: gql(readRepositories),
//         variables: const {
//           "keyword": "",
//           "page": {
//             "pageIndex": 4,
//             "pageSize": 3,
//           }
//         },
//         // pollInterval: const Duration(seconds: 10),
//       ),
//     );
//     final result = queryResult.result;
//     List? repositories = result.data?['queryStudents'];
//     if (repositories == null) {
//       return const Text('No repositories');
//     }
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Graphql Demo'),
//       ),
//       // body: const Text('test'),
//       body: ListView.builder(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//         itemCount: 2,
//         itemExtent: 60,
//         itemBuilder: (context, index) {
//           final repository = repositories[index];
//           return Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('${repository['id'] ?? 0}'),
//               const SizedBox(width: 10),
//               Column(
//                 children: [
//                   Text(repository['name'] ?? ''),
//                   Text(repository['roll'] ?? '')
//                 ],
//               )
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

class GraphqlExamplePage extends StatefulHookWidget {
  const GraphqlExamplePage({Key? key}) : super(key: key);

  @override
  State<GraphqlExamplePage> createState() => _GraphqlExamplePageState();
}

class _GraphqlExamplePageState extends State<GraphqlExamplePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const String readRepositories = """
        query QueryStudents(\$keyword: String, \$page: Page) {
        queryStudents(keyword: \$keyword, page: \$page) {
          id
          name
          roll
        }
      }
      """;

    const String addStar = """
        mutation AddStudent2(\$student: StudentDTO) {
          addStudent2(student: \$student)
        }
      """;

// ...

    final addStudentMutation = useMutation(
      MutationOptions(
        document: gql(addStar), // this is the mutation string you just created
        // you can update the cache based on results
        // update: (GraphQLDataProxy cache, QueryResult result) {
        //   return cache;
        // },
        // or do something with the result.data on completion
        onCompleted: (dynamic resultData) {
          print(resultData);
        },
      ),
    );
    final queryResult = useQuery(
      QueryOptions(
        cacheRereadPolicy: CacheRereadPolicy.mergeOptimistic,
        document: gql(readRepositories),
        variables: const {
          "keyword": "",
          "page": {
            "pageIndex": 1,
            "pageSize": 6,
          }
        },
        // pollInterval: const Duration(seconds: 10),
      ),
    );
    final result = queryResult.result;
    List? repositories = result.data?['queryStudents'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Graphql Demo'),
      ),
      // body: const Text('test'),
      body: repositories == null
          ? const Text('No repositories')
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              itemCount: 2,
              itemExtent: 60,
              itemBuilder: (context, index) {
                final repository = repositories[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${repository['id'] ?? 0}'),
                    const SizedBox(width: 10),
                    Column(
                      children: [
                        Text(repository['name'] ?? ''),
                        Text(repository['roll'] ?? '')
                      ],
                    )
                  ],
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addStudentMutation.runMutation({
          "student": {
            "name": "12334",
            "roll": "12243",
          }
        }),
        tooltip: 'Star',
        child: Icon(Icons.star),
      ),
    );
  }
}
