extends Node

var http_request: HTTPRequest;
var user_event: UserEvent;

func sendReq(data):
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "_onReqCompleted")
	var post_url = "http://localhost:1234/events"
	var post_body = JSON.print(data)
	http_request.request(post_url, ["Content-Type: application/json"], true, HTTPClient.METHOD_POST, post_body)
	yield(http_request, "request_completed")
	remove_child(http_request)

func _onReqCompleted(result, response_code, _headers, body):
	var data = JSON.parse(body.get_string_from_utf8()).result
	UserData.save(data.data)

func saveLocal(event):
	user_event.create(event)
	
func saveRemote():
	var localEvents = user_event.getAllUnSync()
	for event in localEvents:
		event.data= JSON.parse(event.data).result
		sendReq(event)

func save(data):
	saveLocal(data);
	saveRemote();
	
func _ready():
	user_event = UserEvent.new()
