/**
 * Creates documentation for CFCs JavaDoc style via DocBox
 * .
 * You can pass the strategy options by prefixing them with 'strategy-'. So if a strategy takes
 * in a property of 'outputDir' you will pass it as 'strategy-outputdir='
 * Examples
 * {code:bash}
 * docbox run source=/path/to/coldbox mapping=coldbox excludes=tests strategy-outputDir=/output/path strategy-projectTitle="My Docs"
 * {code}
 *
 * Multiple source mappings may be specified.
 * {code:bash}
 * docbox generate source="[{'dir':'../src/modules_app/v1/models', 'mapping':'v1.models'}, {'dir':'../src/modules_app/v2/models', 'mapping':'v2.models'}]" strategy-outputDir=docbox strategy-projectTitle="My API"
 * {code}
 **/
component {

	/**
	* Run DocBox to generate your docs
	* @strategy The strategy class to use to generate the docs.
	* @strategy.options docbox.strategy.api.HTMLAPIStrategy,docbox.strategy.uml2tools.XMIStrategy
	* @source Either, the string directory source, OR a JSON array of structs containing 'dir' and 'mapping' key
	* @mapping The base mapping for the folder. Only required if the source is a string
	* @excludes	A regex that will be applied to the input source to exclude from the docs
	**/
	function run(
		string strategy="docbox.strategy.api.HTMLAPIStrategy",
		string source = "",
		string mapping,
		string excludes
	){
		var docboxSourceMaps = [];

		if (isJSON(arguments.source)) {
			// Deserialize the array of directory/mapping structures from JSON. Then copy what seems to be valid.
			arguments.source = deserializeJSON(arguments.source);
			if (!isArray(arguments.source)) {
				return error("The source argument should be a JSON serialized array of structures, each having a key for 'dir' and 'mapping'.");
			}
			for (var tuple in arguments.source) {
				if (!structKeyExists(tuple, "dir") || len(tuple.dir) == 0 || !structKeyExists(tuple, "mapping") || len(tuple.mapping) == 0) {
					print.yellowLine("Skipping invalid source mapping.");
					continue;
				}
				tuple.dir = variables.fileSystemUtil.resolvePath(tuple.dir);
				arrayAppend(docboxSourceMaps, tuple);
			}
		} else {
			// Basic usage; provide a source directory and a mapping as separate arguments
			arrayAppend(docboxSourceMaps, {"dir": variables.fileSystemUtil.resolvePath(arguments.source), "mapping": arguments.mapping});
		}

		// We should have at least one valid source mapping, or don't bother continuing
		if (arrayLen(docboxSourceMaps) == 0) {
			return error("No valid source mappings found. Type `help docbox Generate` for guidance.")
		}

		// Inflate strategy properties
		var properties = {};
		for( var thisArg in arguments ){
			if( !isNull( arguments[ thisArg ] ) and reFindNoCase( "^strategy\-" , thisArg ) ){
				properties[ listLast( thisArg, "-" ) ] = arguments[ thisArg ];
				//print.yellowLine( "Adding strategy property: #listLast( thisArg, "-" )#" );
			}
		}

		// Resolve Output Dir
		if( structKeyExists( properties, "outputDir" ) ){
			properties.outputDir = fileSystemUtil.resolvePath( properties.outputDir );
		}

		// init docbox with default strategy and properites
		var docbox = new "commandbox-docbox.docbox.DocBox"(
			strategy = arguments.strategy,
			properties = properties
		);

		// Provide a little feedback when something is horribly wrong.
		for (var tuple in docboxSourceMaps) {
			if (!directoryExists(tuple.dir)) {
				print.redLine("Warning: '#tuple.dir#' does not exist.");
			} else {
				print.yellowLine("Source: #tuple.dir#")
					.yellowLine("Mapping: #tuple.mapping#");
			}
		}

		print.yellowLine( "Output: #properties.outputDir#")
			.redLine( "Starting Generation, please wait..." )
			.toConsole();

		// Create mappings
		var mappings = getApplicationSettings().mappings;
		for (var tuple in docboxSourceMaps) {
			mappings["/" & replace(tuple.mapping, ".", "/", "all")] = tuple.dir;
		}
		application action="update" mappings=mappings;

		// Generate
		docbox.generate(source=docboxSourceMaps, excludes=arguments.excludes);

		print.greenLine( "Generation complete" );
	}

}
