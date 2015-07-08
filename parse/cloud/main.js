
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});


Parse.Cloud.define("books", function(request, response) {

	var query = new Parse.query("Book");
	query.find({
		success: function(results) {
			response.success(results);
		},
		error: function() {
			response.error("Error querying books");
		}
	});

});


Parse.Cloud.define("bookDetail", function(request, respose) {

	var query = new Parse.query("Book");
	query.equalTo("objectID", request.params.bookID);
	query.find({
	    success: function(results) {
	      response.success(results);
	    },
	    error: function() {
	      response.error("Error querying book details");
	    }
  	});
});