extends Node

var http_request: HTTPRequest; 

func save(data):
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "_onReqCompleted")
	var post_url = "http://localhost:1234/events"
	var post_body = JSON.print(data)
	http_request.request(post_url, [], true, HTTPClient.METHOD_POST, post_body)
	yield(http_request, "request_completed")
	remove_child(http_request)

func _onReqCompleted(result, response_code, _headers, body):
	var data = JSON.parse(body.get_string_from_utf8()).result
	UserData.save(data)
