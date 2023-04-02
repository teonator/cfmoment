<cfscript>

	any function moment(
		date dateTime = Now()
	) {
		return getInstance( "Moment@CFMoment" ).init( argumentCollection=arguments );
	}

</cfscript>