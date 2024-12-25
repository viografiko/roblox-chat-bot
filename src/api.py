from flask import Flask, request, jsonify
import google.generativeai as genai

app = Flask(__name__)

# add here ur google gemini ai api key, get here https://ai.google.dev/gemini-api/docs/api-key?hl=en-us
genai.configure(api_key="your-api-key")

@app.route('/chat', methods=['POST'])
def chat():
    try:
        data = request.json
        user_message = data.get("message", "")

        if not user_message:
            return jsonify({"error": "message not founded"}), 400

        model = genai.GenerativeModel("gemini-1.5-flash") # u can change the model here, check at README.md
        ai_response = model.generate_content(user_message).text

        return jsonify({"response": ai_response})

    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/')
def home():
    return '200'

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
