import "package:flutter/material.dart";
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {runApp(MaterialApp(title: "GQL App",
home: MyApp(),));
  
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink("https://countries.trevorblades.com/");
    final GraphQLCache cache = GraphQLCache(
      dataIdFromObject: typenameDataIdFromObject,
    );
    final ValueNotifier<GraphQLClient>client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: httpLink as Link,
        cache: OptimisticCache(
          dataIdFromObject: typenameDataIdFromObject,
        ),
      ),
    );
    return GraphQLProvider(
      child: HomePage(),
      client: client,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Graphql Client"),
      ),
      body: Query(
          options: QueryOptions(document: r"""
      query Getcontinents{
      continents{
      name
      }
      }
      """),
          builder:(
              QueryResult result, {
                voidCallback refetch,
              }) {
            if(result.data==null){
              return Text("No data found");
          }
            print(result.data!['continents']);
            return ListView.builder(itemBuilder: (BuildContext context,int index){
            return ListTile(title: Text(result.data!['continents'][index]['name']  ),
    );
  },
  itemCount:result.data!['continents'].length,
    );
}),
    );
}
}
