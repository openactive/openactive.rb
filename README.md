# OpenActive Client Library for Ruby

Dataset:

* Extract RDFa from dataset page

Feed:

* Fetch a page, parse to JSON
* Is this the last page?
* Fully process a feed, e.g. iterate from a start URL, to last page
* Process item
* Is payload standard?

Data Model:



Issues:

* What should client do if there's a 404 when requesting a page? Can they resume from there?
* Can we tell the version of the API specification that is supported?
* What if the server redirects on a request, what do we use for paging from that point? What
  URL should the server be quoting?
* Relative or absolute urls in next_page
* Comparison of request URL with URL in body of response to determine next_page. 
  Should probably canonicalise? Especially with relative URLs

