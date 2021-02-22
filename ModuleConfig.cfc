/**
 * Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
 * www.ortussolutions.com
 * ---
 * DocBox command for CommandBox
 */
component {

	function configure(){
	}

	function onLoad(){
		shell
			.getUtil()
			.addMapping(
				"/docbox",
				expandPath( "/commandbox-docbox/docbox" )
			);
	}

}
