/**
 * This task is used to execute all of your test suite.
 * No need to do try/catch we will do that for you.  Just write all the commands, assertions you need.
 */
component {

	/**
	 * Run my test suites
	 */
	function run(){
		command( "hello help" ).run( returnOutput: true );
	}

}
