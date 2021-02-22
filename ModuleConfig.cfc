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
