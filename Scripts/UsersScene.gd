extends Control

onready var http : HTTPRequest = $HTTPRequest
onready var form_button : Button = $Column/Form/FormButton
onready var form_nickname : LineEdit = $Column/Form/LineEdit
onready var column : VBoxContainer = $Column

export var user_row : PackedScene
export var user_count : int = 5

var deleting_entries := false

# Unity: Start()
func _ready() -> void:
	randomize()
	#get_highscores()
	get_users()


func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	if deleting_entries:
		return
	form_button.disabled = false
	form_nickname.text = ""
	var request_result := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	if "documents" in request_result.keys():
		var users := get_formated_users(request_result.documents)
		#scores.sort_custom(self, "sort_scores")
		if users.size() > user_count:
			var index := users.size() - 1
			deleting_entries = true
			while index != user_count - 1:
				Firebase.delete_document("users/%s" % users[index].id, http)
				yield(http, "request_completed")
				index -= 1
			deleting_entries = false
			get_users()
		else:
			delete_current_rows()
			#add_new_rows(users)
	elif not request_result.empty():
		get_users()

"""
func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	if deleting_entries:
		return
	form_button.disabled = false
	form_nickname.text = ""
	var request_result := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	if "documents" in request_result.keys():
		var scores := get_formated_scores(request_result.documents)
		scores.sort_custom(self, "sort_scores")
		if scores.size() > highscore_count:
			var index := scores.size() - 1
			deleting_entries = true
			while index != highscore_count - 1:
				Firebase.delete_document("highscores/%s" % scores[index].id, http)
				yield(http, "request_completed")
				index -= 1
			deleting_entries = false
			get_highscores()
		else:
			delete_current_rows()
			add_new_rows(scores)
	elif not request_result.empty():
		get_highscores()
"""

func _on_FormButton_pressed() -> void:
	if form_nickname.text.empty():
		return
	form_button.disabled = true
	var body := {
		"user_name": {"stringValue": form_nickname.text },
		"stage": {"integerValue": 1 },
	}
	Firebase.save_document("users", body, http)
	
	#if form_nickname.text.empty():
		#return
	#form_button.disabled = true
	#var body := {
		#"nickname": {"stringValue": form_nickname.text },
		#"value": {"integerValue": randi() % 9999 },
	#}
	#Firebase.save_document("highscores", body, http)


#func get_highscores() -> void:
	#Firebase.get_document_or_collection("highscores", http)

func get_users() -> void:
	Firebase.get_document_or_collection("users", http)

func get_formated_scores(documents: Array) -> Array:
	var scores := []
	for document in documents:
		var split := document.name.split("/") as PoolStringArray
		scores.append({
			"nickname": document.fields.nickname.stringValue,
			"value": int(document.fields.value.integerValue),
			"id": split[split.size() - 1]
		})
	return scores
	
func get_formated_users(documents: Array) -> Array:
	var users := []
	for document in documents:
		var split := document.name.split("/") as PoolStringArray
		users.append({
			"user_name": document.fields.user_name.stringValue,
			"stage": int(document.fields.stage.integerValue),
			"id": split[split.size() - 1]
		})
	return users

func sort_scores(a, b) -> bool:
	if a.value < b.value:
		return false
	return true

func delete_current_rows() -> void:
	for child in column.get_children():
		if child is UserRow:
			child.queue_free()

#func add_new_rows(users: Array) -> void:
#	for user in users:
		
		#var new_user_row := user_row.instance() as UserRow
		#column.add_child(new_user_row)
		#new_user_row.userNameLabel.text = user.user_name
		#new_user_row.stageLabel.text = str(user.stage)
