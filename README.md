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