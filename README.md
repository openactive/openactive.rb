[![License](http://img.shields.io/:license-mit-blue.svg)](http://theodi.mit-license.org)

# OpenActive Client Library for Ruby

A basic Ruby client library for working with data published as part of the [OpenActive](https://openactive.io) project.

Specifically the code provides support for:

* Listing all datasets that have been published as part of the project
* Fetching and harvesting a [Realtime Paged Data Exchange](https://www.openactive.io/realtime-paged-data-exchange/) (RPDE) containing opportunity data
* Identifying whether a feed conforms to the RPDE specification and/or the [Modelling Opportunity Data](https://www.openactive.io/modelling-opportunity-data/) specification

The project also provides some simple command-line tools to help to illustrate its use.

## Installation

Add this line to your application's Gemfile:

```
gem 'openactive'

```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install openactive
```

## Usage Examples

The code includes a couple of example scripts in the `bin` directory that illustrate usage of the library to fetch 
metadata and page through feeds.

See:

* `bin/oa_list.rb` -- list all published datasets
* `bin/oa_status.rb` -- create a CSV file summarising current status of published datasets
* `bin/oa_sample.rb` -- dump a random "modified" entry from a feed
* `bin/oa_harvest.rb` -- harvest all data from a feed, storing results in a directory

