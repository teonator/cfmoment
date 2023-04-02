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

	public any function day(
		numeric day
	) {
		return IsNumeric( arguments.day ) ? setDay( arguments.day ) : getDay( variables.moment );
	}

	public any function month(
		numeric month
	) {
		return IsNumeric( arguments.month ) ? setMonth( arguments.month ) : getMonth( variables.moment );
	}

	public any function year(
		numeric year
	) {
		return IsNumeric( arguments.year ) ? setYear( arguments.year ) : getYear( variables.moment );
	}

	/**
	* Getter
	*/

	public numeric function getDay(
		date moment
	) {
		return Day( arguments.moment ?: variables.moment );
	}

	public numeric function getMonth(
		date moment
	) {
		return Month( arguments.moment ?: variables.moment );
	}

	public numeric function getYear(
		date moment
	) {
		return Year( arguments.moment ?: variables.moment );
	}

	/**
	* Setters
	*/

	public any function setDay(
		required numeric day
	) {
		variables.moment = CreateDate( this.year(), this.month(), _getDayOfMonth( this.year(), this.month(), arguments.day ) );

		return this;
	}

	public any function setMonth(
		required numeric month
	) {
		variables.moment = CreateDate( this.year(), arguments.month, _getDayOfMonth( this.year(), arguments.month, this.day() ) );

		return this;
	}

	public any function setYear(
		required numeric year
	) {
		variables.moment = CreateDate( arguments.year, this.month(), _getDayOfMonth( arguments.year, this.month(), this.day() ) );

		return this;
	}

	/**
	* Formatter
	*/

	public string function toDate() {
		return toString( "yyyy-mm-dd" );
	}

	public string function toString(
		required string mask
	) {
		return DateTimeFormat( variables.moment, arguments.mask );
	}

	public string function toObject() {
		return variables.moment;
	}

	/**
	* Private
	*/

	private any function _setMoment(
		  required string  datePart
		, required numeric number
	) {
		variables.moment = DateAdd( arguments.datePart, arguments.number, variables.moment );

		return this;
	}

	private numeric function _getDayOfMonth(
		  required numeric year
		, required numeric month
		, required numeric day
	) {
		return Min( arguments.day, DaysInMonth( CreateDate( arguments.year, arguments.month, 1 ) ) )
	}

}