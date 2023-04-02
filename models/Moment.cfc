component accessors=true {

	property name="moment" type="date";

	public any function init(
		date dateTime = Now()
	) {
		variables.moment = arguments.dateTime;

		return this;
	}

	/**
	* Alias
	*/

	public numeric function day() {
		return Day( variables.moment );
	}

	public numeric function week() {
		return Week( variables.moment );
	}

	public numeric function month() {
		return Month( variables.moment );
	}

	public numeric function quater() {
		return Quater( variables.moment );
	}

	public numeric function year() {
		return Year( variables.moment );
	}

}