component accessors=true {

	property name="moment" type="date";

	public any function init(
		date dateTime = Now()
	) {
		variables.moment = arguments.dateTime;

		return this;
	}

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
	* Get
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
	* Set
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
	* Add
	*/

	public any function addDays(
		required numeric days
	) {
		return _setMoment( datePart="d", number=arguments.days );
	}

	public any function addMonths(
		required numeric months
	) {
		return _setMoment( datePart="m", number=arguments.months );
	}

	public any function addYears(
		required numeric years
	) {
		return _setMoment( datePart="yyyy", number=arguments.years );
	}

	/**
	* Substract
	*/

	public any function subDays(
		required numeric days
	) {
		return _setMoment( datePart="d", number=( arguments.days * -1 ) );
	}

	public any function subMonths(
		required numeric months
	) {
		return _setMoment( datePart="m", number=( arguments.months * -1 ) );
	}

	public any function subYears(
		required numeric years
	) {
		return _setMoment( datePart="yyyy", number=( arguments.years * -1 ) );
	}

	/**
	* Format
	*/

	public string function toDate() {
		return toStr( "yyyy-mm-dd" );
	}

	public string function toStr(
		required string mask
	) {
		return DateTimeFormat( variables.moment, arguments.mask );
	}

	public string function toObj() {
		return variables.moment;
	}

	// Compare

	public boolean function isSame(
		required date dateTime
	) {
		return DateCompare( variables.moment, arguments.dateTime ) == 0;
	}

	public boolean function isAfter(
		required date dateTime
	) {
		return DateCompare( variables.moment, arguments.dateTime ) > 0;
	}

	public boolean function isBefore(
		required date dateTime
	) {
		return DateCompare( variables.moment, arguments.dateTime ) < 0;
	}

	public boolean function isSameOrAfter(
		required date dateTime
	) {
		return isSame( arguments.dateTime ) || isAfter( arguments.dateTime );
	}

	public boolean function isSameOrBefore(
		required date dateTime
	) {
		return isSame( arguments.dateTime ) || isBefore( arguments.dateTime );
	}

	public boolean function isBetween(
		  required date startDateTime
		, required date endDateTime
	) {
		return isAfter( arguments.startDateTime ) && isBefore( arguments.endDateTime );
	}

	public boolean function isLeapYear() {
		return isLeapYear( variables.moment );
	}

	/**
	* Difference
	*/

	public numeric function diffInDays(
		  date    dateTime = Now()
		, boolean absolute = true
	) {
		return _getDiff( argumentCollection=arguments, datePart="d" );
	}

	public numeric function diffInMonths(
		  date    dateTime = Now()
		, boolean absolute = true
	) {
		return _getDiff( argumentCollection=arguments, datePart="m" );
	}

	public numeric function diffInYears(
		  date    dateTime = Now()
		, boolean absolute = true
	) {
		return _getDiff( argumentCollection=arguments, datePart="yyyy" );
	}

	public string function diffForHuman(
		  date    dateTime = Now()
		, boolean absolute = true
	) {
		var past      = "";
		var future    = "";
		var diff      = 0;
		var dateParts = [
			  "yyyy" = "year"
			, "m"    = "month"
			, "w"    = "week"
			, "d"    = "day"
			, "h"    = "hour"
			, "n"    = "minute"
			, "s"    = "second"
		];

		if ( DateCompare( arguments.dateTime, Now() ) == 0 ) {
			past   = "ago";
			future = "from now";
		} else {
			past   = "before";
			future = "after";
		}

		for ( var key in dateParts ) {
			diff = DateDiff( key, arguments.dateTime, variables.moment );

			if ( diff < 0 ) {
				if ( arguments.absolute ) {
					diff = Abs( diff );
				}

				return diff & " " & dateParts[ key ] & ( diff > 1 ? "s" : "" ) & " " & past;
			}

			if ( diff > 0 ) {
				if ( arguments.absolute ) {
					diff = Abs( diff );
				}

				return diff & " " & dateParts[ key ] & ( diff > 1 ? "s" : "" ) & " " & future;
			}
		}

		return "now";
	}

	/**
	* Misc
	*/
	public string function rangeForHuman(
		  date   dateTime  = Now()
		, string separator = "-"
	) {
		var mask      = "d mmm yyyy";
		var startDate = variables.moment;
		var endDate   = arguments.dateTime;

		if ( this.init( startDate ).isAfter( endDate ) ) {
			startDate = arguments.dateTime;
			endDate   = variables.moment;
		}

		if ( DateFormat( startDate, "yyyy" ) == DateFormat( endDate, "yyyy" ) ) {
			mask = Replace( mask, "yyyy", "" );

			if ( DateFormat( startDate, "mm" ) == DateFormat( endDate, "mm" ) ) {
				mask = Replace( mask, "mmm", "" );
			}
		}

		return DateFormat( startDate, mask ) & " " & arguments.separator &  " " & DateFormat( endDate, "d mmm yyyy" );
	}

	/**
	* Utility
	*/
	public any function clone() {
		return Duplicate( this );
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

	private numeric function _getDiff(
		  required string   datePart
		, required dateTime dateTime
		, required boolean  absolute
	) {
		var count = DateDiff( arguments.datePart, arguments.dateTime, variables.moment );

		return arguments.absolute ? Abs( count ) : count;
	}

}