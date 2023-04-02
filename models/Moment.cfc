component accessors=true {

	property name="moment" type="date";

	public any function init( date dateTime = Now() ) {
		variables.moment = arguments.dateTime;

		return this;
	}

}