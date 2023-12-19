extends Node

var http_request: HTTPRequest; 
var response;
var prettyResponse;

func save(data):
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "onReqCompleted")
	var post_url = "https://jsonplaceholder.typicode.com/posts"
	var post_body = JSON.print(data)
	http_request.request(post_url, [], true, HTTPClient.METHOD_POST, post_body)

func onReqCompleted(result, response_code, _headers, body):
	print('called')
	var data = JSON.parse(body.get_string_from_utf8()).result
	response = {
		'result': result, 
		'responseCode': response_code, 
		'data': data,
	}
	prettyResponse = JSON.print(response, "\t")
	print("Backend Data:", prettyResponse)


	
