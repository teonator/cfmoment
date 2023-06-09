# CFMoment

A ColdBox date module for parsing, validating, manipulating, and formatting date.

Inspired by:
* [Moment.js](https://github.com/moment/moment)
* [Luxon](https://github.com/moment/luxon)
* [Day.js](https://github.com/iamkun/dayjs)

## Usage

Get an instance by WireBox:
```
property name="moment" inject="Moment@CFMoment";

var millennium = moment.year( 2000 ).month( 1 ).day( 1 );
```

Get an instance by helper:
```
var millennium = Moment().year( 2000 ).month( 1 ).day( 1 );
```

Compare the dates:

```
var epochDay              = CreateDateTime( 1970, 1, 1 );
var millenniumDay         = CreateDateTime( 2000, 1, 1 );
var terminatorJudgmentDay = CreateDateTime( 1997, 8, 29 );

Moment( epochDay ).isSame( millenniumDay ); // false
Moment( epochDay ).isBefore( millenniumDay ); // true
Moment( millenniumDay ).isAfter( epochDay ); // true
Moment( terminatorJudgmentDay ).isBetween( epochDay, millenniumDay ); // true

```

Get difference of the dates:

```
var epochDay      = CreateDateTime( 1970, 1, 1 );
var millenniumDay = CreateDateTime( 2000, 1, 1 );

Moment( epochDay ).diffInDays( millenniumDay ); // 10957
Moment( epochDay ).diffInMonths( millenniumDay ); // 360
Moment( epochDay ).diffInYears( millenniumDay ); // 30
```

To manipulate the dates:
```
var epochDay = CreateDateTime( 1970, 1, 1 );

Moment( epochDay ).addMonths( 11 ).addDays( 30 ).toDate(); // 1970-12-31
Moment( epochDay ).subYears( 1 ).subMonths( 5 ).toDate(); // 1968-08-01

```

For human:
```
var epochDay      = CreateDateTime( 1970, 1, 1 );
var millenniumDay = CreateDateTime( 2000, 1, 1 );

Moment( epochDay ).diffForHuman(); // 53 years ago
Moment( epochDay ).diffForHuman( millenniumDay ); // 30 years before
Moment( epochDay ).rangeForHuman( CreateDateTime( 1970, 1, 31 ) ); // 1 - 31 Jan 1970
Moment( epochDay ).rangeForHuman( CreateDateTime( 1970, 6, 9 ) ); // 1 Jan - 9 Jun 1970
```


