/**
 * Creates documentation for CFCs JavaDoc style via DocBox
 * .
 * You can pass the strategy options by prefixing them with 'strategy-'. So if a strategy takes
 * in a property of 'outputDir' you will pass it as 'strategy-outputdir='
 * Single source/mapping example:
 * {code:bash}
 * docbox generate source=/path/to/coldbox mapping=coldbox excludes=tests strategy-outputDir=/output/path strategy-projectTitle="My Docs"
 * {code}
 * Multiple source/mapping example:
 * {code:bash}
 * docbox generate mappings:v1.models=/path/to/modules_app/v1/models mappings:v2.models=/path/to/modules_app/v2/models strategy-outputDir=/output/path strategy-projectTitle="My Docs"
 * {code}
 **/
component {

	/**
	* Run DocBox to generate your docs
	* @strategy The strategy class to use to generate the docs.
	* @strategy.options docbox.strategy.api.HTMLAPIStrategy,docbox.strategy.uml2tools.XMIStrategy
	* @source The directory source
	* @mapping The base mapping for the folder.
	* @excludes	A regex that will be applied to the input source to exclude from the docs
	* @mappings A struct provided by the dynamic parameters facility of CommandBox that defines one or more mappings.
	**/
	function run(
		string strategy="docbox.strategy.api.HTMLAPIStrategy",
		string source = "",
		string mapping,
		string excludes,
		struct mappings
	){
		var docboxSourceMaps = [];

		// If mappings has been provided, it overrides the traditional source and mapping arguments.
		if (structKeyExists(arguments, "mappings") && isStruct(arguments.mappings) && structCount(arguments.mappings)) {
			for (var key in arguments.mappings) {
				arrayAppend(docboxSourceMaps, {"dir": variables.fileSystemUtil.resolvePath(arguments.mappings[key]), "mapping": key});
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
