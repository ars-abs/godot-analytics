extends Node

var http_request: HTTPRequest

func getReq():
	var get_url = "https://jsonplaceholder.typicode.com/users/1"
	http_request.request(get_url,[], true, HTTPClient.METHOD_GET)

func postReq():
	var post_url = "http://localhost:1234/events"
	var post_data = {
		'title': 'foo',
		'body': 'bar',
		'userId': 1,
	}
	var post_body = JSON.print(post_data)
	http_request.request(post_url,["Content-Type: application/json"], false, HTTPClient.METHOD_POST, post_body)
	

func deleteReq():
	var delete_url = "https://jsonplaceholder.typicode.com/posts/1"
	http_request.request(delete_url, [], true, HTTPClient.METHOD_DELETE)

func putReq():
	var put_url = "https://jsonplaceholder.typicode.com/posts/1"
	var put_data = {
		'id': 1,
		'title': 'foo',
		'body': 'bar',
		'userId': 1,
	}
	var put_body = JSON.print(put_data)
	http_request.request(put_url, [], true, HTTPClient.METHOD_PUT, put_body)

func onReqCompleted(result, response_code, headers, body):
	print('called')
	var data = JSON.parse(body.get_string_from_utf8()).result
	var output = {
		'result': result, 
		'responseCode': response_code, 
#		'headers': headers,
		'data': data,
	}
	var pretty_json = JSON.print(output, "\t")
	print("Backend Data:", pretty_json)

func _ready():
	http_request = HTTPRequest.new()
	http_request.connect("request_completed", self, "onReqCompleted")
	add_child(http_request)

	getReq();
	yield(http_request, "request_completed")
	postReq();
	yield(http_request, "request_completed")
	putReq();
	yield(http_request, "request_completed")
	deleteReq();
