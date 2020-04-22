from flask import Flask, request, jsonify

app = Flask(__name__)


@app.route("/api", methods=['POST'])
def api():
	text = request.get_json()
	print(text)
	return jsonify({status:200, data:'recieved'})

app.run(host='0.0.0.0', port=5001, debug=True)