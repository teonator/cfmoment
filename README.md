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

Compare te dates:

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
var epoch = CreateDateTime( 1970, 1, 1 );

Moment( epoch ).diffInDays(); // 19449
Moment( epoch ).diffInMonths(); // 19449
Moment( epoch ).diffInDays(); // 53
Moment( epoch ).diffForHuman(); // 53 years ago
```